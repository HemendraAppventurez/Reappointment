<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeFile="NewsAnnouncements.aspx.cs" Inherits="NewsAnnouncements" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="bootstrap/js/datatables/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="css/dashboard/AdminLTE.css" rel="stylesheet" />
    <script src="bootstrap/js/jquery-3.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    <link href="css/sweetalert.css" rel="stylesheet" />
    <script src="js/sweetalert.min.js"></script>
    <script>
        function ConfirmUndo() {
            var inputs = document.getElementsByTagName('input');
            var count = 0

            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].type == "checkbox") {
                    if (inputs[i].checked == true)
                        count = count + 1;
                }
            }
            if (count > 0) {
                var r = confirm("Are you sure you want to remove the selected News.");
                if (r == true) {
                    return true;
                }
                else {
                    return false;
                }
            }
        }
    </script>
    <section class="content-header">
        <h1>News and Announcements</h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">News and Announcements</li>
        </ol>
    </section>
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <!-- Main content -->
    <section class="content">
        <div id="printContent" runat="server">
            <div class="box box-solid box-default" style="overflow-x: scroll !important; max-height: 530px;">
                <div class="box-header">
                    <div class="col-md-2">
                        <label for="txtNews">Heading</label>
                        &nbsp; 
                        <asp:RequiredFieldValidator ID="rfvNews" runat="server" ControlToValidate="txtNews" ValidationGroup="Entry">
                        <span class="glyphicon glyphicon-exclamation-sign" style="color:red;" title="Enter News and Announcements heading"></span>
                        </asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-10">
                        <asp:TextBox ID="txtNews" runat="server" Style="width: 100%" autocomplete="off"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <label for="fuMBBSNew">MBBS New</label>
                    </div>
                    <div class="col-md-4">
                        <asp:FileUpload ID="fuMBBSNew" runat="server" Style="padding: 4px; display: inline" Width="200px"></asp:FileUpload>
                    </div>
                    <div class="col-md-2">
                        <label for="fuMBBSExt">MBBS Extention</label>
                    </div>
                    <div class="col-md-4">
                        <asp:FileUpload ID="fuMBBSExt" runat="server" Style="padding: 4px; display: inline" Width="200px"></asp:FileUpload>
                    </div>
                    <div class="col-md-2">
                        <label for="fuSpecialistNew">Specialist New</label>
                    </div>
                    <div class="col-md-4">
                        <asp:FileUpload ID="fuSpecialistNew" runat="server" Style="padding: 4px; display: inline" Width="200px"></asp:FileUpload>
                    </div>
                    <div class="col-md-2">
                        <label for="fuSpecialistExt">Specialist Extention</label>
                    </div>
                    <div class="col-md-4">
                        <asp:FileUpload ID="fuSpecialistExt" runat="server" Style="padding: 4px; display: inline" Width="200px"></asp:FileUpload>
                    </div>
                    <div class="col-md-12">
                        <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" ValidationGroup="Entry"
                          OnClick="btnUpdate_Click" Text="Update News and Announcements" />
                    </div>
                </div>
                <asp:Repeater ID="rptNews" runat="server" OnItemCommand="rptNews_ItemCommand">
                    <HeaderTemplate>
                        <table id="example1" class="table table-hover table-bordered" style="font-size: 0.9em; color: black;">
                            <colgroup>
                                <col style="width: 1%;" />
                                <col style="width: 2%;" />
                                <col style="width: 50%;" />
                                <col style="width: 10%;" />
                                <col style="width: 10%;" />
                                <col style="width: 10%;" />
                                <col style="width: 10%;" />
                                <col style="width: 5%;" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th></th>
                                    <th style="vertical-align: top;">S.No.</th>
                                    <th style="vertical-align: top;" align="left">News</th>
                                    <th style="vertical-align: top;" align="left">MBBS New</th>
                                    <th style="vertical-align: top;" align="left">MBBS Extention</th>
                                    <th style="vertical-align: top;" align="left">Specialist New</th>
                                    <th style="vertical-align: top;" align="left">Specialist Extention</th>
                                    <th style="vertical-align: top;" align="left">Remove</th>
                                </tr>
                            </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td valign="top" align="left">
                                <asp:CheckBox runat="server" ID="chkApp" />
                                <asp:Label ID="lblNews" runat="server" Text='<%# Eval("id") %>' Visible="false"></asp:Label>
                            </td>

                            <td valign="top" align="left"><%# Container.ItemIndex+1 %></td>
                            <td valign="top" align="left"><%# Eval("NewsHeading") %> </td>
                            <td valign="top" align="left" style="word-break: break-all;"><a href="<%# "Files/"+Eval("MBBSNew").ToString()%>" target="_blank"><%# Eval("MBBSNew").ToString() %> </a></td>
                            <td valign="top" align="left" style="word-break: break-all;"><a href="<%# "Files/"+Eval("MBBSExt").ToString()%>" target="_blank"><%# Eval("MBBSExt").ToString() %> </a></td>
                            <td valign="top" align="left" style="word-break: break-all;"><a href="<%# "Files/"+Eval("SpecNew").ToString()%>" target="_blank"><%# Eval("SpecNew").ToString() %> </a></td>
                            <td valign="top" align="left" style="word-break: break-all;"><a href="<%# "Files/"+Eval("SpecExt").ToString()%>" target="_blank"><%# Eval("SpecExt").ToString() %> </a></td>
                            <td valign="top" align="center">
                                <asp:LinkButton ID="lnkremove" runat="server" CommandArgument='<%# Eval("id") %>' Text="Remove"
                                    CommandName="remove" ToolTip="Remove file" ForeColor="White" Style="padding: 4px;" BackColor="#e20000" OnClientClick="return ConfirmUndo();"></asp:LinkButton>
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

    </section>
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

