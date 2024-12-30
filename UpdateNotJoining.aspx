<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="UpdateNotJoining.aspx.cs" Inherits="UpdateNotJoining" %>

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
                var r = confirm("Are you sure you want to update not joining?");
                if (r == true) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                swal("", "Select records for update!", "error");
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

        .rbl1 {
            color: red;
            width: 500px;
        }
    </style>

    <section class="content-header">
        <h1>Update Not Joined</h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Update Not Joined</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <div id="printContent" runat="server">

            <asp:Repeater ID="rptData" runat="server">
                <HeaderTemplate>
                    <div class="box box-solid box-default" style="overflow-x: scroll !important; max-height: 530px;">
                        <div class="box-header">
                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success"
                                OnClientClick="return ConfirmApprove();" OnClick="btnSubmit_Click" ValidationGroup="Entry" Text="Update Not Joined" />
                        </div>
                        <table id="example1" class="table table-hover table-bordered" style="font-size: 0.9em; color: black;">
                            <colgroup>
                                <col style="width: 5%;" />
                                <col style="width: 2%" />
                                <col style="width: 7%;" />
                                <col style="width: 7%;" />
                                <col style="width: 8%;" />
                                <col style="width: 10%;" />
                                <col style="width: 20%;" />
                                <col style="width: 6%;" />
                                <col style="width: 20%;" />
                                <col style="width: 8%;" />
                                <col style="width: 8%;" />
                                <col style="width: 4%" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th style="vertical-align: top; text-align: center;"></th>
                                    <th style="vertical-align: top;" align="left">SN.</th>
                                    <th style="vertical-align: top;" align="left">Appl. No.</th>
                                    <th style="vertical-align: top;" align="left">PIS</th>
                                    <th style="vertical-align: top;" align="left">Seniority No.</th>
                                    <th style="vertical-align: top;" align="left">Entry Date</th>
                                    <th style="vertical-align: top;" align="left">Name</th>
                                    <th style="vertical-align: top;" align="left">Gender</th>
                                    <th style="vertical-align: top;" align="left">Relative Name</th>
                                    <th style="vertical-align: top;" align="left">DOB</th>
                                    <th style="vertical-align: top;" align="left">ehrms Code</th>
                                    <th style="vertical-align: top;" align="left">Portal Round</th>
                                </tr>
                            </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td valign="top" align="left" style="text-align: center;">
                            <asp:CheckBox runat="server" ID="chkApp" /><asp:Label ID="lblAppNo" runat="server" Text='<%# Eval("ApplicationNo") %>' Visible="false"></asp:Label>
                        </td>
                        <td><%# Container.ItemIndex + 1 %></td>
                        <td valign="top" align="left"><%# Eval("ApplicationNo") %> </td>
                        <td valign="top" align="left"><%# Eval("PIS").ToString().ToUpper() %> </td>
                        <td valign="top" align="left"><%# Eval("SeniorityNumber").ToString().ToUpper() %> </td>
                        <td valign="top" align="left"><%# Eval("EntryDate")%> </td>
                        <td valign="top" align="left"><%# Eval("Name").ToString().ToUpper() %> </td>
                        <td valign="top" align="left"><%# Eval("Gender") %> </td>
                        <td valign="top" align="left"><%# Eval("RelativeName") %> </td>
                        <td valign="top" align="left"><%# Convert.ToDateTime(Eval("DOB")).ToString("dd/MM/yyyy").Replace('-', '/') %> </td>
                        <td valign="top" align="left"><%# Eval("eHRMSCode") %> </td>
                        <td valign="top" align="left"><%# Eval("PortalRound") %> </td>
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



