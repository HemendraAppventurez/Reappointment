using System;
using System.Data;
using System.IO;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DatainExcel : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    DataAccessLayer objAP = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        objAP.chkCookie();
        if (!Page.IsPostBack)
        {
            ddlPortalRound.DataSource = new clsReappointmentDashboard().GetPortalRounds();
            ddlPortalRound.DataTextField = "DateRange";
            ddlPortalRound.DataValueField = "PortalRound";
            ddlPortalRound.DataBind();
            ddlPortalRound.Items.Insert(0, new ListItem("All Portal Rounds", "0"));
            ds = new clsReappointmentDashboard().GetDataforExcel(0, 1);
            rptData.DataSource = ds;
            rptData.DataBind();
        }
    }

    protected void btn_Excel_Click(object sender, EventArgs e)
    {
        Response.ContentType = "application/x-msexcel";
        if (rblNewOrExtension.SelectedValue == "1")
            Response.AddHeader("Content-Disposition", "attachment; filename = ReappointmentData.xls");
        else
            Response.AddHeader("Content-Disposition", "attachment; filename = ReappointmentDataExtention.xls");
        Response.ContentEncoding = Encoding.UTF8;
        StringWriter tw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(tw);
        printContent.RenderControl(hw);
        Response.Write(tw.ToString());
        Response.End();
    }

    protected void ddlPortalRound_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rblNewOrExtension.SelectedValue == "1")
        {
            BindData(1);
        }
        else
        {
            BindData(0);
        }
    }

    private void BindData(int i)
    {
        ds = new clsReappointmentDashboard().GetDataforExcel(Convert.ToInt32(ddlPortalRound.SelectedValue), i);
        rptData.DataSource = ds;
        rptData.DataBind();
    }
    protected void rblNewOrExtension_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rblNewOrExtension.SelectedValue == "1")
        {
            BindData(1);
        }
        else
        {
            BindData(0);
        }
    }
}