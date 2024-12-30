using System;
using System.Data;
using System.Globalization;
using System.Net;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Questionnaire : System.Web.UI.Page
{
    DataAccessLayer DALayer = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(this.GetType(), "msg123", "<script>enableDisableDetailDisc();enableDisableDetailCrim();enableDisableDetailCBI();enableDisableDetailVig();enableDisableReappointment();MaritalStatus();Speciality();</script>");
        if (!IsPostBack)
        {
            hidAddEditMode.Value = "Add";
            SetCombos();
            DataSet ds = new DataSet();
            ds = DALayer.getRosterFile();
            MBBSimg.ImageUrl = @"images/PDF-icon.png";
            specialistimg.ImageUrl = @"images/PDF-icon.png";
            MBBS.HRef = ds.Tables[0].Rows[0][0].ToString();
            MBBS.InnerText = "MBBS Vacancy Roster";
            specialist.HRef = ds.Tables[0].Rows[0][2].ToString();
            specialist.InnerText = "Specialist Vacancy Roster";
            DataTable dt = DALayer.Get10News();
            string str = "";
            int i = 1;
            foreach (DataRow row in dt.Rows)
            {
                if (i == 1)
                {
                    if (row[2].ToString() == "")
                    {
                        str += "<li><a href = 'Files/" + row[1].ToString() + "' target = '_blank' > " + row[5].ToString() + "</a><img src = 'images/new.gif' width = '50' height = '30'/></li>";
                    }
                    else
                    {
                        str += "<li>" + row[5].ToString() +
                            "&nbsp;&nbsp;";
                        if (row[1] != null)
                            str += "<a href='Files/" + row[1].ToString() + "' target = '_blank'> MBBS New</a> &nbsp;&nbsp;";
                        if (row[2] != null)
                            str += "<a href ='Files/" + row[2].ToString() + "' target = '_blank' >MBBS Extention</a> &nbsp;&nbsp;";
                        if (row[3] != null)
                            str += "<a href='Files/" + row[3].ToString() + "' target = '_blank'>Specialist New</a> &nbsp;&nbsp;";
                        if (row[4] != null)
                            str += "<a href ='Files/" + row[4].ToString() + "' target = '_blank' >Specialist Extention</a>";
                        str += "<img src = 'images/new.gif' width = '50' height = '30'/></li>";
                    }
                    i++;
                }
                else
                {
                    if (row[2].ToString() == "")
                    {
                        str += "<li><a href = 'Files/" + row[1].ToString() + "' target = '_blank' > " + row[5].ToString() + "</a></li>";
                    }
                    else
                    {
                        str += "<li>&nbsp;" + row[5].ToString() + "&nbsp;&nbsp;";
                        if (row[1] != null)
                            str += "<a href='Files/" + row[1].ToString() + "' target = '_blank'> MBBS New</a> &nbsp;&nbsp;";
                        if (row[2] != null)
                            str += "<a href ='Files/" + row[2].ToString() + "' target = '_blank' >MBBS Extention</a> &nbsp;&nbsp;";
                        if (row[3] != null)
                            str += "<a href='Files/" + row[3].ToString() + "' target = '_blank'>Specialist New</a> &nbsp;&nbsp;";
                        if (row[4] != null)
                            str += "<a href ='Files/" + row[4].ToString() + "' target = '_blank' >Specialist Extention</a>";
                        str += "</li>";
                    }
                    i++;
                }
            }
            //foreach (DataRow row in dt.Rows)
            //{
            //    if (i == 1)
            //    {

            //        str += "<li>" + row[5].ToString() +
            //            "&nbsp;&nbsp;";
            //        if (row[1] != null)
            //            str += "<a href='Files/" + row[1].ToString() + "' target = '_blank'> MBBS New</a> &nbsp;&nbsp;";
            //        if (row[2] != null)
            //            str += "<a href ='Files/" + row[2].ToString() + "' target = '_blank' >MBBS Extention</a> &nbsp;&nbsp;";
            //        if (row[3] != null)
            //            str += "<a href='Files/" + row[3].ToString() + "' target = '_blank'>Specialist New</a> &nbsp;&nbsp;";
            //        if (row[4] != null)
            //            str += "<a href ='Files/" + row[4].ToString() + "' target = '_blank' >Specialist Extention</a>";
            //        str += "<img src = 'images/new.gif' width = '50' height = '50'/></li>";
            //        i++;
            //    }
            //    else
            //    {
            //        str += "<li>&nbsp;" + row[5].ToString() + "&nbsp;&nbsp;";
            //        if (row[1] != null)
            //            str += "<a href='Files/" + row[1].ToString() + "' target = '_blank'> MBBS New</a> &nbsp;&nbsp;";
            //        if (row[2] != null)
            //            str += "<a href ='Files/" + row[2].ToString() + "' target = '_blank' >MBBS Extention</a> &nbsp;&nbsp;";
            //        if (row[3] != null)
            //            str += "<a href='Files/" + row[3].ToString() + "' target = '_blank'>Specialist New</a> &nbsp;&nbsp;";
            //        if (row[4] != null)
            //            str += "<a href ='Files/" + row[4].ToString() + "' target = '_blank' >Specialist Extention</a>";
            //        str += "</li>";
            //        i++;
            //    }
            //}
            news.InnerHtml = str;
            DataSet dsDate = DALayer.OpenPortal();
            if (dsDate.Tables[0].Rows.Count > 0)
            {
                DateTime OpeningDate = Convert.ToDateTime(dsDate.Tables[0].Rows[0][0].ToString());
                DateTime ClosingDate = Convert.ToDateTime(dsDate.Tables[0].Rows[0][1].ToString());

                if (DateTime.Today <= ClosingDate && DateTime.Now >= OpeningDate)
                {
                    divClosePortal.Style.Add("display", "none");
                    divOpenPortal.Style.Add("display", "block");
                }
                else
                {
                    divClosePortal.Style.Add("display", "block");
                    divOpenPortal.Style.Add("display", "none");
                }
            }
        }

    }

    protected void SetCombos()
    {
        DataSet dsDistrict = DALayer.GetDistricts();

        ddlDistrict.DataSource = dsDistrict;
        ddlDistrict.DataTextField = "Class_District";
        ddlDistrict.DataValueField = "District_Id";
        ddlDistrict.DataBind();

        ddlHomeDistrict.DataSource = dsDistrict;
        ddlHomeDistrict.DataTextField = "Class_District";
        ddlHomeDistrict.DataValueField = "District_Id";
        ddlHomeDistrict.DataBind();
        ddlHomeDistrict.Items.Insert(75, new ListItem("Other", "76"));

        ddlDistPreference1.DataSource = dsDistrict;
        ddlDistPreference1.DataTextField = "Class_District";
        ddlDistPreference1.DataValueField = "District_Id";
        ddlDistPreference1.DataBind();
        ddlDistPreference1.Items.Insert(0, new ListItem("Select First preference", "0"));

        ddlDesig.DataSource = DALayer.GetDesignations();
        ddlDesig.DataTextField = "DesignationName";
        ddlDesig.DataValueField = "DesignationKey";
        ddlDesig.DataBind();

        ddlSpeciality.DataSource = DALayer.GetSpeciality();
        ddlSpeciality.DataTextField = "SpecialityName";
        ddlSpeciality.DataValueField = "SpecialityKey";
        ddlSpeciality.DataBind();
        ddlSpeciality.Items.Insert(0, new ListItem("Select Speciality", "0"));

        ddlDistPreference2.Items.Insert(0, new ListItem("Select Second preference", "0"));
        ddlDistPreference2.Enabled = false;

        ddlDistPreference3.Items.Insert(0, new ListItem("Select Third preference", "0"));
        ddlDistPreference3.Enabled = false;
        hidHRMSDiff.Value = "0";
        btnChangeDetail.Visible = false;
        lblEdit.Visible = false;
    }

    protected void btnChangeDetails_Click(object sender, EventArgs e)
    {
        EnablePISFields();
        hidHRMSDiff.Value = "1";
    }
    protected void ClearFields()
    {
        txtAadhaar.Text = "";
        txtCriminalCasesDetails.Text = "";
        txtCurrentAddress.Text = "";
        txtDisciplinaryActionDetails.Text = "";
        txtDOB.Text = "";
        txtEmail.Text = "";
        txtHRMSCode.Text = "";
        txtJoining.Text = "";
        txtLastDrawnSal.Text = "";
        txtName.Text = "";
        txtPermAddress.Text = "";
        txtPhone.Text = "";
        txtPISNumber.Text = "";
        txtRelativeName.Text = "";
        txtRelieving.Text = "";
        txtRetirementDate.Text = "";
        txtSeniority.Text = "";
    }

    protected void EnablePISFields()
    {
        if (rblNewOrExtension.SelectedValue == "1")
        {
            txtDOB.Enabled = true;
            txtName.Enabled = true;
            ddlHomeDistrict.Enabled = true;
            txtRelativeName.Enabled = true;
            //txtPISNumber.Enabled = true;
            txtSeniority.Enabled = true;
            ddlLevel.Enabled = true;
            txtPermAddress.Enabled = true;
            txtCurrentAddress.Enabled = true;
        }
        else
        {
            txtDOB.Enabled = true;
            txtName.Enabled = true;
            ddlHomeDistrict.Enabled = true;
            txtRelativeName.Enabled = true;
            txtPANNumber.Enabled = true;
            ddlGender.Enabled = true;
            txtRetirementDate.Enabled = true;
            //txtPISNumber.Enabled = true;
            txtSeniority.Enabled = true;
            ddlLevel.Enabled = true;
            txtPermAddress.Enabled = true;
            txtCurrentAddress.Enabled = true;
        }
    }

    protected void DisablePISFields()
    {
        if (!string.IsNullOrEmpty(txtDOB.Text))
            txtDOB.Enabled = false;
        if (!string.IsNullOrEmpty(txtName.Text))
            txtName.Enabled = false;
        if (ddlHomeDistrict.SelectedValue == "0")
            ddlHomeDistrict.Enabled = true;
        if (!string.IsNullOrEmpty(txtRelativeName.Text))
            txtRelativeName.Enabled = false;
        if (!string.IsNullOrEmpty(txtPISNumber.Text))
            txtPISNumber.Enabled = false;
        if (!string.IsNullOrEmpty(txtSeniority.Text))
            txtSeniority.Enabled = false;
        if (ddlLevel.SelectedValue != "0")
            ddlLevel.Enabled = false;
        if (!string.IsNullOrEmpty(txtPermAddress.Text))
            txtPermAddress.Enabled = false;
        if (!string.IsNullOrEmpty(txtCurrentAddress.Text))
            txtCurrentAddress.Enabled = false;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            int FlagProceed = 0; Int16 AppointedBefore = 0;
            hidAppointmentStatus.Value = "0";

            if (!string.IsNullOrEmpty(txtPISNumber.Text))
            {
                Int16 PISExist = DALayer.CheckPISExistence(txtPISNumber.Text);

                //Uncomment from Here --------------------------------------------------------
                if (PISExist == 2)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'You have already applied for Reappointment.', type:'info', showConfirmButton: true});</script>");
                    return;
                }
                else if (PISExist == 1)
                {
                    AppointedBefore = DALayer.CheckAppointmentStatus(txtPISNumber.Text);
                    // Applicant has been appointed and he has joined.
                    if (AppointedBefore == 0)
                    {
                        //ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'You have already been Reappointed!', type: 'error', showConfirmButton: true }, function() { window.location.href = 'Questionnaire.aspx'; });</script>");
                        //return;

                        divWantToReapply.Style.Add("display", "block");
                        divNews.Style.Add("display", "none");
                        rblNewOrExtension.Enabled = false;
                        return;
                    }
                    else
                    {
                        // Applicant has been allowed to reapply,
                        if (AppointedBefore == 100)
                        {
                            rblNewOrExtension.SelectedValue = "0";
                            ClientScript.RegisterStartupScript(this.GetType(), "msg124", "<script>enableDisableReappointment();</script>");
                            rblNewOrExtension.Enabled = false;
                            FlagProceed = 1;
                        }

                        // Applicant has been appointed and he has not joined. And he has not reapplied more than 3 times,
                        else if (AppointedBefore < 3)
                        {
                            FlagProceed = 1;
                        }
                        // Applicant has already been appointed for 3 times and he has not joined.
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'You cannot apply anymore!', type: 'error', showConfirmButton: true }, funation() { window.location.href = 'Questionnaire.aspx'; });</script>");
                            return;
                        }
                    }

                }

                if (PISExist == 0 || FlagProceed == 1)
                {

                    if (FlagProceed == 1)
                    {
                        divNotJoining.Style.Add("display", "block;");
                        rfvReasonNotJoining.Enabled = true;
                    }
                    else
                    {
                        divNotJoining.Style.Add("display", "none;");
                        rfvReasonNotJoining.Enabled = false;
                    }

                    if (AppointedBefore == 1)
                    {
                        divNotJoining.Style.Add("display", "none;");
                        rfvReasonNotJoining.Enabled = false;
                    }
                    hidHRMSDiff.Value = "0";

                    DataSet ds = new DataSet();
                    DataSet dsPostingDetails = new DataSet();
                    if (rblNewOrExtension.SelectedValue == "1")
                    {
                        if (AppointedBefore == 2)
                        {
                            //Get Resigned Candidates Data
                            ds = DALayer.GetDataForExtention(txtPISNumber.Text);
                            dsPostingDetails = DALayer.GetPostingDetailsForExtention(txtPISNumber.Text);
                            NewMethod(ds);
                        }
                        else
                        {
                            //Get New Candidates Data
                            ds = DALayer.GetDatafromPISNumber(txtPISNumber.Text);
                            dsPostingDetails = DALayer.GetPostingDetailsfromPISNumber(txtPISNumber.Text);

                            if (dsPostingDetails != null && dsPostingDetails.Tables.Count > 0 && dsPostingDetails.Tables[0].Rows.Count > 0)
                            {

                                if (ds.Tables[0].Rows[0]["ehrms"].ToString() == "1")
                                {
                                    txtHRMSCode.Text = ds.Tables[0].Rows[0]["PISNumber"].ToString();
                                    if (txtHRMSCode.Text != "")
                                        txtHRMSCode.Enabled = false;
                                }
                            }
                        }
                    }
                    else
                    {
                        //For Extention 
                        ds = DALayer.GetDataForExtention(txtPISNumber.Text);
                        dsPostingDetails = DALayer.GetPostingDetailsForExtention(txtPISNumber.Text);
                        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        {
                            NewMethod(ds);
                            //Bind Prefered District
                            NewMethod1(ds);
                        }
                    }
                    if (ds != null && ds.Tables[0].Rows.Count > 0)
                    {
                        txtDOB.Text = !string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["DOB"])) ? String.Format("{0:dd/MM/yyyy}", Convert.ToDateTime(ds.Tables[0].Rows[0]["DOB"])).Replace('-', '/') : "";
                        txtAge.Text = ds.Tables[0].Rows[0]["Age"].ToString();
                        txtName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                        txtRelativeName.Text = ds.Tables[0].Rows[0]["FatherHusbName"].ToString();
                        txtSeniority.Text = ds.Tables[0].Rows[0]["SeniorityNumber"].ToString();
                        txtPermAddress.Text = ds.Tables[0].Rows[0]["PermAddress"].ToString();
                        txtCurrentAddress.Text = ds.Tables[0].Rows[0]["CurrentAddress"].ToString();
                        ddlLevel.SelectedValue = ds.Tables[0].Rows[0]["Level"].ToString();
                        DataSet ds1 = DALayer.GetData("Select District_ID from tbl_District1 where class_district = '" + ds.Tables[0].Rows[0]["HomeDistrict"].ToString() + "'");
                        if (ds1 != null && ds1.Tables[0].Rows.Count > 0)
                            ddlHomeDistrict.SelectedValue = ds1.Tables[0].Rows[0]["District_ID"].ToString();
                        else if (ds1 != null && ds1.Tables[0].Rows.Count == 0)
                        {
                            if (rblNewOrExtension.SelectedValue == "1")
                            {
                                ddlHomeDistrict.Items.Insert(0, new ListItem("Select", "0"));
                                ddlHomeDistrict.SelectedValue = "0";
                            }
                        }
                        DisablePISFields();
                        btnChangeDetail.Visible = true;
                        lblEdit.Visible = true;

                        divForm.Style.Add("display", "block");
                        divNews.Style.Add("display", "none");

                        if (dsPostingDetails != null)
                        {
                            AddDefaultFirstRecord();
                            DataTable dtCurrentTable = (DataTable)ViewState["Positions"];
                            DataRow drCurrentRow = null;

                            ViewState["Positions"] = dsPostingDetails.Tables[0];

                            for (int i = 0; i < dsPostingDetails.Tables[0].Rows.Count; i++)
                            {
                                //add each row into data table  
                                drCurrentRow = dtCurrentTable.NewRow();
                                drCurrentRow["ID"] = dsPostingDetails.Tables[0].Rows[i]["ID"];
                                ds1 = DALayer.GetData("Select DesignationKey from Designation where DesignationName = '" + dsPostingDetails.Tables[0].Rows[i]["designame"].ToString() + "'");
                                if (ds1 != null)
                                {
                                    drCurrentRow["DesignationName"] = dsPostingDetails.Tables[0].Rows[i]["designame"];
                                    drCurrentRow["Designation"] = ds1.Tables[0].Rows.Count > 0 ? ds1.Tables[0].Rows[0]["DesignationKey"].ToString() : "0";
                                }
                                ds1 = DALayer.GetData("Select District_ID from tbl_District1 where Class_District = '" + dsPostingDetails.Tables[0].Rows[i]["districtname"].ToString() + "'");
                                if (ds1 != null)
                                {
                                    drCurrentRow["DistrictName"] = dsPostingDetails.Tables[0].Rows[i]["districtname"];
                                    drCurrentRow["District"] = ds1.Tables[0].Rows.Count > 0 ? ds1.Tables[0].Rows[0]["District_ID"].ToString() : "0";
                                }
                                drCurrentRow["Joining"] = !string.IsNullOrEmpty(Convert.ToString(dsPostingDetails.Tables[0].Rows[i]["doposting"])) ? Convert.ToDateTime(dsPostingDetails.Tables[0].Rows[i]["doposting"]) : Convert.ToDateTime("01/01/0001");
                                drCurrentRow["Relieving"] = !string.IsNullOrEmpty(Convert.ToString(dsPostingDetails.Tables[0].Rows[i]["dorelieve"])) ? Convert.ToDateTime(dsPostingDetails.Tables[0].Rows[i]["dorelieve"]) : Convert.ToDateTime("01/01/0001");

                                dtCurrentTable.Rows.Add(drCurrentRow);
                            }
                            if (dtCurrentTable.Rows[0][0].ToString() == "")
                            {
                                dtCurrentTable.Rows[0].Delete();
                                dtCurrentTable.AcceptChanges();
                            }

                            ViewState["Positions"] = dtCurrentTable;
                            rptPositions.DataSource = dtCurrentTable;
                            rptPositions.DataBind();
                        }

                    }
                    else
                    {
                        divForm.Style.Add("display", "none");
                        divNews.Style.Add("display", "block");
                        ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Invalid PIS Number!', type: 'error', showConfirmButton: true }, function() { window.location.href = 'Questionnaire.aspx'; });</script>");
                        return;
                    }
                }
                // Uncomment till here ----------------------------------------------------------------------------------
                if (AppointedBefore == 1)
                {
                    hidAppointmentStatus.Value = "0";
                    divNotJoining.Style.Add("display", "block;");
                    rfvReasonNotJoining.Enabled = false;
                }
                else
                {
                    hidAppointmentStatus.Value = AppointedBefore.ToString();
                    divNotJoining.Style.Add("display", "none;");
                    rfvReasonNotJoining.Enabled = false;
                }
            }
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Error Occured!', type: 'error', showConfirmButton: true });</script>");
            // btnSearch.Visible = true;
            return;
        }
    }

    private void NewMethod1(DataSet ds)
    {
        ddlDistPreference1.SelectedValue = ds.Tables[0].Rows[0]["DistrictPreference1"].ToString();
        ddlDistPreference2.DataSource = DALayer.GetDistrictsForPref(ddlDistPreference1.SelectedValue + "," + ddlDistPreference3.SelectedValue);
        ddlDistPreference2.DataTextField = "ManavSampada_DistrictName";
        ddlDistPreference2.DataValueField = "District_Id";
        ddlDistPreference2.DataBind();
        ddlDistPreference2.Items.Insert(0, new ListItem("Select Second preference", "0"));
        ddlDistPreference2.SelectedValue = ds.Tables[0].Rows[0]["DistrictPreference2"].ToString();
        ddlDistPreference3.DataSource = DALayer.GetDistrictsForPref(ddlDistPreference2.SelectedValue + "," + ddlDistPreference1.SelectedValue);
        ddlDistPreference3.DataTextField = "ManavSampada_DistrictName";
        ddlDistPreference3.DataValueField = "District_Id";
        ddlDistPreference3.DataBind();
        ddlDistPreference3.Items.Insert(0, new ListItem("Select third preference", "0"));
        ddlDistPreference3.SelectedValue = ds.Tables[0].Rows[0]["DistrictPreference3"].ToString();
        ddlDistPreference1.Enabled = false;
        ddlDistPreference2.Enabled = false;
        ddlDistPreference3.Enabled = false;
    }

    private void NewMethod(DataSet ds)
    {
        txtAge.Text = ds.Tables[0].Rows[0]["Age"].ToString();
        txtPhone.Text = ds.Tables[0].Rows[0]["PhoneNumber"].ToString();
        txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
        txtRetirementDate.Text = ds.Tables[0].Rows[0]["DateofRetirement"].ToString();
        txtAadhaar.Text = ds.Tables[0].Rows[0]["AadhaarNumber"].ToString();
        txtPANNumber.Text = ds.Tables[0].Rows[0]["Pannumber"].ToString();
        txtPPONumber.Text = ds.Tables[0].Rows[0]["PPOnumber"].ToString();
        txtHRMSCode.Text = ds.Tables[0].Rows[0]["eHRMSCode"].ToString();
        ddlSpeciality.SelectedValue = !string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Speciality"].ToString()) ? ds.Tables[0].Rows[0]["Speciality"].ToString() : "0";
        ddlGender.SelectedValue = !string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Gender"].ToString()) ? ds.Tables[0].Rows[0]["Gender"].ToString() : "0";
        ddlHomeDistrict.SelectedValue = "76";
        if (ds.Tables[0].Rows[0]["District"].ToString() == "0")
        {
            divOtherHomeDistrict.Style.Add("Display", "block");
            txtOtherDistrictState.Text = ds.Tables[0].Rows[0]["OtherDistrictStateName"].ToString();
            if (txtOtherDistrictState.Text == "")
                txtOtherDistrictState.Enabled = true;
            else
                txtOtherDistrictState.Enabled = false;
        }
        if (ds.Tables[0].Rows[0]["MaritalStatus"].ToString() == "Married")
        {
            rblMaritalStatus.SelectedValue = ds.Tables[0].Rows[0]["MaritalStatus"].ToString();
        }
        else
        {
            rblMaritalStatus.SelectedValue = "Unmarried";
        }
        if (Convert.ToBoolean(ds.Tables[0].Rows[0]["SpouseDoctor"]))
        {
            rblSpouseDoc.SelectedValue = "1";
            txtSpousePIS.Text = ds.Tables[0].Rows[0]["SpousePIS"].ToString();
            if (txtSpousePIS.Text == "")
                txtSpousePIS.Enabled = true;
            else
                txtSpousePIS.Enabled = false;
        }
        else
        {
            rblSpouseDoc.SelectedValue = "0";
        }

        if (!Convert.ToBoolean(ds.Tables[0].Rows[0]["CriminalCases"].ToString()))
        {
            rbCriminalCases.SelectedValue = "0";
        }
        else
        {
            rbCriminalCases.SelectedValue = "1";
            txtCriminalCasesDetails.Text = ds.Tables[0].Rows[0]["CriminalCasesDetail"].ToString();
        }
        if (!Convert.ToBoolean(ds.Tables[0].Rows[0]["CBIEnquiry"].ToString()))
        {
            rblCBIEnquiry.SelectedValue = "0";
        }
        else
        {
            rblCBIEnquiry.SelectedValue = "1";
            txtCBIEnquiry.Text = ds.Tables[0].Rows[0]["CBIEnquiryDetails"].ToString();
        }
        if (!Convert.ToBoolean(ds.Tables[0].Rows[0]["VigilanceEnquiry"].ToString()))
        {
            rblVigilance.SelectedValue = "0";
        }
        else
        {
            rblVigilance.SelectedValue = "1";
            txtVigilance.Text = ds.Tables[0].Rows[0]["VigilanceEnquiryDetails"].ToString();
        }
        if (!Convert.ToBoolean(ds.Tables[0].Rows[0]["DisciplinaryAction"].ToString()))
        {
            rbDisciplinaryAction.SelectedValue = "0";
        }
        else
        {
            rbDisciplinaryAction.SelectedValue = "1";
            txtDisciplinaryActionDetails.Text = ds.Tables[0].Rows[0]["DisciplinaryActionDetail"].ToString();
        }
        if (txtPPONumber.Text == "")
            txtPPONumber.Enabled = true;
        else
            txtPPONumber.Enabled = false;
        if (txtPANNumber.Text == "")
            txtPANNumber.Enabled = true;
        else
            txtPANNumber.Enabled = false;
        if (txtAadhaar.Text == "")
            txtAadhaar.Enabled = true;
        else
            txtAadhaar.Enabled = false;
        if (txtHRMSCode.Text == "")
            txtHRMSCode.Enabled = true;
        else
            txtHRMSCode.Enabled = false;
        if (ddlSpeciality.SelectedIndex == 0)
            ddlSpeciality.Enabled = true;
        else
            ddlSpeciality.Enabled = false;
        if (ddlGender.SelectedIndex != 0)
            ddlGender.Enabled = false;
        else
            ddlGender.Enabled = true;
        txtRetirementDate.Enabled = false;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (rblNewOrExtension.SelectedValue == "0" && string.IsNullOrEmpty(txtReRelieving.Text))
        {
            rfvReRelieving.Enabled = true;
            txtReRelieving.Focus();
            ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Enter Relieving Date', type: 'error', showConfirmButton: true });</script>");
            return;
        }
        else
        {
            if (!string.IsNullOrEmpty(txtPISNumber.Text))
            {
                if (((DataTable)ViewState["Positions"]).Rows.Count == 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Enter Posting Details', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                if (!ValidateString(txtName.Text) || !ValidateString(txtRelativeName.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Special Characters are not allowed in Name', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (Convert.ToInt16(txtAge.Text) < 60)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Age less than 60 years as on date is not allowed', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (!ValidateDate(txtDOB.Text) || !ValidateDate(txtRetirementDate.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Invalid Date Format', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (!ValidateMobileNumber(txtPhone.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Invalid Mobile Number', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (!ValidateEmailID(txtEmail.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Invalid Email ID', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if ((txtPermAddress.Text != "" && !ValidateAddress(txtPermAddress.Text)) || (txtCurrentAddress.Text != "" && !ValidateAddress(txtCurrentAddress.Text)))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Special Characters are not allowed in Address', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (txtAadhaar.Text != "" && !ValidateAddhar(txtAadhaar.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Invalid Adhaar Number', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (txtPANNumber.Text == "")
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Enter Pan Number', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (!ValidatePANNumber(txtPANNumber.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Invalid Pan Number', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (txtPPONumber.Text != "" && !ValidatePPONumber(txtPPONumber.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Invalid PPO Number', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (!ValidateSeniorityNumber(txtSeniority.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Invalid Seniority Number', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (txtHRMSCode.Text != "" && !ValidateEhrms(txtHRMSCode.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Invalid Seniority Number', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (txtLastDrawnSal.Text != "" && !ValidateLastSalaryDrawn(txtLastDrawnSal.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Invalid Salary Format', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (txtLastDrawnSal.Text != "" && !ValidateLastSalaryDrawn(txtLastDrawnSal.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Invalid Salary Format', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (txtDisciplinaryActionDetails.Text != "" && !ValidateProceeding(txtDisciplinaryActionDetails.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Invalid Discriplinary Action Format', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (txtCriminalCasesDetails.Text != "" && !ValidateProceeding(txtCriminalCasesDetails.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Invalid Criminal Cases Format', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (txtCBIEnquiry.Text != "" && !ValidateProceeding(txtCBIEnquiry.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Invalid CBI Enquiry Format', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                else if (txtVigilance.Text != "" && !ValidateProceeding(txtVigilance.Text))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Invalid Vigilance Enquiry Format', type: 'error', showConfirmButton: true });</script>");
                    return;
                }
                String nm = txtName.Text;
                String gndr = ddlGender.SelectedItem.Text;
                String RelativeName = txtRelativeName.Text;

                DateTime dob =DateTime.ParseExact(txtDOB.Text, "dd/MM/yyyy", null);

                Int16 dist = ddlHomeDistrict.SelectedItem.Value == "76" ? Convert.ToInt16(0) : Convert.ToInt16(ddlHomeDistrict.SelectedItem.Value);
                String PhNum = txtPhone.Text;
                String PAddress = txtPermAddress.Text;

                String CAddress = txtCurrentAddress.Text;
                String Aadhaar = txtAadhaar.Text;
                DateTime RetirementDt = DateTime.ParseExact(txtRetirementDate.Text, "dd/MM/yyyy", null);
                String Email = txtEmail.Text;

                String SeniorityNum = txtSeniority.Text;
                String PISNum = txtPISNumber.Text;
                String eHRMS = txtHRMSCode.Text;
                String lvl = ddlLevel.SelectedItem.Text;

                Boolean ApplyForSpeciality = false;
                Int16 Speciality = Convert.ToInt16(ddlSpeciality.SelectedValue);
                if (ddlSpeciality.SelectedValue != "0")
                    ApplyForSpeciality = rblApplySpecPos.SelectedValue == "0" ? false : true;
                else
                    ApplyForSpeciality = false;

                DateTime reJoining;
                if (txtReJoining.Text!=null && txtReJoining.Text!="")
                {
                    reJoining= DateTime.ParseExact(txtReJoining.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture); //Convert.ToDateTime(txtReJoining.Text);
                }
                else
                {
                    reJoining= Convert.ToDateTime("01/01/0001");
                }
                 //!string.IsNullOrEmpty(txtReJoining.Text) ? DateTime.ParseExact(txtReJoining.Text, "dd/MM/yyyy", null) : DateTime.ParseExact(txtReJoining.Text, "01/01/0001", null);
               // DateTime reRelieving = !string.IsNullOrEmpty(txtReRelieving.Text) ? Convert.ToDateTime(txtReRelieving.Text) : Convert.ToDateTime("01/01/0001");


                DateTime reRelieving;
                if (txtReRelieving.Text != null && txtReRelieving.Text != "")
                {
                    reRelieving = DateTime.ParseExact(txtReRelieving.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture); //Convert.ToDateTime(txtReJoining.Text);
                }
                else
                {
                    reRelieving = Convert.ToDateTime("01/01/0001");
                }


                Int16 DistrictPreference1 = Convert.ToInt16(ddlDistPreference1.SelectedItem.Value);
                Int16 DistrictPreference2 = Convert.ToInt16(ddlDistPreference2.SelectedItem.Value);
                Int16 DistrictPreference3 = Convert.ToInt16(ddlDistPreference3.SelectedItem.Value);

                Decimal LastSalaryDrawn = !string.IsNullOrEmpty(txtLastDrawnSal.Text) ? Convert.ToDecimal(txtLastDrawnSal.Text) : Convert.ToDecimal(0);
                String OtherDistrictStateName = ddlHomeDistrict.SelectedValue == "76" ? txtOtherDistrictState.Text : "";

                String DisciplinaryActionDetails = null;
                Boolean DisciplinaryAction;
                if (rbDisciplinaryAction.SelectedItem.Value == "0")
                {
                    DisciplinaryAction = false;
                }
                else if (rbDisciplinaryAction.SelectedItem.Value == "1")
                {
                    DisciplinaryAction = true;
                    DisciplinaryActionDetails = txtDisciplinaryActionDetails.Text;
                }
                else
                {
                    throw new Exception("Undefined behaviour!");
                }

                String CriminalCaseDetails = null;
                Boolean CriminalCase;
                if (rbCriminalCases.SelectedItem.Value == "0")
                {
                    CriminalCase = false;
                }
                else if (rbCriminalCases.SelectedItem.Value == "1")
                {
                    CriminalCase = true;
                    CriminalCaseDetails = txtCriminalCasesDetails.Text;
                }
                else
                {
                    throw new Exception("Undefined behaviour!");
                }

                String CBIEnquiryDetails = null;
                Boolean CBIEnquiry;
                if (rblCBIEnquiry.SelectedItem.Value == "0")
                {
                    CBIEnquiry = false;
                }
                else if (rblCBIEnquiry.SelectedItem.Value == "1")
                {
                    CBIEnquiry = true;
                    CBIEnquiryDetails = txtCBIEnquiry.Text;
                }
                else
                {
                    throw new Exception("Undefined behaviour!");
                }

                String VigEnquiryDetails = null;
                Boolean VigEnquiry;
                if (rblVigilance.SelectedItem.Value == "0")
                {
                    VigEnquiry = false;
                }
                else if (rblVigilance.SelectedItem.Value == "1")
                {
                    VigEnquiry = true;
                    VigEnquiryDetails = txtVigilance.Text;
                }
                else
                {
                    throw new Exception("Undefined behaviour!");
                }
                Int64 QuestionnaireKey = 0;
                DataTable dt = (DataTable)ViewState["Positions"];
                if (dt != null && dt.Rows.Count > 0)
                {
                    QuestionnaireKey = DALayer.InsertUpdateQuestionnaire("InsertQuestionnaire", 0, nm, gndr, "", RelativeName, dob, dist, PhNum, PAddress, CAddress, Aadhaar, Email, SeniorityNum, PISNum, eHRMS, lvl, Speciality, ApplyForSpeciality, txtPANNumber.Text.ToUpper(), txtPPONumber.Text, DistrictPreference1, DistrictPreference2, DistrictPreference3, LastSalaryDrawn, DisciplinaryAction, DisciplinaryActionDetails, CriminalCase, CriminalCaseDetails, CBIEnquiry, CBIEnquiryDetails, VigEnquiry, VigEnquiryDetails, RetirementDt, hidHRMSDiff.Value == "0" ? false : true, reJoining, reRelieving, rblMaritalStatus.SelectedValue, rblMaritalStatus.SelectedValue == "Married" ? txtSpousePIS.Text : "", (rblMaritalStatus.SelectedValue == "Married" ? (rblSpouseDoc.SelectedValue == "1" ? true : false) : false), OtherDistrictStateName, rblHasAppliedBefore.SelectedValue == "1" ? true : false);

                    foreach (DataRow row in dt.Rows)
                    {
                        Int16 desig = Convert.ToInt16(row["Designation"]);
                        Int16 distP = Convert.ToInt16(row["District"]);
                        //DateTime DoJ = DateTime.ParseExact(row["Joining"].ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture); //DateTime.ParseExact(row["Joining"].ToString(), "dd/MM/yyyy", null);
                        //DateTime DoR = DateTime.ParseExact(row["Relieving"].ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);//DateTime.ParseExact(row["Relieving"].ToString(), "dd/MM/yyyy", null);
                        DateTime DoJ = Convert.ToDateTime(row["Joining"].ToString());
                        DateTime DoR = Convert.ToDateTime(row["Relieving"].ToString());

                        Int64 ExecutionStatus = DALayer.PostingDetailsInsert("PostingDetailsInsert", QuestionnaireKey, PISNum, desig, distP, DoJ, DoR);

                    }
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal('', 'Please enter Posting Details!', 'error');;</script>");
                    return;
                }
                string spURL = null;
                string spDomain = "PrintQuestionnaire.aspx";
                string authKey = "kRgo1HtkTn3qBp8F";
                string authIV = "Mb3QsgrG8miQzATI";
                spURL = "m=0&PIS=" + txtPISNumber.Text;
                spURL = EncryptionDecryption.Encrypt1(spURL, authIV, authKey);
                spURL = spURL.Replace("+", "%2B");
                spURL = "?details=" + spURL;
                spURL = spDomain + spURL;
                spURL = spURL.Replace(" ", "%20");

                if (hidAppointmentStatus.Value == "0")
                    if (Convert.ToBoolean(ViewState["NotJoined"]) == false)
                        ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Record Submitted Successfully!', type: 'success', showConfirmButton: true }, function() { window.location.href ='" + spURL + "'; });</script>");
                    else
                    {
                        DALayer.UpdateReasonForNotJoiningInPreviousRound(QuestionnaireKey, txtReasonNotJoining.Text);
                        DALayer.ResetPriviousJoiningStatusTurnedToNotJoined(txtPISNumber.Text);
                        ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Record Submitted Successfully!', type: 'success', showConfirmButton: true }, function() { window.location.href ='" + spURL + "'; });</script>");
                    }
                else
                {
                    DALayer.UpdateReasonForNotJoining(txtPISNumber.Text, txtReasonNotJoining.Text);
                    ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Record Submitted Successfully!', type: 'success', showConfirmButton: true }, function() { window.location.href ='" + spURL + "'; });</script>");
                }

            }
        }
    }

    protected void Add_Click(object sender, EventArgs e)
    {
        if (!ValidateDate(txtJoining.Text) || !ValidateDate(txtRelieving.Text))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Invalid Date Format', type: 'error', showConfirmButton: true });</script>");
            return;
        }
        hidHRMSDiff.Value = "1";
        if (ViewState["Positions"] == null)
            AddDefaultFirstRecord();
        if (hidAddEditMode.Value == "Add")
        {
            //AddNewRecordRowToGrid();
            DataTable dtCurrentTable1 = (DataTable)ViewState["Positions"];
            if (dtCurrentTable1.Rows.Count > 0)
                AddNewRecordRowToGrid();
            else
            {
                AddDefaultFirstRecord();
                AddNewRecordRowToGrid();
            }
        }
        else
        {
            if (!string.IsNullOrEmpty(hidRecordID.Value))
            {
                DataTable dtCurrentTable = (DataTable)ViewState["Positions"];

                Int32 row_no = dtCurrentTable.Rows.Count - Convert.ToInt32(hidRecordID.Value);
                dtCurrentTable.Rows[row_no]["Designation"] = Convert.ToInt16(ddlDesig.SelectedValue);
                dtCurrentTable.Rows[row_no]["DesignationName"] = ddlDesig.SelectedItem.Text;
                dtCurrentTable.Rows[row_no]["District"] = Convert.ToInt16(ddlDistrict.SelectedValue);
                dtCurrentTable.Rows[row_no]["DistrictName"] = ddlDistrict.SelectedItem.Text;
                dtCurrentTable.Rows[row_no]["Joining"] =DateTime.ParseExact(txtJoining.Text, "dd/MM/yyyy", null);
                dtCurrentTable.Rows[row_no]["Relieving"] = DateTime.ParseExact(txtRelieving.Text, "dd/MM/yyyy", null);

                ViewState["Positions"] = dtCurrentTable;
                rptPositions.DataSource = dtCurrentTable;
                rptPositions.DataBind();
            }

            Add.Text = "Add";
            hidRecordID.Value = "";
            hidAddEditMode.Value = "Add";
            trAddEdit.Style.Add("display", "none");

            ddlDesig.SelectedValue = "1";
            ddlDistrict.SelectedValue = "15";
            txtJoining.Text = "";
            txtRelieving.Text = "";
        }
    }
    private void AddDefaultFirstRecord()
    {
        //creating dataTable   
        DataTable dt = new DataTable();
        DataRow dr;
        dt.TableName = "Positions";
        dt.Columns.Add(new DataColumn("ID", typeof(Int16)));
        dt.Columns.Add(new DataColumn("Designation", typeof(Int16)));
        dt.Columns.Add(new DataColumn("DesignationName", typeof(String)));
        dt.Columns.Add(new DataColumn("District", typeof(Int64)));
        dt.Columns.Add(new DataColumn("DistrictName", typeof(String)));
        dt.Columns.Add(new DataColumn("Joining", typeof(DateTime)));
        dt.Columns.Add(new DataColumn("Relieving", typeof(DateTime)));
        dr = dt.NewRow();
        dt.Rows.Add(dr);
        //saving databale into viewstate   
        ViewState["Positions"] = dt;
        //bind Gridview  
        rptPositions.DataSource = dt;
        rptPositions.DataBind();
    }
    private void AddNewRecordRowToGrid()
    {
        // check view state is not null  
        if (ViewState["Positions"] != null)
        {
            //get datatable from view state   
            DataTable dtCurrentTable = (DataTable)ViewState["Positions"];
            DataRow drCurrentRow = null;

            if (dtCurrentTable.Rows.Count > 0)
            {
                for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                {
                    //add each row into data table  
                    drCurrentRow = dtCurrentTable.NewRow();
                    drCurrentRow["ID"] = dtCurrentTable.Rows.Count - i + 1;
                    drCurrentRow["Designation"] = Convert.ToInt16(ddlDesig.SelectedValue);
                    drCurrentRow["DesignationName"] = ddlDesig.SelectedItem.Text;
                    drCurrentRow["District"] = Convert.ToInt16(ddlDistrict.SelectedValue);
                    drCurrentRow["DistrictName"] = ddlDistrict.SelectedItem.Text;

                    //drCurrentRow["Designation"] = Convert.ToInt16(1);
                    //drCurrentRow["District"] = Convert.ToInt16(1);
                    drCurrentRow["Joining"] = DateTime.ParseExact(txtJoining.Text, "dd/MM/yyyy", null);
                    drCurrentRow["Relieving"] = DateTime.ParseExact(txtRelieving.Text, "dd/MM/yyyy", null);

                }
                //Remove initial blank row  
                if (dtCurrentTable.Rows[0][0].ToString() == "")
                {
                    dtCurrentTable.Rows[0].Delete();
                    dtCurrentTable.AcceptChanges();

                }

                //add created Rows into dataTable  
                dtCurrentTable.Rows.Add(drCurrentRow);
                //Save Data table into view state after creating each row  
                ViewState["Positions"] = dtCurrentTable;
                //Bind Gridview with latest Row  
                rptPositions.DataSource = dtCurrentTable;
                rptPositions.DataBind();

                trAddEdit.Style.Add("display", "none");
                ddlDesig.SelectedValue = "1";
                ddlDistrict.SelectedValue = "1";
                txtJoining.Text = "";
                txtRelieving.Text = "";
            }
        }
    }

    protected void ddlDistPreference1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDistPreference1.SelectedValue == ddlDistPreference2.SelectedValue || ddlDistPreference2.SelectedValue == "0")
        {
            ddlDistPreference2.DataSource = DALayer.GetDistrictsForPref(ddlDistPreference1.SelectedValue + "," + ddlDistPreference3.SelectedValue);
            ddlDistPreference2.DataTextField = "ManavSampada_DistrictName";
            ddlDistPreference2.DataValueField = "District_Id";
            ddlDistPreference2.DataBind();
            ddlDistPreference2.Items.Insert(0, new ListItem("Select Second preference", "0"));
        }

        if (ddlDistPreference1.SelectedValue == ddlDistPreference3.SelectedValue || ddlDistPreference3.SelectedValue == "0")
        {
            ddlDistPreference3.DataSource = DALayer.GetDistrictsForPref(ddlDistPreference2.SelectedValue + "," + ddlDistPreference1.SelectedValue);
            ddlDistPreference3.DataTextField = "ManavSampada_DistrictName";
            ddlDistPreference3.DataValueField = "District_Id";
            ddlDistPreference3.DataBind();
            ddlDistPreference3.Items.Insert(0, new ListItem("Select Third preference", "0"));
        }
        if (ddlDistPreference1.SelectedValue != "0")
        {
            ddlDistPreference2.Enabled = true;

            if (ddlDistPreference2.SelectedValue != "0")
            {
                ddlDistPreference3.Enabled = true;
            }
        }
    }

    protected void ddlDistPreference2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDistPreference2.SelectedValue == ddlDistPreference1.SelectedValue || ddlDistPreference1.SelectedValue == "0")
        {
            ddlDistPreference1.DataSource = DALayer.GetDistrictsForPref(ddlDistPreference2.SelectedValue + "," + ddlDistPreference3.SelectedValue);
            ddlDistPreference1.DataTextField = "ManavSampada_DistrictName";
            ddlDistPreference1.DataValueField = "District_Id";
            ddlDistPreference1.DataBind();
            ddlDistPreference1.Items.Insert(0, new ListItem("Select First preference", "0"));
        }
        if (ddlDistPreference2.SelectedValue == ddlDistPreference3.SelectedValue || ddlDistPreference3.SelectedValue == "0")
        {
            ddlDistPreference3.DataSource = DALayer.GetDistrictsForPref(ddlDistPreference2.SelectedValue + "," + ddlDistPreference1.SelectedValue);
            ddlDistPreference3.DataTextField = "ManavSampada_DistrictName";
            ddlDistPreference3.DataValueField = "District_Id";
            ddlDistPreference3.DataBind();
            ddlDistPreference3.Items.Insert(0, new ListItem("Select Third preference", "0"));
        }

        if (ddlDistPreference2.SelectedValue != "0")
        {
            ddlDistPreference3.Enabled = true;
        }
        else
        {
            ddlDistPreference3.SelectedValue = "0";
            ddlDistPreference3.Enabled = false;
        }
    }

    protected void ddlDistPreference3_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDistPreference3.SelectedValue == ddlDistPreference1.SelectedValue || ddlDistPreference1.SelectedValue == "0")
        {
            ddlDistPreference1.DataSource = DALayer.GetDistrictsForPref(ddlDistPreference2.SelectedValue + "," + ddlDistPreference3.SelectedValue);
            ddlDistPreference1.DataTextField = "ManavSampada_DistrictName";
            ddlDistPreference1.DataValueField = "District_Id";
            ddlDistPreference1.DataBind();
            ddlDistPreference1.Items.Insert(0, new ListItem("Select First preference", "0"));
        }

        if (ddlDistPreference3.SelectedValue == ddlDistPreference2.SelectedValue || ddlDistPreference2.SelectedValue == "0")
        {
            ddlDistPreference2.DataSource = DALayer.GetDistrictsForPref(ddlDistPreference1.SelectedValue + "," + ddlDistPreference3.SelectedValue);
            ddlDistPreference2.DataTextField = "ManavSampada_DistrictName";
            ddlDistPreference2.DataValueField = "District_Id";
            ddlDistPreference2.DataBind();
            ddlDistPreference2.Items.Insert(0, new ListItem("Select Second preference", "0"));
        }
    }

    protected void rptPositions_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            Int16 ID = Convert.ToInt16(e.CommandArgument);
            hidRecordID.Value = ID.ToString();
            Add.Text = "Update";
            trAddEdit.Style.Add("display", "table-row");
            DataTable dtCurrentTable = (DataTable)ViewState["Positions"];
            int row_no = dtCurrentTable.Rows.Count - ID;
            ddlDesig.SelectedValue = dtCurrentTable.Rows[row_no]["Designation"].ToString();
            string q = dtCurrentTable.Rows[row_no]["District"].ToString();
            ddlDistrict.SelectedValue = dtCurrentTable.Rows[row_no]["District"].ToString();

            string JoiningDate = "";
            if (!string.IsNullOrEmpty(dtCurrentTable.Rows[row_no]["Joining"].ToString()))
            {
                JoiningDate = dtCurrentTable.Rows[row_no]["Joining"].ToString().Split('-')[0].PadLeft(2, '0') + "/" + dtCurrentTable.Rows[row_no]["Joining"].ToString().Split('-')[1].PadLeft(2, '0') + "/" + dtCurrentTable.Rows[row_no]["Joining"].ToString().Split('-')[2];
                txtJoining.Text = JoiningDate.Split(' ')[0];
            }
            else
                txtJoining.Text = "";
            string RelievingingDate = "";
            if (!string.IsNullOrEmpty(dtCurrentTable.Rows[row_no]["Relieving"].ToString()))
            {
                RelievingingDate = dtCurrentTable.Rows[row_no]["Relieving"].ToString().Split('-')[0].PadLeft(2, '0') + "/" + dtCurrentTable.Rows[row_no]["Relieving"].ToString().Split('-')[1].PadLeft(2, '0') + "/" + dtCurrentTable.Rows[row_no]["Relieving"].ToString().Split('-')[2];
                txtRelieving.Text = RelievingingDate.Split(' ')[0];
            }
            else
                txtRelieving.Text = "";
            hidAddEditMode.Value = "Edit";
        }

        if (e.CommandName == "Remove")
        {
            Int16 ID = Convert.ToInt16(e.CommandArgument);

            DataTable dtCurrentTable = (DataTable)ViewState["Positions"];
            //if (dtCurrentTable.Rows.Count == 1)
            //{
            //    dtCurrentTable.Rows[ID-1].Delete();
            //    dtCurrentTable.AcceptChanges();
            //    ViewState["Positions"] = dtCurrentTable;
            //    rptPositions.DataSource = dtCurrentTable;
            //    rptPositions.DataBind();
            //}
            //else
            //{
            dtCurrentTable.Rows[ID].Delete();
            dtCurrentTable.AcceptChanges();
            ViewState["Positions"] = dtCurrentTable;
            rptPositions.DataSource = dtCurrentTable;
            rptPositions.DataBind();
            //}
        }
    }

    protected void lnkAddRow_Click(object sender, EventArgs e)
    {
        trAddEdit.Style.Add("display", "table-row");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Add.Text = "Add";
        hidRecordID.Value = "";
        hidAddEditMode.Value = "Add";
        trAddEdit.Style.Add("display", "none");

        ddlDesig.SelectedValue = "1";
        ddlDistrict.SelectedValue = "1";
        txtJoining.Text = "";
        txtRelieving.Text = "";
    }

    protected void reload_Click(object sender, ImageClickEventArgs e)
    {

    }

    protected void chkBox_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chk = (CheckBox)sender;
        if (chk.Checked)
        {
            btnSubmit.Enabled = true;
        }
        else
        {
            btnSubmit.Enabled = false;
        }
    }

    #region Validation
    private bool ValidateApplicationNo(string s)
    {
        var regex = new Regex("^[1-9][0-9]{4}$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidateReason(string s)
    {
        var regex = new Regex("^[a-z A-Z.,]*$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidateString(string s)
    {
        var regex = new Regex(@"^[a-z A-Z.]*$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidateMobileNumber(string s)
    {
        var regex = new Regex(@"^[6-9][0-9]{9}$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidateAddhar(string s)
    {
        var regex = new Regex(@"^[1-9][0-9]{11}$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidateEmailID(string s)
    {
        var regex = new Regex(@"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidateYear(string s)
    {
        var regex = new Regex(@"^[1-2][0-9]{3}$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidatePANNumber(string s)
    {
        var regex = new Regex(@"^[A-Za-z]{5}\d{4}[A-Za-z]{1}$");
        if (regex.IsMatch(s))
            return true;
        else
            return false;

    }
    private bool ValiddateMCINumber(string s)
    {
        var regex = new Regex(@"^[a-zA-Z0-9-//().,\s]+$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidateMBBSYear(string s)
    {
        var regex = new Regex(@"^[1-2][0-9]{3}$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidateInstitute(string s)
    {
        var regex = new Regex(@"^[a-zA-Z-.//,\s]+$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidateUniversity(string s)
    {
        var regex = new Regex(@"[a-zA-Z 0-9-.,\s]+");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidatePercentage(string s)
    {
        var regex = new Regex(@"^[0-9]{2}\.[0-9]{2}$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidateEhrms(string s)
    {
        var regex = new Regex("^[1-9][0-9]{4,5}$");
        if (regex.IsMatch(s))
            return true;
        else
            return false;
    }
    private bool ValidateAddress(string s)
    {
        var regex = new Regex(@"^[a-zA-Z0-9-//., \s]+$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidateDate(string s)
    {
        var regex = new Regex(@"^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidatePPONumber(string s)
    {
        var regex = new Regex(@"^[0-9\/]*$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidateSeniorityNumber(string s)
    {
        var regex = new Regex(@"^[a-zA-Z0-9\s]+$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }
    private bool ValidateLastSalaryDrawn(string s)
    {
        var regex = new Regex(@"\d+(\.\d{1,2})?");
        if (regex.IsMatch(s)) return true;
        else return false;
    }

    private bool ValidateProceeding(string s)
    {
        var regex = new Regex(@"^[a-zA-Z0-9-//., \s]+$");
        if (regex.IsMatch(s)) return true;
        else return false;
    }

    #endregion


    protected void rdoNotJoiningReason_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rdoNotJoiningReason.SelectedValue == "RESIGNED")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Kindly Contact to dgmh office training cell department at \\n 0522-2230017 for updating reason of " + rdoNotJoiningReason.SelectedItem.ToString() + "!', type: 'info', showConfirmButton: true }, function() { window.location.href ='Questionnaire.aspx'; });</script>");
            return;
        }
        DataTable dt = new DataTable();
        dt = DALayer.getMobileNumber(txtPISNumber.Text);
        if (string.IsNullOrEmpty(dt.Rows[0][0].ToString()) && string.IsNullOrEmpty(dt.Rows[0][2].ToString()))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "msg1234", "<script>swal({ title: '', text: 'Kindly Contact to Admin for updating reason of " + rdoNotJoiningReason.SelectedItem.ToString() + "!', type: 'success', showConfirmButton: true }, function() { window.location.href =Questionnaire.aspx; });</script>");
        }
        else
        {
            lblmobileNo.Text = dt.Rows[0][0].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0][2].ToString()))
                lblEmailID.Text = dt.Rows[0][2].ToString();
            else
            {
                lblEmailID.Visible = false;
                spanEmailID.Style.Add("display", "none");
            }
        }
        txtPANNumber.Enabled = false;
        if (rdoNotJoiningReason.SelectedValue == "NOTJOINED")
            lblReason.Text = "For updating reason of not joining,";
        //else if (rdoNotJoiningReason.SelectedValue == "RESIGNED")
        //    lblReason.Text = "For uploading PDF document,";
        //else if (rdoNotJoiningReason.SelectedValue == "SERVICETERMINATED")
        //    lblReason.Text = "For updating service closer reason,";
        btnSearch.Enabled = false;

        divSentMobileNumberMessage.Style.Add("display", "block");
        divNotJoiningReason.Style.Add("display", "block");
    }

    protected void btnGetOTP_Click(object sender, EventArgs e)
    {
        rdoNotJoiningReason.Enabled = false;
        DataTable dt = new DataTable();
        dt = DALayer.getMobileNumber(txtPISNumber.Text);
        string MobileNo = dt.Rows[0][1].ToString();
        string EmailID = dt.Rows[0]["Email"].ToString();
        string Name = dt.Rows[0]["Name"].ToString();
        dt.Clear();
        dt = DALayer.generateOTP(txtPISNumber.Text, MobileNo);
        if (dt.Rows.Count > 0)
        {
            string msg = dt.Rows[0][0].ToString() + " This Verification code is valid for 15 minutes";
            divMobileNumber.Style.Add("display", "block");
            SendSMS(MobileNo, msg);
            EmailFormat(EmailID, Name, dt.Rows[0][0].ToString());
            btnGetOTP.Visible = false;
            btnSearch.Enabled = false;
            rdoWantToReapply.Enabled = false;
        }
    }
    protected void SendSMS(string MobileNumber, string Message)
    {
        //WebRequest request = WebRequest.Create("http://aanviit.com/api/mt/SendSMS?user=Indianhealthaction&password=12345678&senderid=UPMHFW&channel=TRANS&DCS=0&flashsms=0&number=" + MobileNumber + "&text=" + Message + "&route=02");


        WebRequest request = WebRequest.Create("http://smsaanvi.alert.ind.in/sms_api/sendsms.php?username=indianhealth&password=12345678&mobile=" + MobileNumber + "&sendername=UPMHFW&message=" + Message + " &templateid=1707160101406110214");


     

        request.Credentials = CredentialCache.DefaultCredentials;
        HttpWebResponse response1 = (HttpWebResponse)request.GetResponse();
        System.IO.Stream dataStream = response1.GetResponseStream();
        System.IO.StreamReader reader = new System.IO.StreamReader(dataStream);
        String responseFromServer = reader.ReadToEnd();
        string SMS_Response = responseFromServer.ToString().Trim();

        reader.Close();
        dataStream.Close();
        response1.Close();
    }
    protected void EmailFormat(string EmailID, string ApplicantName, string code)
    {
        try
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            MailMessage Msg = new MailMessage();
            Msg.From = new MailAddress("uphealth.walkin@gmail.com");
            Msg.To.Add(EmailID);
            Msg.Subject = "Verification Code - Walk-in interview for MBBS Doctors/Specialists for Medical & Health Services, Uttar Pradesh";
            Msg.IsBodyHtml = true;
            sb.Append("<html><body style='font-family:Calibri;'>");
            sb.Append("<div style='width:100%; font-size:15px;'>Dear " + ApplicantName.ToUpper() + ",<br/><br/>");
            sb.Append("The Verification Code is <b>" + code + "</b>, this Verification code is valid for 15 minutes.");
            sb.Append("<br/><br/><br/>");
            sb.Append("<strong>Warm Regards</strong>,<br/>");
            sb.Append("Director General Medical Health<br/>");
            sb.Append("Directorate of Medical and Health Services,<br/>");
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
            smtp.Send(Msg);
            Msg = null;
        }
        catch (Exception ex)
        {
            Console.WriteLine("{0} Exception caught.", ex);
        }
    }


    protected void btnSubmitOTP_Click(object sender, EventArgs e)
    {
        divForm.Style.Add("display", "block");
        divNotJoining.Style.Add("display", "block");
        rfvReasonNotJoining.Enabled = true;
        ViewState["NotJoined"] = true;
        divWantToReapply.Style.Add("display", "none");
        DataSet ds = DALayer.GetDataForExtention(txtPISNumber.Text);
        DataSet dsPostingDetails = DALayer.GetPostingDetailsForExtention(txtPISNumber.Text);
        NewMethod(ds);
        txtDOB.Text = !string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["DOB"])) ? String.Format("{0:dd/MM/yyyy}", Convert.ToDateTime(ds.Tables[0].Rows[0]["DOB"])).Replace('-', '/') : "";
        txtAge.Text = ds.Tables[0].Rows[0]["Age"].ToString();
        txtName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
        txtRelativeName.Text = ds.Tables[0].Rows[0]["FatherHusbName"].ToString();
        txtSeniority.Text = ds.Tables[0].Rows[0]["SeniorityNumber"].ToString();
        txtPermAddress.Text = ds.Tables[0].Rows[0]["PermAddress"].ToString();
        txtCurrentAddress.Text = ds.Tables[0].Rows[0]["CurrentAddress"].ToString();
        ddlLevel.SelectedValue = ds.Tables[0].Rows[0]["Level"].ToString();
        DataSet ds1 = DALayer.GetData("Select District_ID from tbl_District1 where class_district = '" + ds.Tables[0].Rows[0]["HomeDistrict"].ToString() + "'");
        if (ds1 != null && ds1.Tables[0].Rows.Count > 0)
            ddlHomeDistrict.SelectedValue = ds1.Tables[0].Rows[0]["District_ID"].ToString();
        else if (ds1 != null && ds1.Tables[0].Rows.Count == 0)
        {
            if (rblNewOrExtension.SelectedValue == "1")
            {
                ddlHomeDistrict.Items.Insert(0, new ListItem("Select", "0"));
                ddlHomeDistrict.SelectedValue = "0";
            }
        }
        DisablePISFields();
        btnChangeDetail.Visible = true;
        lblEdit.Visible = true;
        if (dsPostingDetails != null)
        {
            AddDefaultFirstRecord();
            DataTable dtCurrentTable = (DataTable)ViewState["Positions"];
            DataRow drCurrentRow = null;

            ViewState["Positions"] = dsPostingDetails.Tables[0];

            for (int i = 0; i < dsPostingDetails.Tables[0].Rows.Count; i++)
            {
                //add each row into data table  
                drCurrentRow = dtCurrentTable.NewRow();
                drCurrentRow["ID"] = dsPostingDetails.Tables[0].Rows[i]["ID"];
                ds1 = DALayer.GetData("Select DesignationKey from Designation where DesignationName = '" + dsPostingDetails.Tables[0].Rows[i]["designame"].ToString() + "'");
                if (ds1 != null)
                {
                    drCurrentRow["DesignationName"] = dsPostingDetails.Tables[0].Rows[i]["designame"];
                    drCurrentRow["Designation"] = ds1.Tables[0].Rows.Count > 0 ? ds1.Tables[0].Rows[0]["DesignationKey"].ToString() : "0";
                }
                ds1 = DALayer.GetData("Select District_ID from tbl_District1 where Class_District = '" + dsPostingDetails.Tables[0].Rows[i]["districtname"].ToString() + "'");
                if (ds1 != null)
                {
                    drCurrentRow["DistrictName"] = dsPostingDetails.Tables[0].Rows[i]["districtname"];
                    drCurrentRow["District"] = ds1.Tables[0].Rows.Count > 0 ? ds1.Tables[0].Rows[0]["District_ID"].ToString() : "0";
                }
                drCurrentRow["Joining"] = !string.IsNullOrEmpty(Convert.ToString(dsPostingDetails.Tables[0].Rows[i]["doposting"])) ? Convert.ToDateTime(dsPostingDetails.Tables[0].Rows[i]["doposting"]) : Convert.ToDateTime("01/01/0001");
                drCurrentRow["Relieving"] = !string.IsNullOrEmpty(Convert.ToString(dsPostingDetails.Tables[0].Rows[i]["dorelieve"])) ? Convert.ToDateTime(dsPostingDetails.Tables[0].Rows[i]["dorelieve"]) : Convert.ToDateTime("01/01/0001");

                dtCurrentTable.Rows.Add(drCurrentRow);
            }
            if (dtCurrentTable.Rows[0][0].ToString() == "")
            {
                dtCurrentTable.Rows[0].Delete();
                dtCurrentTable.AcceptChanges();
            }

            ViewState["Positions"] = dtCurrentTable;
            rptPositions.DataSource = dtCurrentTable;
            rptPositions.DataBind();
        }
    }
}