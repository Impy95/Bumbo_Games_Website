<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucProductSearch.ascx.cs" Inherits="BumboGames.ucProductSearch" %>
<li class="px-4">
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search" CssClass="form-control"></asp:TextBox>
            </li>
            <li>
                <asp:Button ID="btnSearch" runat="server" Text="Go" CssClass="btn btn-outline-dark my-2 my-sm-0" OnClick="btnSearch_Click" />
         <asp:CheckBox ID="chkAllWords" runat="server" /> All Words
         </li>