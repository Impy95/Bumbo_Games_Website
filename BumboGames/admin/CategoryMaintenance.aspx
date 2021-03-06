﻿<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" CodeBehind="CategoryMaintenance.aspx.cs" Inherits="BumboGames.admin.CategoryMaintenance" %>

<%@ Register Src="~/admin/ucAdminNav.ascx" TagPrefix="uc1" TagName="ucAdminNav" %>
<asp:Content ID="Content2" ContentPlaceHolderID="navigation" runat="server">
    <uc1:ucAdminNav runat="server" id="ucAdminNav" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="categorySideBar" runat="server">
    <!--Author: Greg VanKampen & Vaughn Rowse-->
<!--File:CategoryMaintenance.aspx-->
<!--Date3/22-2019-->
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="phrContent" runat="server">
    <br />
     <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red"></asp:Label>
        <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Green"></asp:Label>
    <asp:GridView ID="grdCategories" runat="server" AutoGenerateColumns="False"
        DataKeyNames="id" OnRowCommand="grdCategories_RowCommand" OnRowDeleting="grdCategories_RowDeleting" OnRowUpdating="grdCategories_RowUpdating" 
        OnRowEditing="grdCategories_RowEditing"
         OnRowCancelingEdit="grdCategories_RowCancelingEdit"
            AllowPaging="True"
            OnPageIndexChanging="grdCategories_PageIndexChanging"
            PageSize="5"
            ShowFooter="True"
            AllowSorting="true">
        <FooterStyle BackColor="#3399ff" />
        <Columns>
                <asp:TemplateField HeaderText="Id">
                    <ItemTemplate>
                        <asp:Label ID="lblCategoryId" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Category Name">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtCategoryName" runat="server" Text='<%# Eval("name") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblCategoryName" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtCategoryNameNew" runat="server"></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Category Description">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtCategoryDesc" runat="server" Text='<%# Eval("description") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblCategoryDesc" runat="server" Text='<%# Eval("description") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtCategoryDescNew" runat="server"></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:Button ID="btnUpdate" runat="server" CausesValidation="True" CommandName="Update"
                            Text="Update" />&nbsp;<asp:Button ID="btnCancel" runat="server" CausesValidation="False"
                                CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Button ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                            Text="Edit" />&nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False"
                                CommandName="Delete" Text="Delete" />
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Button ID="btnNew" runat="server" CommandName="btnNew" Text="Insert New Category" />
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
    </asp:GridView>
    <br />
</asp:Content>
