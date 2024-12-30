using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ActivateEligibleApplicantforReappointment : System.Web.UI.Page
{
    DataAccessLayer objAP = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        objAP.chkCookie();
        if (!Page.IsPostBack)
        {
            BindData();
        }
    }
    protected void BindData()
    {
        DataSet ds = new DataSet();
        ds = objAP.getEligibleApplicantforReappointment();
        rptData.DataSource = ds;
        rptData.DataBind();
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        foreach (RepeaterItem item in rptData.Items)
        {
            CheckBox chkApp = (CheckBox)item.FindControl("chkApp");
            Label lblApplication = (Label)item.FindControl("lblApplication");
            if (chkApp.Checked)
            {
                objAP.ActivateEligibleCandidateForReappointment(lblApplication.Text);
                ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'The Selected Applicant is activated now!', type: 'info', showConfirmButton: true }, function() {});</script>");
            }
        }
        BindData();
    }
    protected void rptData_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "View")
        {
            string PIS = e.CommandArgument.ToString();
            string spURL = null;
            string spDomain = "PrintQuestionnaire.aspx";
            string authKey = "kRgo1HtkTn3qBp8F";
            string authIV = "Mb3QsgrG8miQzATI";
            spURL = "m=5&PIS=" + PIS;
            spURL = EncryptionDecryption.Encrypt1(spURL, authIV, authKey);
            spURL = spURL.Replace("+", "%2B");
            spURL = "?details=" + spURL;
            spURL = spDomain + spURL;
            spURL = spURL.Replace(" ", "%20");
            Response.Redirect(spURL);
        }
    }
}