<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucProductSearch.ascx.cs" Inherits="BumboGames.ucProductSearch" %>
<div id="col3">
<h5>Product Search</h5>
<asp:TextBox ID="txtSearch" runat="server" Height="50px" Width="180px"></asp:TextBox><br />
<asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" /> <asp:CheckBox ID="chkAllWords" runat="server" /> All Words
    </div>