<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucNavigation.ascx.cs" Inherits="BumboGames.ucNavigation" %>
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
            <li class="px-4">
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search" CssClass="form-control"></asp:TextBox>
            </li>
            <li>
                <asp:Button ID="btnSearch" runat="server" Text="Go" CssClass="btn btn-outline-dark my-2 my-sm-0" />
            </li>
        </ul>
    </div>
</nav>
