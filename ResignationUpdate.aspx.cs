using System;
using System.Data;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ResignationUpdate : System.Web.UI.Page
{
    DataAccessLayer objAP = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        objAP.chkCookie();
        if (!Page.IsPostBack)
        {
            btnSubmit.Enabled = false;
        }
    }

    protected void BindData(string PISNumber)
    {
        DataSet ds = new DataSet();
        ds = objAP.getJoinedApplicantDetails(PISNumber);
        if (ds.Tables[0].Rows.Count > 0)
        {
            rptData.DataSource = ds;
            rptData.DataBind();
            btnSubmit.Enabled = true;
        }
        else
        {
            rptData.DataSource = null;
            rptData.DataBind();
            btnSubmit.Enabled = false;
            ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'PIS Number not valid for resignation', type: 'warning', showConfirmButton: true }, function() {});</script>");
        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
            foreach (RepeaterItem item in rptData.Items)
            {
                int i = 0;
                // CheckBox chkApp = (CheckBox)item.FindControl("chkApp");
                Label QuestionnaireKey = (Label)item.FindControl("lblAppNo");
                Label lblPIS = (Label)item.FindControl("lblPIS");
                TextBox txt = (TextBox)item.FindControl("txtResignDate");
                FileUpload fu = (FileUpload)item.FindControl("fuResignLetter");
                //if (chkApp.Checked)
                //{
                if (string.IsNullOrEmpty(txt.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Enter Resignation Date!', type: 'warning', showConfirmButton: true }, function() {});</script>");
                    txt.Focus();
                    return;
                }
                if (!fu.HasFile)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Upload File!', type: 'warning', showConfirmButton: true }, function() {});</script>");
                    fu.Focus();
                    return;
                }

                else
                {
                    if (fu.HasFile)
                    {
                        string fileName = Path.GetFileName(fu.PostedFile.FileName);
                        int extensionIndex = fileName.LastIndexOf('.');
                        string filname = fileName;
                        string extension = filname.Remove(0, extensionIndex);
                        if (extension.ToLower() == ".pdf" || extension.ToLower() == ".jpg")
                        {
                            string s;
                            string FileName = Path.GetFileNameWithoutExtension(fu.FileName) + "_" + DateTime.Now.ToString("dd_MM_yyyy_hh_mm_ss") + Path.GetExtension(fu.FileName);
                            fu.SaveAs(Server.MapPath("~/ResignationFiles/") + FileName);
                            s = "ResignationFiles/" + FileName;
                            i = objAP.insertResignationDetails(s, lblPIS.Text, DateTime.ParseExact(txt.Text, "dd/MM/yyyy", null), Convert.ToInt32(QuestionnaireKey.Text));
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Error! Upload Resignation Letter in pdf/jpg format', type: 'error', showConfirmButton: true }, function() {});</script>");
                        }
                    }
                }
                //}
                if (i > 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'The Applicant Resignation detail has been updated', type: 'info', showConfirmButton: true }, function() {});</script>");
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Kindly check the applicant for Updation', type: 'info', showConfirmButton: true }, function() {});</script>");
                }

            }
            //BindData();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        
            if (Page.IsValid)
            {
                if (txtPIS.Text == "")
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Enter PIS Number', type: 'info', showConfirmButton: true }, function() {});</script>");
                }
                else
                {
                    BindData(txtPIS.Text);
                }
            }

    }
}