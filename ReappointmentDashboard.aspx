<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReappointmentDashboard.aspx.cs" Inherits="ReappointmentDashboard" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Online Dashboard for Reappointment</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/dashboard/AdminLTE.css" rel="stylesheet" />
    <link href="bootstrap/js/datatables/dataTables.bootstrap.css" rel="stylesheet" />
    <script src="bootstrap/js/jquery-3.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>
<body>
    <form id="form1" runat="server">
        <cc1:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </cc1:ToolkitScriptManager>
        <div class="container-fluid">
            <div class="row bg-gray1" style="margin-right: -10px; margin-left: -10px; margin-bottom: 10px;">
                <div class="col-md-1">
                    <img src="uplogo.png" />
                </div>
                <div class="col-md-9">
                    <h2>Online Dashboard for Reappointment </h2>
                    <a href="DatainExcel.aspx" target="_blank" style="color: #0029ff; font-size: 16px; text-decoration: underline;" title="Click to view data in Excel">
                        <img src="excel-icon.png" />&nbsp; Download Data</a>
                </div>
                <div class="col-md-2 text-right">
                    <asp:Button ID="Button1" runat="server" Text="Logout" CssClass="btn btn-warning" OnClick="btnLogout_Click" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <asp:DropDownList ID="ddlRound" runat="server" BackColor="#002c52" ForeColor="White" AutoPostBack="true" OnSelectedIndexChanged="ddlRound_SelectedIndexChanged"
                        Style="margin-bottom: 10px; width: 100%; padding: 10px;">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3">
                    <div class="small-box bg-teal">
                        <div class="inner">
                            <h3>
                                <asp:Label ID="lblTotalApplicants" runat="server"></asp:Label>
                            </h3>
                            <p>Total Applicants</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-android-clipboard"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="small-box bg-purple">
                        <div class="inner">
                            <h3>
                                <asp:Label ID="lblMBBSApplicants" runat="server"></asp:Label>
                            </h3>
                            <p>Total MBBS Applicants</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-android-list"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="small-box bg-red">
                        <div class="inner">
                            <h3>
                                <asp:Label ID="lblSpecApplicants" runat="server"></asp:Label>
                            </h3>
                            <p>Total Specialist Applicants</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-android-list"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="small-box bg-green1">
                        <div class="inner">
                            <h3>
                                <asp:Label ID="lblSpecAppliedMBBS" runat="server"></asp:Label>
                            </h3>
                            <p>Total Specialist Applicants who have applied for MBBS Position</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-android-list"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-5">
                    <div class="box box-solid box-default">
                        <div class="box-header">
                            <h3 class="box-title">Age Bracket wise Applicants
                            </h3>
                        </div>
                        <div style="overflow-x: auto;">
                            <%--<cc1:AreaChart ID="AreaChart1" runat="server" ChartHeight="480" ChartWidth="500"
                            ChartType="Basic" ForeColor="White"
                            ChartTitleColor="#0E426C" CategoryAxisLineColor="c4c6c6"
                            ValueAxisLineColor="EFEFEF" BaseLineColor="#717171">
                        </cc1:AreaChart>--%>
                            <cc1:BarChart ID="BarChart1" runat="server" ChartHeight="380" ChartWidth="520" ForeColor="#FFFFFF"
                                ChartType="Column" ChartTitleColor="#000" Visible="false"
                                CategoryAxisLineColor="#EFEFEF" ValueAxisLineColor="#EFEFEF" BaseLineColor="#717171">
                            </cc1:BarChart>
                        </div>
                    </div>
                </div>
                <div class="col-md-7">
                    <div class="box box-solid box-default">
                        <div class="box-header">
                            <h3 class="box-title">District Preference of Applicants
                            </h3>
                        </div>
                        <div>
                            <div style="height: 460px !important; overflow-y: auto; background-color: #fbfbfb;">
                                <asp:Repeater ID="rptSummary" runat="server">
                                    <HeaderTemplate>
                                        <table id="example1" class="table table-hover table-bordered">
                                            <thead>
                                                <tr>
                                                    <th style="vertical-align: top;" rowspan="2">District</th>
                                                    <th style="vertical-align: top; text-align: center;" colspan="2">Reappointment Vacancy</th>
                                                    <th style="vertical-align: top; text-align: center;" colspan="2">1st Preference</th>
                                                    <th style="vertical-align: top; text-align: center;" colspan="2">2nd Preference</th>
                                                    <th style="vertical-align: top; text-align: center;" colspan="2">3rd Preference</th>
                                                </tr>
                                                <tr>
                                                    <th style="vertical-align: top;">MBBS</th>
                                                    <th style="vertical-align: top;">Specialist</th>
                                                    <th style="vertical-align: top;">MBBS</th>
                                                    <th style="vertical-align: top;">Specialist</th>
                                                    <th style="vertical-align: top;">MBBS</th>
                                                    <th style="vertical-align: top;">Specialist</th>
                                                    <th style="vertical-align: top;">MBBS</th>
                                                    <th style="vertical-align: top;">Specialist</th>
                                                </tr>
                                            </thead>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Eval("District_Name") %> </td>
                                            <td><%# Eval("ProposedMBBSPositions") %> </td>
                                            <td><%# Eval("ProposedSpecialistPositions") %> </td>
                                            <td><%# Eval("Preference1MBBS") %> </td>
                                            <td><%# Eval("Preference1Specialist") %> </td>
                                            <td><%# Eval("Preference2MBBS") %> </td>
                                            <td><%# Eval("Preference2Specialist") %> </td>
                                            <td><%# Eval("Preference3MBBS") %> </td>
                                            <td><%# Eval("Preference3Specialist") %> </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <tfoot>
                                            <tr>
                                                <td>Total </td>
                                                <td><%= ProposedMBBSPositions %> </td>
                                                <td><%= ProposedSpecialistPositions %> </td>
                                                <td><%= Preference1MBBS %> </td>
                                                <td><%= Preference1Specialist %> </td>
                                                <td><%= Preference2MBBS %> </td>
                                                <td><%= Preference2Specialist %> </td>
                                                <td><%= Preference3MBBS %> </td>
                                                <td><%= Preference3Specialist %> </td>
                                            </tr>
                                        </tfoot>
                                        </table>
                                            
                                    </FooterTemplate>
                                </asp:Repeater>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="bootstrap/js/datatables/jquery.dataTables.min.js"></script>
    <script>
        $(function () {
            $("#example1").DataTable();
        });

    </script>
</body>
</html>
