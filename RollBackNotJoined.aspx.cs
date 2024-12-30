using System;
using System.Data;

public partial class RollBackNotJoined : System.Web.UI.Page
{
    DataAccessLayer objAP = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        objAP.chkCookie();
        if (!IsPostBack)
        {
            divInfo.Style.Add("display", "none");
            btnUpdate.Visible = false;
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {

        DataSet ds = objAP.GetDataForRollBackJoining(txtPISNumber.Text);
        if (ds.Tables[0].Rows.Count > 0)
        {
            lblName.Text = ds.Tables[0].Rows[0][0].ToString();
            lblFatherName.Text = ds.Tables[0].Rows[0][1].ToString();
            lblDOB.Text = ds.Tables[0].Rows[0][2].ToString();
            lblPortalRound.Text = ds.Tables[0].Rows[0][3].ToString();
            txtehrmsCode.Text = ds.Tables[0].Rows[0][4].ToString();
            if (txtehrmsCode.Text != "")
                txtehrmsCode.Enabled = false;
            lblPanNumber.Text = ds.Tables[0].Rows[0][5].ToString();
            lblApplicationNo.Text = ds.Tables[0].Rows[0][6].ToString();
            lblPIS.Text = ds.Tables[0].Rows[0][7].ToString();
            txtPISNumber.Text = "";
            btnUpdate.Enabled = true;
            divInfo.Style.Add("display", "block");
            btnUpdate.Visible = true;

        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "msg1", "<script>swal('PIS Number is not Valid for Roll out', '', 'error')</script>");
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (txtJoiningDate.Text != "")
        {
            objAP.UpdateJoiningDateAndehrms(lblApplicationNo.Text, Convert.ToDateTime(txtJoiningDate.Text), txtehrmsCode.Text);
            ClientScript.RegisterStartupScript(this.GetType(), "msg", "<script>swal({ title: '', text: 'Not Joining Status has been rolled-out', type: 'info', showConfirmButton: true }, function() { window.location.href = 'RollBackNotJoined.aspx'; });</script>");
        }
    }
}