<%@ Page Title="" Language="C#" MasterPageFile="HomeMaster.master" AutoEventWireup="true" CodeFile="Questionnaire.aspx.cs"
    Inherits="Questionnaire" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
    <%--<script src="js/jquery-2.0.0_min.js"></script>--%>
    <script src="js/sweetalert.min.js"></script>
    <link href="css/datepicker.css" rel="stylesheet" />
    <link href="css/sweetalert.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
          function GetStatus() {
            var WantToReapply = $('#<%=rdoWantToReapply.ClientID%> :checked').val();
            if (WantToReapply == '1') {
                $('#<%=divNotJoiningReason.ClientID%>').show();
            }
            else {
                swal({ title: '', text: 'As you are working, Please try next time!!', type: 'error', showConfirmButton: true }, function () { window.location.href = 'Questionnaire.aspx'; })
                $('#<%=divForm.ClientID%>').hide();
            }
        }
        function ConfirmRemove() {
            var i = confirm('Are you Sure you want to remove this record?');
            if (i == 1)
                return true;
            else
                return false
        }
        function enableDisableDetailDisc() {
            var selectedvalue = $('#<%= rbDisciplinaryAction.ClientID %> input:checked').val();
            if (selectedvalue == "1") {
                $("#<%=txtDisciplinaryActionDetails.ClientID%>").removeAttr("disabled");
                $("#<%=txtDisciplinaryActionDetails.ClientID%>").focus();
                ValidatorEnable($('#<%= rfvDisciplinaryActionDetails.ClientID %>')[0], true);
            }
            else if (selectedvalue == "0") {
                $("#<%=txtDisciplinaryActionDetails.ClientID%>").val("");
                $("#<%=txtDisciplinaryActionDetails.ClientID%>").attr("disabled", "disabled");
                ValidatorEnable($('#<%= rfvDisciplinaryActionDetails.ClientID %>')[0], false);
            }
        }
        function enableDisableDetailCrim() {
            var selectedvalue = $('#<%= rbCriminalCases.ClientID %> input:checked').val();
            if (selectedvalue == "1") {
                $("#<%=txtCriminalCasesDetails.ClientID%>").removeAttr("disabled");
                $("#<%=txtCriminalCasesDetails.ClientID%>").focus();
                ValidatorEnable($('#<%= rfvCriminalCasesDetails.ClientID %>')[0], true);
            }
            else if (selectedvalue == "0") {
                $("#<%=txtCriminalCasesDetails.ClientID%>").val("");
                $("#<%=txtCriminalCasesDetails.ClientID%>").attr("disabled", "disabled");
                ValidatorEnable($('#<%= rfvCriminalCasesDetails.ClientID %>')[0], false);
            }
        }
        function enableDisableDetailCBI() {
            var selectedvalue = $('#<%= rblCBIEnquiry.ClientID %> input:checked').val();
            if (selectedvalue == "1") {
                $("#<%=txtCBIEnquiry.ClientID%>").removeAttr("disabled");
                $("#<%=txtCBIEnquiry.ClientID%>").focus();
                ValidatorEnable($('#<%= rfvCBIEnquiry.ClientID %>')[0], true);
            }
            else if (selectedvalue == "0") {
                $("#<%=txtCBIEnquiry.ClientID%>").val("");
                $("#<%=txtCBIEnquiry.ClientID%>").attr("disabled", "disabled");
                ValidatorEnable($('#<%= rfvCBIEnquiry.ClientID %>')[0], false);
            }
        }
        function enableDisableDetailVig() {
            var selectedvalue = $('#<%= rblVigilance.ClientID %> input:checked').val();
            if (selectedvalue == "1") {
                $("#<%=txtVigilance.ClientID%>").removeAttr("disabled");
                $("#<%=txtVigilance.ClientID%>").focus();
                ValidatorEnable($('#<%= rfvVigilance.ClientID %>')[0], true);
            }
            else if (selectedvalue == "0") {
                $("#<%=txtVigilance.ClientID%>").val("");
                $("#<%=txtVigilance.ClientID%>").attr("disabled", "disabled");
                ValidatorEnable($('#<%= rfvVigilance.ClientID %>')[0], false);
            }
        }
        function enableDisableReappointment() {
            var selectedvalue = $('#<%= rblNewOrExtension.ClientID %> input:checked').val();
            if (selectedvalue == "0") {
                ValidatorEnable($('#<%= rfvReRelieving.ClientID %>')[0], true);
                ValidatorEnable($('#<%= rfvReJoining.ClientID %>')[0], true);
                $("#<%=divReappointment.ClientID%>").show();
            }
            else if (selectedvalue == "1") {
                $("#<%=divReappointment.ClientID%>").hide();
                $("#<%=txtReJoining.ClientID%>").val("");
                $("#<%=txtReRelieving.ClientID%>").val("");
                ValidatorEnable($('#<%= rfvReJoining.ClientID %>')[0], false);
                ValidatorEnable($('#<%= rfvReRelieving.ClientID %>')[0], false);
            }
        }
        function MaritalStatus() {
            var selectedvalue = $('#<%= rblMaritalStatus.ClientID %> input:checked').val();
            if (selectedvalue == "Married") {
                $("#<%=divSpouse.ClientID%>").show();
                enableDisableSpousePIS();
            }
            else if (selectedvalue == "Unmarried") {
                $("#<%=divSpouse.ClientID%>").hide();
                $("#<%=divSpousePIS1.ClientID%>").hide();
                $("#<%=divSpousePIS2.ClientID%>").hide();
                $("#<%=txtSpousePIS.ClientID%>").val("");
                $('#<%=rblSpouseDoc.ClientID %>').val("0");

            }
        }
        function enableDisableSpousePIS() {
            var selectedvalue1 = $('#<%= rblSpouseDoc.ClientID %> input:checked').val();
            if (selectedvalue1 == "1") {
                $("#<%=divSpousePIS1.ClientID%>").show();
                $("#<%=divSpousePIS2.ClientID%>").show();
            }
            else if (selectedvalue1 == "0") {
                $("#<%=divSpousePIS1.ClientID%>").hide();
                $("#<%=divSpousePIS2.ClientID%>").hide();
                $("#<%=txtSpousePIS.ClientID%>").val("");
            }
        }
        function OtherHomeDistrict() {
            var selectedvalue = $('#<%= ddlHomeDistrict.ClientID %>').val();
            if (selectedvalue == "76") {
                $("#<%=divOtherHomeDistrict.ClientID%>").show();
                ValidatorEnable($('#<%= rfvOtherDistrictState.ClientID %>')[0], false);
            }
            else {
                $("#<%=divOtherHomeDistrict.ClientID%>").hide();
                $("#<%=txtOtherDistrictState.ClientID%>").val("");
                ValidatorEnable($('#<%= rfvOtherDistrictState.ClientID %>')[0], false);
            }
        }
        function Speciality() {
            var selectedvalue = $('#<%= ddlSpeciality.ClientID %>').val();
            if (selectedvalue == "0") {
                $("#<%=divApplySpecialist.ClientID%>").hide();
            }
            else {
                $("#<%=divApplySpecialist.ClientID%>").show();
            }
        }

        $(document).ready(function () {
            $("#<%=txtDOB.ClientID%>").datepicker({
                format: 'dd/mm/yyyy',
                todayBtn: 1,
                autoclose: true,
            }).on('changeDate', function (selected) {

                var D1 = $("#<%=txtDOB.ClientID%>").val();
                if (D1 != null) {
                    var D2 = new Date(D1.split('/')[1] + "/" + D1.split('/')[0] + "/" + D1.split('/')[2]);
                    if (Math.floor((new Date() - D2)) / (365.25 * 24 * 60 * 60 * 1000) < 60) {
                        swal("", "Age less than 60 years as on date is not allowed!", "error");
                        $("#<%=txtDOB.ClientID%>").val("");
                        $("#<%=txtAge.ClientID%>").val("");
                    } else {
                        var d = Math.round(Math.floor((new Date() - D2)) / (365.25 * 24 * 60 * 60 * 1000));
                        $("#<%=txtAge.ClientID%>").val(d);
                        }
                    }
                });
        });
        function CalculateAge() {
            var D1 = $("#<%=txtDOB.ClientID%>").val();
            if (D1 != null) {
                var D2 = new Date(D1.split('/')[1] + "/" + D1.split('/')[0] + "/" + D1.split('/')[2]);
                if (Math.floor((new Date() - D2)) / (365.25 * 24 * 60 * 60 * 1000) < 60) {
                    swal("", "Age less than 60 years as on date is not allowed!!", "error");
                    $("#<%=txtDOB.ClientID%>").val("");
                    $("#<%=txtAge.ClientID%>").val("");
                }
                else {
                    var d1 = Math.floor((new Date() - D2)) / (365.25 * 24 * 60 * 60 * 1000);
                    var d = Math.round(d1);
                    $("#<%=txtAge.ClientID%>").val(d);
                }
            }
        }
    </script>
    <asp:HiddenField ID="hidHRMSDiff" runat="server" />
    <asp:HiddenField ID="hidAddEditMode" runat="server" />
    <asp:HiddenField ID="hidRecordID" runat="server" />
    <asp:HiddenField ID="hidAppointmentStatus" runat="server" />
    <div class="row form-control-static text-center" style="padding-top: 0px !important; padding-bottom: 0px !important">
        <div class="col-md-12" style="padding: 10px; background-color: #016c7d;">
            <asp:Image ImageUrl="~/images/PDF-icon.png" ID="MBBSimg" runat="server" />
            <a href="Files/MBBS_6.pdf" target="_blank" style="color: white; font-size: 17px;" runat="server" id="MBBS">List of Vacancies for MBBS Position </a>&nbsp;&nbsp;
             <asp:Image ImageUrl="~/images/PDF-icon.png" ID="specialistimg" runat="server" />
            <a href="Files/Specialist_6.pdf" target="_blank" style="color: white; font-size: 17px;" runat="server" id="specialist">List of Vacancies for Specialist Position </a>&nbsp;&nbsp;
        </div>
    </div>
    <div class="row form-control-static text-center" style="padding-top: 0px !important; padding-bottom: 0px !important">
        <div class="col-md-12" style="padding: 10px; background-color: #eaeaea;">
            <a href="Files/GO.pdf" target="_blank" style="color: #1e09c1; text-decoration: underline; font-size: 17px;">Government order for Reappointment, dated 19th Jul, 2017</a>
        </div>
    </div>
    <div class="row form-control-static text-center" style="padding-top: 6px !important; padding-bottom: 0px !important; background-color: #58606f;">
        <div class="col-md-10 col-sm-9 col-xs-12" style="text-align: left;">
            <a href="PrintApplication.aspx" title="Click to take a Printout" style="color: white; font-size: 16px;"><span class="glyphicon glyphicon-print" title="Click to take a Printout"></span>Already applied? Click here to View/ Print your application</a>
        </div>
        <div class="col-md-2  col-sm-3  col-xs-12">
            <a href="ContactUs.aspx" target="_parent" title="Contact Us" style="color: white; font-size: 16px;"><span class="glyphicon glyphicon-envelope" title="Contact Us"></span>&nbsp;Contact Us</a>
        </div>
    </div>

    <div class="row top-padd25 redText" runat="server" id="divClosePortal" style="text-align: center">
        Portal is closed till further notice.
    </div>
    <div id="divOpenPortal" runat="server">
        <div class="row form-control-static">
            <div class="col-md-2">
                Application Type
            </div>
            <div class="col-md-10">
                <asp:RadioButtonList ID="rblNewOrExtension" runat="server" RepeatDirection="Vertical" onchange="enableDisableReappointment();" CssClass="rbl1">
                    <asp:ListItem Text="New Reappointment Application" Value="1" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Extension Application for Reappointment (eligible after 10 months of joining)" Value="0"></asp:ListItem>
                </asp:RadioButtonList>
            </div>
        </div>

        <div class="row top-padd25 form-control-static">
            <div class="col-md-2">
                PIS Number (P2 Number)/ eHRMS Code <span class="redText">*</span>
            </div>
            <div class="col-md-4">
                <asp:TextBox ID="txtPISNumber" runat="server" Width="270px" autocomplete="off"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPISNumber" runat="server" ControlToValidate="txtPISNumber" ValidationGroup="Entry1">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter PIS Number"></span>
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPISNumber" runat="server" ControlToValidate="txtPISNumber" ValidationExpression="^[a-zA-Z0-9\s]+$" ValidationGroup="Entry1">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid PIS Number"></span>
                </asp:RegularExpressionValidator>
            </div>
            <div class="col-md-6">
                <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Submit" ValidationGroup="Entry1" OnClick="btnSearch_Click" />
                <asp:Button ID="btnChangeDetail" runat="server" CssClass="btn btn-danger" Text="Edit Details" ValidationGroup="Entry1" OnClick="btnChangeDetails_Click" />
                <asp:Label runat="server" ID="lblEdit" Style="font-size: small" Text="(If required any correction, Click on Edit Button)" CssClass="redText"></asp:Label>
            </div>
        </div>
        <div id="divWantToReapply" runat="server" style="display: none;">
        <div class="row">
            <div class="col-md-12">You have been appointed in previous recruitment rounds</div>
        </div>
        <div class="row">
            <div class="col-md-2">Do you want to re-apply?</div>
            <div class="col-md-4">
                <asp:RadioButtonList ID="rdoWantToReapply" runat="server" RepeatDirection="Horizontal"
                    onchange="GetStatus();">
                    <asp:ListItem Value="1">Yes&nbsp;&nbsp;</asp:ListItem>
                    <asp:ListItem Value="0">No</asp:ListItem>
                </asp:RadioButtonList>
            </div>
        </div>
        <div class="row top-padd25" style="display: none" id="divNotJoiningReason" runat="server">
            <div class="col-md-2">Reason for re-applying</div>
            <div class="col-md-4">
                <asp:RadioButtonList ID="rdoNotJoiningReason" runat="server"  RepeatDirection="Vertical" AutoPostBack="true" OnSelectedIndexChanged="rdoNotJoiningReason_SelectedIndexChanged">
                    <asp:ListItem Value="NOTJOINED">Not Joined in Previous round</asp:ListItem>
                    <asp:ListItem Value="RESIGNED">Resigned/ Termination/ Service Pre-closer</asp:ListItem>
                    <%--<asp:ListItem Value="SERVICETERMINATED">Completion of service/ Not willing for extension</asp:ListItem>--%>
                </asp:RadioButtonList>
            </div>
        </div>
        <div style="padding-top: 25px; display: none" id="divSentMobileNumberMessage" runat="server">
            <div class="row">
                <div class="col-md-6">
                    <asp:Label ID="lblReason" runat="server"></asp:Label>&nbsp;
                    a verification code will be sent on your registered
                    <br />
                    Mobile Number:&nbsp;
                <asp:Label ID="lblmobileNo" runat="server" Style="font-weight: bold"></asp:Label>,&nbsp&nbsp; <span runat="server" id="spanEmailID">Email ID:</span>&nbsp;<asp:Label ID="lblEmailID" runat="server" Style="font-weight: bold"></asp:Label>

                </div>
                <div class="col-md-6" style="vertical-align: bottom;">
                    <asp:Button ID="btnGetOTP" runat="server" Text="Get Verification Code" CssClass="btn btn-info" OnClick="btnGetOTP_Click"  />
                </div>
            </div>
        </div>
        <div class="row" id="divMobileNumber" runat="server" style="padding-top: 25px; display: none;">
            <div class="col-md-12">
                <span class="redText">OTP sent on your registered Number and valid for 15 mintues.</span><asp:LinkButton ID="lnkResend" runat="server" >Resend OTP</asp:LinkButton>
            </div>
            <div class="col-md-2 top-padd25">
                Enter the OTP<span class="redText">*</span>
            </div>
            <div class="col-md-4  top-padd25">
                <asp:TextBox ID="txtOTP" runat="server" Style="width: 270px;" MaxLength="5" autocomplete="off" onkeypress="return isNumber(event)"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvOTP" runat="server" ControlToValidate="txtOTP" ErrorMessage="Enter Verification Code"
                    ValidationGroup="OTP" Display="Dynamic">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Verification Code"></span>
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revOTP" runat="server" ControlToValidate="txtOTP"
                    ValidationExpression="^[0-9]{5}$" ValidationGroup="OTP" Display="Dynamic" ErrorMessage="Incorrect Verification Code">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Incorrect Verification Code"></span>
                </asp:RegularExpressionValidator>
            </div>
            <div class="col-md-2  top-padd25">
                <asp:Button ID="btnSubmitOTP" runat="server" Text="Submit Verification Code"  CssClass="btn btn-info" ValidationGroup="OTP" OnClick="btnSubmitOTP_Click" />
            </div>
        </div>
    </div>
        <div id="divForm" runat="server" style="display: none; min-height: 400px;">
            <div id="divNotJoining" runat="server" style="display: none;" class="row form-control-static">
                <div class="col-md-2">
                    Please state reason of not joining your previous appointment?<span class="redText">*</span>
                </div>
                <div class="col-md-10">
                    <asp:TextBox ID="txtReasonNotJoining" runat="server" Width="90%" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvReasonNotJoining" runat="server" ErrorMessage="Enter Reason of Not joining your previous appointment" ControlToValidate="txtReasonNotJoining" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Reason of Not joining your previous appointment"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revReasonNotJoining" runat="server" ErrorMessage="Enter Valid format of String Reason of Not joining your previous appointment" ControlToValidate="txtReasonNotJoining" ValidationExpression="^[a-z A-Z.,]*$" ValidationGroup="Entry1">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Valid format of String Reason of Not joining your previous appointment"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Have you applied for this position before?
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rblHasAppliedBefore" runat="server" RepeatDirection="Horizontal" Width="120px">
                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                        <asp:ListItem Text="No" Value="0" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-2"></div>
                <div class="col-md-4"></div>
            </div>
            <div id="divReappointment" runat="server" class="row form-control-static" style="display: none;">
                <div class="col-md-2">
                    Date of Joining (of Reappointment)  <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtReJoining" runat="server" Width="270px" CssClass="datepicker" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator Display="Dynamic" ID="rfvReJoining" ErrorMessage="Enter Date of ReJoining (under Reappointment)" runat="server" ControlToValidate="txtReJoining" ValidationGroup="Entry">
                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Date of Joining (under Reappointment)"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revReJoining" runat="server" Display="Dynamic" ControlToValidate="txtReJoining" ErrorMessage="Invalid Date of Joining (of Reappointment)" ValidationGroup="Entry"
                        ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Date"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    Date of Relieving (of Reappointment) <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtReRelieving" runat="server" Width="270px" CssClass="datepicker" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvReRelieving" runat="server" ControlToValidate="txtReRelieving" ErrorMessage="Enter Date of Relieving (under Reappointment)" ValidationGroup="Entry" Enabled="false">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Date of Relieving (under Reappointment)"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revReRelieving" runat="server" ControlToValidate="txtReRelieving" ErrorMessage="Invalid Date of Relieving (of Reappointment)" ValidationGroup="Entry"
                        ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Date"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Applicant Name <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtName" runat="server" Width="270px" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Enter Name" ValidationGroup="Entry" Display="Dynamic">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Name"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revName" runat="server" ControlToValidate="txtName" ErrorMessage="Invalid Name" ValidationExpression="^[a-z A-Z.]*$" Display="Dynamic" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Name"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    Father’s/ Mother’s/ Spouse's Name <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtRelativeName" runat="server" Width="270px" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvRelativeName" runat="server" ControlToValidate="txtRelativeName" ErrorMessage="Enter Relative's Name" Display="Dynamic" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Relative's Name"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revRelativeName" runat="server" ControlToValidate="txtRelativeName" ErrorMessage="Invalid Relative's Name" Display="Dynamic" ValidationExpression="^[a-z A-Z.]*$" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Name"></span>
                    </asp:RegularExpressionValidator>
                </div>


            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Date of Birth <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtDOB" runat="server" Width="270px" CssClass="datepicker" autocomplete="off" onchange="CalculateAge();"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDOB" runat="server" ControlToValidate="txtDOB" ErrorMessage="Enter Date of Birth" ValidationGroup="Entry" Display="Dynamic">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Date of Birth"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revDOB" runat="server" ControlToValidate="txtDOB" ErrorMessage="Invalid Date of Birth" ValidationGroup="Entry" Display="Dynamic"
                        ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Date"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    Age <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtAge" runat="server" Width="270px" Enabled="false" autocomplete="off"></asp:TextBox>
                </div>


            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Gender <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlGender" runat="server" Width="270px">
                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvGender" runat="server" ControlToValidate="ddlGender" ErrorMessage="Select Gender" ValidationGroup="Entry" InitialValue="0">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Select Gender"></span>
                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-md-2">
                    Marital Status <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rblMaritalStatus" runat="server" RepeatDirection="Horizontal" Width="150px" onchange="MaritalStatus();">
                        <asp:ListItem Text="Married" Value="Married"></asp:ListItem>
                        <asp:ListItem Text="Unmarried" Value="Unmarried" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>
            <div id="divSpouse" runat="server" class="row form-control-static" style="display: none;">
                <div class="col-md-2">
                    Is your spouse working as a doctor in Department of Health & Family Welfare, Uttar Pradesh? <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rblSpouseDoc" runat="server" RepeatDirection="Horizontal" Width="120px" onchange="enableDisableSpousePIS();">
                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                        <asp:ListItem Text="No" Value="0" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div id="divSpousePIS1" runat="server" class="col-md-2" style="display: none;">
                    Spouse's PIS Number/ P2 Number/ eHRMS Code
                </div>
                <div id="divSpousePIS2" runat="server" class="col-md-4" style="display: none;">
                    <asp:TextBox ID="txtSpousePIS" runat="server" Width="270px" autocomplete="off"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revSpousePIS" runat="server" ControlToValidate="txtSpousePIS" ErrorMessage="Invalid Spouse's PIS Number" ValidationExpression="^[a-zA-Z0-9\s]+$" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid PIS Number"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    PAN Number <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtPANNumber" runat="server" Width="270px" MaxLength="10" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPANNumber" runat="server" ControlToValidate="txtPANNumber" ErrorMessage="Enter PAN Number" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter PAN Number"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPANNumber" runat="server" ControlToValidate="txtPANNumber" ErrorMessage="Invalid PAN Number" ValidationExpression="[A-Za-z]{5}\d{4}[A-Za-z]{1}" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    Aadhaar Number <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtAadhaar" runat="server" Width="270px" MaxLength="12" autocomplete="off"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revAadhaar" runat="server" ControlToValidate="txtAadhaar" Display="Dynamic" ErrorMessage="Invalid Aadhaar Number" ValidationExpression="^[1-9][0-9]{11}$" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Aadhaar Number"></span>
                    </asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="rfvAadhaar" runat="server" ControlToValidate="txtAadhaar" Display="Dynamic" ErrorMessage="Enter Aadhaar Number" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Aadhaar Number"></span>
                    </asp:RequiredFieldValidator>
                </div>

            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Date of Retirement <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtRetirementDate" runat="server" Width="270px" CssClass="datepicker" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvRetirementDate" runat="server" ControlToValidate="txtRetirementDate" ErrorMessage="Enter Date Of Retirement" Display="Dynamic" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Date of Retirement"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revRetirementDate" runat="server" ControlToValidate="txtRetirementDate" ErrorMessage="Invalid Date Of Retirement" Display="Dynamic" ValidationGroup="Entry"
                        ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Date"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    PPO Number
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtPPONumber" runat="server" Width="270px" MaxLength="15" autocomplete="off"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revPPONumber" runat="server" ControlToValidate="txtPPONumber" ErrorMessage="Invalid PPO Number" ValidationExpression="^[0-9\/]*$" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>

            </div>

            <div class="row form-control-static">
                <div class="col-md-2">
                    Permanent Address <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtPermAddress" runat="server" Width="270px" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPermAddress" runat="server" ControlToValidate="txtPermAddress" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Permanent Address"></span>
                    </asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator ID="revPermAddress" runat="server" ErrorMessage="Invalid Permanent Address" ControlToValidate="txtPermAddress" ValidationGroup="Entry"
                        ValidationExpression="^[a-zA-Z0-9-//., \s]+$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    Current Address <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtCurrentAddress" runat="server" Width="270px" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCurrentAddress" runat="server" ControlToValidate="txtCurrentAddress" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Current Address"></span>
                    </asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator ID="revCurrentAddress" runat="server" ErrorMessage="Invalid Current Address" ControlToValidate="txtCurrentAddress" ValidationGroup="Entry"
                        ValidationExpression="^[a-zA-Z0-9-//., \s]+$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>

            <div class="row form-control-static">
                <div class="col-md-2">
                    Mobile Number <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtPhone" runat="server" Width="270px" MaxLength="10" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Enter Mobile Number" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Mobile Number"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Invalid Mobile Number" ValidationGroup="Entry"
                        ValidationExpression="^[6-9][0-9]{9}$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Mobile Number"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    Email ID  <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtEmail" runat="server" Width="270px" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Enter Email ID" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Email ID"></span>
                    </asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid Email ID" Display="Dynamic" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Email ID"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Home District <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlHomeDistrict" runat="server" Width="270px" onchange="OtherHomeDistrict();"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvddlHomeDistrict" runat="server" ControlToValidate="ddlHomeDistrict" ErrorMessage="Select Home District" ValidationGroup="Entry" InitialValue="0">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Select Home District"></span>
                    </asp:RequiredFieldValidator>
                </div>
            </div>
            <div id="divOtherHomeDistrict" runat="server" class="row form-control-static" style="display: none;">
                <div class="col-md-2">
                    Home District,State <span class="redText">*</span>
                </div>
                <div class="col-md-10">
                    <asp:TextBox ID="txtOtherDistrictState" runat="server" Width="270px" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvOtherDistrictState" runat="server" ControlToValidate="txtOtherDistrictState" ErrorMessage="Enter Home District and State" Display="Dynamic" ValidationGroup="Entry" Enabled="false">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Home District and State"></span>
                    </asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator ID="revOtherDistrictState" runat="server" ControlToValidate="txtOtherDistrictState" ErrorMessage="Invalid Home District and State Format" Display="Dynamic" ValidationExpression="^[a-z A-Z.,]*$" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                    <span style="color: #07559a; font-size: 13px;">(Enter your home district and state name seperated by comma. Example- Mumbai, Maharashtra)</span>
                </div>
            </div>



            <div class="row form-control-static">
                <div class="col-md-12 text-center" style="border-bottom: 1px solid #b0b0de; color: #006675;">
                    <h3>Service Details</h3>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Seniority Number <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtSeniority" runat="server" Width="270px" MaxLength="12" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvSeniority" runat="server" ControlToValidate="txtSeniority" ErrorMessage="Enter Seniority Number" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Seniority Number"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revSeniority" runat="server" ErrorMessage="Invalid Seniority Number" ControlToValidate="txtSeniority" ValidationExpression="^[a-zA-Z0-9\s]+$" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Seniority Number"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    e-HRMS Code (or Manav Sampada Code)
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtHRMSCode" runat="server" Width="270px" MaxLength="7" autocomplete="off"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revHRMSCode" runat="server" ErrorMessage="Invalid e-HRMS Code" ControlToValidate="txtHRMSCode" ValidationExpression="^[1-9][0-9]{4,7}" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid e-HRMS Code"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Level <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlLevel" runat="server" Width="270px">
                        <asp:ListItem Text="Select Level" Value="0"></asp:ListItem>
                        <asp:ListItem Text="L1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="L2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="L3" Value="3"></asp:ListItem>
                        <asp:ListItem Text="L4" Value="4"></asp:ListItem>
                        <asp:ListItem Text="L5" Value="5"></asp:ListItem>
                        <asp:ListItem Text="L6" Value="6"></asp:ListItem>
                        <asp:ListItem Text="L7" Value="7"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvLevel" runat="server" ControlToValidate="ddlLevel" InitialValue="0" ErrorMessage="Select Level" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Select Level"></span>
                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-md-2">
                    Speciality
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlSpeciality" runat="server" Width="270px" onchange="Speciality();"></asp:DropDownList>
                </div>
            </div>
            <div id="divApplySpecialist" runat="server" class="row form-control-static" style="display: none;">
                <div class="col-md-2">
                    Do you wish to apply for a Specialist position? <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rblApplySpecPos" runat="server" RepeatDirection="Horizontal" Width="150px" onchange="MaritalStatus();">
                        <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="No" Value="0"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-2">
                </div>
                <div class="col-md-4">
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <br />
                    <strong>Posting details (Start from last Posting. Provide Posting Details of last 10 years only)</strong>
                    <asp:LinkButton ID="lnkAddRow" runat="server" Text="Click to Add Posting Detail" OnClick="lnkAddRow_Click"></asp:LinkButton>
                    <br />
                    <br />
                </div>
            </div>
            <div class="row form-control-static" style="width: 96%; margin: 0px auto; background-color: #fcfcfc; border: 1px solid gainsboro;">
                <div class="col-md-12" style="overflow-x: auto">
                    <table style="width: 98%; margin: 0px auto;" class="table">
                        <colgroup>
                            <col style="width: 23%;" />
                            <col style="width: 23%;" />
                            <col style="width: 18%;" />
                            <col style="width: 18%;" />
                            <col style="width: 18%;" />
                        </colgroup>
                        <tr>
                            <th style="border-right: 1px solid #e8e8e8; border-top: 0px !important;">Designation
                            </th>
                            <th style="border-right: 1px solid #e8e8e8; border-top: 0px !important;">District
                            </th>
                            <th style="border-right: 1px solid #e8e8e8; border-top: 0px !important; text-align: center;">Date of Joining
                            </th>
                            <th style="border-top: 0px !important; text-align: center;">Date of Relieving
                            </th>
                            <th style="border-top: 0px !important;"></th>
                        </tr>
                        <tr id="trAddEdit" runat="server" style="display: none; background-color: #ffd2c0;">
                            <td style="border-right: 1px solid #e8e8e8; vertical-align: middle;">
                                <asp:DropDownList ID="ddlDesig" runat="server" Width="200px"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvDesig" runat="server" ControlToValidate="ddlDesig" ErrorMessage="Select Designation" ValidationGroup="Posting">
                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Select Designation"></span>
                                </asp:RequiredFieldValidator>
                            </td>
                            <td style="border-right: 1px solid #e8e8e8; vertical-align: middle;">
                                <asp:DropDownList ID="ddlDistrict" runat="server" Width="200px"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" ControlToValidate="ddlDistrict" ErrorMessage="Select District" ValidationGroup="Posting">
                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Select District"></span>
                                </asp:RequiredFieldValidator>
                            </td>
                            <td style="border-right: 1px solid #e8e8e8; vertical-align: middle; text-align: center;">
                                <asp:TextBox ID="txtJoining" runat="server" CssClass="datepicker" Width="150px" autocomplete="off"></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" ID="rfvJoining" runat="server" ErrorMessage="Enter Date of Joining" ControlToValidate="txtJoining" ValidationGroup="Posting">
                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Date of Joining"></span>
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator Display="Dynamic" ErrorMessage="Invalid Date of Joining Format" ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtJoining" ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$" ValidationGroup="Posting">
                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                                </asp:RegularExpressionValidator>
                            </td>
                            <td style="border-right: 1px solid #e8e8e8; vertical-align: middle; text-align: center;">
                                <asp:TextBox ID="txtRelieving" runat="server" CssClass="datepicker" Width="150px" autocomplete="off"></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" ID="rfvRelieving" ErrorMessage="Enter Date of Relieving" runat="server" ControlToValidate="txtRelieving" ValidationGroup="Posting">
                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Date of Relieving"></span>
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator Display="Dynamic" ID="RegularExpressionValidator1" ErrorMessage="Invalid Date of Relieving Format" runat="server" ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$" ControlToValidate="txtRelieving" ValidationGroup="Posting">
                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                                </asp:RegularExpressionValidator>
                            </td>
                            <td>
                                <asp:Button ID="Add" runat="server" Text="Add" OnClick="Add_Click" CssClass="btn btn-success" ValidationGroup="Posting" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" CssClass="btn btn-success" />
                            </td>
                        </tr>
                        <asp:Repeater ID="rptPositions" runat="server" OnItemCommand="rptPositions_ItemCommand">
                            <HeaderTemplate>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr style="background-color: #f3f3f3">
                                    <td style="border-right: 1px solid #e8e8e8;"><%# Eval("DesignationName") %></td>
                                    <td style="border-right: 1px solid #e8e8e8;"><%# Eval("DistrictName") %></td>
                                    <td style="border-right: 1px solid #e8e8e8; text-align: center;"><%# DataBinder.Eval(Container.DataItem, "Joining", "{0:dd/MM/yyyy}").Replace('-','/') %></td>
                                    <td style="border-right: 1px solid #e8e8e8; text-align: center;"><%# DataBinder.Eval(Container.DataItem, "Relieving", "{0:dd/MM/yyyy}").Replace('-','/') =="01/01/0001" ? "" : DataBinder.Eval(Container.DataItem, "Relieving", "{0:dd/MM/yyyy}").Replace('-','/') %></td>
                                    <td>
                                        <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%#Eval("ID") %>' CommandName="Edit" Text="Edit"></asp:LinkButton>
                                        <asp:LinkButton ID="lnkRemove" runat="server" CommandArgument='<%# Container.ItemIndex %>' CommandName="Remove" Text="Remove" Style="color: red;" OnClientClick="return ConfirmRemove();"></asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <tr style="background-color: #fbfbfb">
                                    <td style="border-right: 1px solid #e8e8e8;"><%# Eval("DesignationName") %></td>
                                    <td style="border-right: 1px solid #e8e8e8;"><%#Eval("DistrictName") %></td>
                                    <td style="border-right: 1px solid #e8e8e8; text-align: center;"><%#  DataBinder.Eval(Container.DataItem, "Joining", "{0:dd/MM/yyyy}").Replace('-','/') %></td>
                                    <td style="border-right: 1px solid #e8e8e8; text-align: center;"><%# DataBinder.Eval(Container.DataItem, "Relieving").ToString() =="01/01/0001" ? "" : DataBinder.Eval(Container.DataItem, "Relieving", "{0:dd/MM/yyyy}").Replace('-','/') %></td>
                                    <td>
                                        <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%#Eval("ID") %>' CommandName="Edit" Text="Edit"></asp:LinkButton>
                                        <asp:LinkButton ID="lnkRemove" runat="server" CommandArgument='<%# Container.ItemIndex %>' CommandName="Remove" Text="Remove" Style="color: red;" OnClientClick="return ConfirmRemove();"></asp:LinkButton>
                                    </td>
                                </tr>
                            </AlternatingItemTemplate>
                        </asp:Repeater>
                    </table>
                </div>
            </div>
            <div class="row form-control-static top-padd25">
                <div class="col-md-2">
                    District Preference 1 <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlDistPreference1" runat="server" Width="270px" AutoPostBack="true" OnSelectedIndexChanged="ddlDistPreference1_SelectedIndexChanged"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvDistPreference1" runat="server" ControlToValidate="ddlDistPreference1" ErrorMessage="Select District Preference 1" InitialValue="0" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Select District Preference 1"></span>
                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-md-2">
                    District Preference 2
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlDistPreference2" runat="server" Width="270px" AutoPostBack="true" OnSelectedIndexChanged="ddlDistPreference2_SelectedIndexChanged"></asp:DropDownList>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    District Preference 3
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlDistPreference3" runat="server" Width="270px" AutoPostBack="true" OnSelectedIndexChanged="ddlDistPreference3_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="col-md-2">
                    Last Drawn Salary
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtLastDrawnSal" runat="server" Width="270px" autocomplete="off"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revLastDrawnSal" runat="server" ControlToValidate="txtLastDrawnSal"
                        ValidationExpression="\d+(\.\d{1,2})?" ValidationGroup="Entry" ErrorMessage="Invalid Last Drawn Salary">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-12 text-center" style="border-bottom: 1px solid #b0b0de; color: #006675;">
                    <h3>Enquiry/Proceedings during Service</h3>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Disciplinary Action <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rbDisciplinaryAction" runat="server" Width="120px" RepeatDirection="Horizontal" onchange="enableDisableDetailDisc()">
                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                        <asp:ListItem Text="No" Value="0" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-2">
                    Disciplinary Action Details
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtDisciplinaryActionDetails" runat="server" Width="270px" Enabled="false" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDisciplinaryActionDetails" runat="server" Display="Dynamic" ControlToValidate="txtDisciplinaryActionDetails" ErrorMessage="Enter Disciplinary Action Details" ValidationGroup="Entry" Enabled="false">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Disciplinary Action Details"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revDisciplinaryActionDetails" runat="server" Display="Dynamic" ErrorMessage="Invalid Disciplinary Action Details Format" ControlToValidate="txtDisciplinaryActionDetails" ValidationGroup="Entry"
                        ValidationExpression="^[a-zA-Z0-9-//., \s]+$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Criminal Cases <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rbCriminalCases" runat="server" Width="120px" RepeatDirection="Horizontal" onchange="enableDisableDetailCrim();">
                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                        <asp:ListItem Text="No" Value="0" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-2">
                    Criminal Action Details
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtCriminalCasesDetails" runat="server" Width="270px" Enabled="false" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCriminalCasesDetails" runat="server" Display="Dynamic" ControlToValidate="txtCriminalCasesDetails" ErrorMessage="Enter Criminal Action Details" ValidationGroup="Entry" Enabled="false">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Criminal Action Details"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revCriminalCasesDetails" runat="server" Display="Dynamic" ErrorMessage="Invalid Criminal Action Details Format" ControlToValidate="txtCriminalCasesDetails" ValidationGroup="Entry"
                        ValidationExpression="^[a-zA-Z0-9-//., \s]+$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    CBI Enquiry <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rblCBIEnquiry" runat="server" Width="120px" RepeatDirection="Horizontal" onchange="enableDisableDetailCBI();">
                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                        <asp:ListItem Text="No" Value="0" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-2">
                    CBI Enquiry Details
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtCBIEnquiry" runat="server" Width="270px" Enabled="false" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCBIEnquiry" runat="server" ControlToValidate="txtCBIEnquiry" Display="Dynamic" ErrorMessage="Enter CBI Enquiry Details" ValidationGroup="Entry" Enabled="false">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="CBI Enquiry Details"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revCBIEnquiry" runat="server" ControlToValidate="txtCBIEnquiry" ErrorMessage="Invalid CBI Enquiry Details Format" Display="Dynamic" ValidationGroup="Entry"
                        ValidationExpression="^[a-zA-Z0-9-//., \s]+$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Vigilance Enquiry <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rblVigilance" runat="server" Width="120px" RepeatDirection="Horizontal" onchange="enableDisableDetailVig();">
                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                        <asp:ListItem Text="No" Value="0" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-2">
                    Vigilance Enquiry Details
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtVigilance" runat="server" Width="270px" Enabled="false" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvVigilance" runat="server" Display="Dynamic" ControlToValidate="txtVigilance" ErrorMessage="Enter Vigilance Enquiry Details" ValidationGroup="Entry" Enabled="false">
                <span class="glyphicon glyphicon-exclamation-sign redText"  title="Enter Vigilance Enquiry Details"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revVigilance" runat="server" Display="Dynamic" ErrorMessage="Invalid Vigilance Enquiry Details Format" ControlToValidate="txtVigilance" ValidationGroup="Entry"
                        ValidationExpression="^[a-zA-Z0-9-//., \s]+$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-12 Declaration">
                    <asp:CheckBox ID="chkBox" runat="server" OnCheckedChanged="chkBox_CheckedChanged" AutoPostBack="true" />
                    I hereby declare that the details given in the application form are true, complete and correct according to my knowledge and understanding. 
            I also accept that in the event of any information being found false, incomplete or incorrect at any point of time or if I do not fulfill the 
            qualifications of the eliibility criteria, my candidature may be cancelled without any notice.
            I have read all the rules, regulations and procedure of reappointment given in the advertisement and I'll stictly adhere to it.
                <br />
                    I will continue to observe the departmental website http://uphealth.up.nic.in and if I do not contribute to the prescribed post within one month of publication 
            of the reappointment orders on website, my application will be deemed cancelled.

                </div>
            </div>
            <div class="row form-control-static bott-padd50">
                <div class="col-md-4">
                </div>
                <div class="col-md-8">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Submit Final Form" Width="240px" ValidationGroup="Entry" OnClick="btnSubmit_Click" Enabled="false" />
                </div>
            </div>
            <div class="row form-control-static bott-padd50">
                <div class="col-md-12">
                    <strong>Note: List of documents which are to be carried along for physical verification :</strong>
                    <ul>
                        <li>Post-Graduate Degree/Diploma Degree (if relevant)</li>
                        <li>P.P.O. (Pension Paper)</li>
                        <li>Medical Certificate</li>
                        <li>PAN Card</li>
                        <li>Aadhar Card</li>
                        <li>P2 or eHRMS Code</li>
                        <li>Charge Certificate after retirement</li>
                        <li>Recommendation for extension by the concern authority (in case of extension of reappointment)</li>
                        <li><a href="Format1.pdf" target="_blank" title="Click here to download format">Performance report on the prescribed format (in case of extension of reappointment)</a></li>
                        <li>Affidavit on stamp paper of Rs. 10/-</li>
                    </ul>
                </div>
            </div>
        </div>
        <%-- <div id="divForm" runat="server" style="display: none; min-height: 400px;">
            <div id="divNotJoining" runat="server" style="display: none;" class="row form-control-static">
                <div class="col-md-2">
                    Please state reason of not joining your previous appointment?
                </div>
                <div class="col-md-10">
                    <asp:TextBox ID="txtReasonNotJoining" runat="server" Width="90%" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvReasonNotJoining" runat="server" ErrorMessage="Enter Reason of Not joining your previous appointment" ControlToValidate="txtReasonNotJoining" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Reason of Not joining your previous appointment"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revReasonNotJoining" runat="server" ErrorMessage="Enter Valid format of String Reason of Not joining your previous appointment" ControlToValidate="txtReasonNotJoining" ValidationExpression="^[a-z A-Z.,]*$" ValidationGroup="Entry1">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Valid format of String Reason of Not joining your previous appointment"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Have you applied for this position before?
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rblHasAppliedBefore" runat="server" RepeatDirection="Horizontal" Width="120px">
                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                        <asp:ListItem Text="No" Value="0" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-2"></div>
                <div class="col-md-4"></div>
            </div>
            <div id="divReappointment" runat="server" class="row form-control-static" style="display: none;">
                <div class="col-md-2">
                    Date of Joining (of Reappointment)
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtReJoining" runat="server" Width="270px" CssClass="datepicker" autocomplete="off"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revReJoining" runat="server" ControlToValidate="txtReJoining" ErrorMessage="Invalid Date of Joining (of Reappointment)" ValidationGroup="Entry"
                        ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Date"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    Date of Relieving (of Reappointment) <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtReRelieving" runat="server" Width="270px" CssClass="datepicker" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvReRelieving" runat="server" ControlToValidate="txtReRelieving" ErrorMessage="Enter Date of Relieving (under Reappointment)" ValidationGroup="Entry" Enabled="false">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Date of Relieving (under Reappointment)"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revReRelieving" runat="server" ControlToValidate="txtReRelieving" ErrorMessage="Invalid Date of Relieving (of Reappointment)" ValidationGroup="Entry"
                        ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Date"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Name <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtName" runat="server" Width="270px" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Enter Name" ValidationGroup="Entry" Display="Dynamic">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Name"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revName" runat="server" ControlToValidate="txtName" ErrorMessage="Invalid Name" ValidationExpression="^[a-z A-Z.]*$" Display="Dynamic" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Name"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    Date of Birth <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtDOB" runat="server" Width="270px" CssClass="datepicker" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDOB" runat="server" ControlToValidate="txtDOB" ErrorMessage="Enter Date of Birth" ValidationGroup="Entry" Display="Dynamic">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Date of Birth"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revDOB" runat="server" ControlToValidate="txtDOB" ErrorMessage="Invalid Date of Birth" ValidationGroup="Entry" Display="Dynamic"
                        ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Date"></span>
                    </asp:RegularExpressionValidator>

                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Gender <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlGender" runat="server" Width="270px">
                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvGender" runat="server" ControlToValidate="ddlGender" ErrorMessage="Select Gender" ValidationGroup="Entry" InitialValue="0">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Select Gender"></span>
                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-md-2">
                    Mobile Number <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtPhone" runat="server" Width="270px" MaxLength="10" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Enter Mobile Number" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Mobile Number"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Invalid Mobile Number" ValidationGroup="Entry"
                        ValidationExpression="^[6-9][0-9]{9}$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Mobile Number"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Father’s/ Mother’s/ Husband’s/ Wife’s Name <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtRelativeName" runat="server" Width="270px" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvRelativeName" runat="server" ControlToValidate="txtRelativeName" ErrorMessage="Enter Relative's Name" Display="Dynamic" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Relative's Name"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revRelativeName" runat="server" ControlToValidate="txtRelativeName" ErrorMessage="Invalid Relative's Name" Display="Dynamic" ValidationExpression="^[a-z A-Z.]*$" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Name"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    Date of Retirement <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtRetirementDate" runat="server" Width="270px" CssClass="datepicker" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvRetirementDate" runat="server" ControlToValidate="txtRetirementDate" ErrorMessage="Enter Date Of Retirement" Display="Dynamic" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Date of Retirement"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revRetirementDate" runat="server" ControlToValidate="txtRetirementDate" ErrorMessage="Invalid Date Of Retirement" Display="Dynamic" ValidationGroup="Entry"
                        ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Date"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Email ID  <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtEmail" runat="server" Width="270px" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Enter Email ID" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Email ID"></span>
                    </asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid Email ID" Display="Dynamic" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Email ID"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    Home District <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlHomeDistrict" runat="server" Width="270px" onchange="OtherHomeDistrict();"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvddlHomeDistrict" runat="server" ControlToValidate="ddlHomeDistrict" ErrorMessage="Select Home District" ValidationGroup="Entry" InitialValue="0">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Select Home District"></span>
                    </asp:RequiredFieldValidator>
                </div>
            </div>
            <div id="divOtherHomeDistrict" runat="server" class="row form-control-static" style="display: none;">
                <div class="col-md-2">
                    Home District,State <span class="redText">*</span>
                </div>
                <div class="col-md-10">
                    <asp:TextBox ID="txtOtherDistrictState" runat="server" Width="270px" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvOtherDistrictState" runat="server" ControlToValidate="txtOtherDistrictState" ErrorMessage="Enter Home District and State" Display="Dynamic" ValidationGroup="Entry" Enabled="false">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Home District and State"></span>
                    </asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator ID="revOtherDistrictState" runat="server" ControlToValidate="txtOtherDistrictState" ErrorMessage="Invalid Home District and State Format" Display="Dynamic" ValidationExpression="^[a-z A-Z.,]*$" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                    <span style="color: #07559a; font-size: 13px;">(Enter your home district and state name seperated by comma. Example- Mumbai, Maharashtra)</span>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Permanent Address <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtPermAddress" runat="server" Width="270px" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPermAddress" runat="server" ControlToValidate="txtPermAddress" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Permanent Address"></span>
                    </asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator ID="revPermAddress" runat="server" ErrorMessage="Invalid Permanent Address" ControlToValidate="txtPermAddress" ValidationGroup="Entry"
                        ValidationExpression="^[a-zA-Z0-9-//., \s]+$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    Current Address <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtCurrentAddress" runat="server" Width="270px" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCurrentAddress" runat="server" ControlToValidate="txtCurrentAddress" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Current Address"></span>
                    </asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator ID="revCurrentAddress" runat="server" ErrorMessage="Invalid Current Address" ControlToValidate="txtCurrentAddress" ValidationGroup="Entry"
                        ValidationExpression="^[a-zA-Z0-9-//., \s]+$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Aadhaar Number
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtAadhaar" runat="server" Width="270px" MaxLength="12" autocomplete="off"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revAadhaar" runat="server" ControlToValidate="txtAadhaar" ErrorMessage="Invalid Aadhaar Number" ValidationExpression="^[1-9][0-9]{11}$" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Aadhaar Number"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    PAN Number <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtPANNumber" runat="server" Width="270px" MaxLength="10" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPANNumber" runat="server" ControlToValidate="txtPANNumber" ErrorMessage="Enter PAN Number" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter PAN Number"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPANNumber" runat="server" ControlToValidate="txtPANNumber" ErrorMessage="Invalid PAN Number" ValidationExpression="[A-Za-z]{5}\d{4}[A-Za-z]{1}" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    PPO Number
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtPPONumber" runat="server" Width="270px" MaxLength="15" autocomplete="off"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revPPONumber" runat="server" ControlToValidate="txtPPONumber" ErrorMessage="Invalid PPO Number" ValidationExpression="^[0-9\/]*$" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    Marital Status <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rblMaritalStatus" runat="server" RepeatDirection="Horizontal" Width="150px" onchange="MaritalStatus();">
                        <asp:ListItem Text="Married" Value="Married"></asp:ListItem>
                        <asp:ListItem Text="Unmarried" Value="Unmarried" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>
            <div id="divSpouse" runat="server" class="row form-control-static" style="display: none;">
                <div class="col-md-2">
                    Is your spouse working as a doctor in Department of Health & Family Welfare, Uttar Pradesh? <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rblSpouseDoc" runat="server" RepeatDirection="Horizontal" Width="120px" onchange="enableDisableSpousePIS();">
                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                        <asp:ListItem Text="No" Value="0" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div id="divSpousePIS1" runat="server" class="col-md-2" style="display: none;">
                    Spouse's PIS Number (or P2 Number/P2 Computer ID)
                </div>
                <div id="divSpousePIS2" runat="server" class="col-md-4" style="display: none;">
                    <asp:TextBox ID="txtSpousePIS" runat="server" Width="270px" autocomplete="off"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revSpousePIS" runat="server" ControlToValidate="txtSpousePIS" ErrorMessage="Invalid Spouse's PIS Number" ValidationExpression="^[a-zA-Z0-9\s]+$" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid PIS Number"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-12 text-center" style="border-bottom: 1px solid #b0b0de; color: #006675;">
                    <h3>Service Details</h3>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Seniority Number <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtSeniority" runat="server" Width="270px" MaxLength="12" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvSeniority" runat="server" ControlToValidate="txtSeniority" ErrorMessage="Enter Seniority Number" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Seniority Number"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revSeniority" runat="server" ErrorMessage="Invalid Seniority Number" ControlToValidate="txtSeniority" ValidationExpression="^[a-zA-Z0-9\s]+$" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Seniority Number"></span>
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-2">
                    e-HRMS Code (or Manav Sampada Code)
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtHRMSCode" runat="server" Width="270px" MaxLength="6" autocomplete="off"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revHRMSCode" runat="server" ErrorMessage="Invalid e-HRMS Code" ControlToValidate="txtHRMSCode" ValidationExpression="^[1-9][0-9]{5}" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid e-HRMS Code"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Level <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlLevel" runat="server" Width="270px">
                        <asp:ListItem Text="L1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="L2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="L3" Value="3"></asp:ListItem>
                        <asp:ListItem Text="L4" Value="4"></asp:ListItem>
                        <asp:ListItem Text="L5" Value="5"></asp:ListItem>
                        <asp:ListItem Text="L6" Value="6"></asp:ListItem>
                        <asp:ListItem Text="L7" Value="7"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvLevel" runat="server" ControlToValidate="ddlLevel" ErrorMessage="Select Level" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Select Level"></span>
                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-md-2">
                    Speciality
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlSpeciality" runat="server" Width="270px" onchange="Speciality();"></asp:DropDownList>
                </div>
            </div>
            <div id="divApplySpecialist" runat="server" class="row form-control-static" style="display: none;">
                <div class="col-md-2">
                    Do you wish to apply for a Specialist position? <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rblApplySpecPos" runat="server" RepeatDirection="Horizontal" Width="150px">
                        <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="No" Value="0"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-2">
                </div>
                <div class="col-md-4">
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <br />
                    <strong>Posting details (Start from last Posting. Provide Posting Details of last 10 years only)</strong>
                    <asp:LinkButton ID="lnkAddRow" runat="server" Text="Click to Add Posting Detail" OnClick="lnkAddRow_Click"></asp:LinkButton>
                    <br />
                    <br />
                </div>
            </div>
            <div class="row form-control-static" style="width: 96%; margin: 0px auto; background-color: #fcfcfc; border: 1px solid gainsboro;">
                <div class="col-md-12" style="overflow-x: auto">
                    <table style="width: 98%; margin: 0px auto;" class="table">
                        <colgroup>
                            <col style="width: 23%;" />
                            <col style="width: 23%;" />
                            <col style="width: 18%;" />
                            <col style="width: 18%;" />
                            <col style="width: 18%;" />
                        </colgroup>
                        <tr>
                            <th style="border-right: 1px solid #e8e8e8; border-top: 0px !important;">Designation
                            </th>
                            <th style="border-right: 1px solid #e8e8e8; border-top: 0px !important;">District
                            </th>
                            <th style="border-right: 1px solid #e8e8e8; border-top: 0px !important; text-align: center;">Date of Joining
                            </th>
                            <th style="border-top: 0px !important; text-align: center;">Date of Relieving
                            </th>
                            <th style="border-top: 0px !important;"></th>
                        </tr>
                        <tr id="trAddEdit" runat="server" style="display: none; background-color: #ffd2c0;">
                            <td style="border-right: 1px solid #e8e8e8; vertical-align: middle;">
                                <asp:DropDownList ID="ddlDesig" runat="server" Width="200px"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvDesig" runat="server" ControlToValidate="ddlDesig" ErrorMessage="Select Designation" ValidationGroup="Posting">
                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Select Designation"></span>
                                </asp:RequiredFieldValidator>
                            </td>
                            <td style="border-right: 1px solid #e8e8e8; vertical-align: middle;">
                                <asp:DropDownList ID="ddlDistrict" runat="server" Width="200px"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" ControlToValidate="ddlDistrict" ErrorMessage="Select District" ValidationGroup="Posting">
                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Select District"></span>
                                </asp:RequiredFieldValidator>
                            </td>
                            <td style="border-right: 1px solid #e8e8e8; vertical-align: middle; text-align: center;">
                                <asp:TextBox ID="txtJoining" runat="server" CssClass="datepicker" Width="150px" autocomplete="off"></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" ID="rfvJoining" runat="server" ErrorMessage="Enter Date of Joining" ControlToValidate="txtJoining" ValidationGroup="Posting">
                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Date of Joining"></span>
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator Display="Dynamic" ErrorMessage="Invalid Date of Joining Format" ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtJoining" ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$" ValidationGroup="Posting">
                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                                </asp:RegularExpressionValidator>
                            </td>
                            <td style="border-right: 1px solid #e8e8e8; vertical-align: middle; text-align: center;">
                                <asp:TextBox ID="txtRelieving" runat="server" CssClass="datepicker" Width="150px" autocomplete="off"></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" ID="rfvRelieving" ErrorMessage="Enter Date of Relieving" runat="server" ControlToValidate="txtRelieving" ValidationGroup="Posting">
                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Date of Relieving"></span>
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator Display="Dynamic" ID="RegularExpressionValidator1" ErrorMessage="Invalid Date of Relieving Format" runat="server" ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$" ControlToValidate="txtRelieving" ValidationGroup="Posting">
                    <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                                </asp:RegularExpressionValidator>
                            </td>
                            <td>
                                <asp:Button ID="Add" runat="server" Text="Add" OnClick="Add_Click" CssClass="btn btn-success" ValidationGroup="Posting" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" CssClass="btn btn-success" />
                            </td>
                        </tr>
                        <asp:Repeater ID="rptPositions" runat="server" OnItemCommand="rptPositions_ItemCommand">
                            <HeaderTemplate>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr style="background-color: #f3f3f3">
                                    <td style="border-right: 1px solid #e8e8e8;"><%# Eval("DesignationName") %></td>
                                    <td style="border-right: 1px solid #e8e8e8;"><%# Eval("DistrictName") %></td>
                                    <td style="border-right: 1px solid #e8e8e8; text-align: center;"><%# DataBinder.Eval(Container.DataItem, "Joining", "{0:dd/MM/yyyy}").Replace('-','/') %></td>
                                    <td style="border-right: 1px solid #e8e8e8; text-align: center;"><%# DataBinder.Eval(Container.DataItem, "Relieving", "{0:dd/MM/yyyy}").Replace('-','/') =="01/01/0001" ? "" : DataBinder.Eval(Container.DataItem, "Relieving", "{0:dd/MM/yyyy}").Replace('-','/') %></td>
                                    <td>
                                        <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%#Eval("ID") %>' CommandName="Edit" Text="Edit"></asp:LinkButton>
                                        <asp:LinkButton ID="lnkRemove" runat="server" CommandArgument='<%# Container.ItemIndex %>' CommandName="Remove" Text="Remove" Style="color: red;" OnClientClick="return ConfirmRemove();"></asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <tr style="background-color: #fbfbfb">
                                    <td style="border-right: 1px solid #e8e8e8;"><%# Eval("DesignationName") %></td>
                                    <td style="border-right: 1px solid #e8e8e8;"><%#Eval("DistrictName") %></td>
                                    <td style="border-right: 1px solid #e8e8e8; text-align: center;"><%#  DataBinder.Eval(Container.DataItem, "Joining", "{0:dd/MM/yyyy}").Replace('-','/') %></td>
                                    <td style="border-right: 1px solid #e8e8e8; text-align: center;"><%# DataBinder.Eval(Container.DataItem, "Relieving").ToString() =="01/01/0001" ? "" : DataBinder.Eval(Container.DataItem, "Relieving", "{0:dd/MM/yyyy}").Replace('-','/') %></td>
                                    <td>
                                        <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%#Eval("ID") %>' CommandName="Edit" Text="Edit"></asp:LinkButton>
                                        <asp:LinkButton ID="lnkRemove" runat="server" CommandArgument='<%# Container.ItemIndex %>' CommandName="Remove" Text="Remove" Style="color: red;" OnClientClick="return ConfirmRemove();"></asp:LinkButton>
                                    </td>
                                </tr>
                            </AlternatingItemTemplate>
                        </asp:Repeater>
                    </table>
                </div>
            </div>
            <div class="row form-control-static top-padd25">
                <div class="col-md-2">
                    District Preference 1 <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlDistPreference1" runat="server" Width="270px" AutoPostBack="true" OnSelectedIndexChanged="ddlDistPreference1_SelectedIndexChanged"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvDistPreference1" runat="server" ControlToValidate="ddlDistPreference1" ErrorMessage="Select District Preference 1" InitialValue="0" ValidationGroup="Entry">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Select District Preference 1"></span>
                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-md-2">
                    District Preference 2
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlDistPreference2" runat="server" Width="270px" AutoPostBack="true" OnSelectedIndexChanged="ddlDistPreference2_SelectedIndexChanged"></asp:DropDownList>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    District Preference 3
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlDistPreference3" runat="server" Width="270px" AutoPostBack="true" OnSelectedIndexChanged="ddlDistPreference3_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="col-md-2">
                    Last Drawn Salary
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtLastDrawnSal" runat="server" Width="270px" autocomplete="off"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revLastDrawnSal" runat="server" ControlToValidate="txtLastDrawnSal"
                        ValidationExpression="\d+(\.\d{1,2})?" ValidationGroup="Entry" ErrorMessage="Invalid Last Drawn Salary">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-12 text-center" style="border-bottom: 1px solid #b0b0de; color: #006675;">
                    <h3>Enquiry/Proceedings during Service</h3>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Disciplinary Action <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rbDisciplinaryAction" runat="server" Width="120px" RepeatDirection="Horizontal" onchange="enableDisableDetailDisc()">
                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                        <asp:ListItem Text="No" Value="0" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-2">
                    Disciplinary Action Details
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtDisciplinaryActionDetails" runat="server" Width="270px" Enabled="false" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDisciplinaryActionDetails" runat="server" Display="Dynamic" ControlToValidate="txtDisciplinaryActionDetails" ErrorMessage="Enter Disciplinary Action Details" ValidationGroup="Entry" Enabled="false">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Disciplinary Action Details"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revDisciplinaryActionDetails" runat="server" Display="Dynamic" ErrorMessage="Invalid Disciplinary Action Details Format" ControlToValidate="txtDisciplinaryActionDetails" ValidationGroup="Entry"
                        ValidationExpression="^[a-zA-Z0-9-//., \s]+$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Criminal Cases <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rbCriminalCases" runat="server" Width="120px" RepeatDirection="Horizontal" onchange="enableDisableDetailCrim();">
                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                        <asp:ListItem Text="No" Value="0" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-2">
                    Criminal Action Details
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtCriminalCasesDetails" runat="server" Width="270px" Enabled="false" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCriminalCasesDetails" runat="server" Display="Dynamic" ControlToValidate="txtCriminalCasesDetails" ErrorMessage="Enter Criminal Action Details" ValidationGroup="Entry" Enabled="false">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Enter Criminal Action Details"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revCriminalCasesDetails" runat="server" Display="Dynamic" ErrorMessage="Invalid Criminal Action Details Format" ControlToValidate="txtCriminalCasesDetails" ValidationGroup="Entry"
                        ValidationExpression="^[a-zA-Z0-9-//., \s]+$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    CBI Enquiry <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rblCBIEnquiry" runat="server" Width="120px" RepeatDirection="Horizontal" onchange="enableDisableDetailCBI();">
                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                        <asp:ListItem Text="No" Value="0" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-2">
                    CBI Enquiry Details
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtCBIEnquiry" runat="server" Width="270px" Enabled="false" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCBIEnquiry" runat="server" ControlToValidate="txtCBIEnquiry" Display="Dynamic" ErrorMessage="Enter CBI Enquiry Details" ValidationGroup="Entry" Enabled="false">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="CBI Enquiry Details"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revCBIEnquiry" runat="server" ControlToValidate="txtCBIEnquiry" ErrorMessage="Invalid CBI Enquiry Details Format" Display="Dynamic" ValidationGroup="Entry"
                        ValidationExpression="^[a-zA-Z0-9-//., \s]+$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-2">
                    Vigilance Enquiry <span class="redText">*</span>
                </div>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="rblVigilance" runat="server" Width="120px" RepeatDirection="Horizontal" onchange="enableDisableDetailVig();">
                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                        <asp:ListItem Text="No" Value="0" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-2">
                    Vigilance Enquiry Details
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtVigilance" runat="server" Width="270px" Enabled="false" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvVigilance" runat="server" Display="Dynamic" ControlToValidate="txtVigilance" ErrorMessage="Enter Vigilance Enquiry Details" ValidationGroup="Entry" Enabled="false">
                <span class="glyphicon glyphicon-exclamation-sign redText"  title="Enter Vigilance Enquiry Details"></span>
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revVigilance" runat="server" Display="Dynamic" ErrorMessage="Invalid Vigilance Enquiry Details Format" ControlToValidate="txtVigilance" ValidationGroup="Entry"
                        ValidationExpression="^[a-zA-Z0-9-//., \s]+$">
                <span class="glyphicon glyphicon-exclamation-sign redText" title="Invalid Format"></span>
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row form-control-static">
                <div class="col-md-12 Declaration">
                    <asp:CheckBox ID="chkBox" runat="server" OnCheckedChanged="chkBox_CheckedChanged" AutoPostBack="true" />
                    I hereby declare that the details given in the application form are true, complete and correct according to my knowledge and understanding. 
            I also accept that in the event of any information being found false, incomplete or incorrect at any point of time or if I do not fulfill the 
            qualifications of the eliibility criteria, my candidature may be cancelled without any notice.
            I have read all the rules, regulations and procedure of reappointment given in the advertisement and I'll stictly adhere to it.
                <br />
                    I will continue to observe the departmental website http://uphealth.up.nic.in and if I do not contribute to the prescribed post within one month of publication 
            of the reappointment orders on website, my application will be deemed cancelled.

                </div>
            </div>
            <div class="row form-control-static bott-padd50">
                <div class="col-md-4">
                </div>
                <div class="col-md-8">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Submit Final Form" Width="240px" ValidationGroup="Entr" OnClick="btnSubmit_Click" Enabled="false" />
                </div>
            </div>
            <div class="row form-control-static bott-padd50">
                <div class="col-md-12">
                    <strong>Note: List of documents which are to be carried along for physical verification :</strong>
                    <ul>
                        <li>Post-Graduate Degree/Diploma Degree (if relevant)</li>
                        <li>P.P.O. (Pension Paper)</li>
                        <li>Medical Certificate</li>
                        <li>Recommendation for extension by the concern authority (in case of extension of reappointment)</li>
                        <li><a href="Format1.pdf" target="_blank" title="Click here to download format">Performance report on the prescribed format (in case of extension of reappointment)</a></li>
                    </ul>
                </div>
            </div>
        </div>--%>
    </div>
    <div class="row form-control-static bott-padd50 col-md-10 col-md-push-1" id="divNews"
        runat="server">
        <div class="panel panel-info">
            <div class="panel panel-heading">
                News & Announcements
            </div>
            <div class="panel panel-body">
                <ul runat="server" id="news">
                </ul>
            </div>
        </div>
    </div>
    <asp:ValidationSummary ID="vs" runat="server" ShowMessageBox="true" ValidationGroup="Entry" ShowSummary="False" />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" ValidationGroup="Posting" ShowSummary="False" />

    <script src="js/jquery-1.9.1.min.js"></script>
    <script src="js/bootstrap-datepicker.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.datepicker').datepicker({
                format: 'dd/mm/yyyy'
            });
        });
    </script>

</asp:Content>

