<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="BumboGames.Products" %>

<%@ Register Src="~/ucProducts.ascx" TagPrefix="uc1" TagName="ucProducts" %>


<asp:Content ID="Content3" ContentPlaceHolderID="phrContent" runat="server">
    <!--Author: Greg VanKampen & Vaughn Rowse-->
<!--File:Products.aspx-->
<!--Date3/22-2019-->
    <uc1:ucProducts runat="server" ID="ucProducts" />
</asp:Content>
