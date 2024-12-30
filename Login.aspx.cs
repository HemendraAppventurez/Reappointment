using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;

public partial class Login : System.Web.UI.Page
{
    DataAccessLayer obj = new DataAccessLayer();
    SqlConnection con;
    SqlCommand Cmd;
    DataSet ds = new DataSet();
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            StoreSaltForAdmin();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            Dictionary<string, string> AdminLoginDetails = default(Dictionary<string, string>);
            AdminLoginDetails = GetAdminLoginDetails(txtUsername.Text);
            string UserType = "";
            string hashedPasswordAndSalt;
            if ((txtPassword.Text).Length < 40 || (txtPassword.Text).Length > 40)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal('', 'Operation can not performed. Your browser is not supporting Password Encryption. Error Code #10022 !', 'error'); </script>");
                txtPassword.Text = "";
                txtUsername.Text = "";
                txtVerificationCode.Text = "";
                return;
            }
            else if (Session["CaptchaVerify"].ToString().ToUpper() != txtVerificationCode.Text)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal('', 'Invalid Verification Code. Please try again!', 'error'); </script>");
                txtPassword.Text = "";
                txtUsername.Text = "";
                txtVerificationCode.Text = "";
                return;
            }

            if (AdminLoginDetails == null)
            {
                LoginTrail("fail", "anonymous");
                hashedPasswordAndSalt = null;
                txtPassword.Text = "";
                txtUsername.Text = "";
                ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal('', 'Invalid login id/password. Please try again. Error Code #10021 !', 'error'); </script>");
            }
            else
            {
                hashedPasswordAndSalt = CreatePasswordHash(AdminLoginDetails["UPassword"].ToString() + Session["adminsalt"].ToString());
                if (hashedPasswordAndSalt.Equals(txtPassword.Text))
                {
                    UserType = AdminLoginDetails["UType"].ToString();
                    LoginTrail("success", UserType);
                    StoreSaltForAdmin();


                    string guid = Guid.NewGuid().ToString();
                    Session["AuthToken"] = guid;

                    Response.Cookies.Add(new HttpCookie("AuthToken", guid));

                    string _session = Session["AuthToken"].ToString();
                    if (UserType == "mdnhm")
                    {
                        Session["username"] = AdminLoginDetails["Uname"].ToString();
                        LoginTrail("success", UserType);
                        Server.Transfer("NHMWalkinDashboard.aspx", false);
                    }
                    else if (UserType == "Admin")
                    {
                        Session["username"] = AdminLoginDetails["Uname"].ToString();
                        LoginTrail("success", UserType);
                        Response.Redirect("~/Screening.aspx", false);
                    }
                    else if (UserType == "HRMS")
                    {
                        Session["username"] = "HRMS";
                        LoginTrail("success", UserType);
                        Response.Redirect("UpdateHRMS.aspx", false);
                    }
                    else
                    {
                        LoginTrail("fail", UserType);
                        ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Unauthenticated User ID or Password. Error Code #10020 !', type: 'error', showConfirmButton: true }, function() { window.location.href = 'Login.aspx'; });</script>");
                    }
                }

                else
                {
                    UpdateCaptchaText();
                    LoginTrail("fail", UserType);
                    ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Invalid Credentials. Error Code #10020 !', type: 'error', showConfirmButton: true }, function() { window.location.href = 'Login.aspx'; });</script>");
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void LoginTrail(string loginstatus, string usrtype)
    {
        string ip = obj.GetIPAddress();
        string mac = obj.GetMACAddress(ip);
        //obj.logTrail(txtUsername.Text, DateTime.Now, loginstatus, ip, mac, usrtype, "login");
    }
    public void UpdateCaptchaText()
    {
        Image2.ImageUrl = "Captcha.aspx";
    }
    protected void reload_Click(object sender, ImageClickEventArgs e)
    {
        UpdateCaptchaText();
    }
    public static string CreatePasswordHash(string pwd)
    {
        string hashedPwd = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(pwd, "sha1");
        return hashedPwd;
    }
    public void StoreSaltForAdmin()
    {
        int saltSize = 16;
        //HiddenField1.Value = CreateSalt(saltSize);
        Session["adminsalt"] = CreateSalt(saltSize);
        //  submit.Attributes.Add("onclick", "return AdminLogin_Validator('" + Session["adminsalt"].ToString() + "');");
    }
    public static string CreateSalt(int size)
    {
        string chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider(chars);
        byte[] buff = new byte[size];
        rng.GetBytes(buff);
        return Convert.ToBase64String(buff);
    }
    public static string GenerateLongRandomCode()
    {
        var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        var random = new Random();
        var result = new string(
            Enumerable.Repeat(chars, 16)
                      .Select(s => s[random.Next(s.Length)])
                      .ToArray());
        return result;
    }
    public Dictionary<string, string> GetAdminLoginDetails(string user_id)
    {
        Dictionary<string, string> UserloginDetail = null;
        try
        {
            con = new SqlConnection(constr);
            con.Open();
            SqlCommand Cmd = new SqlCommand("ReappintmentQuestionnaire", con);
            Cmd.CommandType = CommandType.StoredProcedure;
            Cmd.Parameters.AddWithValue("@QueryType", "Login");
            Cmd.Parameters.AddWithValue("@Username", user_id);
            Cmd.ExecuteNonQuery();
            SqlDataAdapter sda = new SqlDataAdapter(Cmd);
            sda.Fill(ds, "udetail");
            if (ds.Tables["udetail"].Rows.Count > 0)
            {
                UserloginDetail = new Dictionary<string, string>(5);
                UserloginDetail.Add("Uname", ds.Tables[0].Rows[0]["Username"].ToString());
                UserloginDetail.Add("UPassword", ds.Tables[0].Rows[0]["Password"].ToString());
                UserloginDetail.Add("UType", ds.Tables[0].Rows[0]["UserType"].ToString());

            }
            return UserloginDetail;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public static string AuthTicket
    {
        get { return HttpContext.Current.Session["AuthTicket"] as string; }
        set { HttpContext.Current.Session["AuthTicket"] = value; }
    }
    public static string SecKey
    {
        get { return HttpContext.Current.Session["ASP.NET_SessionId"] as string; }
        set { HttpContext.Current.Session["ASP.NET_SessionId"] = value; }
    }

}