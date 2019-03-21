<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" CodeBehind="ImageValidation.aspx.cs" Inherits="BumboGames.admin.ImageValidation" %>
<asp:Content ID="Content3" ContentPlaceHolderID="categorySideBar" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="phrContent" runat="server">
     <div style="padding-bottom: 20px;">
        <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red"></asp:Label>
        <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Green"></asp:Label>
        <asp:GridView ID="grdProducts" runat="server" AutoGenerateColumns="False"
            DataKeyNames="id"
            OnRowCommand="grdProducts_RowCommand"
            OnRowDeleting="grdProducts_RowDeleting"
            OnRowUpdating="grdProducts_RowUpdating"
            OnRowEditing="grdProducts_RowEditing"
            OnRowCancelingEdit="grdProducts_RowCancelingEdit"
            AllowPaging="True"
            OnPageIndexChanging="grdProducts_PageIndexChanging"
            PageSize="5"
            ShowFooter="True"
            AllowSorting="true"
            Width="100%"
            CssClass="table table-responsive table-striped">
            <FooterStyle BackColor="#3399ff" />
            <Columns>
                <asp:TemplateField HeaderText="Id">
                    <ItemTemplate>
                        <asp:Label ID="lblProductId" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product Name">
                    <ItemTemplate>
                        <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                    </ItemTemplate>
                <asp:TemplateField HeaderText="Image">
                    <ItemTemplate>
                        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# "~/" + Eval("ImageName") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:Button ID="btnValidate" runat="server" onClick="validateImage" />&nbsp;<asp:Button ID="btnDelete" runat="server" CausesValidation="False"
                                CommandName="Delete" Text="Delete" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
         
        </asp:GridView>
         </div>
</asp:Content>
