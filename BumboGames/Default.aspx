<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BumboGames.Default" %>

<%@ Register Src="~/ucProducts.ascx" TagPrefix="uc1" TagName="ucProducts" %>

<asp:Content ID="Content2" ContentPlaceHolderID="phrContent" runat="server">
    <!--Author: Greg VanKampen & Vaughn Rowse-->
<!--File:Default.aspx-->
<!--Date3/22-2019-->
    <br />
    <uc1:ucProducts runat="server" ID="ucProducts" Featured="true" />
</asp:Content>
