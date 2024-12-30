using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class NewsAnnouncements : System.Web.UI.Page
{
    DataAccessLayer obj = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        obj.chkCookie();
        if (!IsPostBack)
        {
            //Create a unique and random string
            string CSRF_Token = System.Guid.NewGuid().ToString();
            //First get the current page name
            string page_name = System.IO.Path.GetFileName(System.Web.HttpContext.Current.Request.Url.AbsolutePath);
            //Create the name of the session variable for the current page
            string page_token = page_name + "_ID";
            // Assign the CSRF token  to the session variable.
            Session[page_token] = CSRF_Token;
            //Finally assign the CSRF token to a hidden field
            HiddenField1.Value = CSRF_Token;
            bindNews();
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        //First build the session variable name
        string Page_Token = System.IO.Path.GetFileName(System.Web.HttpContext.Current.Request.Url.AbsolutePath) + "_ID";
        //Compare the hidden field value with the session variable of the page.
        if (HiddenField1.Value.ToString() != Session[Page_Token].ToString())
        {
            obj.sessionterminate();
        }
        else
        {
            if (!string.IsNullOrEmpty(txtNews.Text))
            {
                string fileNameMBBSNew = null, fileNameMBBSExt = null, fileNameSpecNew = null, fileNameSpecExt = null;
                if (fuMBBSNew.HasFile)
                {
                    if (fuMBBSNew.PostedFile.ContentType == "application/pdf")
                    {
                        string file = System.IO.Path.GetFileNameWithoutExtension(fuMBBSNew.PostedFile.FileName);
                        fileNameMBBSNew = file + "_" + DateTime.Now.ToString("yyyyMMddhhmmssfff") + ".pdf";
                        fuMBBSNew.PostedFile.SaveAs(Server.MapPath("~/Files/" + fileNameMBBSNew));
                    }
                }
                else
                {
                    Response.Write("<script>alert('Please upload file in PDF format')</script>");
                    fuMBBSNew.Focus();
                }
                if (fuMBBSExt.HasFile)
                {
                    if (fuMBBSExt.PostedFile.ContentType == "application/pdf")
                    {
                        string file = System.IO.Path.GetFileNameWithoutExtension(fuMBBSExt.PostedFile.FileName);
                        fileNameMBBSExt = file + "_" + DateTime.Now.ToString("yyyyMMddhhmmssfff") + ".pdf";
                        fuMBBSExt.PostedFile.SaveAs(Server.MapPath("~/Files/" + fileNameMBBSExt));
                    }
                }
                else
                {
                    Response.Write("<script>alert('Please upload file in PDF format')</script>");
                    fuMBBSExt.Focus();
                }
                if (fuSpecialistNew.HasFile)
                {
                    if (fuSpecialistNew.PostedFile.ContentType == "application/pdf")
                    {
                        string file = System.IO.Path.GetFileNameWithoutExtension(fuSpecialistNew.PostedFile.FileName);
                        fileNameSpecNew = file + "_" + DateTime.Now.ToString("yyyyMMddhhmmssfff") + ".pdf";
                        fuSpecialistNew.PostedFile.SaveAs(Server.MapPath("~/Files/" + fileNameSpecNew));
                    }
                }
                else
                {
                    Response.Write("<script>alert('Please upload file in PDF format')</script>");
                    fuSpecialistNew.Focus();
                }
                if (fuSpecialistExt.HasFile)
                {
                    if (fuSpecialistExt.PostedFile.ContentType == "application/pdf")
                    {
                        string file = System.IO.Path.GetFileNameWithoutExtension(fuSpecialistExt.PostedFile.FileName);
                        fileNameSpecExt = file + "_" + DateTime.Now.ToString("yyyyMMddhhmmssfff") + ".pdf";
                        fuSpecialistExt.PostedFile.SaveAs(Server.MapPath("~/Files/" + fileNameSpecExt));
                    }
                }
                else
                {
                    Response.Write("<script>alert('Please upload file in PDF format')</script>");
                    fuSpecialistExt.Focus();
                }
                obj.InsertIntoNews(txtNews.Text, fileNameMBBSNew, fileNameMBBSExt, fileNameSpecNew, fileNameSpecExt);
                bindNews();
            }
        }
    }


    private void bindNews()
    {
        DataTable dt = obj.GetNews();
        rptNews.DataSource = dt;
        rptNews.DataBind();
    }

    protected void rptNews_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        //First build the session variable name
        string Page_Token = System.IO.Path.GetFileName(System.Web.HttpContext.Current.Request.Url.AbsolutePath) + "_ID";
        //Compare the hidden field value with the session variable of the page.
        if (HiddenField1.Value.ToString() != Session[Page_Token].ToString())
        {
            obj.sessionterminate();
        }
        else
        {
            string command = e.CommandName;
            CheckBox chk = (CheckBox)e.Item.FindControl("chkApp");
            Label lbl = (Label)e.Item.FindControl("lblNews");
            if (chk.Checked)
            {
                if (command == "remove")
                {
                    int i = obj.DeleteNews(Convert.ToInt16(lbl.Text));
                    if (i > 0)
                    {
                        Response.Write("<script>alert('News Deleted')</script>");
                        bindNews();
                    }

                }
            }
        }
    }
}