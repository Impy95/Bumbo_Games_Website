<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="BumboGames.Cart" %>
<asp:Content ID="Content3" ContentPlaceHolderID="categorySideBar" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="phrContent" runat="server">
 <h5 style="text-align:center" class="candy-border">Shopping Cart</h5>
    <asp:GridView ID="grdCart" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductId">
        <Columns>
            <asp:TemplateField HeaderText="Product Id">
                <ItemTemplate>
                    <asp:HyperLink ID="hypProduct" runat="server" NavigateUrl='<%# Eval("ProductId","Products.aspx?id={0}") %>' Text='<%# Eval("ProductId") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Product Name" DataField="ProductName" />
            <asp:TemplateField HeaderText="Quantity">
                <ItemTemplate>
                    <asp:HiddenField ID="hdnCurrentQty" runat="server" Value='<%# Eval("Qty") %>'/>
                    <asp:TextBox ID="txtQty" runat="server" Height="21px" Text='<%# Eval("Qty") %>' Width="44px"></asp:TextBox>
                    <%--<asp:CompareValidator ID="compQty" runat="server" ControlToValidate="txtQty" 
                        ErrorMessage="Invalid quantity" ForeColor="Red" 
                        ToolTip="Invalid Quantity" Type="Integer" ValidationGroup="Group1">*</asp:CompareValidator>--%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataFormatString="{0:c}" HeaderText="Price" DataField="Price" />
            <asp:BoundField HeaderText="Subtotal" DataField="LineTotal" DataFormatString="{0:c}" />
            <asp:TemplateField HeaderText="Remove">
                <ItemTemplate>
                    <asp:CheckBox ID="chkRemove" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <div style="text-align:center">
        <asp:Label ID="lblTotal" runat="server" Text="Total:" EnableViewState="false"></asp:Label> <asp:Label ID="lblCartTotal" runat="server" Text="" Font-Bold="true" EnableViewState="false"></asp:Label>
        <asp:Label ID="lblTax" runat="server" Text="+ Tax:" EnableViewState="false"></asp:Label> <asp:Label ID="lblCartTax" runat="server" Text="" Font-Bold="true" EnableViewState="false"></asp:Label>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Group1"/>
    <asp:Button ID="btnUpdateCart" 
        runat="server" Text="Update Cart" 
        OnClick="btnUpdateCart_Click" Width="99px" CssClass="crs"
        ValidationGroup="Group1"
        /> <asp:Button ID="btnContinueShopping" runat="server" Text="Continue Shopping" Width="151px" OnClick="btnContinueShopping_Click" CssClass="crs" /> <asp:Button ID="btnCheckout" runat="server" Text="Check Out" Width="94px" OnClick="btnCheckout_Click" CssClass="crs" />
</asp:Content>
