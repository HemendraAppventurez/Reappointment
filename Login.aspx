<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Online Application for Reappointment | Log in</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link href="css/sweetalert.css" rel="stylesheet" />
    <script src="js/sweetalert.min.js"></script>
    <script src="js/sha1.js"></script>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <link href="css/dashboard/AdminLTE.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    <script>
        function AdminLogin_Validator() {
            var salt = '<%=Session["adminsalt"].ToString() %>';
            if (document.getElementById('txtPassword').value != "") {
                document.getElementById('txtPassword').value = (hex_sha1(document.getElementById('txtPassword').value + document.getElementById('txtUsername').value)).toUpperCase();
                document.getElementById('txtPassword').value = (hex_sha1(document.getElementById('txtPassword').value + salt)).toUpperCase();
                return (true);
            }
            else {
                return (false);
            }
        }
    </script>
</head>
<body class="hold-transition login-page" style="height: 80%;">
    <div class="login-box">
        <div class="login-logo">
            <a href="#">Online Dashboard for <b>Reappointment</b></a>
        </div>
        <div class="login-box-body">
            <p class="login-box-msg" style="font-size: 15px;">Login to view Dashboard</p>

            <form id="form1" runat="server" method="post">
                <asp:HiddenField ID="HiddenField1" runat="server" />
                <div class="form-group has-feedback">
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username" name="Username" autocomplete="off"></asp:TextBox>
                    <span class="glyphicon glyphicon-user form-control-feedback" style="line-height: 46px;"></span>
                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="Enter Username" ForeColor="Red" ValidationGroup="Login">
                    </asp:RequiredFieldValidator>
                </div>
                <div class="form-group has-feedback">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPassword" ErrorMessage="Enter Password" ForeColor="Red" ValidationGroup="Login">
                    </asp:RequiredFieldValidator>
                    <span class="glyphicon glyphicon-lock form-control-feedback" style="line-height: 46px;"></span>
                </div>
                <div class="form-group has-feedback">
                    <div class="row">
                        <div class="col-xs-1"></div>
                        <div class="col-xs-5">
                            <asp:Image ID="Image2" runat="server" Height="33px" ImageUrl="~/Captcha.aspx" Width="150px" />
                        </div>
                        <div class="col-xs-6" style="text-align: center;">
                            <asp:ImageButton ID="reload" runat="server" ImageUrl="images/reload-icon.png" Height="35px" Width="35px" OnClick="reload_Click" />
                        </div>
                    </div>
                </div>
                <div class="row" style="padding-left: 9px; padding-right: 9px">
                    <div class="col-xs-8">
                        <asp:TextBox runat="server" ID="txtVerificationCode" CssClass="form-control" placeholder="Enter Verification Code" autocomplete="off"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtVerificationCode" ErrorMessage="Enter Verification Code" ForeColor="Red" ValidationGroup="Login">
                        </asp:RequiredFieldValidator>
                    </div>
                    <div class="col-xs-4">
                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary btn-block btn-flat" Text="Sign In" OnClick="btnSubmit_Click" OnClientClick="AdminLogin_Validator();" ValidationGroup="Login" Style="height: 45px;" />
                    </div>
                </div>
            </form>
        </div>
    </div>
    <script src="js/jquery-1.9.1.min.js"></script>
    <script src="bootstrap/js/jquery-3.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>

</body>
</html>
