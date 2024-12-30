<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="ResignationUpdate.aspx.cs" Inherits="ResignationUpdate" %>


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
            $('input[type=text][id*=txtResignDate]').datepicker({
                dateFormat: 'dd/mm/yy', maxDate: 0, autoclose: true
            });
        });
    </script>
    <section class="content-header">
        <h1>Resignation Update</h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Resignation Update</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <div id="printContent" runat="server">
            <div class="box box-solid box-default">
                <div class="box-header text-left">
                    <label for="txtPIS">PIS Number:</label>
                    <asp:TextBox ID="txtPIS" runat="server" autocomplete="off" />
                    <asp:RequiredFieldValidator ID="rfvPIS" runat="server" ControlToValidate="txtPIS" Display="Dynamic" ValidationGroup="Entry">
                        <span class="glyphicon glyphicon-exclamation-sign" style="color:red;" title="Enter PIS Number"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPIS" runat="server" ControlToValidate="txtPIS"
                        ValidationGroup="Entry" ValidationExpression="^[a-zA-Z0-9\s]+$" Display="Dynamic">
                <span class="glyphicon glyphicon-exclamation-sign"  style="color:red" title="Invalid PIS" ></span>
                    </asp:RegularExpressionValidator>

                    <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success" OnClick="btnSearch_Click" Text="Search" ValidationGroup="Entry" />
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-info" OnClick="btnSubmit_Click" Text="Update" ValidationGroup="Entry1" />
                </div>
                <div style="overflow-x: scroll !important; max-height: 470px;">
                    <asp:Repeater ID="rptData" runat="server">
                        <HeaderTemplate>
                            <table id="example1" class="table table-hover table-bordered" style="font-size: 0.9em; color: black;">
                                <colgroup>
                                    <col style="width: 5%;" />
                                    <col style="width: 12%;" />
                                    <col style="width: 12%;" />
                                    <col style="width: 5%;" />
                                    <col style="width: 5%;" />
                                    <col style="width: 4%;" />
                                    <col style="width: 15%;" />
                                    <col style="width: 20%;" />
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th style="vertical-align: top;" align="left">Appl. No.</th>
                                        <th style="vertical-align: top;" align="left">Name</th>
                                        <th style="vertical-align: top;" align="left">Father's Name</th>
                                        <th style="vertical-align: top;" align="left">Gender</th>
                                        <th style="vertical-align: top;" align="left">DOB</th>
                                        <th style="vertical-align: top;" align="left">Age</th>
                                        <th style="vertical-align: top;" align="left">Resignation Date</th>
                                        <th style="vertical-align: top;" align="left">Resignation Letter</th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td valign="top" align="left">
                                    <asp:Label ID="lblAppNo" runat="server" Text='<%# Eval("ApplicationNo") %>' Visible="false"></asp:Label>
                                    <asp:Label ID="lblPIS" runat="server" Text='<%# Eval("PIS") %>' Visible="false"></asp:Label><%# Eval("ApplicationNo") %> </td>
                                <td valign="top" align="left"><%# Eval("Name").ToString().ToUpper() %> </td>
                                <td valign="top" align="left"><%# Eval("FatherName").ToString().ToUpper() %> </td>
                                <td valign="top" align="left"><%# Eval("Gender") %> </td>
                                <td valign="top" align="left"><%# Convert.ToDateTime(Eval("DOB")).ToString("dd/MM/yyyy").Replace('-', '/') %> </td>
                                <td valign="top" align="left"><%# Eval("Age") %> </td>
                                <td valign="top" align="left">
                                    <asp:TextBox ID="txtResignDate" runat="server" AutoCompleteType="Disabled" placeHolder="dd/MM/yyyy" CssClass="datepicker" AutoComplete="Off"></asp:TextBox>
                                    <asp:RegularExpressionValidator Display="Dynamic" ID="revResignDate" runat="server" ControlToValidate="txtResignDate" ValidationGroup="Entry1"
                                        ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$">
                <span class="glyphicon glyphicon-exclamation-sign" style="color:red" title="Invalid Date"></span>
                                    </asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvResginDate" runat="server" ControlToValidate="txtResignDate" ValidationGroup="Entry1" Display="Dynamic">
                <span class="glyphicon glyphicon-exclamation-sign"  style="color:red" title="Enter Contract Termination Date"></span>
                                    </asp:RequiredFieldValidator>
                                </td>
                                <td valign="top" align="left">
                                    <asp:FileUpload ID="fuResignLetter" runat="server"></asp:FileUpload>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="fuResignLetter" ValidationGroup="Entry1" Display="Dynamic">
                <span class="glyphicon glyphicon-exclamation-sign"  style="color:red" title="Upload Letter"></span>
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                    </div>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </section>
    <link href="jquery-ui-1.12.1.custom/jquery-ui.min.css" rel="stylesheet" />
    <script src="jquery-ui-1.12.1.custom/jquery-ui.js"></script>
</asp:Content>

