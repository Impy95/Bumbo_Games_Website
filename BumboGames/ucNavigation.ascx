<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucNavigation.ascx.cs" Inherits="BumboGames.ucNavigation" %>
<%@ Register Src="~/ucProductSearch.ascx" TagPrefix="uc1" TagName="ucProductSearch" %>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mx-auto">
            <li class="nav-item active px-4">
                <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item active px-4">
                <a class="nav-link" href="#">Top Products</a>
            </li>
            <li class="nav-item active px-4">
                <a class="nav-link" href="#">Sign In</a>
            </li>
            <li class="nav-item active px-4">
                <a class="nav-link" href="#">Cart</a>
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
