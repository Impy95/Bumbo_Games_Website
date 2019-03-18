<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="AccountManagement.aspx.cs" Inherits="BumboGames.admin.AccountManagement" %>

<%@ Register Src="~/admin/ucAdminNav.ascx" TagPrefix="uc1" TagName="ucAdminNav" %>

<asp:Content ID="Content2" ContentPlaceHolderID="navigation" runat="server">
    <uc1:ucAdminNav runat="server" ID="ucAdminNav" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="categorySideBar" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="phrContent" runat="server">
    <br />
    <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red"></asp:Label>
    <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Green"></asp:Label>
    <asp:GridView ID="grdAccounts" runat="server" AutoGenerateColumns="False"
        DataKeyNames="userName"
            AllowPaging="True"
            PageSize="5"
            ShowFooter="False"
            AllowSorting="true"  OnPageIndexChanging="grdAccounts_PageIndexChanging" OnRowCancelingEdit="grdAccounts_RowCancelingEdit" 
        OnRowEditing="grdAccounts_RowEditing" OnRowUpdating="grdAccounts_RowUpdating" >
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
                <EditItemTemplate>
                    <asp:TextBox ID="txtEmail" runat="server" Text='<%# Eval("email") %>' />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="First Name">
                <ItemTemplate>
                    <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("firstName") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Eval("firstName") %>' />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Middle Name">
                <ItemTemplate>
                    <asp:Label ID="lblMiddleName" runat="server" Text='<%# Eval("middleName") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtMiddleName" runat="server" Text='<%# Eval("middleName") %>' />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Last Name">
                <ItemTemplate>
                    <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("lastName") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtLastName" runat="server" Text='<%# Eval("lastName") %>' />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Street">
                <ItemTemplate>
                    <asp:Label ID="lblStreet" runat="server" Text='<%# Eval("street") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtStreet" runat="server" Text='<%# Eval("street") %>' />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="City">
                <ItemTemplate>
                    <asp:Label ID="lblCity" runat="server" Text='<%# Eval("city") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCity" runat="server" Text='<%# Eval("city") %>' />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Province">
                <ItemTemplate>
                    <asp:Label ID="lblProvince" runat="server" Text='<%# Eval("province") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtProvince" runat="server" Text='<%# Eval("province") %>' />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Country">
                <ItemTemplate>
                    <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("country") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCountry" runat="server" Text='<%# Eval("country") %>' />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="PostalCode">
                <ItemTemplate>
                    <asp:Label ID="lblPostalCode" runat="server" Text='<%# Eval("postalCode") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtPostalCode" runat="server" Text='<%# Eval("postalCode") %>' />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Phone">
                <ItemTemplate>
                    <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("phone") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtPhone" runat="server" Text='<%# Eval("phone") %>' />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Archive Account">
                <ItemTemplate>
                    <asp:CheckBox ID="chkArchive" runat="server" Enabled="false" Checked='<%#Eval("archived") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="false">
                <ItemTemplate>
                    <asp:Button ID="btnArchive" runat="server" OnClick="btnArchive_onclick"
                        Text="Archive" />
                    <asp:Button ID="btnEdit" runat="server" CommandName="Edit"
                        Text="Edit" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Button ID="btnUpdate" runat="server" CommandName="Update"
                        Text="Update" />
                    &nbsp;<asp:Button ID="btnCancel" runat="server" CausesValidation="False"
                        CommandName="Cancel" Text="Cancel" />
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
</asp:Content>
