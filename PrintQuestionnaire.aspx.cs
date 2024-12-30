using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;

public partial class ReappointmentPortal_PrintQuestionnaire : System.Web.UI.Page
{
    DataAccessLayer DLayer = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        string query = Request["details"].ToString();
        query = query.Replace("%2B", "+");
        query = query.Replace(" ", "+");
        string authKey = "kRgo1HtkTn3qBp8F";
        string authIV = "Mb3QsgrG8miQzATI";
        string DecrptURL = EncryptionDecryption.Decrypt1(query, authIV, authKey);
        //Uri myUri = new Uri("http://localhost:50267/PrintQuestionnaire.aspx?" + DecrptURL);
        Uri myUri = new Uri("http://111.93.62.138:8084/PrintQuestionnaire.aspx?" + DecrptURL);

        String regno = HttpUtility.ParseQueryString(myUri.Query).Get("m");
        Session["m"] = regno;
        String applicationNo = HttpUtility.ParseQueryString(myUri.Query).Get("PIS");

        if (!string.IsNullOrEmpty(applicationNo))
        {
            SetInnerHtmlForPIS(applicationNo);
        }
        else
        {
            Response.Redirect("~/Questionnaire.aspx");
        }
    }

    private void SetInnerHtmlForPIS(string Pis)
    {
        divDetail.InnerHtml = "";
        string _innerHtml = string.Empty;
        DataSet ds = new DataSet();
        ds = DLayer.GetProfile(Pis);
        string ResignationLetter = null;
        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
        {
            //_innerHtml += "<table style='width:100%'>";

            //"</table>";
            _innerHtml += "<table style='width:100%'>";
            _innerHtml += "<tr><td colspan='2' style='text-align:center'>&nbsp;<br/><br/></td></tr>";
            _innerHtml += "<tr><td colspan='2' style='text-align:right'><h4><span style='border:1px black solid'>Portal Round:&nbsp;<b>" + ds.Tables[0].Rows[0]["PortalRound"] + "</b></span></h4></td></tr>";
            ResignationLetter = DLayer.getResignationRecords(Pis);
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["ReasonForNotJoining"].ToString()))
            {
                _innerHtml += "<tr><td colspan='2' style='background-color:#CCC;text-align:center'><h4>For office use</h4></td></tr>";
                _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Reason for Not Joined in previous round:</b>" + ds.Tables[0].Rows[0]["ReasonForNotJoining"] + "</tr>";
            }
            else if (!string.IsNullOrEmpty(ResignationLetter))
            {
                _innerHtml += "<tr><td colspan='2' style='background-color:#CCC;text-align:center'><h4>For office use</h4></td></tr>";
                _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Previous round application status:</b>" + ResignationLetter + "</tr>";
            }
            _innerHtml += "<tr><td colspan='2' style='background-color:#CCC;text-align:center'><h4>Personal Details</h4></td></tr>";
            _innerHtml += "<tr><td style='padding:1%;'><b>Application No:</b> " + Convert.ToString(ds.Tables[0].Rows[0]["QuestionnaireKey"]) + "</td>";
            _innerHtml += "<td rowspan='5' style='padding:1%;'><div class='myDIV'  style= 'vertical-align: middle;width:150px;height:150px;border: solid 2px #000; text-align: center;background-image:url(images/images.png);background-repeat: no-repeat;  background-position-y: 10px;'></div><centre><table style='width:100%;'><tr><td style='vertical-align:bottom;padding-bottom:10%;' align='center'><b>Paste coloured<br/> photograph above.</b></td></tr></table></centre></td></tr>";

            _innerHtml += "<tr><td style='width:83%;padding:1%;'><b>Name of Applicant: </b>Dr.  " + ds.Tables[0].Rows[0]["Name"].ToString().Trim() + " </td><td></td>";
            _innerHtml += "<tr><td colspan=2 style='padding:1%;'><b>Father’s/ Mother’s/ Spouse’s Name:</b> " + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["RelativeName"])) ? Convert.ToString(ds.Tables[0].Rows[0]["RelativeName"]) : "NA") + "</td></tr>";
            _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Date of Birth:</b> " + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["DOB"])) ? Convert.ToDateTime(ds.Tables[0].Rows[0]["DOB"]).ToString("dd/MM/yyyy").Split(' ')[0] : "NA") + "</td></tr>";

            _innerHtml += "<tr><td style='padding:1%;'><b>Gender: </b>" + ds.Tables[0].Rows[0]["Gender"].ToString().Trim() + "</td><td></td></tr>";
            _innerHtml += "<tr><td style='padding:1%;'><b>Marital Status: </b>" + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["MaritalStatus"])) ? Convert.ToString(ds.Tables[0].Rows[0]["MaritalStatus"]) : "NA") + "</td><td></td></tr>";
            _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>PAN Number:</b> " + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["PANNumber"])) ? Convert.ToString(ds.Tables[0].Rows[0]["PANNumber"]) : "NA") + "</td></tr>";
            _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Aadhaar Number:</b> " + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["AadhaarNumber"])) ? Convert.ToString(ds.Tables[0].Rows[0]["AadhaarNumber"]) : "NA") + "</td></tr>";
            _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>PPO Number: </b>" + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["PPONumber"])) ? Convert.ToString(ds.Tables[0].Rows[0]["PPONumber"]) : "NA") + "</td>";





            if (ds.Tables[0].Rows[0]["MaritalStatus"].ToString().Trim() == "Married")
            {
                _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Is your spouse working as a doctor in Department of Health & Family Welfare, Uttar Pradesh?(If Married)</b></td></tr>";
                _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Spouse's PIS Number (or P2 Number/P2 Computer ID):</b> " + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["SpousePIS"])) ? Convert.ToString(ds.Tables[0].Rows[0]["SpousePIS"]) : "NA") + "</td></tr>";
            }
            _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Permanent Address:</b> " + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["PermanentAddress"])) ? Convert.ToString(ds.Tables[0].Rows[0]["PermanentAddress"]) : "NA") + "</td></tr>";

            _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Current Address: </b>" + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["CurrentAddress"])) ? Convert.ToString(ds.Tables[0].Rows[0]["CurrentAddress"]) : "NA") + "</td></tr>";
            _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Home District: </b>" + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["HDistrict"])) ? Convert.ToString(ds.Tables[0].Rows[0]["HDistrict"]) : "NA") + "</td></tr>";

            _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Mobile Number:</b> " + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["PhoneNumber"])) ? Convert.ToString(ds.Tables[0].Rows[0]["PhoneNumber"]) : "NA") + "</td></tr>";
            _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Email ID:</b> " + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["Email"])) ? Convert.ToString(ds.Tables[0].Rows[0]["Email"]) : "NA") + "</td></tr></table>";





            _innerHtml += "<table style='width:100%'>" +
                "<tr><td colspan='2' style='background-color:#CCC;text-align:center'><h4>Service Details</h4></td></tr>";
            _innerHtml += "<tr>" +
                "<td style='padding:1%;'><b>Date of Joining (of Reappointment):</b> " + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["ReJoiningDate"])) ? Convert.ToDateTime(ds.Tables[0].Rows[0]["ReJoiningDate"]).ToString("dd/MM/yyyy").Split(' ')[0] : "Not Under Reappointment") + "</td>" +
                "<td><b>Date of Relieving (of Reappointment):</b> " + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["ReRelievingDate"])) ? Convert.ToDateTime(ds.Tables[0].Rows[0]["ReRelievingDate"]).ToString("dd/MM/yyyy").Split(' ')[0] : "Not Under Reappointment") + "</td></tr>";
            _innerHtml += "<tr><td></td><td></td></tr>";

            _innerHtml += "<tr><td style='padding:1%;'><b>PIS Number(or P2 Number/ P2 Computer ID):</b> " + ds.Tables[0].Rows[0]["PISNumber"].ToString().Trim() + "</td><td><b>e - HRMS Code(or Manav Sampada Code):</b> " + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["eHRMSCode"])) ? Convert.ToString(ds.Tables[0].Rows[0]["eHRMSCode"]) : "NA") + "</td></tr>";
            _innerHtml += "<tr><td style='padding:1%;'><b>Seniority Number:</b> " + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["SeniorityNumber"])) ? Convert.ToString(ds.Tables[0].Rows[0]["SeniorityNumber"]) : "NA") + "</td><td><b>Date of Retirement:</b> " + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["DateofRetirement"])) ? Convert.ToDateTime(ds.Tables[0].Rows[0]["DateofRetirement"]).ToString("dd/MM/yyyy").Split(' ')[0] : "NA") + "</td></tr>";
            _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Level:</b> " + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["Level"])) ? Convert.ToString(ds.Tables[0].Rows[0]["Level"]) : "NA") + "</td></tr>";
            if (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["SpecialityName"])))
            {
                _innerHtml += "<tr><td style='padding:1%;'><b>Do you wish to apply for a Specialist position?: </b>" + (Convert.ToString(ds.Tables[0].Rows[0]["ApplySpecialityPosition"]) == "False" ? "NO" : "YES") + "</td><td><b>Speciality: </b>" + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["SpecialityName"])) ? Convert.ToString(ds.Tables[0].Rows[0]["SpecialityName"]) : "NA") + "</td></tr>";
            }


            _innerHtml += "<tr><td colspan='2'><br/></td></tr>";
            _innerHtml += "<tr><td colspan='2'><br/></td></tr>";
            _innerHtml += "<tr><td colspan='2' style='background-color:#CCC;text-align:center'><h4>Posting details (Start from last Posting Date)</h4></td></tr>";
            DataSet dsPostingDetails = DLayer.GetPostingDetailsfromPISNumberUpdatedEntry(Pis);
            _innerHtml += "<tr><td colspan='2' style='padding:1%;'>";
            _innerHtml += "<table style='width:98%; margin:0px auto;' class='table'>";

            _innerHtml += " <tbody><tr>";
            _innerHtml += "<th style='border -right:1px solid #e8e8e8; border-top:0px !important;'>";
            _innerHtml += "Designation";
            _innerHtml += "</th>";
            _innerHtml += " <th style='border -right:1px solid #e8e8e8; border-top:0px !important;'>";
            _innerHtml += "District";
            _innerHtml += "</th>";
            _innerHtml += "<th style='border -right:1px solid #e8e8e8; border-top:0px !important; text-align:center;'> ";
            _innerHtml += "Date of Joining";
            _innerHtml += "</th>";
            _innerHtml += "<th style='border-top: none; text-align:center;'> ";
            _innerHtml += "Date of Relieving";
            _innerHtml += "</th></tr>";
            if (dsPostingDetails != null && dsPostingDetails.Tables.Count > 0 && dsPostingDetails.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < dsPostingDetails.Tables[0].Rows.Count; i++)
                {
                    _innerHtml += "<tr>";
                    _innerHtml += " <td>" + dsPostingDetails.Tables[0].Rows[i]["designame"].ToString().Trim() + "</td>";
                    _innerHtml += "<td>" + dsPostingDetails.Tables[0].Rows[i]["districtname"].ToString().Trim() + "</td>";
                    _innerHtml += "<td style='text-align:center;'>" + (!string.IsNullOrEmpty(Convert.ToString(dsPostingDetails.Tables[0].Rows[i]["doposting"])) ? Convert.ToDateTime(dsPostingDetails.Tables[0].Rows[i]["doposting"]).ToString("dd/MM/yyyy").Split(' ')[0] : "NA").ToString() + "</td>";
                    _innerHtml += "<td style='text-align:center;'>" + (!string.IsNullOrEmpty(Convert.ToString(dsPostingDetails.Tables[0].Rows[i]["dorelieve"])) ? Convert.ToDateTime(dsPostingDetails.Tables[0].Rows[i]["dorelieve"]).ToString("dd/MM/yyyy").Split(' ')[0] : "NA").ToString() + "</td>";
                    _innerHtml += "</tr>";
                }
            }
            else
            {
                _innerHtml += "<tr><td colspan='4' style='text-align:center'>NA</td></tr>";
            }
            _innerHtml += "</tbody></table>";
            _innerHtml += "</tr></td>";


            _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>District Preference 1:</b> " + ds.Tables[0].Rows[0]["District1"].ToString().Trim() + "</td></tr>";
            _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>District Preference 2:</b> " + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["District2"])) ? Convert.ToString(ds.Tables[0].Rows[0]["District2"]) : "NA") + "</td></tr>";
            _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>District Preference 3: </b>" + (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["District3"])) ? Convert.ToString(ds.Tables[0].Rows[0]["District3"]) : "NA") + "</td></tr>";

            _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Last Drawn Salary: </b>" + (ds.Tables[0].Rows[0]["LastDrawnSalary"].ToString().Trim() == "0.00" ? "NA" : ds.Tables[0].Rows[0]["LastDrawnSalary"].ToString().Trim()) + "</td></tr>";


            _innerHtml += "<tr><td colspan='2' style='background-color:#CCC;text-align:center'><h4>Enquiry/Proceedings during Service</h4></td></tr>";

            if (ds.Tables[0].Rows[0]["DisciplinaryAction"].ToString().Trim() != "False")
                _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Disciplinary Action:</b>YES," + ds.Tables[0].Rows[0]["DisciplinaryActionDetail"].ToString().Trim() + "</td></tr>";
            else
                _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Disciplinary Action: </b>NO</td></tr>";
            if (ds.Tables[0].Rows[0]["CriminalCases"].ToString().Trim() != "False")
                _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Criminal Cases: </b>YES," + ds.Tables[0].Rows[0]["CriminalCasesDetail"].ToString().Trim() + "</td></tr>";
            else
                _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Criminal Cases: </b>NO</td></tr>";
            if (ds.Tables[0].Rows[0]["CBIEnquiry"].ToString().Trim() != "False")
                _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>CBI Enquiry: </b>YES," + ds.Tables[0].Rows[0]["CBIEnquiryDetails"].ToString().Trim() + "</td></tr>";
            else
                _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>CBI Enquiry: </b>NO</td></tr>";
            if (ds.Tables[0].Rows[0]["VigilanceEnquiry"].ToString().Trim() != "False")
                _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Vigilance Enquiry:</b>YES," + ds.Tables[0].Rows[0]["VigilanceEnquiryDetails"].ToString().Trim() + "</td></tr>";
            else
                _innerHtml += "<tr><td colspan='2' style='padding:1%;'><b>Vigilance Enquiry:</b>NO</td></tr>";
            _innerHtml += "<tr><td colspan='2' style='padding:1%;'>";
            _innerHtml += "<div class='col -md-12 Declaration'>";
            _innerHtml += "I hereby declare that the details given in the application form are true, complete and correct according to my knowledge and understanding.";
            _innerHtml += "I also accept that in the event of any information being found false, incomplete or incorrect at any point of time or if I do not fulfill the";
            _innerHtml += "qualifications of the eliibility criteria, my candidature may be cancelled without any notice.";
            _innerHtml += "I have read all the rules, regulations and procedure of reappointment given in the advertisement and I'll stictly adhere to it.<br/>";

            _innerHtml += " <br/>";
            _innerHtml += " I will continue to observe the departmental website http://uphealth.up.nic.in and if I do not contribute to the prescribed post within one month of publication ";
            _innerHtml += "of the reappointment orders on website, my application will be deemed cancelled.<br/>";

            _innerHtml += "</div>";
            _innerHtml += "</td></tr>";
            _innerHtml += "<tr><td colspan='2'> <br/></td></tr>";
            _innerHtml += "<tr><td><b>Date:</b> </td><td><b>Applicant's Signature</b></td></tr>";
            _innerHtml += "<tr><td colspan='2' style='padding:1%;'>";
            _innerHtml += "<div class='col -md-12'>";
            _innerHtml += "<strong>Note: List of documents which are to be carried along for physical verification :</strong>";
            _innerHtml += "<ul>";
            //_innerHtml += "<li>High School Certificate</li>";
            //_innerHtml += "<li>Address Proof</li>";
            //_innerHtml += "<li>MBBS Degree</li>";
            _innerHtml += "<li>Post-Graduate Degree/Diploma Degree(if relevant)</li>";
            _innerHtml += "<li>P.P.O. (Pension Paper)</li>";
            _innerHtml += "<li>Medical Certificate</li>";
            _innerHtml += "<li>PAN Card</li>";
            _innerHtml += "<li>Aadhar Card</li>";
            _innerHtml += "<li>P2 or eHRMS Code</li>";
            _innerHtml += "<li>Charge Certificate after retirement </li>";
            _innerHtml += "<li>Recommendation for extension by the concern authority(in case of extension of reappointment)</li>";
            _innerHtml += "<li><a href='Format1.pdf' target='_blank' title='Click here to download format'>Performance report on the prescribed format (in case of extension of reappointment)</a></li>";
            _innerHtml += "<li>Affidavit on stamp paper of Rs. 10/-    </li>";
            _innerHtml += "</ul>";
            _innerHtml += "</div>";
            _innerHtml += "</td></tr>";
            _innerHtml += "</table>";
        }
        divDetail.InnerHtml = _innerHtml;
    }

    private void CreatePDF()
    {
        string query = Request["details"].ToString();
        query = query.Replace("%2B", "+");
        query = query.Replace(" ", "+");
        string authKey = "kRgo1HtkTn3qBp8F";
        string authIV = "Mb3QsgrG8miQzATI";
        string DecrptURL = EncryptionDecryption.Decrypt1(query, authIV, authKey);
        //Uri myUri = new Uri("http://localhost:52814/PrintQuestionnaire.aspx?" + DecrptURL);
        Uri myUri = new Uri("http://111.93.62.138:8084/PrintQuestionnaire.aspx?" + DecrptURL);
        String applicationNo = HttpUtility.ParseQueryString(myUri.Query).Get("PIS");
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=EmployeeDetail_PIS_" + applicationNo + ".pdf");

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);

        div1.Style.Add("display", "block");
        detail.RenderControl(hw);
        //this.Page.LoadComplete(hw);
        StringReader sr = new StringReader(sw.ToString());

        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 20f, 0f);
        pdfDoc.NewPage();
        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        pdfDoc.Open();
        htmlparser.Parse(sr);
        pdfDoc.Close();
        Response.Write(pdfDoc);
        Response.End();
    }

    protected void btn_PDF_Click(object sender, EventArgs e)
    {
        CreatePDF();
    }
}