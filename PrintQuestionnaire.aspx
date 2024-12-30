<%@ Page Title="" Language="C#" MasterPageFile="HomeMaster.master" AutoEventWireup="true" CodeFile="PrintQuestionnaire.aspx.cs" Inherits="ReappointmentPortal_PrintQuestionnaire" %>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript">
        function Print() {
            $('#trPrint').hide();
            $('#heading').html('<div style="text-align:center"><h3>Online Application: Reappointment Portal for Doctors/ Specialists<br />Department of Health & Family Welfare, Uttar Pradesh</h3></div>');
            window.print();
            $('#trPrint').show();
        }
    </script>
    <style>
        @media print {
            @page {
                size: portrait
            }
        }

        @media print {
            .myDIV {
                content: url(images/images.png);
                -webkit-print-color-adjust: exact;
            }
        }
    </style>
    <iframe style="height: 0px; width: 0px; position: absolute; display: none;" id="framediv"></iframe>
    <div id="printable">
        <center>
    <table class="table-responsive">
        <tr id="trPrint">
            <td align="right" style="padding-top:2%">
                
                <a href="#" onclick="getBack();" class="btn btn-danger">Go Back</a>
                
                
                <asp:Button ID="btn_PDF" runat="server" OnClick="btn_PDF_Click"  CssClass="btn btn-primary" Text="Download as PDF"/>
                <asp:Button ID="btn_print" runat="server" OnClientClick="Print();"   CssClass="btn btn-success" Text="Print"/>
            </td>
        </tr>
        <tr>
            <td align="center">
                <div id="detail" runat="server" style="width:100%">

                <div id="div1" runat="server" style="width:100%; display:none; text-align:center"><h3>Online Application: Reappointment Portal for Doctors/ Specialists<br />Department of Health & Family Welfare, Uttar Pradesh</h3></div>
                <div id="divDetail" runat="server" style="width:100%">
                </div>
                 </div>
            </td>
        </tr>
    </table>
        </center>
    </div>
    <script>
        function getBack() {
            var m =<%=Session["m"]%>;

            if (m == 1) {
                window.location = "Screening.aspx";
            }
            else if (m == 2) {
                window.location = "RejectedCandidates.aspx";
            }
            else if (m == 3) {
                window.location = "CallLetter.aspx";
            }
            else if (m == 4) {
                window.location = "MarkAppointment.aspx";
            }
            else if (m == 5) {
                window.location = "ActivateEligibleApplicantforReappointment.aspx";
            }
            else if (m == 6) {
                window.location = "PrintApplication.aspx";
            }
            else if (m == 0) {
                window.location = "Questionnaire.aspx";
            }
        }
    </script>
</asp:Content>

