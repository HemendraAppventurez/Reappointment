using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class UpdateHRMS : System.Web.UI.Page
{
    DataAccessLayer objAP = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            BindData();
        }
    }

    protected void BindData()
    {
        DataSet ds = new DataSet();
        ds = objAP.GetDataforHRMSUpdation(0);
        rptData.DataSource = ds;
        rptData.DataBind();
    }

    protected void rptData_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        foreach (RepeaterItem item in rptData.Items)
        {
            CheckBox chkApp = (CheckBox)item.FindControl("chkApp");
            Label lblAppNo = (Label)item.FindControl("lblAppNo");
            TextBox txtHRMSCode = (TextBox)item.FindControl("txtHRMSCode");

            if (chkApp.Checked)
            {
                if (!string.IsNullOrEmpty(txtHRMSCode.Text))
                {
                    objAP.UpdateHRMSCode(lblAppNo.Text, txtHRMSCode.Text);
                }
            }
        }
        BindData();
    }
}