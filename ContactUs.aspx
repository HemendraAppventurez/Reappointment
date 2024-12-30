<%@ Page Title="" Language="C#" MasterPageFile="~/HomeMaster.master" AutoEventWireup="true" CodeFile="ContactUs.aspx.cs" Inherits="ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container" style="padding-top: 10px;">
        <a href="Questionnaire.aspx" class="btn btn-success"><span class="glyphicon glyphicon-arrow-left">&nbsp;Back</span></a>
        <br />
        <br />
        <div class="row">
            <div class="col-md-7 col-sm-12">

                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3559.4586344206004!2d80.9298303150437!3d26.85716598315167!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x399bfda2b5a628c5%3A0x9ee4f9864548c213!2sSwasthya+Bhawan!5e0!3m2!1sen!2sin!4v1565764648124!5m2!1sen!2sin" style="width: 100%; height: 450px; border: 0" frameborder="0" allowfullscreen></iframe>
            </div>
            <div class="col-md-5 col-sm-12">
                <h1>Contact Us</h1>
                <br />
                <span class="glyphicon gly"></span>Directorate of Medical and Health Services,<br />
                Swasthya Bhawan, Kaiserbagh,<br />
                Lucknow, Uttar Pradesh<br />
                <br />
                <table>
                    <tr>
                        <td style="vertical-align: top">Contact no:</td>
                        <td>
                            <ul>
                                <li>0522 2230017</li>
                                <li><span class="redText">1800-313-8566 (Toll Free Number)</span></li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top"># Email id:</td>
                        <td>
                            <ul>
                                <li>dgmhtraining@gmail.com</li>
                                <li>uphealth.walkin@gmail.com</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top">Website URL:</td>
                        <td style="padding-left: 30px;">
                            <a href="http://www.dgmhup.gov.in/en/default" target="_blank">www.dgmhup.gov.in</a>
                        </td>
                    </tr>
                </table>

            </div>
        </div>
    </div>
</asp:Content>

