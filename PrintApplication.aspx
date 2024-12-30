<%@ Page Title="" Language="C#" MasterPageFile="HomeMaster.master" AutoEventWireup="true" CodeFile="PrintApplication.aspx.cs" Inherits="PrintApplication" EnableEventValidation="false" ViewStateEncryptionMode="Always" EnableViewState="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/datepicker.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
    <script src="js/sweetalert.min.js"></script>
    <link href="css/sweetalert.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <div class="row form-control-static top-padd">
            <div class="col-md-2">
                PIS Number (or P2 Number/P2 Computer ID)/ eHRMS Code <span class="redText">*</span>
            </div>
            <div class="col-md-4">
                <asp:TextBox ID="txtAppNo" runat="server" Width="270px" AutoCompleteType="Disabled" AutoComplete="Off"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAppNo" runat="server" ControlToValidate="txtAppNo" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter PIS Number/ eHRMS Code"></span>
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revAppNo" runat="server" ControlToValidate="txtAppNo" ValidationExpression="^[0-9]{2,10}$"
                    ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid PIS Number/ eHRMS Code"></span>
                </asp:RegularExpressionValidator>
            </div>
            <div class="col-md-2">
                Date of Birth <span class="redText">*</span>
            </div>
            <div class="col-md-4">
                <asp:TextBox ID="txtDOB" runat="server" Width="270px" CssClass="datepicker" autocomplete="off"></asp:TextBox>
                <asp:RequiredFieldValidator Display="Dynamic" ID="rfvDOB" runat="server" ControlToValidate="txtDOB" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Date of Birth"></span>
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator Display="Dynamic" ID="revDOB" runat="server" ControlToValidate="txtDOB" ValidationGroup="Entry"
                    ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Date"></span>
                </asp:RegularExpressionValidator>
            </div>
        </div>

        <div class="row form-control-static bott-padd50 top-padd25">
            <div class="col-md-4">
            </div>
            <div class="col-md-8">
                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Submit" Width="120px" ValidationGroup="Entry"
                    OnClick="btnSubmit_Click" />
                <a href="Questionnaire.aspx" class="btn btn-danger" style="width: 120px;">Go Back</a>
            </div>
        </div>
    </div>
    <script src="js/jquery-1.9.1.min.js"></script>
    <script src="js/bootstrap-datepicker.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.datepicker').datepicker({
                format: 'dd/mm/yyyy',
                todayBtn: 1,
                autoclose: true,
            });
        });
    </script>
</asp:Content>

