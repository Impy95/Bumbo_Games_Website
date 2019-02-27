<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" CodeBehind="CreateAccount.aspx.cs" Inherits="BumboGames.CreateAccount" %>

<asp:Content ID="AccountForm" ContentPlaceHolderID="phrContent" runat="server">
    <h1>Create your account</h1>
    <asp:Label ID="lblFirstName" runat="server" Text="First Name:"></asp:Label>
    <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox><br />
    <asp:Label ID="lblMiddleName" runat="server" Text="Middle Name:"></asp:Label>
    <asp:TextBox ID="txtMiddleName" runat="server"></asp:TextBox><br />
    <asp:Label ID="lblLastName" runat="server" Text="Last Name:"></asp:Label>
    <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox><br />
    <asp:Label ID="lblUsername" runat="server" Text="Username:"></asp:Label>
    <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox><br />
    <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
    <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox><br />
    <asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm Password:"></asp:Label>
    <asp:TextBox ID="txtConfirmPassword" runat="server"></asp:TextBox><br />
    <asp:Label ID="lblBirthday" runat="server" Text="Date of Birth:"></asp:Label> 
    <asp:TextBox ID="txtBirthday" runat="server"></asp:TextBox><br /> <!--TODO: Change this to a Calendar-->
    <asp:Label ID="lblStreet" runat="server" Text="Street Address:"></asp:Label>
    <asp:TextBox ID="txtStreet" runat="server"></asp:TextBox><br />
    <asp:Label ID="lblCity" runat="server" Text="City:"></asp:Label>
    <asp:TextBox ID="txtCity" runat="server"></asp:TextBox><br />
    <asp:Label ID="lblProvince" runat="server" Text="Province:"></asp:Label>
    <asp:TextBox ID="txtProvince" runat="server"></asp:TextBox><br />
    <asp:Label ID="lblPostalCode" runat="server" Text="Postal/Zip Code:"></asp:Label>
    <asp:TextBox ID="txtPostalCode" runat="server"></asp:TextBox><br />
    <asp:Label ID="lblCountry" runat="server" Text="Country:"></asp:Label>
    <asp:TextBox ID="txtCountry" runat="server"></asp:TextBox><br />
    <asp:Label ID="lblPhone" runat="server" Text="Phone Number:"></asp:Label>
    (<asp:TextBox ID="txtPhone1" runat="server"></asp:TextBox>)
    <asp:TextBox ID="txtPhone2" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtPhone3" runat="server"></asp:TextBox><br />
    <asp:Label ID="lblEmail" runat="server" Text="Email Address:"></asp:Label>
    <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox><br />

    <asp:Button runat="server" ID="btnCreateAccount" Text="Create"/>
</asp:Content>
