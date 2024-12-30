using System;
using System.Data;
using System.Net;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MarkAppointment : System.Web.UI.Page
{
    DataAccessLayer objAP = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        objAP.chkCookie();
        if (!Page.IsPostBack)
        {
            BindData();
            //EmailFormat("", "", "", "");
            //string Message = "You have been selected as a Contractual Medical Officer under CMO/CMS. You are requested to join within 15 days of this SMS. Please visit website for details. Thanks UPMHFW";

            //SendSMS("8090086779",Message);
        }
    }

    protected void BindData()
    {
        DataSet ds = new DataSet();
        ds = objAP.GetDataforMarkingAppointment();
        rptData.DataSource = ds;
        rptData.DataBind();
    }

    protected void btnApprove_Click(object sender, EventArgs e)
    {

        foreach (RepeaterItem item in rptData.Items)
        {
            CheckBox chkApp = (CheckBox)item.FindControl("chkApp");
            Label lblAppNo = (Label)item.FindControl("lblAppNo");
            Label lblName = (Label)item.FindControl("lblName");
            Label lblEmail = (Label)item.FindControl("lblEmail");
            Label lblMobileNumber = (Label)item.FindControl("lblMobileNumber");
            Label ehrmsCode = (Label)item.FindControl("lblehrmsCode");
            Label lblPIS = (Label)item.FindControl("lblPIS");

            if (chkApp.Checked)
            {
                DateTime joiningDate = DateTime.Now.AddDays(10);
                if (joiningDate.Day == 5)//Removing Week Off Saturday
                    joiningDate = DateTime.Now.AddDays(17);
                else if (joiningDate.Day == 6)//Removing Week Off Sunday
                    joiningDate = DateTime.Now.AddDays(16);


               objAP.UpdateJoiningDate(lblAppNo.Text,joiningDate,ehrmsCode.Text,lblPIS.Text);//Update Joining by default

                objAP.MarkAppointment(lblAppNo.Text);//Update Mark appointment

                
                EmailFormat(lblEmail.Text, lblAppNo.Text, lblName.Text, ehrmsCode.Text);// Sending Email
                string Message = "You have been selected as a Contractual Medical Officer under CMO/CMS. You are requested to join within 15 days of this SMS. Please visit website for details. Thanks UPMHFW";

                SendSMS(lblMobileNumber.Text, Message);//Sending SMS

            }
        }
        BindData();
    }

    protected void EmailFormat(string EmailID, string ApplicationNo, string ApplicantName,string ehrms)
    {
        try
        {
            //EmailID = "ayushi.srivastava@ihat.in";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            MailMessage Msg = new MailMessage();
            Msg.From = new MailAddress("uphealth.walkin@gmail.com");
            Msg.To.Add(EmailID);
            Msg.Subject = "Appointment Intimation - Reappointment for MBBS Doctors/Specialists for Medical & Health Services, Uttar Pradesh";
            Msg.IsBodyHtml = true;



            sb.Append("<html><body style='font-family:Calibri;'>");
            sb.Append("<div style='width:100%; font-size:15px;'>Dear " + ApplicantName.ToUpper() + ",<br/><br/>");

            DataSet dsScreening = objAP.GetAppointmentScreeningDetail(ApplicationNo);
            sb.Append("We thank you for your application (Application number: " + ApplicationNo + ") on the online portal for Reappointment interviews for MBBS Doctors/ Specialists. We are happy to inform you that You have been selected as a Contractual Medical Officer under CMO/CMS. You are requested to join within 15 days from the date of issue of the Office Order Letter. Please visit the application portal https://reappointmentportal.tsuprogram.com for more details. Information of joining to be shared within 05 days of joining along with scan copy of your appointment letter duly signed by CMO/CMS at email ID : <strong>adswasthyabhawan@gmail.com</strong>.");
            sb.Append("<br/>");
            sb.Append("As per the instructions on the application form, we request you to bring the following original documents for verification and self-attested photo copy of official records on the day of your joining:<br/>");
            sb.Append("<ul>");
            sb.Append("<li>Caste certificate (if applicable)</li>");
            sb.Append("<li>Aadhaar card</li>");
            sb.Append("<li>PAN Card</li>");
            sb.Append("<li>Professional mark sheets </li>");
            sb.Append("<li>Degree certificate</li>");
            sb.Append("<li>Specialization certificate(if applicable)</li>");
            sb.Append("<li>Self - declaration that you have no criminal enquiries/ records</li>");
            sb.Append("<li>Medical Certificate from Competent Authority</li>");
            sb.Append("<li>MCI Registration</li></ul>");
            sb.Append("</ul><br/>");
            if (ehrms == "")
            {
                sb.Append("Also, you can download the Manav Sampada form for your kind perusal through the below link:<br/>");
                sb.Append("<br/>");
                sb.Append("<a href='https://reappointmentportal.tsuprogram.com/SampleForm-InstrusctutionBook.pdf'>Sample Form-Instruction Book</a><br/>");
                sb.Append("<a href='https://reappointmentportal.tsuprogram.com/CodeSheet.pdf'>Code Book</a><br/>");
                sb.Append("<a href='https://reappointmentportal.tsuprogram.com/ManavSampadaForm.pdf'>Manav Sampada Form</a><br/><br/>");
                sb.Append("Please fill-up and carry the Manav Sampada form during the day of joining. This form is to be filled by you, self-attested and counter-signed by respective CMO/CMS and submitted to Computer Cell, Swasthya Bhawan to generate your Manav Sampada ID. It is mandatory for all employees under the Uttar Pradesh Health System to register on Manav Sampada.<br/>");
                sb.Append("<br/><br/>");
            }
            sb.Append("Warm Regards,<br/>");
            sb.Append("Directorate of Medical and Health Services,<br/>");
            sb.Append("Swasthya Bhawan, Kaiserbagh, <br/>");
            sb.Append("Lucknow, Uttar Pradesh <br/>");
            sb.Append("# Contact no – 8860655380 Office Time Only");
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

    protected void SendSMS(string MobileNumber, string Message)
    {
        try
        {
            //MobileNumber = "8004641027";


            HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create("http://smsaanvi.alert.ind.in/sms_api/sendsms.php?username=indianhealth&password=12345678&mobile=" + MobileNumber + "&sendername=UPMHFW&message=" + Message + "&templateid=1207163222252704838");

          

            HttpWebResponse myResp = (HttpWebResponse)myReq.GetResponse();
            System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
            string responseString = respStreamReader.ReadToEnd();
            respStreamReader.Close();
            myResp.Close();
        }
        catch(Exception ex)
        {
            Console.WriteLine("{0} Exception caught.", ex);
        }
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
            spURL = "m=4&PIS=" + PIS;
            spURL = EncryptionDecryption.Encrypt1(spURL, authIV, authKey);
            spURL = spURL.Replace("+", "%2B");
            spURL = "?details=" + spURL;
            spURL = spDomain + spURL;
            spURL = spURL.Replace(" ", "%20");
            Response.Redirect(spURL);
        }
    }
}