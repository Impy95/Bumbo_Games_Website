<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" EnableEventValidation="false"  AutoEventWireup="true" CodeBehind="AccountManagement.aspx.cs" Inherits="BumboGames.admin.AccountManagement" %>

<%@ Register Src="~/admin/ucAdminNav.ascx" TagPrefix="uc1" TagName="ucAdminNav" %>

<asp:Content ID="Content2" ContentPlaceHolderID="navigation" runat="server">
    <uc1:ucAdminNav runat="server" ID="ucAdminNav" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="categorySideBar" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="phrContent" runat="server">
    <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red"></asp:Label>
        <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Green"></asp:Label>
    <asp:GridView ID="grdAccounts" runat="server" AutoGenerateColumns="False"
        DataKeyNames="userName"
            AllowPaging="True"
            PageSize="5"
            ShowFooter="False"
            AllowSorting="true"  OnPageIndexChanging="grdAccounts_PageIndexChanging" >
        <Columns>
                <asp:TemplateField HeaderText="Id">
                    <ItemTemplate>
                        <asp:Label ID="lblCustomerId" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            <asp:TemplateField HeaderText="User Name">
                    <ItemTemplate>
                        <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("userName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            <asp:TemplateField HeaderText="Email">
                    <ItemTemplate>
                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("email") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="First Name">
                    <ItemTemplate>
                        <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("firstName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Last Name">
                    <ItemTemplate>
                        <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("lastName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            <asp:TemplateField HeaderText="Archive Account">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkArchive" runat="server" Enabled ="false" Checked='<%#Eval("archived") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            <asp:TemplateField ShowHeader="false">
                    <ItemTemplate>
                        <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_onClick"
                            Text="Archive" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
    </asp:GridView>
</asp:Content>
