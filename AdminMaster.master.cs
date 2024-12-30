using System;
using System.Collections.Generic;
//
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminMaster : System.Web.UI.MasterPage
{
    DataAccessLayer obj = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        //string w = Convert.ToString(Session["username"]);
        //if (string.IsNullOrEmpty(Convert.ToString(Session["username"])))
        //{
        //    Response.Redirect("~/Login.aspx");
        //}
        //else if (Session["username"].ToString().ToLower() != "admin")
        //{
        //    Response.Redirect("~/Login.aspx");
        //}
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        obj.sessionterminate();
        //Session["username"] = null;
        //Response.Redirect("~/Login.aspx");
    }
}
