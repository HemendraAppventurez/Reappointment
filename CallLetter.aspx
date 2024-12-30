<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="CallLetter.aspx.cs" Inherits="CallLetter" %>

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
        $(function () {
            $('#<%=txtInterviewDate.ClientID%>').datepicker({
                dateFormat: 'dd/mm/yy', autoclose: true
            });
        });

    </script>
    <script type="text/javascript">
        function ConfirmSending() {
            var interviewdate = $("#<%=txtInterviewDate.ClientID%>").val();
            var interviewtime = $("#<%=txtInterviewTime.ClientID%>").val();
            var interviewvenue = $("#<%=txtInterviewVenue.ClientID%>").val();

            if (interviewdate == '' || interviewtime == '' || interviewvenue == '') {
                ValidatorEnable($('#<%= rfvInterviewDate.ClientID %>')[0], true);
                ValidatorEnable($('#<%= rfvInterviewTime.ClientID %>')[0], true);
                ValidatorEnable($('#<%= rfvInterviewVenue.ClientID %>')[0], true);
                return false;
            }

            else {

                var inputs = document.getElementsByTagName('input');
                var count = 0

                for (var i = 0; i < inputs.length; i++) {
                    if (inputs[i].type == "checkbox") {
                        if (inputs[i].checked == true)
                            count = count + 1;
                    }
                }

                if (count > 0) {

                    var r = confirm("Are you sure you want to send call letters to these applicants?");
                    if (r == true) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                else {
                    swal("", "Select applications to continue!", "error");
                    return false;
                }
            }
        }

        function ConfirmUndo() {
            var r = confirm("Are you sure you want to undo approval of this candidate? The record will be visible in Screening Panel for verification. Click 'OK' to continue.");
            if (r == true) {
                return true;
            }
            else {
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
        <h1>Call Letter & SMS</h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Call Letter & SMS</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <div id="printContent" runat="server">
            <div class="box box-solid box-default" style="overflow-x: scroll !important; max-height: 530px;">
                <div class="box-header text-center">
                    Interview Date
                    <asp:TextBox ID="txtInterviewDate" runat="server" AutoCompleteType="Disabled" placeholder="dd/mm/yyyy" Style="padding: 4px;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvInterviewDate" runat="server" Display="Dynamic" ControlToValidate="txtInterviewDate" ValidationGroup="Entry">
                        <span class="glyphicon glyphicon-exclamation-sign" style="color:red;" title="Enter Interview Date"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revInterviewDate" runat="server" ControlToValidate="txtInterviewDate"
                        ValidationGroup="Entry" ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$" Display="Dynamic">
                <span class="glyphicon glyphicon-exclamation-sign" style="color:red" title="Invalid Date" ></span>
                    </asp:RegularExpressionValidator>

                    &nbsp;

                        Interview Time
                    <asp:TextBox ID="txtInterviewTime" runat="server" Style="padding: 4px;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvInterviewTime" runat="server" ControlToValidate="txtInterviewTime" Display="Dynamic" ValidationGroup="Entry">
                        <span class="glyphicon glyphicon-exclamation-sign" style="color:red;" title="Enter Interview Time"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revInterviewTime" runat="server" ControlToValidate="txtInterviewTime"
                        ValidationGroup="Entry" ValidationExpression="^(((0[1-9])|(1[0-2])):([0-5])(0|5|1)\s(A|P|a|p)(M|m))$" Display="Dynamic">
                <span class="glyphicon glyphicon-exclamation-sign"  style="color:red" title="Invalid Time" ></span>
                    </asp:RegularExpressionValidator>

                    &nbsp;

                        Interview Venue
                    <asp:TextBox ID="txtInterviewVenue" runat="server" Width="300px" Style="padding: 4px;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvInterviewVenue" runat="server" ControlToValidate="txtInterviewVenue" Display="Dynamic" ValidationGroup="Entry">
                        <span class="glyphicon glyphicon-exclamation-sign" style="color:red;" title="Enter Interview Venue"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revInterviewVenue" runat="server" ControlToValidate="txtInterviewVenue"
                        ValidationGroup="Entry" ValidationExpression="^[a-zA-Z0-9-//,\s]+$" Display="Dynamic">
                <span class="glyphicon glyphicon-exclamation-sign"  style="color:red" title="Invalid Format" ></span>
                    </asp:RegularExpressionValidator>

                    <br />
                    <br />
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success" ValidationGroup="Entry"
                        OnClientClick="return ConfirmSending();" OnClick="btnSubmit_Click" Text="Send Call Letter & SMS" />
                </div>
                <asp:Repeater ID="rptData" runat="server" OnItemCommand="rptData_ItemCommand">
                    <HeaderTemplate>
                        <table id="example1" class="table table-hover table-bordered" style="font-size: 0.9em; color: black;">
                            <colgroup>
                                <col style="width: 5%;" />
                                <col style="width: 1%;" />
                                <col style="width: 5%;" />
                                <col style="width: 5%;" />
                                <col style="width: 5%;" />
                                <col style="width: 12%;" />
                                <col style="width: 5%;" />
                                <col style="width: 5%;" />
                                <col style="width: 2%;" />
                                <col style="width: 12%;" />
                                <col style="width: 8%;" />
                                <col style="width: 8%;" />
                                <col style="width: 8%;" />
                                <col style="width: 8%;" />
                                <col style="width: 8%;" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th rowspan="2">&nbsp;</th>
                                    <th style="vertical-align: top;" rowspan="2">
                                        <asp:CheckBox ID="chkHeader" runat="server" /></th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">SN.</th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">Appl. No.</th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">PIS</th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">Name</th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">Gender</th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">DOB</th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">Age</th>
                                    <th style="vertical-align: top;" align="left" rowspan="2">Email</th>
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
                            <td valign="top" align="center">
                                <asp:LinkButton ID="lnkUndo" runat="server" CommandArgument='<%# Eval("ApplicationNo") %>' Text="Remove"
                                    CommandName="Undo" ToolTip="Undo Screening Approval of this candidate" ForeColor="White" Style="padding: 4px;" BackColor="#e20000" OnClientClick="return ConfirmUndo();"></asp:LinkButton>
                            </td>
                            <td valign="top" align="left">
                                <asp:CheckBox runat="server" ID="chkApp" />
                                <asp:Label ID="lblAppNo" runat="server" Text='<%# Eval("ApplicationNo") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lblEntryDate" runat="server" Text='<%# Eval("EntryDate") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lblMobileNumber" runat="server" Text='<%# Eval("MobileNumber") %>' Visible="false"></asp:Label>
                            </td>
                            <td valign="top" align="left"><%# Container.ItemIndex+1 %></td>
                            <td valign="top" align="left"><%# Eval("ApplicationNo") %> </td>
                            <td valign="top" align="left"><%# Eval("PIS") %> </td>
                            <td valign="top" align="left"><%# Eval("Name").ToString().ToUpper() %> </td>
                            <td valign="top" align="left"><%# Eval("Gender") %> </td>
                            <td valign="top" align="left"><%# Convert.ToDateTime(Eval("DOB")).ToString("dd/MM/yyyy").Replace('-', '/') %> </td>
                            <td valign="top" align="left"><%# Eval("Age") %> </td>
                            <td valign="top" align="left"><%# Eval("Email") %> </td>
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

