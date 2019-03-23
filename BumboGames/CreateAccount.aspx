<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" CodeBehind="CreateAccount.aspx.cs" Inherits="BumboGames.CreateAccount" %>

<asp:Content ID="Content3" ContentPlaceHolderID="categorySideBar" runat="server">
    <!--Author: Greg VanKampen & Vaughn Rowse-->
<!--File:CreateAccount.aspx-->
<!--Date3/22-2019-->
</asp:Content>
<asp:Content ID="AccountForm" ContentPlaceHolderID="phrContent" runat="server">
    <br />
    <div class="text-xl-center">
        <h2>
            <asp:Label ID="lblHeader" runat="server"></asp:Label></h2>
    </div>
    <br />
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblFirstName" runat="server" Text="First Name"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:RequiredFieldValidator ID="reqFirstName"
                runat="server"
                ErrorMessage="First Name is required"
                ControlToValidate="txtFirstName"
                CssClass="cursor"
                ForeColor="Red"
                ToolTip="First Name is required"
                ValidationGroup="validateAccount"><i class="fas fa-exclamation-triangle" style="color:red;"></i></asp:RequiredFieldValidator>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblMiddleName" runat="server" Text="Middle Name"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtMiddleName" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:RequiredFieldValidator ID="reqMiddleName"
                runat="server"
                ErrorMessage="Middle Name is required"
                ControlToValidate="txtMiddleName"
                CssClass="cursor"
                ForeColor="Red"
                ToolTip="Middle Name is required"
                ValidationGroup="validateAccount"><i class="fas fa-exclamation-triangle" style="color:red;"></i></asp:RequiredFieldValidator>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblLastName" runat="server" Text="Last Name"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:RequiredFieldValidator ID="reqLastName"
                runat="server"
                ErrorMessage="Last Name is required"
                ControlToValidate="txtLastName"
                CssClass="cursor"
                ForeColor="Red"
                ToolTip="Last Name is required"
                ValidationGroup="validateAccount"><i class="fas fa-exclamation-triangle" style="color:red;"></i></asp:RequiredFieldValidator>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:RequiredFieldValidator ID="reqUserName"
                runat="server"
                ErrorMessage="User Name is required"
                ControlToValidate="txtUsername"
                CssClass="cursor"
                ForeColor="Red"
                ToolTip="User Name is required"
                ValidationGroup="validateAccount"><i class="fas fa-exclamation-triangle" style="color:red;"></i></asp:RequiredFieldValidator>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:RequiredFieldValidator ID="reqPassword"
                runat="server"
                ErrorMessage="Password is required"
                ControlToValidate="txtPassword"
                CssClass="cursor"
                ForeColor="Red"
                ToolTip="Password is required"
                ValidationGroup="validateAccount" Display="Dynamic">
                        <i class="fas fa-exclamation-triangle" style="color:red;"></i>
            </asp:RequiredFieldValidator>
            <asp:CompareValidator ID="compPassword"
                ForeColor="Red"
                runat="server"
                ErrorMessage="Password do not match"
                ToolTip="Passwords do not match"
                ValidationGroup="Card1"
                ControlToValidate="txtPassword"
                ControlToCompare="txtConfirmPassword" Display="Dynamic">
                            <i class="fas fa-exclamation-circle" style="color:red;"></i>
            </asp:CompareValidator>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm Password"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:RequiredFieldValidator ID="reqConfirmPassword"
                runat="server"
                ErrorMessage="Confirm Password is required"
                ControlToValidate="txtConfirmPassword"
                CssClass="cursor"
                ForeColor="Red"
                ToolTip="Confirm Password is required"
                ValidationGroup="validateAccount"
                Display="Dynamic">
                        <i class="fas fa-exclamation-triangle" style="color:red;"></i>
            </asp:RequiredFieldValidator>
            <asp:CompareValidator ID="compConfirmPassword"
                ForeColor="Red"
                runat="server"
                ErrorMessage="Passwords do not match"
                ToolTip="Passwords do not match"
                ValidationGroup="Card1"
                ControlToValidate="txtConfirmPassword"
                ControlToCompare="txtPassword"
                Display="Dynamic">
                            <i class="fas fa-exclamation-circle" style="color:red;"></i>
            </asp:CompareValidator>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblBirthday" runat="server" Text="Birthday"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtBirthday" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:RequiredFieldValidator ID="reqBirthday"
                runat="server"
                ErrorMessage="Birthday is required"
                ControlToValidate="txtBirthday"
                CssClass="cursor"
                ForeColor="Red"
                ToolTip="Birthday is required"
                ValidationGroup="validateAccount">
                <i class="fas fa-exclamation-triangle" style="color:red;"></i>
            </asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="regBirthday" runat="server"
                ErrorMessage="Birthday is not in valid format" ForeColor="Red"
                ToolTip="Birthday is not in valid format (DD-MM-YYYY)"
                ControlToValidate="txtBirthday"
                ValidationExpression="((0?[13578]|10|12)(-|\/)((0[0-9])|([12])([0-9]?)|(3[01]?))(-|\/)((\d{4})|(\d{2}))|(0?[2469]|11)(-|\/)((0[0-9])|([12])([0-9]?)|(3[0]?))(-|\/)((\d{4}|\d{2})))"
                ValidationGroup="validateAccount"
                Display="Dynamic">
                            <i class="fas fa-exclamation-circle" style="color:red;"></i>
            </asp:RegularExpressionValidator>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblStreet" runat="server" Text="Street Address"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtStreet" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:RequiredFieldValidator ID="reqStreet"
                runat="server"
                ErrorMessage="Street is required"
                ControlToValidate="txtStreet"
                CssClass="cursor"
                ForeColor="Red"
                ToolTip="Street is required"
                ValidationGroup="validateAccount"><i class="fas fa-exclamation-triangle" style="color:red;"></i></asp:RequiredFieldValidator>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblCity" runat="server" Text="City"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:RequiredFieldValidator ID="reqCity"
                runat="server"
                ErrorMessage="City is required"
                ControlToValidate="txtCity"
                CssClass="cursor"
                ForeColor="Red"
                ToolTip="City is required"
                ValidationGroup="validateAccount"><i class="fas fa-exclamation-triangle" style="color:red;"></i></asp:RequiredFieldValidator>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblProvince" runat="server" Text="Province"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtProvince" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:RequiredFieldValidator ID="reqProvince"
                runat="server"
                ErrorMessage="Province is required"
                ControlToValidate="txtProvince"
                CssClass="cursor"
                ForeColor="Red"
                ToolTip="Province is required"
                ValidationGroup="validateAccount">
                        <i class="fas fa-exclamation-triangle" style="color:red;"></i>
            </asp:RequiredFieldValidator>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblPostalCode" runat="server" Text="Postal/Zip Code"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtPostalCode" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:RequiredFieldValidator ID="reqPostalCode"
                runat="server"
                ErrorMessage="Postal Code is required"
                ControlToValidate="txtPostalCode"
                CssClass="cursor"
                ForeColor="Red"
                ToolTip="Postal Code is required"
                ValidationGroup="validateAccount"><i class="fas fa-exclamation-triangle" style="color:red;"></i></asp:RequiredFieldValidator>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblPhone" runat="server" Text="Phone Number"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtPhone1" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:RequiredFieldValidator ID="reqPhone"
                runat="server"
                ErrorMessage="Phone is required"
                ControlToValidate="txtPhone1"
                CssClass="cursor"
                ForeColor="Red"
                ToolTip="Phone is required"
                Display="Dynamic"
                ValidationGroup="validateAccount">
                <i class="fas fa-exclamation-triangle" style="color:red;"></i>
            </asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="regPhone" runat="server"
                ErrorMessage="Phone is not in valid format" ForeColor="Red"
                ToolTip="Phone is not in valid format"
                ControlToValidate="txtPhone1"
                ValidationExpression="^[0][1-9](\d{6}|\d{9})$|^[1-9](\d{6}|\d{9})$"
                ValidationGroup="validateAccount"
                Display="Dynamic">
                            <i class="fas fa-exclamation-circle" style="color:red;"></i>
            </asp:RegularExpressionValidator>
        </div>
        <%--        <div class="col-md-2">
            <asp:TextBox ID="txtPhone2" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtPhone3" runat="server" CssClass="form-control"></asp:TextBox>
        </div>--%>
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblEmail" runat="server" Text="Email Address:"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:RequiredFieldValidator ID="reqEmail"
                runat="server"
                ErrorMessage="Email is required"
                ControlToValidate="txtEmail"
                CssClass="cursor"
                ForeColor="Red"
                ToolTip="Email is required"
                Display="Dynamic"
                ValidationGroup="validateAccount">
                <i class="fas fa-exclamation-triangle" style="color:red;"></i>
            </asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="regEmail" runat="server"
                ErrorMessage="Email is not in valid format" ForeColor="Red"
                ToolTip="Email is not in valid format"
                ControlToValidate="txtEmail"
                ValidationExpression="^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
                ValidationGroup="validateAccount"
                Display="Dynamic">
                            <i class="fas fa-exclamation-circle" style="color:red;"></i>
            </asp:RegularExpressionValidator>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-2">
            <asp:Button runat="server" ID="btnCreateAccount" Text="Create" OnClick="btnCreateAccount_Click" CssClass="btn-dark form-control"
                ValidationGroup="validateAccount" />
            <asp:Button runat="server" ID="btnUpdateAccount" Text="Update" OnClick="btnUpdateAccount_Click" Visible="False" CssClass="btn-dark" />
        </div>
    </div>
    <br />
    <br />
</asp:Content>
