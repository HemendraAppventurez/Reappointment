<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintProfile.aspx.cs" Inherits="PrintProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Online Application for Reappointment</title>
</head>
<body>
    <script type="text/javascript">
        function PrintReport(divID)
        {
            var printContents = document.getElementById(divID).innerHTML;
            var mywindow = window.open('', 'PRINT', 'height=400,width=600');

            mywindow.document.write('<html><head><title>' + document.title  + '</title>');
            mywindow.document.write('</head><body ><div style="width: 95%; margin: 0px auto;">');
            mywindow.document.write(printContents);
            mywindow.document.write('</div></body></html>');

            mywindow.document.close(); // necessary for IE >= 10
            mywindow.focus(); // necessary for IE >= 10*/

            mywindow.print();
            mywindow.close();

            return true;
        }
    </script>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hidPrintContent" runat="server" />
        <asp:LinkButton ID="lnkPrint" runat="server" Text="Print" OnClientClick="PrintReport('printContent')"></asp:LinkButton>
        <div style="width: 80%; margin: 0px auto;">
            <div id="printContent">
                <style type="text/css">
                    body {
                        font-family:  sans-serif;
                        font-size: 13px;
                    }

                    table td, th {
                        border: 1px solid #999999;
                        border-collapse: collapse;
                        padding: 8px;
                    }

                    table {
                        border-collapse: collapse !important;
                    }

                    @media print {
                        body {
                            background-color: white;
                            height: 100%;
                            width: 100%;
                            position: fixed;
                            top: 0;
                            left: 0;
                            margin: 0;
                            padding: 15px;
                            font-size: 14px;
                            line-height: 18px;
                        }
                    }
                </style>
                <table style="width: 100%;">
                    <tr>
                        <td valign="top" style="width: 20%;">
                            <strong>PIS Number</strong>
                        </td>
                        <td valign="top" style="width: 30%;">
                            <asp:Label ID="lblPISNumber" runat="server"></asp:Label>
                        </td>
                        <td valign="top" style="width: 20%;">
                            <strong>Seniority Number</strong>
                        </td>
                        <td valign="top" style="width: 30%;">
                            <asp:Label ID="lblSeniority" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trReappointment" runat="server">
                        <td>
                            <strong>Date of Joining (of Reappointment)</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblReJoining" runat="server"></asp:Label>
                        </td>
                        <td>
                            <strong>Date of Relieving (of Reappointment)</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblReRelieving" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Name</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblName" runat="server"></asp:Label>
                        </td>
                        <td>
                            <strong>Date of Birth</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblDOB" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Gender</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblGender" runat="server"></asp:Label>
                        </td>
                        <td>
                            <strong>Mobile Number</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblMobileNumber" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Father's Name</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblFather" runat="server"></asp:Label>
                        </td>
                        <td>
                            <strong>Date of Retirement</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblRetirement" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Email ID</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblEmail" runat="server"></asp:Label>
                        </td>
                        <td>
                            <strong>Home District</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblHomeDistrict" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Permanent Address</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblPermAddress" runat="server"></asp:Label>
                        </td>
                        <td>
                            <strong>Current Address</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblCurrAddress" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Aadhaar Number</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblAadhaar" runat="server"></asp:Label>
                        </td>
                        <td>
                            <strong>PAN Number</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblPAN" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>PPO Number</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblPPONumber" runat="server"></asp:Label>
                        </td>
                        <td>
                            <strong>Marital Status</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblMaritalStatus" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Is your spouse working as a doctor in Department of Health & Family Welfare, Uttar Pradesh?</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblSpouseDoc" runat="server"></asp:Label>
                        </td>
                        <td valign="top" id="tdSpousePIS1" runat="server">
                            <strong>Spouse's PIS Number</strong>
                        </td>
                        <td valign="top" id="tdSpousePIS2" runat="server">
                            <asp:Label ID="lblSpousePIS" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" colspan="4">
                            <h3>Service Details</h3>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>e-HRMS Code</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblHRMS" runat="server"></asp:Label>
                        </td>
                        <td>
                            <strong>Level</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblLevel" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Speciality</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblSpeciality" runat="server"></asp:Label>
                        </td>
                        <td>
                            <strong>Last Drawn Salary</strong>
                        </td>
                        <td>
                            <asp:Label ID="lblSalary" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" colspan="4">
                            <h4>Posting Details</h4>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" colspan="4">
                            <asp:Repeater ID="rptPosting" runat="server">
                                <HeaderTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <th>Designation</th>
                                            <th>District</th>
                                            <th>Date of Joining</th>
                                            <th>Date of Relieving</th>
                                        </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <%# Eval("Designation") %>
                                        </td>
                                        <td>
                                            <%# Eval("District") %>
                                        </td>
                                        <td>
                                            <%# Eval("DateofJoining") %>
                                        </td>
                                        <td>
                                            <%# Eval("DateofRelieving") %>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>District Preference</strong>
                        </td>
                        <td>
                            <span id="spnDistPreference" runat="server"></span>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td valign="top" colspan="4">
                            <h3>Enquiry/Proceedings during Service</h3>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Disciplinary Action</strong>
                        </td>
                        <td>
                            <span id="spnDisciplinary" runat="server"></span>
                        </td>
                        <td>
                            <strong>Criminal Cases</strong>
                        </td>
                        <td>
                            <span id="spnCriminal" runat="server"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>CBI Enquiry</strong>
                        </td>
                        <td>
                            <span id="spnCBI" runat="server"></span>
                        </td>
                        <td>
                            <strong>Vigilance Enquiry</strong>
                        </td>
                        <td>
                            <span id="spnVig" runat="server"></span>
                        </td>
                    </tr>

                </table>
            </div>
        </div>
    </form>
</body>
</html>
