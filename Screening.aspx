<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="Screening.aspx.cs" Inherits="Screening" %>

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
    <script type="text/javascript">
        function ConfirmApprove() {
            var inputs = document.getElementsByTagName('input');
            var count = 0

            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].type == "checkbox") {
                    if (inputs[i].checked == true)
                        count = count + 1;
                }
            }
            if (count > 0) {

                var r = confirm("Are you sure you want to approve these records?");
                if (r == true) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                swal("", "Select records for approval!", "error");
                return false;
            }
        }

        function ConfirmReject() {
            var inputs = document.getElementsByTagName('input');
            var count = 0

            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].type == "checkbox") {
                    if (inputs[i].checked == true)
                        count = count + 1;
                }
            }

            if (count > 0) {
                var r = confirm("Are you sure you want to reject these records?");
                if (r == true) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                swal("", "Select records for rejection!", "error");
                return false;
            }
        }
    </script>
    <style type="text/css">
        .table > tbody > tr > td {
            padding: 3px !important;
        }
    </style>

    <section class="content-header">
        <h1>Screening Panel</h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Screening Panel</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <div id="printContent" runat="server">

            <asp:Repeater ID="rptData" runat="server" OnItemCommand="rptData_ItemCommand">
                <HeaderTemplate>
                    <div class="box box-solid box-default" style="overflow-x: scroll !important; max-height: 530px;">
                        <div class="box-header">
                            <asp:Button ID="btnApprove" runat="server" CssClass="btn btn-success"
                                OnClientClick="return ConfirmApprove();" OnClick="btnApprove_Click" Text="Approve Screening" />
                            <asp:Button ID="btnReject" runat="server" CssClass="btn btn-danger"
                                OnClientClick="return ConfirmReject();" OnClick="btnReject_Click" Text="Reject Screening" />
                        </div>
                        <table id="example1" class="table table-hover table-bordered" style="font-size: 0.9em; color: black;">
                            <colgroup>
                                <col style="width: 1%;" />
                                <col style="width: 1%;" />
                                <col style="width: 5%;" />
                                <col style="width: 5%;" />
                                <col style="width: 20%;" />
                                <col style="width: 3%;" />
                                <col style="width: 7%;" />
                                <col style="width: 2%;" />
                                <col style="width: 15%;" />
                                <col style="width: 10%;" />
                                <col style="width: 10%;" />
                                <col style="width: 10%;" />
                                <col style="width: 8%;" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th style="vertical-align: top;" rowspan="2">
                                        <asp:CheckBox ID="chkHeader" runat="server" /></th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">SN.</th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">Appl. No.</th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">PIS</th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">Name</th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">Gender</th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">DOB</th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">Age</th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">Speciality</th>
                                    <th style="vertical-align: top; text-align: center;" colspan="3">District Preference</th>
                                    <th rowspan="2">&nbsp;</th>
                                </tr>
                                <tr>
                                    <th style="vertical-align: top;" align="left">Dist Pref 1</th>
                                    <th style="vertical-align: top;" align="left">Dist Pref 2</th>
                                    <th style="vertical-align: top;" align="left">Dist Pref 3</th>
                                </tr>
                            </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td valign="top" align="left">
                            <asp:CheckBox runat="server" ID="chkApp" /><asp:Label ID="lblAppNo" runat="server" Text='<%# Eval("ApplicationNo") %>' Visible="false"></asp:Label>
                        </td>
                        <td valign="top" align="left"><%# Container.ItemIndex+1 %> </td>
                        <td valign="top" align="left"><%# Eval("ApplicationNo") %> </td>
                        <td valign="top" align="left"><%# Eval("PIS") %> </td>
                        <td valign="top" align="left"><%# Eval("Name").ToString().ToUpper() %> </td>
                        <td valign="top" align="left"><%# Eval("Gender") %> </td>
                        <td valign="top" align="left"><%# Convert.ToDateTime(Eval("DOB")).ToString("dd/MM/yyyy").Replace('-', '/') %> </td>
                        <td valign="top" align="left"><%# Eval("Age") %> </td>
                        <%--<td valign="top" align="left"><%# Eval("Email") %> </td>--%>
                        <td valign="top" align="left"><%# Eval("Speciality") %> </td>
                        <td valign="top" align="left"><%# Eval("DistrictPreference1") %> </td>
                        <td valign="top" align="left"><%# Eval("DistrictPreference2") %> </td>
                        <td valign="top" align="left"><%# Eval("DistrictPreference3") %> </td>
                        <td valign="top" align="left">
                            <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%#Eval("PIS") %>' CommandName="View" Text="View Details"></asp:LinkButton></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
        </div>

    </section>
    <script src="bootstrap/js/datatables/jquery.dataTables.min.js"></script>
    <script>
        $(function () {
            $("#example1").DataTable();
        });

    </script>

</asp:Content>

