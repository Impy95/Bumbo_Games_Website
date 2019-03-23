<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" EnableEventValidation ="false" CodeBehind="ImageValidation.aspx.cs" Inherits="BumboGames.admin.ImageValidation" %>

<%@ Register Src="~/admin/ucAdminNav.ascx" TagPrefix="uc1" TagName="ucAdminNav" %>


<asp:Content ID="Content1" ContentPlaceHolderID="navigation" runat="server">
    <!--Author: Greg VanKampen & Vaughn Rowse-->
<!--File:ImageValidation.aspx-->
<!--Date3/22-2019-->
    <uc1:ucAdminNav runat="server" ID="ucAdminNav" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="categorySideBar" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="phrContent" runat="server">
     <div style="padding-bottom: 20px;">
        <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red"></asp:Label>
        <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Green"></asp:Label>
        <asp:GridView ID="grdImages" runat="server" AutoGenerateColumns="False"
            DataKeyNames="id"
            AllowPaging="True"
            OnPageIndexChanging="grdImages_PageIndexChanging"
            PageSize="5"
            ShowFooter="True"
            AllowSorting="true"
            Width="100%"
            CssClass="table table-responsive table-striped">
            <FooterStyle BackColor="#3399ff" />
            <Columns>
                <asp:TemplateField HeaderText="Product Id">
                    <ItemTemplate>
                        <asp:Label ID="lblProductId" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product Name">
                    <ItemTemplate>
                        <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Image">
                    <ItemTemplate>
                        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# "~/" + Eval("ImageName") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:Button ID="btnValidate" runat="server" onClick="validateImage" Text="Validate Image" />&nbsp;<asp:Button ID="btnDelete" runat="server" CausesValidation="False"
                                onClick="deleteProduct" Text="Delete Associated Product" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
         
        </asp:GridView>
         </div>
</asp:Content>
