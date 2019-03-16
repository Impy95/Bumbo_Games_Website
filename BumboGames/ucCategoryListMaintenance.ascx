<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucCategoryListMaintenance.ascx.cs" Inherits="BumboGames.ucCategoryListMaintenance" %>
<h5>Game Genres</h5>
<asp:DataList ID="dtvCategories" runat="server">
    <ItemTemplate>
        <asp:HyperLink
            title='<%# Eval("name") %>'
            CssClass="categories-datalist"
            ID="hypCategories"
            runat="server"
            NavigateUrl='<%# Eval("id","~/admin/ProductMaintenance.aspx?categoryId={0}") %>'
            Text='<%# Eval("name") %>'></asp:HyperLink>
    </ItemTemplate>
</asp:DataList>