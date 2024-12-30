<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="UpdateJoining.aspx.cs" Inherits="UpdateJoining" %>

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
            if (count == 0) {
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
        $(function () {
            $('input[type=text][id*=txtJoiningDate]').datepicker({
                dateFormat: 'dd/mm/yy', autoclose: true, maxDate: 0
            });
        });
    </script>
    <style type="text/css">
        .table > tbody > tr > td {
            padding: 3px !important;
        }
    </style>

    <section class="content-header">
        <h1>Joining Details</h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Joining Details</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <div id="printContent" runat="server">

            <asp:Repeater ID="rptData" runat="server" OnItemDataBound="rptData_ItemDataBound">
                <HeaderTemplate>
                    <div class="box box-solid box-default" style="overflow-x: scroll !important; max-height: 530px;">
                        <div class="box-header">
                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success"
                                OnClientClick="return ConfirmApprove();" OnClick="btnSubmit_Click" Text="Update Joining Details" ValidationGroup="Entry" />
                        </div>
                        <table id="example1" class="table table-hover table-bordered" style="font-size: 0.9em; color: black;">
                            <colgroup>
                                <col style="width: 5%;" />
                                <col style="width: 5%;" />
                                <col style="width: 5%;" />
                                <col style="width: 5%;" />
                                <col style="width: 10%;" />
                                <col style="width: 4%;" />
                                <col style="width: 20%;" />
                                <col style="width: 5%;" />
                                <col style="width: 7%;" />
                                
                                <col style="width: 14%;" />
                                <col style="width: 14%;" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th style="vertical-align: top; text-align: center;">
                                        <asp:CheckBox ID="chkHeader" runat="server" /></th>
                                    <th style="vertical-align: top; text-align: center;">SN.</th>
                                    <th style="vertical-align: top;" align="left">Appl. No.</th>
                                    <th style="vertical-align: top;" align="left">Seniority No.</th>
                                    <th style="vertical-align: top;" align="left">PIS No.</th>
                                    <th style="vertical-align: top;" align="left">Form Filling Date</th>
                                    <th style="vertical-align: top;" align="left">Name</th>
                                    <th style="vertical-align: top;" align="left">Gender</th>
                                    <th style="vertical-align: top;" align="left">DOB</th>
                                    
                                    <th style="vertical-align: top;" align="left">Joining Date</th>
                                    <th style="vertical-align: top;" align="left">ehrmsCode</th>
                                </tr>
                            </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td valign="top" align="left" style="text-align: center;">
                            <asp:CheckBox runat="server" ID="chkApp" /><asp:Label ID="lblAppNo" runat="server" Text='<%# Eval("ApplicationNo") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lblMobileNumber" runat="server" Text='<%# Eval("MobileNumber") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lblPIS" runat="server" Text='<%# Eval("PISNumber") %>' Visible="false"></asp:Label>
                        </td>
                        <td valign="top" align="left"><%# Container.ItemIndex+1 %></td>
                        <td valign="top" align="left"><%# Eval("ApplicationNo") %> </td>
                        <td valign="top" align="left"><%# Eval("SeniorityNumber") %> </td>
                        <td valign="top" align="left"><%# Eval("PISNumber") %> </td>
                        <td valign="top" align="left"><%# Eval("EntryDate") %> </td>
                        <td valign="top" align="left"><%# Eval("Name").ToString().ToUpper() %> </td>
                        <td valign="top" align="left"><%# Eval("Gender") %> </td>
                        <td valign="top" align="left"><%# Convert.ToDateTime(Eval("DOB")).ToString("dd/MM/yyyy").Replace('-', '/') %> </td>
                        
                        <td valign="top" align="left">
                            <asp:TextBox ID="txtJoiningDate" runat="server" Width="150px" Text='<%# Eval("JoiningDate") %>' CssClass="datepicker" AutoComplete="off"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revJoiningDate" runat="server" ControlToValidate="txtJoiningDate" ValidationGroup="Entry"
                                ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$">
                                    <span class="glyphicon glyphicon-exclamation-sign" style="color:red" title="Invalid Date"></span>
                            </asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="txteHRMSCode" runat="server" Width="150px" Text='<%# Eval("eHRMSCode") %>'  AutoComplete="off" onkeypress="return event.charCode >= 48 && event.charCode <= 57" MaxLength="7"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revEhrmsCode" runat="server" ControlToValidate="txtEhrmsCode" ValidationExpression="^[1-9][0-9]{4,6}$" ValidationGroup="Entry">
                                <span class="glyphicon glyphicon-exclamation-sign"  style="color:red" title="Invalid ehrms Code"></span>
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
    <script src="bootstrap/js/datatables/jquery.dataTables.min.js"></script>
    <script>
        $(function () {
            $("#example1").DataTable();
        });

    </script>
    <link href="jquery-ui-1.12.1.custom/jquery-ui.min.css" rel="stylesheet" />
    <script src="jquery-ui-1.12.1.custom/jquery-ui.js"></script>
</asp:Content>

