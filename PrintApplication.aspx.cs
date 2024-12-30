using System;
using System.Data;
using System.Globalization;

public partial class PrintApplication : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (txtAppNo.Text != "" && txtDOB.Text != "")
        {
            DataAccessLayer objPortal = new DataAccessLayer();
            DataSet ds = new DataSet();

            DateTime dob = DateTime.ParseExact(txtDOB.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);

          //  string[] date = dob.Split('/');
            ds = objPortal.GetProfile1(txtAppNo.Text,Convert.ToString(dob));
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0][0].ToString()))
            {
                string spURL = null;
                string spDomain = "PrintQuestionnaire.aspx";
                string authKey = "kRgo1HtkTn3qBp8F";
                string authIV = "Mb3QsgrG8miQzATI";
                spURL = "m=6&PIS=" + txtAppNo.Text;
                spURL = EncryptionDecryption.Encrypt1(spURL, authIV, authKey);
                spURL = spURL.Replace("+", "%2B");
                spURL = "?details=" + spURL;
                spURL = spDomain + spURL;
                spURL = spURL.Replace(" ", "%20");
                Response.Redirect(spURL);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal('', 'Incorrect Details!', 'error'); </script>");
                return;
            }
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal('', 'Enter all Mandatory Fields!', 'error'); </script>");
            return;
        }
    }
}