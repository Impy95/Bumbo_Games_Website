<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BumboGames.Default" %>

<%@ Register Src="~/ucProducts.ascx" TagPrefix="uc1" TagName="ucProducts" %>

<asp:Content ID="Content2" ContentPlaceHolderID="phrContent" runat="server">
    <br />
    <uc1:ucProducts runat="server" ID="ucProducts" Featured="true" />
</asp:Content>
