<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="ActivateEligibleApplicantforReappointment.aspx.cs" Inherits="ActivateEligibleApplicantforReappointment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="bootstrap/js/datatables/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="css/dashboard/AdminLTE.css" rel="stylesheet" />
    <script src="bootstrap/js/jquery-3.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    <link href="css/sweetalert.css" rel="stylesheet" />
    <script src="js/sweetalert.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $(function () {
            $("#example1 [id*=chkHeader]").click(function () {
                if ($(this).is(":checked")) {
                    $("#example1 [id*=chkApp]").attr("checked", "checked");
                } else {
                    $("#example1 [id*=chkApp]").removeAttr("checked");
                }
            });
            $("#example1 [id*=chkRow]").click(function () {
                if ($("#example1 [id*=chkApp]").length == $("#example1 [id*=chkApp]:checked").length) {
                    $("#example1 [id*=chkHeader]").attr("checked", "checked");
                } else {
                    $("#example1 [id*=chkHeader]").removeAttr("checked");
                }
            });
        });
    </script>

    <section class="content-header">
        <h1>Activate Eligible Applicant for Extensions</h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Activate Eligible Applicant for Extensions</li>
        </ol>
    </section>
    <section class="content">
        <asp:Repeater ID="rptData" runat="server" OnItemCommand="rptData_ItemCommand">
            <HeaderTemplate>
                <div class="box box-solid box-default" style="overflow-x: scroll !important; max-height: 470px;">
                    <div class="box-header text-left">
                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success" ValidationGroup="Entry"
                            OnClick="btnSubmit_Click" Text="Activate Applicant" />
                    </div>
                    <table id="example1" class="table table-hover table-bordered" style="font-size: 0.9em; color: black;">
                        <colgroup>
                            <col style="width: 1%" />
                            <col style="width: 5%;" />
                            <col style="width: 7%;" />
                            <col style="width: 7%;" />
                            <col style="width: 7%;" />
                            <col style="width: 20%;" />
                            <col style="width: 5%;" />
                            <col style="width: 10%;" />
                            <col style="width: 5%;" />
                            <col style="width: 15%;" />
                            <col style="width: 8%;" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th valign="top" align="left">S.No.</th>
                                <th style="vertical-align: top;">
                                    <asp:CheckBox ID="chkHeader" runat="server" /></th>
                                <th style="vertical-align: top;" align="left">Appl. No.</th>
                                <th style="vertical-align: top;" align="left">PIS No.</th>
                                <th style="vertical-align: top;" align="left">Seniority No.</th>
                                <th style="vertical-align: top;" align="left">Name</th>
                                <th style="vertical-align: top;" align="left">Gender</th>
                                <th style="vertical-align: top;" align="left">DOB</th>
                                <th style="vertical-align: top;" align="left">Age</th>
                                <th style="vertical-align: top;" align="left">Email</th>
                                <th>View</th>
                            </tr>
                        </thead>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td valign="top" align="left"><%# Container.ItemIndex+1 %></td>
                    <td valign="top" align="left">
                        <asp:CheckBox runat="server" ID="chkApp" />
                        <asp:Label ID="lblAppNo" runat="server" Text='<%# Eval("ApplicationNo") %>' Visible="false"></asp:Label>
                        <asp:Label ID="lblPIS" runat="server" Text='<%# Eval("PIS") %>' Visible="false"></asp:Label>
                        <asp:Label ID="lblApplication" runat="server" Text='<%# Eval("ApplicationNo") %>' Visible="false">
                        </asp:Label>
                    </td>
                    <td valign="top" align="left"><%# Eval("ApplicationNo") %> </td>
                    <td valign="top" align="left"><%# Eval("PIS") %> </td>
                    <td valign="top" align="left"><%# Eval("SeniorityNumber") %> </td>
                    <td valign="top" align="left"><%# Eval("Name").ToString().ToUpper() %> </td>
                    <td valign="top" align="left"><%# Eval("Gender") %> </td>
                    <td valign="top" align="left"><%# Convert.ToDateTime(Eval("DOB")).ToString("dd/MM/yyyy").Replace('-', '/') %> </td>
                    <td valign="top" align="left"><%# Eval("Age") %> </td>
                    <td valign="top" align="left"><%# Eval("Email") %> </td>
                    <td valign="top" align="left">
                        <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%#Eval("PIS") %>' CommandName="View" Text="View Details"></asp:LinkButton></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
                </div>
            </FooterTemplate>
        </asp:Repeater>
    </section>
    <script src="bootstrap/js/datatables/jquery.dataTables.min.js"></script>
    <script>
        $(function () {
            $("#example1").DataTable();
        });
    </script>
</asp:Content>

