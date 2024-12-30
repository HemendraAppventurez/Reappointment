<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DatainExcel.aspx.cs" Inherits="DatainExcel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reappointment Applications</title>
    <style>
        .rbl1 {
            color: red;
            width: 250px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:RadioButtonList ID="rblNewOrExtension" RepeatLayout="Flow" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rblNewOrExtension_SelectedIndexChanged" CssClass="rbl1">
            <asp:ListItem Text="New Reappointment Application" Value="1" Selected="True"></asp:ListItem>
            <asp:ListItem Text="Only for Reappointment Extension Application" Value="0"></asp:ListItem>
        </asp:RadioButtonList>
        <br />
        <br />
        <asp:DropDownList ID="ddlPortalRound" CssClass="selectCSS" runat="server" OnSelectedIndexChanged="ddlPortalRound_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
        <asp:Button ID="btn_Excel" runat="server" OnClick="btn_Excel_Click" CssClass="btn" Text="Export to Excel" />
        <br />
        <br />
        <div id="printContent" runat="server">
            <style type="text/css">
                body {
                    font-size: 13px;
                    font-family: Calibri;
                }

                table {
                    border-collapse: collapse;
                }

                    table th, table td {
                        border-collapse: collapse;
                        border: 1px solid #999999;
                        padding: 4px;
                    }

                    table th {
                        font-size: 14px;
                    }

                .btn {
                    padding: 8px;
                    background-color: #00acbd;
                    color: white;
                    border: 2px solid #00acbd;
                    font-size: 14px;
                }

                .selectCSS {
                    padding: 8px;
                    background-color: #189232;
                    color: white;
                    border: 2px solid #459232;
                    font-size: 14px;
                }

                @media print {
                    table {
                        border-collapse: collapse;
                    }

                        table th, table td {
                            border-collapse: collapse;
                            border: 1px solid #999999;
                            padding: 4px;
                        }
                }
            </style>
            <asp:Repeater ID="rptData" runat="server">
                <HeaderTemplate>
                    <table>
                        <thead>
                            <tr>
                                <th valign="top" align="left">Not Joined In Previous Round</th>
                                <th valign="top" align="left">Application No</th>
                                <th valign="top" align="left">Name</th>
                                <th valign="top" align="left">Gender</th>
                                <th valign="top" align="left">Father Name</th>
                                <th valign="top" align="left">Date of Retirement</th>
                                <th valign="top" align="left">DateOfBirth</th>
                                <th valign="top" align="left">Phone Number</th>
                                <th valign="top" align="left">Home District</th>
                                <th valign="top" align="left">Permanent Address</th>
                                <th valign="top" align="left">Current Address</th>
                                <th valign="top" align="left">Aadhaar Number</th>
                                <th valign="top" align="left">Phone Number</th>
                                <th valign="top" align="left">PPO Number</th>
                                <th valign="top" align="left">Email</th>
                                <th valign="top" align="left">Seniority Number</th>
                                <th valign="top" align="left">PIS Number</th>
                                <th valign="top" align="left">eHRMS Code</th>
                                <th valign="top" align="left">Level</th>
                                <th valign="top" align="left">Speciality</th>
                                <th valign="top" align="left">Applying for Speciality Position</th>
                                <th valign="top" align="left">Last Drawn Salary</th>
                                <th valign="top" align="left">Is Different From PIS Data?</th>
                                <th valign="top" align="left">Joining Date (under reappointment)</th>
                                <th valign="top" align="left">Relieving Date (under reappointment)</th>
                                <th valign="top" align="left">Marital Status</th>
                                <th valign="top" align="left">Spouse Doctor</th>
                                <th valign="top" align="left">Spouse PIS</th>
                                <th valign="top" align="left">District Preference1</th>
                                <th valign="top" align="left">District Preference2</th>
                                <th valign="top" align="left">District Preference3</th>
                                <th valign="top" align="left">Disciplinary Action</th>
                                <th valign="top" align="left">Disciplinary Action Detail</th>
                                <th valign="top" align="left">Criminal Cases</th>
                                <th valign="top" align="left">Criminal Cases Detail</th>
                                <th valign="top" align="left">CBI Enquiry</th>
                                <th valign="top" align="left">CBI Enquiry Details</th>
                                <th valign="top" align="left">Vigilance Enquiry</th>
                                <th valign="top" align="left">Vigilance Enquiry Details</th>
                                <th valign="top" align="left">Entry DateTime</th>
                                <th valign="top" align="left">Portal Round</th>
                                <th valign="top" align="left">Application Status</th>
                                <th valign="top" align="left">Screening Status</th>
                                <th valign="top" align="left">Joining Status</th>
                            </tr>
                        </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td valign="top" align="left"><%# Eval("HasNotJoined") %> </td>
                        <td valign="top" align="left"><%# Eval("ApplicationNo") %> </td>
                        <td valign="top" align="left"><%# Eval("Name") %> </td>
                        <td valign="top" align="left"><%# Eval("Gender") %> </td>
                        <td valign="top" align="left"><%# Eval("RelativeName") %> </td>
                        <td valign="top" align="left"><%# Convert.ToDateTime(Eval("DateofRetirement")).ToString("dd/MM/yyyy") %> </td>
                        <td valign="top" align="left"><%# Convert.ToDateTime(Eval("DOB")).ToString("dd/MM/yyyy") %> </td>
                        <td valign="top" align="left"><%# Eval("PhoneNumber") %> </td>
                        <td valign="top" align="left"><%# Eval("HomeDistrict") %> </td>
                        <td valign="top" align="left"><%# Eval("PermanentAddress") %> </td>
                        <td valign="top" align="left"><%# Eval("CurrentAddress") %> </td>
                        <td valign="top" align="left"><%# Eval("AadhaarNumber") %> </td>
                        <td valign="top" align="left"><%# Eval("PhoneNumber") %> </td>
                        <td valign="top" align="left"><%# Eval("PPONumber") %> </td>
                        <td valign="top" align="left"><%# Eval("Email") %> </td>
                        <td valign="top" align="left"><%# Eval("SeniorityNumber") %> </td>
                        <td valign="top" align="left"><%# Eval("PISNumber") %> </td>
                        <td valign="top" align="left"><%# Eval("eHRMSCode") %> </td>
                        <td valign="top" align="left"><%# Eval("Level") %> </td>
                        <td valign="top" align="left"><%# Eval("Speciality") %> </td>
                        <td valign="top" align="left"><%# Eval("ApplySpecialityPosition") %> </td>
                        <td valign="top" align="left"><%# Eval("LastDrawnSalary") %> </td>
                        <td valign="top" align="left"><%# Eval("DifferentFromMSData") %> </td>
                        <td valign="top" align="left"><%# !string.IsNullOrEmpty(Eval("ReJoiningDate").ToString()) ? Convert.ToDateTime(Eval("ReJoiningDate")).ToString("dd/MM/yyyy") : "" %> </td>
                        <td valign="top" align="left"><%# !string.IsNullOrEmpty(Eval("ReRelievingDate").ToString()) ? Convert.ToDateTime(Eval("ReRelievingDate")).ToString("dd/MM/yyyy") : "" %> </td>
                        <td valign="top" align="left"><%# Eval("MaritalStatus") %> </td>
                        <td valign="top" align="left"><%# Eval("SpouseDoctor") %> </td>
                        <td valign="top" align="left"><%# Eval("SpousePIS") %> </td>
                        <td valign="top" align="left"><%# Eval("DistrictPreference1") %> </td>
                        <td valign="top" align="left"><%# Eval("DistrictPreference2") %> </td>
                        <td valign="top" align="left"><%# Eval("DistrictPreference3") %> </td>
                        <td valign="top" align="left"><%# Eval("DisciplinaryAction") %> </td>
                        <td valign="top" align="left"><%# Eval("DisciplinaryActionDetail") %> </td>
                        <td valign="top" align="left"><%# Eval("CriminalCases") %> </td>
                        <td valign="top" align="left"><%# Eval("CriminalCasesDetail") %> </td>
                        <td valign="top" align="left"><%# Eval("CBIEnquiry") %> </td>
                        <td valign="top" align="left"><%# Eval("CBIEnquiryDetails") %> </td>
                        <td valign="top" align="left"><%# Eval("VigilanceEnquiry") %> </td>
                        <td valign="top" align="left"><%# Eval("VigilanceEnquiryDetails") %> </td>
                        <td valign="top" align="left"><%# Eval("EntryDate") %> </td>
                        <td valign="top" align="left"><%# Eval("PortalRound") %> </td>
                        <td valign="top" align="left"><%# Eval("ApplicationStatus") %> </td>
                        <td valign="top" align="left"><%# Eval("ScreeningStatus") %> </td>
                        <td valign="top" align="left"><%# Eval("HasJoined") %> </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>

</html>
