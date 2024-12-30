using System;
using System.Data;
using System.Data.OleDb;
using System.Globalization;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OpenReappointmentPortal : System.Web.UI.Page
{
    DataAccessLayer objAP = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        objAP.chkCookie();
        if (!IsPostBack)
        {
            PortalRoundDetail();
            btnSubmit.Visible = false;
            r1.Style.Add("display", "block");
            r2.Style.Add("display", "none");
            r3.Style.Add("display", "none");

            //if (objAP.AllowToOpenNextRound() == 0)
                if (objAP.AllowToOpenNextRound() != 0)
                {
                btnSubmit.Visible = false;
                r1.Style.Add("display", "block");
                r2.Style.Add("display", "none");
                r3.Style.Add("display", "none");
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Before Opening the next portal Round. Kindly Update Mark Appointment!', type: 'error', showConfirmButton: true }, function() {});</script>");
                btnSubmit.Visible = false;
                r1.Style.Add("display", "none");
                r2.Style.Add("display", "none");
                r3.Style.Add("display", "none");
                return;
            }

        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        DataSet dsDate = objAP.OpenPortal();
        if (dsDate.Tables[0].Rows.Count > 0)
        {
            DateTime OpeningDateOfOpenedPortal = Convert.ToDateTime(dsDate.Tables[0].Rows[0][0].ToString());
            DateTime ClosingDateOfOpenedPortal = Convert.ToDateTime(dsDate.Tables[0].Rows[0][1].ToString());
            if (OpeningDateOfOpenedPortal >= DateTime.Today)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'New Portal Round has already been created, Hence next Round of Portal can not be created!', type: 'error', showConfirmButton: true }, function() { window.location.href = 'OpenReappointmentPortal.aspx'; });</script>");
                return;
            }
            else if (DateTime.Today <= ClosingDateOfOpenedPortal)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Portal Round:" + dsDate.Tables[0].Rows[0][2].ToString() + " is still Opened, Hence next Round of Portal can not be created!', type: 'error', showConfirmButton: true }, function() { window.location.href = 'OpenReappointmentPortal.aspx'; });</script>");
                return;
            }
            else
            {
                if (Page.IsValid)
                {
                    if (txtOpeningDate.Text == "")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Kindly Enter the Opening Date!', type: 'error', showConfirmButton: true }, function() {});</script>");
                        return;
                    }
                    else if (txtClosingDate.Text == "")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Kindly Enter the Closing Date!', type: 'error', showConfirmButton: true }, function() {});</script>");
                        return;
                    }

                    else if (!fuVacancyRoaster.HasFile)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Kindly Upload the Vacancy Roaster for MBBS!', type: 'error', showConfirmButton: true }, function() {});</script>");
                        return;
                    }
                    else if (!fuVacancyRoasterForSpecialist.HasFile)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Kindly Upload the Vacancy Roaster for Specialist!', type: 'error', showConfirmButton: true }, function() {});</script>");
                        return;
                    }
                    else if (fuVacancyRoaster.PostedFile.ContentType != "application/pdf")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Kindly Upload the Vacancy Roaster for MBBS in PDF format!', type: 'error', showConfirmButton: true }, function() {});</script>");
                        return;
                    }
                    else if (fuVacancyRoasterForSpecialist.PostedFile.ContentType != "application/pdf")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Kindly Upload the Vacancy Roaster for Specialist in PDF format!', type: 'error', showConfirmButton: true }, function() {});</script>");
                        return;
                    }
                    try
                    {
                        DateTime openingDate = //Convert.ToDateTime(txtOpeningDate.Text);//
                            DateTime.ParseExact(txtOpeningDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                        DateTime ClosingDate = //Convert.ToDateTime(txtClosingDate.Text);//
                            DateTime.ParseExact(txtClosingDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                        DateTime now = Convert.ToDateTime(DateTime.Now.ToShortDateString());// DateTime.ParseExact(DateTime.Now.ToShortDateString(), "dd/MM/yyyy", null);
                        if (openingDate < now)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Kindly enter the current or future date in Opening Date!', type: 'error', showConfirmButton: true }, function() {});</script>");
                            return;
                        }
                        if (ClosingDate < openingDate)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Closing Date should be greater than opening date!', type: 'error', showConfirmButton: true }, function() {});</script>");
                            return;
                        }
                        int PortalRound = objAP.getMaxPortalRound();
                        objAP.InsertintoPortalRound(openingDate, ClosingDate, PortalRound);
                        fuVacancyRoaster.SaveAs(Server.MapPath("~/Files/" + Path.GetFileName(fuVacancyRoaster.FileName) + DateTime.Now.ToLongDateString()) + ".pdf");
                        fuVacancyRoasterForSpecialist.SaveAs(Server.MapPath("~/Files/" + Path.GetFileName(fuVacancyRoasterForSpecialist.FileName) + DateTime.Now.ToLongDateString()) + ".pdf");

                        foreach (RepeaterItem item in rptData.Items)
                        {
                            Label districtID = (Label)item.FindControl("lblDistrictID");
                            Label district = (Label)item.FindControl("lblDistrict");
                            Label lblDistrictKey_MS = (Label)item.FindControl("lblDistrictKey_MS");
                            TextBox txtMBBSPostition = (TextBox)item.FindControl("txtMBBSPostition");
                            TextBox txtVacantPostition = (TextBox)item.FindControl("txtVacantPostition");
                            objAP.InsertIntoReappointmentVacancyRoster(districtID.Text, district.Text, txtMBBSPostition.Text, txtVacantPostition.Text, PortalRound, lblDistrictKey_MS.Text);

                        }
                        string FilePath = "Files/" + Path.GetFileName(fuVacancyRoaster.FileName) + DateTime.Now.ToLongDateString() + ".pdf";
                        string FilePathSpecialist = "Files/" + Path.GetFileName(fuVacancyRoasterForSpecialist.FileName) + DateTime.Now.ToLongDateString() + ".pdf";
                        objAP.InsertRoasterFile(FilePath, "", FilePathSpecialist, "");
                    }
                    catch (Exception ex)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Enter the Valid date format- dd/MM/yyyy', type: 'error', showConfirmButton: true }, function() {});</script>");
                        return;
                    }

                    ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Record has been saved successfully!', type: 'info', showConfirmButton: true }, function() { window.location.href = 'OpenReappointmentPortal.aspx'; });</script>");
                }
            }
        }
    }

    protected void btnUPLOAD_Click(object sender, EventArgs e)
    {
        if (fuFile.HasFile)
        {

            if (fuFile.PostedFile.ContentType == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" || fuFile.PostedFile.ContentType == "application/octet-stream" || fuFile.PostedFile.ContentType == "application/vnd.ms-excel")
            {
                string[] Files = Directory.GetFiles(Server.MapPath("RoasterFiles"));
                foreach (string file in Files)
                {
                    File.Delete(file);
                }
                fuFile.PostedFile.SaveAs(Server.MapPath("RoasterFiles/" + fuFile.PostedFile.FileName));
                GetAllFilesWithData(Server.MapPath("RoasterFiles"), System.IO.Path.GetFileName(fuFile.PostedFile.FileName));
            }
        }
    }
    private void GetAllFilesWithData(string path, string filename)
    {
        try
        {
            string filepath = Path.Combine(path, filename);
            if (File.Exists(filepath))
            {
                DataTable dtSheetName = new DataTable();
                dtSheetName = getSheetNames(filepath);
                if (dtSheetName != null && dtSheetName.Rows.Count > 0)
                {
                    for (int j = 0; j < dtSheetName.Rows.Count; j++)
                    {
                        DataTable dtSheetData = new DataTable();
                        dtSheetData = readSheet(filepath, dtSheetName.Rows[j]["TABLE_NAME"].ToString());
                        dtSheetData.TableName = dtSheetName.Rows[j]["TABLE_NAME"].ToString();
                        if (dtSheetData.Columns.Count <= 6 && dtSheetData.Rows.Count == 75)
                        {
                            rptData.DataSource = dtSheetData;
                            rptData.DataBind();
                            btnSubmit.Visible = true;
                            btnUPLOAD.Enabled = false;
                            r1.Style.Add("display", "none");
                            r2.Style.Add("display", "block");
                            r3.Style.Add("display", "block");
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Invalid File!', type: 'info', showConfirmButton: true }, function() { window.location.href = 'OpenReappointmentPortal.aspx'; });</script>");
                        }
                    }

                }
            }
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text:'" + ex.Message + "', type: 'info', showConfirmButton: true });</script>");

        }
    }


    public static string getConnection(string filePath)
    {
        OleDbConnectionStringBuilder sbConnection = new OleDbConnectionStringBuilder();
        String strExtendedProperties = String.Empty;
        sbConnection.DataSource = filePath;
        if (Path.GetExtension(filePath).Equals(".xls"))//for 97-03 Excel file
        {
            sbConnection.Provider = "Microsoft.Jet.OLEDB.4.0";
            strExtendedProperties = "Excel 8.0;HDR=Yes;IMEX=1";//HDR=ColumnHeader,IMEX=InterMixed
        }
        else if (Path.GetExtension(filePath).Equals(".xlsx"))  //for 2007 Excel file
        {
            sbConnection.Provider = "Microsoft.ACE.OLEDB.12.0";
            strExtendedProperties = "Excel 12.0;HDR=Yes;IMEX=1";
        }
        sbConnection.Add("Extended Properties", strExtendedProperties);
        return sbConnection.ToString();
    }

    public static DataTable getSheetNames(string filePath)
    {
        string sbConnection = getConnection(filePath);
        using (OleDbConnection conn = new OleDbConnection(sbConnection.ToString()))
        {
            conn.Open();
            DataTable dtSheet = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            return dtSheet;
        }
    }

    public static DataTable readSheet(string filePath, string sheetName)
    {
        string sbConnection = getConnection(filePath);
        using (OleDbConnection conn = new OleDbConnection(sbConnection.ToString()))
        {
            conn.Open();
            String query = "SELECT * FROM [" + sheetName + "]";
            OleDbCommand cmd = new OleDbCommand();
            OleDbDataAdapter da = new OleDbDataAdapter();
            DataTable dt = new DataTable();
            try
            {
                cmd = new OleDbCommand(query, conn);
                da = new OleDbDataAdapter(cmd);
                da.Fill(dt);

            }
            catch
            {
                // Exception Msg 

            }
            finally
            {
                da.Dispose();
                conn.Close();
            }
            return dt;
        }
    }
    private void PortalRoundDetail()
    {
        DataTable dt = objAP.GetPortalRoundsDesc();
        string _str = "";
        if (dt.Rows.Count > 0)
        {
            _str += "<table class='table table-responsive'>";
            _str += "<tr><th>Status</th><th>Portal Round </th><th> Opening Date </th><th> Closing Date </th></tr>";
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string status = "";
                DateTime date1 = DateTime.ParseExact(dt.Rows[i][2].ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);

                if (date1 <= DateTime.Now)
                {
                    status = "Closed";
                }
                else
                {
                    status = "Open";
                }

                DateTime date2 = DateTime.ParseExact(dt.Rows[i][2].ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
                if (date2 >= DateTime.Now)
                {
                    status = "Ready";
                }

                _str += "<tr><td>" + status + "</td>";
                _str += "<td>" + dt.Rows[i][0] + "</td>";
                _str += "<td>" + dt.Rows[i][1] + "</td>";
                _str += "<td>" + dt.Rows[i][2] + "</td></tr>";
            }
            _str += "</table>";
        }
        trRound.InnerHtml = _str;
    }
}