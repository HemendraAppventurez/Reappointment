using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class UpdateNotJoining : System.Web.UI.Page
{
    DataAccessLayer objAP = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        objAP.chkCookie();
        if (!IsPostBack)
        {
            BindData();
        }
    }
    protected void BindData()
    {
        DataSet ds = new DataSet();
        ds = objAP.GetDataforNotJoiningDetails();
        rptData.DataSource = ds;
        rptData.DataBind();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (RepeaterItem item in rptData.Items)
            {
                CheckBox chkApp = (CheckBox)item.FindControl("chkApp");
                Label lblAppNo = (Label)item.FindControl("lblAppNo");
                if (chkApp.Checked)
                {
                    objAP.UpdateNotJoining(lblAppNo.Text);
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1", "<script>swal('Not Joining has been updated!', '', 'info')</script>");
                }

            }
            BindData();
        }
        catch
        {
            ClientScript.RegisterStartupScript(this.GetType(), "msg1", "<script>swal('Error Occured! Please Contact to IT Admin', '', 'error')</script>");
        }
    }
}