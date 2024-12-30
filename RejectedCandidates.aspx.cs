using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RejectedCandidates : System.Web.UI.Page
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
        ds = objAP.GetDataforRejectedCandidates();
        rptData.DataSource = ds;
        rptData.DataBind();
    }

    protected void rptData_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Undo")
        {
            string AppNo = e.CommandArgument.ToString();
            objAP.UndoScreeningVerification(AppNo);

            BindData();
        }
        if (e.CommandName == "View")
        {
            string PIS = e.CommandArgument.ToString();
            string spURL = null;
            string spDomain = "PrintQuestionnaire.aspx";
            string authKey = "kRgo1HtkTn3qBp8F";
            string authIV = "Mb3QsgrG8miQzATI";
            spURL = "m=2&PIS=" + PIS;
            spURL = EncryptionDecryption.Encrypt1(spURL, authIV, authKey);
            spURL = spURL.Replace("+", "%2B");
            spURL = "?details=" + spURL;
            spURL = spDomain + spURL;
            spURL = spURL.Replace(" ", "%20");
            Response.Redirect(spURL);
        }
    }
}