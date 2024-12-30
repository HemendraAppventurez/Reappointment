using System;
using System.Data;
using System.Globalization;
using System.Net;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CallLetter : System.Web.UI.Page
{
    DataAccessLayer objAP = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        objAP.chkCookie();
        if (!Page.IsPostBack)
        {
            BindData();
           //SendSMS("8090086779", "In reference to your application TEST for MO/Specialists, you are requested to attend interview on 11/11/22 10AM SBlko. Please check your email Thanks UPMHFW", "anupamachoudhary19@gmail.com", "123");

        }




        //EmailFormat("anupamachoudhary19@gmail.com", "1111", "Anu", "10/11/2022");


    }

    protected void BindData()
    {
        DataSet ds = new DataSet();
        ds = objAP.GetDataforCallLetters();
        rptData.DataSource = ds;
        rptData.DataBind();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            foreach (RepeaterItem item in rptData.Items)
            {
                CheckBox chkApp = (CheckBox)item.FindControl("chkApp");
                Label lblAppNo = (Label)item.FindControl("lblAppNo");
                Label lblName = (Label)item.FindControl("lblName");
                Label lblEmail = (Label)item.FindControl("lblEmail");
                Label lblEntryDate = (Label)item.FindControl("lblEntryDate");
                Label lblMobileNumber = (Label)item.FindControl("lblMobileNumber");

                if (chkApp.Checked)
                {
                    DateTime _date = DateTime.ParseExact(txtInterviewDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    objAP.UpdateInterviewDetails(lblAppNo.Text, _date, txtInterviewTime.Text, txtInterviewVenue.Text);
                    EmailFormat(lblEmail.Text, lblAppNo.Text, lblName.Text, lblEntryDate.Text);
                    //string Message = "In reference to your application(" + lblAppNo.Text + ") for MBBS Doctors/Specialists,you are requested to attend interview on " + txtInterviewDate.Text + " " + txtInterviewTime.Text + ".For details,check your email.";
                    //string Message = "In reference to your application " + lblAppNo.Text + " for MBBS/Specialists,you are requested to attend interview on " + txtInterviewDate.Text + " " + txtInterviewTime.Text + ".Please visit website and your email. Thanks, UPMHFW";

                    string Message = "In reference to your application " + lblAppNo.Text + " for MBBS/Specialists,you are requested to attend interview on " + txtInterviewDate.Text + " " + txtInterviewTime.Text + ".Please visit website and your email. Thanks, UPMHFW";

                


                    //SendSMS("8896017033", Message, "abc@abc.com", "123");
                    SendSMS(lblMobileNumber.Text, Message, lblEmail.Text, lblAppNo.Text);
                }
            }
            BindData();
        }
    }

    protected void EmailFormat(string EmailID, string ApplicationNo, string ApplicantName, string EntryDate)
    {
        try
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            MailMessage Msg = new MailMessage();
            Msg.From = new MailAddress("uphealth.walkin@gmail.com");
            Msg.To.Add(EmailID);
            Msg.Subject = "Call letter - Reappointment for MBBS Doctors/Specialists for Medical & Health Services, Uttar Pradesh";
            Msg.IsBodyHtml = true;
            //sb.Append("<html><body style='font-family:Calibri;'><div style='width:100%; background-color:#efefef; float:left;><div style='float:left;'><img src='http://111.93.62.138:8081/reappointmentportal/uplogo.png' alt='logo'/></div> <div style='float:right;'></div> </div>");
            sb.Append("<html><body style='font-family:Calibri;'>");
            sb.Append("<div style='width:100%; font-size:15px;'>Dear " + ApplicantName.ToUpper() + ",<br/><br/>");

            DataSet dsScreening = objAP.GetAppointmentScreeningDetail(ApplicationNo);
            sb.Append("We thank you for your application (Application number: " + ApplicationNo + ") on the online portal for Reappointmnet for MBBS Doctors/Specialists. We are happy to inform you that your Reappointment interview has been scheduled for ");
            sb.Append("<strong>" + Convert.ToDateTime(dsScreening.Tables[0].Rows[0]["InterviewDate"]).ToString("dd/MM/yyyy").Replace('-', '/') + " " + dsScreening.Tables[0].Rows[0]["InterviewTime"].ToString() + "</strong> at ");
            sb.Append("<strong>" + dsScreening.Tables[0].Rows[0]["InterviewVenue"].ToString() + "</strong>. As per the instructions on the application form, we request you to bring the following documents for verification on the day of your interview:<br/>");
            sb.Append("<ul>");
            //sb.Append("<li>Caste certificate (if applicable)</li>");
            //sb.Append("<li>Aadhaar card</li>");
            //sb.Append("<li>PAN Card</li>");
            //sb.Append("<li>Professional mark sheets </li>");
            //sb.Append("<li>Degree certificate</li>");
            //sb.Append("<li>Specialization certificate(if applicable)</li>");
            //sb.Append("<li>Self - declaration that you have no criminal enquiries/ records</li>");
            //sb.Append("<li>Medical Certificate from Competent Authority</li>");
            //sb.Append("<li>MCI Registration</li></ul>");
            sb.Append("<li>Post-Graduate Degree/Diploma Degree (if relevant)</li>");
            sb.Append("<li>P.P.O. (Pension Paper)</li>");
            sb.Append("<li>Medical Certificate from Competent Authority</li>");
            sb.Append("<li>PAN Card</li>");
            sb.Append("<li>Aadhar Card</li>");
            sb.Append("<li>P2 or eHRMS Code</li>");
            sb.Append("<li>Charge Certificate after retirement</li>");
            sb.Append("<li>Recommendation for extension by the concern authority (in case of extension of reappointment)</li>");
            sb.Append("<li>Performance report on the prescribed format (in case of extension of reappointment)</li>");
            sb.Append("<li>Affidavit on stamp paper of Rs. 10/-</li></ul>");
            sb.Append("</ul>");
            sb.Append("<br/>");
            sb.Append("Warm Regards,<br/>");
            sb.Append("Director General Medical Health, Uttar Pradesh,<br/>");
            sb.Append("Swasth Bhawan, Kaiserbagh, <br/>");
            sb.Append("Lucknow, Uttar Pradesh <br/>");
            sb.Append("# Contact no – 0522 2230017");
            sb.Append("</div>");
            sb.Append("</body></html>");
            Msg.Body = sb.ToString();
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
            smtp.Credentials = new System.Net.NetworkCredential("uphealth.walkin@gmail.com", "extvdzkuzesnoohw");
            smtp.EnableSsl = true;
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtp.Send(Msg);
            Msg = null;
        }
        catch (Exception ex)
        {
            Console.WriteLine("{0} Exception caught.", ex);
        }
    }

    protected void SendSMS(string MobileNumber, string Message, string EmailID, string AppNo)
    {

   

        //WebRequest request = WebRequest.Create("http://smsaanvi.alert.ind.in/sms_api/sendsms.php?username=indianhealth&password=12345678&mobile="+MobileNumber+"&sendername=UPMHFW&message="+Message+"&templateid=1607100000000128554");

        WebRequest request = WebRequest.Create("http://smsaanvi.alert.ind.in/sms_api/sendsms.php?username=indianhealth&password=12345678&mobile="+MobileNumber+"&sendername=UPMHFW&message="+Message+" &templateid=1607100000000150431");


        request.Credentials = CredentialCache.DefaultCredentials;
        HttpWebResponse response1 = (HttpWebResponse)request.GetResponse();
        System.IO.Stream dataStream = response1.GetResponseStream();
        System.IO.StreamReader reader = new System.IO.StreamReader(dataStream);
        String responseFromServer = reader.ReadToEnd();
        string SMS_Response = responseFromServer.ToString().Trim();

        reader.Close();
        dataStream.Close();
        response1.Close();

        (new DataAccessLayer()).Insert_tbl_LoginSMSDetailsReappointment(MobileNumber, Message, SMS_Response, EmailID, AppNo);
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
            spURL = "m=3&PIS=" + PIS;
            spURL = EncryptionDecryption.Encrypt1(spURL, authIV, authKey);
            spURL = spURL.Replace("+", "%2B");
            spURL = "?details=" + spURL;
            spURL = spDomain + spURL;
            spURL = spURL.Replace(" ", "%20");
            Response.Redirect(spURL);
        }
    }
}
