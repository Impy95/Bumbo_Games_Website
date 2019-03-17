<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" CodeBehind="CreateAccount.aspx.cs" Inherits="BumboGames.CreateAccount" %>

<asp:Content ID="Content3" ContentPlaceHolderID="categorySideBar" runat="server">
</asp:Content>
<asp:Content ID="AccountForm" ContentPlaceHolderID="phrContent" runat="server">
    <br />
    <div class="text-xl-center">
        <h2><asp:Label ID="lblHeader" runat="server"></asp:Label></h2>
    </div> 
    <br />
    <br />
    <div class="row">
        <div class="col-md-2">
            <asp:Label ID="lblFirstName" runat="server" Text="First Name"></asp:Label>
        </div>
        
        <div class="col-md-4">
            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-2">
            <asp:Label ID="lblMiddleName" runat="server" Text="Middle Name"></asp:Label>
        </div>
        
        <div class="col-md-4">
            <asp:TextBox ID="txtMiddleName" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-2">
            <asp:Label ID="lblLastName" runat="server" Text="Last Name"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-2">
            <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-2">
            <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-2">
            <asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm Password"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-2">
            <asp:Label ID="lblStreet" runat="server" Text="Street Address"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtStreet" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-2">
            <asp:Label ID="lblCity" runat="server" Text="City"></asp:Label>   
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-2">
            <asp:Label ID="lblProvince" runat="server" Text="Province"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtProvince" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-2">
            <asp:Label ID="lblPostalCode" runat="server" Text="Postal/Zip Code"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtPostalCode" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-2">
            <asp:Label ID="lblPhone" runat="server" Text="Phone Number"></asp:Label>
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txtPhone1" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txtPhone2" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtPhone3" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-2">
            <asp:Label ID="lblEmail" runat="server" Text="Email Address:"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-2">
            <asp:Button runat="server" ID="btnCreateAccount" Text="Create" OnClick="btnCreateAccount_Click" CssClass="btn-dark" />
            <asp:Button runat="server" ID="btnUpdateAccount" Text="Update" OnClick="btnUpdateAccount_Click" Visible="False" CssClass="btn-dark" />
        </div>
    </div> 
    <br /><br />
</asp:Content>
