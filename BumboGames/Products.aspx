<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="BumboGames.Products" %>

<%@ Register Src="~/ucProducts.ascx" TagPrefix="uc1" TagName="ucProducts" %>


<asp:Content ID="Content3" ContentPlaceHolderID="phrContent" runat="server">
    <uc1:ucProducts runat="server" ID="ucProducts" />
</asp:Content>
