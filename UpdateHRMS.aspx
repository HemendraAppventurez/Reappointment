<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="UpdateHRMS.aspx.cs"
    Inherits="UpdateHRMS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="bootstrap/js/datatables/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="css/dashboard/AdminLTE.css" rel="stylesheet" />
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script src="bootstrap/js/jquery-3.1.1.min.js"></script>
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

                var r = confirm("Records once approved, won't be rollbacked. Are you sure you want to approve these records?");
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

            if (count - 4 > 0) {
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
        <h1>Update eHRMS Code</h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Update eHRMS Code</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div id="printContent" runat="server">

            <asp:Repeater ID="rptData" runat="server" OnItemDataBound="rptData_ItemDataBound">
                <HeaderTemplate>
                    <div class="box box-solid box-default" style="overflow-x: scroll !important; max-height: 520px;">
                        <div class="box-header">
                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success"
                                OnClientClick="return ConfirmApprove();" OnClick="btnSubmit_Click" Text="Update eHRMS Details" />
                        </div>
                        <table id="example1" class="table table-hover table-bordered" style="font-size: 0.9em; color: black;">
                            <colgroup>
                                <col style="width: 7%;" />
                                <col style="width: 1%;" />
                                <col style="width: 20%;" />
                                <col style="width: 10%;" />
                                <%--<col style="width: 10%;" />--%>
                                <col style="width: 7%;" />
                                <col style="width: 8%;" />
                                <col style="width: 10%;" />
                                <col style="width: 28%;" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th style="vertical-align: top; text-align: center;">
                                        <asp:CheckBox ID="chkHeader" runat="server" /></th>
                                    <th style="vertical-align: top; text-align: center;">S.No.</th>
                                    <th style="vertical-align: top;" align="left">Name</th>
                                    <th style="vertical-align: top;" align="left">Gender</th>
                                    <%--<th style="vertical-align: top;" align="left">Reservation Category</th>--%>
                                    <th style="vertical-align: top;" align="left">DOB</th>
                                    <th style="vertical-align: top;" align="left">Age</th>
                                    <th style="vertical-align: top;" align="left">Reappointment Application Number</th>
                                    <th style="vertical-align: top;" align="left">eHRMS Code</th>
                                </tr>
                            </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td valign="top" align="left" style="text-align: center;">
                            <asp:CheckBox runat="server" ID="chkApp" /><asp:Label ID="lblAppNo" runat="server" Text='<%# Eval("ApplicationNo") %>' Visible="false"></asp:Label>
                        </td>
                        <td valign="top" align="left"><%# Container.ItemIndex+1 %></td>
                        <td valign="top" align="left"><%# Eval("Name").ToString().ToUpper() %> </td>
                        <td valign="top" align="left"><%# Eval("Gender") %> </td>
                        <%--<td valign="top" align="left"><%# Eval("ReservationCategory") %> </td>--%>
                        <td valign="top" align="left"><%# Convert.ToDateTime(Eval("DOB")).ToString("dd/MM/yyyy").Replace('-', '/') %> </td>
                        <td valign="top" align="left"><%# Eval("Age") %> </td>
                        <td valign="top" align="left"><%# Eval("ApplicationNo") %> </td>
                        <td valign="top" align="left">
                            <asp:TextBox ID="txtHRMSCode" runat="server" Width="150px" MaxLength="6" AutoCompleteType="Disabled" AutoComplete="Off"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revHRMSCode" runat="server" ControlToValidate="txtHRMSCode" ValidationExpression="^[0-9]{5,6}$" ValidationGroup="Entry">
                                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid e-HRMS Code"></span>
                            </asp:RegularExpressionValidator>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
        </div>

    </section>
    <script src="bootstrap/js/datatables/dataTables.bootstrap.min.js"></script>
    <script src="bootstrap/js/datatables/jquery.dataTables.min.js"></script>
    <script>
        $(function () {
            $("#example1").DataTable();

            //$('#example1').DataTable({
            //    "paging": false,
            //    "info": false
            //});
        });

    </script>

</asp:Content>

