﻿<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="BumboGames.admin.AdminDashboard" %>

<%@ Register Src="~/admin/ucAdminNav.ascx" TagPrefix="uc1" TagName="ucAdminNav" %>

<asp:Content ID="Content4" ContentPlaceHolderID="navigation" runat="server">
    <!--Author: Greg VanKampen & Vaughn Rowse-->
<!--File:AdminDashBoard.aspx-->
<!--Date3/22-2019-->
    <uc1:ucAdminNav runat="server" id="ucAdminNav" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="categorySideBar" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="phrContent" runat="server">
    Welcome to the admin  dashboard
</asp:Content>
