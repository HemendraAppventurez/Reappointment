<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="OpenReappointmentPortal.aspx.cs" Inherits="OpenReappointmentPortal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../bootstrap/js/datatables/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="../css/dashboard/AdminLTE.css" rel="stylesheet" />
    <script src="../bootstrap/js/jquery-3.1.1.min.js"></script>
    <script src="../bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    <link href="../css/sweetalert.css" rel="stylesheet" />
    <script src="../js/sweetalert.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        $(function () {
            $('#<%=txtOpeningDate.ClientID%>').datepicker({
                dateFormat: 'dd/mm/yy', autoclose: true
            });

            $('#<%=txtClosingDate.ClientID%>').datepicker({
                dateFormat: 'dd/mm/yy', autoclose: true
            });
        });
        function CalculateDate() {
            var D1 = $("#<%=txtOpeningDate.ClientID%>").val();
            if (D1 != null) {
                var D2 = new Date(D1.split('/')[1] + "/" + D1.split('/')[0] + "/" + D1.split('/')[2]);
                D2.setDate(D2.getDate() + 14);
                if (D2.getMonth() + 1 < 10)
                    var month = "0" + (D2.getMonth() + 1);
                else
                    var month = D2.getMonth() + 1;
                var ClosingDate = D2.getDate() + "/" + month + "/" + D2.getFullYear();
                $("#<%=txtClosingDate.ClientID%>").val(ClosingDate);
            }
        }
    </script>
    <style type="text/css">
        .table > tbody > tr > td {
            padding: 3px !important;
        }
    </style>
    <section class="content-header">
        <h1>Open Reappointment Portal</h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-pie-chart"></i>Home</a></li>
            <li class="active">Open Reappointment Portal</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <div class="box box-solid box-default">
            <div class="box-header text-left">
                <div class="container form-control-static" runat="server" id="r1">
                    <div class="row">
                        <div class="col-md-2 col-sm-12 col-xs-12">
                            Upload vacancy Template
                        <asp:RequiredFieldValidator ID="rfvFile" runat="server" ControlToValidate="fuFile" ValidationGroup="Entry2">
                        <span class="glyphicon glyphicon-exclamation-sign" style="color:red;" title="Upload file"></span>
                        </asp:RequiredFieldValidator><br />

                        </div>
                        <div class="col-md-4 col-sm-12 col-xs-12">
                            <asp:FileUpload ID="fuFile" runat="server"></asp:FileUpload>
                        </div>
                        <div class="col-md-2">
                            <asp:Button ID="btnUPLOAD" runat="server" Text="UPLOAD" OnClick="btnUPLOAD_Click" CssClass="btn btn-primary" ValidationGroup="Entry2" />
                        </div>
                        <div class="col-md-3 col-sm-12 col-xs-12"><b><a href="VacancyTemplate.xlsx">Download Vacancy Template</a></b></div>

                    </div>
                </div>
                <div class="container form-control-static" runat="server" id="r2">
                    <div class="row">
                        <div class="col-md-2 col-sm-12 col-xs-12">
                            Opening Date
                        </div>
                        <div class="col-md-3 col-sm-12 col-xs-12">
                            <asp:TextBox ID="txtOpeningDate" runat="server" placeholder="dd/mm/yyyy" Style="padding: 4px; width: 240px" autocomplete="off" onchange="CalculateDate()"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvInterviewDate" runat="server" Display="Dynamic" ControlToValidate="txtOpeningDate" ValidationGroup="Entry">
                        <span class="glyphicon glyphicon-exclamation-sign" style="color:red;" title="Enter Opening Date"></span>
                            </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revOpeningDate" runat="server" ControlToValidate="txtOpeningDate"
                                ValidationGroup="Entry" ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$" Display="Dynamic">
                <span class="glyphicon glyphicon-exclamation-sign" style="color:red" title="Invalid Date" ></span>
                            </asp:RegularExpressionValidator>
                        </div>
                        <div class="col-md-2 col-sm-12 col-xs-12">
                            Closing Date
                        </div>
                        <div class="col-md-3 col-sm-12 col-xs-12">
                            <asp:TextBox ID="txtClosingDate" runat="server" Style="padding: 4px; width: 240px" placeholder="dd/mm/yyyy" autocomplete="off"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvInterviewTime" runat="server" Display="Dynamic" ControlToValidate="txtClosingDate" ValidationGroup="Entry">
                        <span class="glyphicon glyphicon-exclamation-sign" style="color:red;" title="Enter Closing Date"></span>
                            </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revClosingDate" runat="server" ControlToValidate="txtClosingDate"
                                ValidationGroup="Entry" ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$" Display="Dynamic">
                <span class="glyphicon glyphicon-exclamation-sign" style="color:red" title="Invalid Date" ></span>
                            </asp:RegularExpressionValidator>
                        </div>
                    </div>
                </div>
                <div class="container form-control-static" runat="server" id="r3">
                    <div class="row">
                        <div class="col-md-2 col-sm-12 col-xs-12">
                            Vacancy Roaster For MBBS<br />
                            (.pdf format only)
                        </div>
                        <div class="col-md-3 col-sm-12 col-xs-12">
                            <asp:FileUpload ID="fuVacancyRoaster" runat="server" Style="float: left; border: 1px solid silver" />
                            <asp:RequiredFieldValidator ID="rfvVacancyRoaster" runat="server" ControlToValidate="fuVacancyRoaster" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign" style="color: red;" title="Upload Vacancy Roaster"></span>
                            </asp:RequiredFieldValidator>
                        </div>

                        <div class="col-md-2 col-sm-12 col-xs-12">
                            Vacancy Roaster For Specialist<br />
                            (.pdf format only)
                        </div>
                        <div class="col-md-3 col-sm-12 col-xs-12">
                            <asp:FileUpload ID="fuVacancyRoasterForSpecialist" runat="server" Style="float: left; border: 1px solid silver" />
                            <asp:RequiredFieldValidator ID="rfvVacancyRoasterForSpecialist" runat="server" ControlToValidate="fuVacancyRoasterForSpecialist" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign" style="color: red;" title="Upload Vacancy Roaster"></span>
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success" ValidationGroup="Entry"
                        OnClick="btnSubmit_Click" Text="Open Portal and Update Vacancy Roaster" />
                </div>

            </div>




            <asp:Repeater ID="rptData" runat="server">
                <HeaderTemplate>
                    <table id="example1" style="font-size: 0.9em; width: 100%; color: black;">
                        <colgroup>
                            <col style="width: 10%;" />
                            <col style="width: 20%;" />
                            <col style="width: 35%;" />
                            <col style="width: 35%;" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th style="vertical-align: top; height: 30px;" align="left">S.No.</th>
                                <th style="vertical-align: top;" align="left">District Name</th>
                                <th style="vertical-align: top;" align="left"># Of Position for MBBS</th>
                                <th style="vertical-align: top;" align="left"># Of Postition for Specialist</th>
                            </tr>
                        </thead>
                    </table>
                    <div style="overflow-x: scroll !important; max-height: 350px;">
                        <table id="example" class="table table-hover table-bordered" style="font-size: 0.9em; color: black;">
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td valign="top" align="left" style="width: 10%;"><%# Container.ItemIndex + 1 %><asp:Label ID="lblDistrictID" runat="server" Text='<%# Eval("DistrictID") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lblDistrict" runat="server" Text='<%# Eval("District") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lblDistrictKey_MS" runat="server" Text='<%# Eval("DistrictKey_MS") %>' Visible="false"></asp:Label>

                        </td>
                        <td valign="top" align="left" style="width: 20%;"><%# Eval("District") %> </td>
                        <td valign="top" align="left" style="width: 35%;">
                            <asp:TextBox ID="txtMBBSPostition" runat="server" Width="150px" MaxLength="3" Text='<%# Eval("MBBS") %>' AutoCompleteType="Disabled" AutoComplete="Off"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvMBBSPostition" runat="server" ControlToValidate="txtMBBSPostition" ValidationGroup="Entry" Display="Dynamic">
                <span class="glyphicon glyphicon-exclamation-sign" style="color: red;" title="Enter Number of Postition for MBBS"></span>
                            </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revMBBSPostition" runat="server" ControlToValidate="txtMBBSPostition" ValidationExpression="^-?[0-9]{0,3}$" Display="Dynamic" ValidationGroup="Entry">
                                <span class="glyphicon glyphicon-exclamation-sign redText" style="color: red;" title="Enter Valid Number"></span>
                            </asp:RegularExpressionValidator>

                        </td>
                        <td valign="top" align="left" style="width: 35%;">
                            <asp:TextBox ID="txtVacantPostition" runat="server" Width="150px" MaxLength="3" Text='<%# Eval("Specialist") %>' AutoCompleteType="Disabled" AutoComplete="Off"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvVacantPostition" runat="server" ControlToValidate="txtVacantPostition" ValidationGroup="Entry" Display="Dynamic">
                <span class="glyphicon glyphicon-exclamation-sign" style="color: red;" title="Enter Vacant Number"></span>
                            </asp:RequiredFieldValidator>

                            <asp:RegularExpressionValidator ID="revVacantPostition" runat="server" ControlToValidate="txtVacantPostition" ValidationExpression="^-?[0-9]{0,3}$" Display="Dynamic" ValidationGroup="Entry">
                                <span class="glyphicon glyphicon-exclamation-sign redText" style="color: red;" title="Enter Valid Number"></span>
                            </asp:RegularExpressionValidator>
                        </td>

                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                    </div>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
        </div>

    </section>
    <div id="divRounds" runat="server">
        <div class="col-md-7"></div>
        <div class="col-md-5">
            <div class="panel" style="border: solid 1px orangered; border-radius: 5%;">
                <div class="panel-title panel-title" style="text-align: center; background-color: orangered; border-top-left-radius: 12px; border-top-right-radius: 12px; height: 40px; padding-top: 10px; color: white"><b>Previous Portal Rounds</b></div>
                <div class="panel-body" id="trRound" runat="server" style="max-height: 300px; overflow-y: scroll">
                </div>
            </div>
        </div>
    </div>
    <link href="jquery-ui-1.12.1.custom/jquery-ui.min.css" rel="stylesheet" />
    <script src="jquery-ui-1.12.1.custom/jquery-ui.js"></script>
</asp:Content>

