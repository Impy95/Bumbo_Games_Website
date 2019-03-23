<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucAdminNav.ascx.cs" Inherits="BumboGames.ucAdminNav" %>
<!--Author: Greg VanKampen & Vaughn Rowse-->
<!--File:ucAdminNav.ascx-->
<!--Date3/22-2019-->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mx-auto">
            <li class="nav-item active px-3">
                <a class="nav-link" href="ProductMaintenance.aspx">ProductMaintenance</a>
            </li>
            <li class="nav-item active px-3">
                <a class="nav-link" href="CategoryMaintenance.aspx">Category Maintenance</a>
            </li>
            <li class="nav-item active px-3">
                <a class="nav-link" href="ImageValidation.aspx">Image Approval</a>
            </li>
            <li class="nav-item active px-3">
                <a class="nav-link" href="AccountManagement.aspx">Account Management</a>
            </li>
            <li class="nav-item active px-3">
                <a class="nav-link" href="../LoggedOut.aspx">Logout</a>
            </li>
        </ul>
    </div>
</nav>