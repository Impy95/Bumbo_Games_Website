<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BumboGames.Login" %>
<asp:Content ID="Content3" ContentPlaceHolderID="categorySideBar" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="phrContent" runat="server">
    <div>
        <!-- BackColor="#F7F6F3" BorderColor="#E6E2D8" BorderPadding="4" BorderStyle="Solid" BorderWidth="1px" -->
        <asp:Login ID="lgnUser" runat="server" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#333333" OnAuthenticate="lgnUser_Authenticate">
            <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
            <LoginButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" 
                BorderWidth="1px" Font-Names="Verdana" 
               Font-Size="1.5em" ForeColor="#284775"/>
            <TextBoxStyle Font-Size="1.5em" BorderColor="Black"/>
            <LabelStyle Font-Size="1.5em" />
            <TitleTextStyle Font-Size="1.5em" />
            <CheckBoxStyle Font-Size="1.5em" />
            <LayoutTemplate>
                <br />
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-8">
                        <h3 class="center">Log In</h3>
                    </div> 
                </div>
                <br />
                <div class="row">
                    <div class="col-md-5">
                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name</asp:Label>
                    </div>
                    <div class="col-md-5">
                        <asp:TextBox ID="UserName" runat="server" BorderColor="Black" Font-Size="1.5em" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." Font-Size="1.5em" ForeColor="Red" ToolTip="User Name is required." ValidationGroup="lgnUser">*</asp:RequiredFieldValidator>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-5">
                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password</asp:Label>
                    </div>
                    <div class="col-md-5">
                        <asp:TextBox ID="Password" runat="server" BorderColor="Black" Font-Size="1.5em" TextMode="Password" 
                            CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." Font-Size="1.5em" ForeColor="Red" ToolTip="Password is required." ValidationGroup="lgnUser">*</asp:RequiredFieldValidator>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-5"></div>
                    <div class="col-md-6">
                        <asp:CheckBox ID="RememberMe" runat="server" Text="Remember Me" />
                    </div>
                    <div class="col-md-5">
                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                    </div>
                </div>
                <br />
                <div class="row">
                    <!-- ForeColor="#284775" BorderStyle="Solid" BorderWidth="1px" BackColor="#FFFBFF" BorderColor="#CCCCCC" Font-Names="Verdana" Font-Size="1.5em" -->
                    <div class="col-md-5"></div>
                    <div class="col-md-5">
                        <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" ValidationGroup="lgnUser" CssClass="form-control btn-dark" />
                    </div>
                </div>
                <br />
                <%--<table cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
                    <tr>
                        <td>
                            <table cellpadding="0">
                                <tr>
                                    <td align="center" colspan="2" style="color:White;background-color:#5D7B9D;font-size:1.2em;font-weight:bold;">Log In</td>
                                </tr>
                                <tr>
                                    <td align="right" style="font-size:1.5em;">
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="UserName" runat="server" BorderColor="Black" Font-Size="1.5em"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." Font-Size="1.5em" ForeColor="Red" ToolTip="User Name is required." ValidationGroup="lgnUser">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="font-size:1.5em;">
                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Password" runat="server" BorderColor="Black" Font-Size="1.5em" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." Font-Size="1.5em" ForeColor="Red" ToolTip="Password is required." ValidationGroup="lgnUser">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="font-size:1.5em;">
                                        <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me next time." />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="color:Red;font-size:1.5em;">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2">
                                        <asp:Button ID="LoginButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" CommandName="Login" Font-Names="Verdana" Font-Size="1.5em" ForeColor="#284775" Text="Log In" ValidationGroup="lgnUser" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>--%>
            </LayoutTemplate>
            <FailureTextStyle Font-Size="1.5em" />
            <ValidatorTextStyle Font-Size="1.5em" />
            <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="1.2em" ForeColor="White" />
        </asp:Login>  
    </div>
</asp:Content>
