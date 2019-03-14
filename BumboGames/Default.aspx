<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BumboGames.Default" %>

<%@ Register Src="~/ucProducts.ascx" TagPrefix="uc1" TagName="ucProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="phrContent" runat="server">
    <uc1:ucProducts runat="server" ID="ucProducts" Featured="false" />
</asp:Content>
