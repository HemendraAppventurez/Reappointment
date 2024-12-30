using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class PrintProfile : System.Web.UI.Page
{
    DataAccessLayer DALayer = new DataAccessLayer();
    DataSet ds = new DataSet();
    DataSet ds1 = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["id"]))
        {
            string PISNumber = Request.QueryString["id"];
            ds = DALayer.GetProfile(PISNumber);
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                lblAadhaar.Text = ds.Tables[0].Rows[0]["AadhaarNumber"].ToString();
                lblCurrAddress.Text = ds.Tables[0].Rows[0]["CurrentAddress"].ToString();
                lblDOB.Text = !string.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOB"].ToString()) ? Convert.ToDateTime(ds.Tables[0].Rows[0]["DOB"]).ToShortDateString().Replace('-', '/') : "";
                lblEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                lblFather.Text = ds.Tables[0].Rows[0]["RelativeName"].ToString();
                lblGender.Text = ds.Tables[0].Rows[0]["Gender"].ToString();
                DataSet ds1 = DALayer.GetData("Select class_district from tbl_District where District_Id = '" + ds.Tables[0].Rows[0]["District"].ToString() + "'");
                if (ds1 != null)
                    lblHomeDistrict.Text = ds1.Tables[0].Rows[0]["class_district"].ToString();
                lblHRMS.Text = ds.Tables[0].Rows[0]["eHRMSCode"].ToString();
                lblLevel.Text = ds.Tables[0].Rows[0]["Level"].ToString();
                lblMaritalStatus.Text = ds.Tables[0].Rows[0]["MaritalStatus"].ToString();
                lblMobileNumber.Text = ds.Tables[0].Rows[0]["PhoneNumber"].ToString();
                lblName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                lblPAN.Text = ds.Tables[0].Rows[0]["PANNumber"].ToString();
                lblPermAddress.Text = ds.Tables[0].Rows[0]["PermanentAddress"].ToString();
                lblPISNumber.Text = ds.Tables[0].Rows[0]["PISNumber"].ToString();
                lblPPONumber.Text = ds.Tables[0].Rows[0]["PPONumber"].ToString();
                lblReJoining.Text = !string.IsNullOrEmpty(ds.Tables[0].Rows[0]["ReJoiningDate"].ToString()) ? Convert.ToDateTime(ds.Tables[0].Rows[0]["ReJoiningDate"]).ToShortDateString().Replace('-', '/') : "";
                lblReRelieving.Text = !string.IsNullOrEmpty(ds.Tables[0].Rows[0]["ReRelievingDate"].ToString()) ? Convert.ToDateTime(ds.Tables[0].Rows[0]["ReRelievingDate"]).ToShortDateString().Replace('-', '/') : "";
                lblRetirement.Text = !string.IsNullOrEmpty(ds.Tables[0].Rows[0]["DateofRetirement"].ToString()) ? Convert.ToDateTime(ds.Tables[0].Rows[0]["DateofRetirement"]).ToShortDateString().Replace('-', '/') : "";
                lblSalary.Text = ds.Tables[0].Rows[0]["LastDrawnSalary"].ToString();
                lblSeniority.Text = ds.Tables[0].Rows[0]["SeniorityNumber"].ToString();
                lblSpeciality.Text = ds.Tables[0].Rows[0]["Speciality"].ToString();
                lblSpouseDoc.Text = !string.IsNullOrEmpty(ds.Tables[0].Rows[0]["SpousePIS"].ToString()) ? "Yes" : "No";
                lblSpousePIS.Text = ds.Tables[0].Rows[0]["SpousePIS"].ToString();
                spnCBI.InnerHtml = Convert.ToBoolean(ds.Tables[0].Rows[0]["CBIEnquiry"]) ? "Yes<br/>" + ds.Tables[0].Rows[0]["CBIEnquiryDetails"].ToString() : "No";
                spnCriminal.InnerHtml = Convert.ToBoolean(ds.Tables[0].Rows[0]["CriminalCases"]) ? "Yes<br/>" + ds.Tables[0].Rows[0]["CriminalCasesDetail"].ToString() : "No";
                spnDisciplinary.InnerHtml = Convert.ToBoolean(ds.Tables[0].Rows[0]["DisciplinaryAction"]) ? "Yes<br/>" + ds.Tables[0].Rows[0]["DisciplinaryActionDetail"].ToString() : "No";
                spnVig.InnerHtml = Convert.ToBoolean(ds.Tables[0].Rows[0]["VigilanceEnquiry"]) ? "Yes<br/>" + ds.Tables[0].Rows[0]["VigilanceEnquiryDetails"].ToString() : "No";
                spnDistPreference.InnerHtml = "1. " + ds.Tables[0].Rows[0]["DistrictPreference1"].ToString() + (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["DistrictPreference2"].ToString()) ? "<br/>" + "2. " + ds.Tables[0].Rows[0]["DistrictPreference2"].ToString() + (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["DistrictPreference3"].ToString()) ? "<br/>" + "3. " + ds.Tables[0].Rows[0]["DistrictPreference3"].ToString() : "") : "");

                //ds.Tables[0].Rows[0]["Name"].ToString();
                //ds.Tables[0].Rows[0]["Gender"].ToString();
                //ds.Tables[0].Rows[0]["RelativeName"].ToString();
                //ds.Tables[0].Rows[0]["DateofRetirement"].ToString();
                //ds.Tables[0].Rows[0]["DOB"].ToString();
                //ds.Tables[0].Rows[0]["District"].ToString();
                //ds.Tables[0].Rows[0]["PhoneNumber"].ToString();
                //ds.Tables[0].Rows[0]["PermanentAddress"].ToString();
                //ds.Tables[0].Rows[0]["CurrentAddress"].ToString();
                //ds.Tables[0].Rows[0]["AadhaarNumber"].ToString();
                //ds.Tables[0].Rows[0]["PANNumber"].ToString();
                //ds.Tables[0].Rows[0]["PPONumber"].ToString();
                //ds.Tables[0].Rows[0]["Email"].ToString();
                //ds.Tables[0].Rows[0]["SeniorityNumber"].ToString();
                //ds.Tables[0].Rows[0]["PISNumber"].ToString();
                //ds.Tables[0].Rows[0]["eHRMSCode"].ToString();
                //ds.Tables[0].Rows[0]["[Level]"].ToString();
                //ds.Tables[0].Rows[0]["Speciality"].ToString();
                //ds.Tables[0].Rows[0]["DistrictPreference1"].ToString();
                //ds.Tables[0].Rows[0]["DistrictPreference2"].ToString();
                //ds.Tables[0].Rows[0]["DistrictPreference3"].ToString();
                //ds.Tables[0].Rows[0]["LastDrawnSalary"].ToString();
                //ds.Tables[0].Rows[0]["DisciplinaryAction"].ToString();
                //ds.Tables[0].Rows[0]["DisciplinaryActionDetail"].ToString();
                //ds.Tables[0].Rows[0]["CriminalCases"].ToString();
                //ds.Tables[0].Rows[0]["CriminalCasesDetail"].ToString();
                //ds.Tables[0].Rows[0]["DifferentFromMSData"].ToString();
                //ds.Tables[0].Rows[0]["ReJoiningDate"].ToString();
                //ds.Tables[0].Rows[0]["ReRelievingDate"].ToString();
                //ds.Tables[0].Rows[0]["MaritalStatus"].ToString();
                //ds.Tables[0].Rows[0]["SpousePIS"].ToString();
                //ds.Tables[0].Rows[0]["CBIEnquiry"].ToString();
                //ds.Tables[0].Rows[0]["CBIEnquiryDetails"].ToString();
                //ds.Tables[0].Rows[0]["VigilanceEnquiry"].ToString();
                //ds.Tables[0].Rows[0]["VigilanceEnquiryDetails"].ToString();

            }
        }
        else
            Response.Redirect("Questionnaire.aspx");
    }
}