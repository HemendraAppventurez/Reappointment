using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Screening : System.Web.UI.Page
{
    DataAccessLayer objAP = new DataAccessLayer();
    protected int sno = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        objAP.chkCookie();
        if (!Page.IsPostBack)
        {
            BindData();
        }
    }

    protected void BindData()
    {
        DataSet ds = new DataSet();
        ds = objAP.GetDataforScreening();
        rptData.DataSource = ds;
        rptData.DataBind();
    }

    protected void btnApprove_Click(object sender, EventArgs e)
    {
        foreach (RepeaterItem item in rptData.Items)
        {
            CheckBox chkApp = (CheckBox)item.FindControl("chkApp");
            Label lblAppNo = (Label)item.FindControl("lblAppNo");

            if (chkApp.Checked)
            {
                objAP.InsertAppointmentScreening(lblAppNo.Text, "Approved");
            }
        }
        BindData();
    }

    protected void btnReject_Click(object sender, EventArgs e)
    {

        foreach (RepeaterItem item in rptData.Items)
        {
            CheckBox chkApp = (CheckBox)item.FindControl("chkApp");
            Label lblAppNo = (Label)item.FindControl("lblAppNo");

            if (chkApp.Checked)
            {
                objAP.InsertAppointmentScreening(lblAppNo.Text, "Rejected");
            }
        }
        BindData();
    }

    //protected void rptData_ItemDataBound(object sender, RepeaterItemEventArgs e)
    //{
    //    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
    //    {
    //        PlaceHolder plcMarks = (PlaceHolder)e.Item.FindControl("plcMarks");
    //        string AppNo = DataBinder.Eval(e.Item.DataItem, "ApplicationNo").ToString();
    //        DataSet dsMarks = objAP.GetSpecDetails_ApplicationWise(AppNo);
    //        int RowCount = dsMarks.Tables[0].Rows.Count;

    //        System.Text.StringBuilder sb = new System.Text.StringBuilder();

    //        Decimal CummPerc = 0;
    //        Decimal Denominator = 0;

    //        for (int i = 0; i < RowCount; i++)
    //        {
    //            sb.AppendFormat("<td>{0}</td><td>{1}</td>", dsMarks.Tables[0].Rows[i]["Professional"].ToString(), dsMarks.Tables[0].Rows[i]["Percentage"].ToString());
    //            CummPerc += Convert.ToDecimal(dsMarks.Tables[0].Rows[i]["Percentage"].ToString());
    //            Denominator++;
    //        }
    //        for (int i = 0; i < 4 - RowCount; i++)
    //        {
    //            sb.Append("<td>-</td><td>-</td>");
    //        }

    //        if (Denominator > 0)
    //            sb.AppendFormat("<td>{0}</td>", (CummPerc / Denominator).ToString("00.00"));
    //        else
    //            sb.Append("<td>-</td>");
    //        plcMarks.Controls.Add(new LiteralControl(sb.ToString()));
    //    }
    //}
    protected void rptData_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "View")
        {
            string PIS = e.CommandArgument.ToString();
            string spURL = null;
            string spDomain = "PrintQuestionnaire.aspx";
            string authKey = "kRgo1HtkTn3qBp8F";
            string authIV = "Mb3QsgrG8miQzATI";
            spURL = "m=1&PIS=" + PIS;
            spURL = EncryptionDecryption.Encrypt1(spURL, authIV, authKey);
            spURL = spURL.Replace("+", "%2B");
            spURL = "?details=" + spURL;
            spURL = spDomain + spURL;
            spURL = spURL.Replace(" ", "%20");
            Response.Redirect(spURL);
        }
    }
}