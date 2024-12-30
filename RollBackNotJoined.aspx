<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="RollBackNotJoined.aspx.cs" Inherits="RollBackNotJoined" %>

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
    <section class="content-header">
        <h1>Rollback  Not Joined Status</h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Rollback  Not Joined Status</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <div id="printContent" runat="server">
            <div class="box box-solid box-default" style="overflow-x: scroll !important;">
                <div class="box-header">
                    PIS Number:
                    <asp:TextBox ID="txtPISNumber" runat="server" autocomplete="off" MaxLength="10"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPanNumber" runat="server" ValidationGroup="search" ControlToValidate="txtPISNumber" Display="Dynamic">
                        <span class="glyphicon glyphicon-exclamation-sign" style="color:red" title="Enter PIS Number"></span>
                    </asp:RequiredFieldValidator>
                    <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success"
                        OnClick="btnSearch_Click" ValidationGroup="search" Text="Search" />


                </div>
                <div class="box-body" runat="server" id="divInfo">
                    <table class="table table-bordered table-responsive" style="font-size: 0.9em; color: black;">
                        <tr>
                            <th style="width: 5%">Application No</th>
                            <th style="width: 5%">PIS</th>
                            <th style="width: 8%">Pan Number</th>
                            <th style="width: 10%">Name</th>
                            <th style="width: 10%">Relative Name</th>
                            <th style="width: 8%">DOB</th>
                            <th style="width: 5%">Portal Round</th>
                            <th style="width: 10%">Joining Date</th>
                            <th style="width: 10%">ehrms Code</th>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblApplicationNo" runat="server"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblPIS" runat="server"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblPanNumber" runat="server"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblName" runat="server"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFatherName" runat="server"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblDOB" runat="server"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblPortalRound" runat="server"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="txtJoiningDate" runat="server" autocomplete="off"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvJoininDate" runat="server" ControlToValidate="txtJoiningDate" Display="Dynamic" ValidationGroup="Entry">
                                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Joining Date"></span>
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revJoiningDate" runat="server" ControlToValidate="txtJoiningDate" Display="Dynamic" ValidationGroup="Entry"
                                    ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$">
                                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Date"></span>
                                </asp:RegularExpressionValidator>
                            </td>
                            <td>
                                <asp:TextBox ID="txtehrmsCode" runat="server" autocomplete="off"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="revEhrmsCode" runat="server" ControlToValidate="txtEhrmsCode" Display="Dynamic" ValidationExpression="^[1-9][0-9]{4,6}$" ValidationGroup="Entry">
                                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid ehrms Code"></span>
                                </asp:RegularExpressionValidator>
                                <%--<asp:RequiredFieldValidator ID="rfvehrmsCode" runat="server" ControlToValidate="txtehrmsCode" Display="Dynamic" ValidationGroup="Entry">
                                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter ehrms Code"></span>
                                </asp:RequiredFieldValidator>--%>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success"
                        OnClick="btnUpdate_Click" ValidationGroup="Entry" Text="Update" Enabled="false" Style="float: right" />
                </div>
            </div>
        </div>

    </section>
    <script src="bootstrap/js/datatables/jquery.dataTables.min.js"></script>
    <script>
        $(function () {
            $('#<%=txtJoiningDate.ClientID%>').datepicker({
                dateFormat: 'dd/mm/yy', autoclose: true, maxDate: 0
            });
        });
    </script>
    <link href="jquery-ui-1.12.1.custom/jquery-ui.min.css" rel="stylesheet" />
    <script src="jquery-ui-1.12.1.custom/jquery-ui.js"></script>
</asp:Content>

