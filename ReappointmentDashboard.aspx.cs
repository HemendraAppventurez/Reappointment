using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ReappointmentDashboard : System.Web.UI.Page
{
    public Int32 Preference1MBBS, Preference1Specialist, Preference2MBBS, Preference2Specialist, Preference3MBBS, Preference3Specialist, ProposedMBBSPositions, ProposedSpecialistPositions = 0;

    clsReappointmentDashboard objreappoint = new clsReappointmentDashboard();
    DataAccessLayer objAP = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        objAP.chkCookie();
        if (string.IsNullOrEmpty(Convert.ToString(Session["username"])))
        {
            objAP.sessionterminate();
        }
        else
        {
            if (!Page.IsPostBack)
            {
                SetCombos();
                BindChart();
                BindData();
            }
        }
    }

    protected void SetCombos()
    {
        ddlRound.Items.Clear();
        ddlRound.DataSource = objreappoint.GetPortalRounds();
        ddlRound.DataTextField = "DateRange";
        ddlRound.DataValueField = "PortalRound";
        ddlRound.DataBind();
        ddlRound.Items.Insert(0, new ListItem("All", "0"));
    }

    protected void BindChart()
    {
        DataSet ds = objreappoint.AgeWiseData_Dashboard(Convert.ToInt32(ddlRound.SelectedValue));
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            DataTable dt = ds.Tables[0];

            string[] x = new string[dt.Rows.Count];
            decimal[] y = new decimal[dt.Rows.Count];

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                x[i] = dt.Rows[i]["ageBracket"].ToString();
                y[i] = Convert.ToDecimal(dt.Rows[i]["TotalApplicants"]);
            }

            BarChart1.Series.Add(new AjaxControlToolkit.BarChartSeries { Data = y, BarColor = "#94aad8", Name = "Number of Applicants" });
            BarChart1.CategoriesAxis = string.Join(",", x);
            BarChart1.Visible = true;
        }
    }

    protected void BindData()
    {
        DataSet ds = objreappoint.DistrictwiseData_Dashboard(Convert.ToInt32(ddlRound.SelectedValue));
        if (ds.Tables[0].Rows.Count > 0)
        {
            rptSummary.DataSource = ds;
            rptSummary.DataBind();

            Preference1MBBS = Convert.ToInt32(ds.Tables[0].Compute("Sum(Preference1MBBS)", null));
            Preference1Specialist = Convert.ToInt32(ds.Tables[0].Compute("Sum(Preference1Specialist)", null));
            Preference2MBBS = Convert.ToInt32(ds.Tables[0].Compute("Sum(Preference2MBBS)", null));
            Preference2Specialist = Convert.ToInt32(ds.Tables[0].Compute("Sum(Preference2Specialist)", null));
            Preference3MBBS = Convert.ToInt32(ds.Tables[0].Compute("Sum(Preference3MBBS)", null));
            Preference3Specialist = Convert.ToInt32(ds.Tables[0].Compute("Sum(Preference3Specialist)", null));
            ProposedMBBSPositions = Convert.ToInt32(ds.Tables[0].Compute("Sum(ProposedMBBSPositions)", null));
            ProposedSpecialistPositions = Convert.ToInt32(ds.Tables[0].Compute("Sum(ProposedSpecialistPositions)", null));

            lblMBBSApplicants.Text = Preference1MBBS.ToString();
            lblSpecApplicants.Text = Preference1Specialist.ToString();
            lblTotalApplicants.Text = (Preference1MBBS + Preference1Specialist).ToString();
            lblSpecAppliedMBBS.Text = Convert.ToString(objreappoint.SpecAppliedforMBBS(Convert.ToInt32(ddlRound.SelectedValue)));
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Data is not recieved yet to display for selected round!', type: 'info', showConfirmButton: true }, function() { window.location.href = 'ReappointmentDashboard.aspx'; });</script>");
        }
    }


    protected void btnLogout_Click(object sender, EventArgs e)
    {
        objAP.sessionterminate();
    }

    protected void ddlRound_SelectedIndexChanged(object sender, EventArgs e)
    {
       
            BindChart();
            BindData();
    }
}