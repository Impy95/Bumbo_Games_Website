﻿<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" CodeBehind="ProductMaintenance.aspx.cs" Inherits="BumboGames.ProductMaintenance" %>

<%@ Register Src="~/ucCategoryListMaintenance.ascx" TagPrefix="uc1" TagName="ucCategoryListMaintenance" %>
<%@ Register Src="~/admin/ucAdminNav.ascx" TagPrefix="uc1" TagName="ucAdminNav" %>
<asp:Content ID="Content4" ContentPlaceHolderID="navigation" runat="server">
    <!--Author: Greg VanKampen & Vaughn Rowse-->
<!--File:ProductMaintenance.aspx-->
<!--Date3/22-2019-->
    <uc1:ucAdminNav runat="server" ID="ucAdminNav" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="categorySideBar" runat="server">
    <br />
    <uc1:ucCategoryListMaintenance runat="server" ID="ucCategoryListMaintenance" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="phrContent" runat="server">
    <br />
    <asp:TextBox ID="txtMaintenanceSearch" runat="server"></asp:TextBox>
    <asp:Button runat="server" Text="Search" ID="btnSearch" OnClick="btnSearch_Click"></asp:Button>
    <br />
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
                    <EditItemTemplate>
                        <asp:TextBox ID="txtProductName" runat="server" Text='<%# Eval("name") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtProductNameNew" runat="server"></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Brief Description">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtBriefDesc" runat="server" Text='<%# Eval("briefDescription") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblBriefDesc" runat="server" Text='<%# Eval("briefDescription") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtBriefDescNew" runat="server"></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Full Description">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtFullDesc" runat="server" Text='<%# Eval("fullDescription") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblFullDesc" runat="server" Text='<%# Eval("fullDescription") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtFullDescNew" runat="server"></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Hidden">
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkStatus" runat="server" Checked='<%# Bind("hidden") %>' />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:CheckBox ID="chkStatusNew" runat="server" />
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkStatusDisplay" runat="server" Checked='<%# Bind("hidden") %>' Enabled="False" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Price">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPrice" runat="server" Text='<%# Eval("price", "{0:0.00}") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("price", "{0:c}") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtPriceNew" runat="server"></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Featured">
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkFeatured" runat="server" Checked='<%# Bind("featured") %>' />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:CheckBox ID="chkFeaturedNew" runat="server" />
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkFeaturedDisplay" runat="server" Checked='<%# Bind("featured") %>' Enabled="False" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Category">
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlCategories" runat="server"></asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("CategoryName") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:DropDownList ID="ddlCategoriesNew" runat="server"></asp:DropDownList>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Image">
                    <ItemTemplate>
                        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# "~/" + Eval("ImageName") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:FileUpload ID="uplUpdateImage" runat="server" />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:FileUpload ID="uplNewImage" runat="server" />
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
                        <asp:Button ID="btnNew" runat="server" CommandName="btnNew" Text="Insert New Product" />
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>

        </asp:GridView>
    </div>
    <br />
</asp:Content>

