using System;
using System.Data;
using System.Net;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UpdateJoining : System.Web.UI.Page
{
    DataAccessLayer objAP = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
       // objAP.chkCookie();
        if (!Page.IsPostBack)
        {
            BindData();
        }
    }

    protected void BindData()
    {
        DataSet ds = new DataSet();
        ds = objAP.GetDataforJoiningDetails();
        rptData.DataSource = ds;
        rptData.DataBind();
    }

    protected void rptData_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            TextBox ehrms = (TextBox)e.Item.FindControl("txteHRMSCode");
            TextBox joiningDate = (TextBox)e.Item.FindControl("txtJoiningDate");
            if (ehrms.Text != "")
            {
                ehrms.Enabled = false;
            }
            else
            {
                ehrms.Enabled = true;
            }
            if (joiningDate.Text != "")
            {
                joiningDate.Enabled = false;
            }
            else
            {
                joiningDate.Enabled = true;
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        if (Page.IsValid)
        {
            try
            {
                foreach (RepeaterItem item in rptData.Items)
                {
                    CheckBox chkApp = (CheckBox)item.FindControl("chkApp");
                    Label lblAppNo = (Label)item.FindControl("lblAppNo");
                    TextBox txtJoiningDate = (TextBox)item.FindControl("txtJoiningDate");
                    Label lblName = (Label)item.FindControl("lblName");
                    Label lblEmail = (Label)item.FindControl("lblEmail");
                    Label lblMobileNumber = (Label)item.FindControl("lblMobileNumber");
                    Label lblPIS = (Label)item.FindControl("lblPIS");
                    TextBox txteHRMSCode = (TextBox)item.FindControl("txteHRMSCode");

                    if (chkApp.Checked)
                    {
                        if (!string.IsNullOrEmpty(txtJoiningDate.Text))
                        {
                            objAP.UpdateJoiningDate(lblAppNo.Text, Convert.ToDateTime(txtJoiningDate.Text), null,lblPIS.Text);
                        }
                        if (txteHRMSCode.Text.Length >= 5)
                        {
                            if (!string.IsNullOrEmpty(txteHRMSCode.Text))
                            {
                                objAP.UpdateJoiningDate(lblAppNo.Text, null, txteHRMSCode.Text,lblPIS.Text);
                            }
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Invalid ehrms Code!', type: 'error', showConfirmButton: true }, function() {window.location.href='UpdateJoining.aspx');</script>");
                            txteHRMSCode.Focus();
                        }
                        if (!string.IsNullOrEmpty(txtJoiningDate.Text) && !string.IsNullOrEmpty(txteHRMSCode.Text))
                        {
                            objAP.UpdateJoiningDate(lblAppNo.Text, Convert.ToDateTime(txtJoiningDate.Text), txteHRMSCode.Text,lblPIS.Text);
                        }
                        if (string.IsNullOrEmpty(txtJoiningDate.Text))
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Enter joining Date!', type: 'error', showConfirmButton: true }, function() {window.location.href='UpdateJoining.aspx'});</script>");
                        }
                        if (string.IsNullOrEmpty(txteHRMSCode.Text))
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Enter ehrms Code!', type: 'error', showConfirmButton: true }, function() {window.location.href='UpdateJoining.aspx'});</script>");
                        }
                    }
                }
                BindData();
            }
            catch
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}