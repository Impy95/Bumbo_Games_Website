<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucNavigation.ascx.cs" Inherits="BumboGames.ucNavigation" %>
<%@ Register Src="~/ucProductSearch.ascx" TagPrefix="uc1" TagName="ucProductSearch" %>
<!--Author: Greg VanKampen & Vaughn Rowse-->
<!--File:ucNavigation.ascx-->
<!--Date3/22-2019-->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mx-auto">
            <li class="nav-item active px-4">
                <asp:HyperLink CssClass="nav-link" ID="lnkHome" NavigateUrl="~/Default.aspx" Text="Home" runat="server" />
            </li>
            <li class="nav-item active px-4">
                <asp:HyperLink CssClass="nav-link" ID="lnkCreate" NavigateUrl="~/CreateAccount.aspx" Text="Sign Up" runat="server"/>
            </li>
            <li class="nav-item active px-4">
                <asp:HyperLink CssClass="nav-link" ID="lnkLogin" NavigateUrl="~/Login.aspx" Text="Log In" runat="server"/>
            </li>
            <uc1:ucProductSearch runat="server" ID="ucProductSearch" />
            <li>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;</p>
            </li>
            <li>
                <asp:HyperLink ID="Cart" ImageUrl="~/resources/cart.png" NavigateUrl="~/Cart.aspx" runat="server">HyperLink</asp:HyperLink>
                <asp:Label ID="lblCartSize" runat="server" Text="" ForeColor="Red"></asp:Label>
            </li>
        </ul>
    </div>
</nav>
