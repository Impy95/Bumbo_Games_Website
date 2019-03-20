<%@ Page Title="" Language="C#" MasterPageFile="~/StorePage.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="BumboGames.Checkout" %>
<asp:Content ID="Content3" ContentPlaceHolderID="categorySideBar" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="phrContent" runat="server">
     <div id="notLoggedIn" runat="server" visible="false">
        You are not logged in. <a href="Login.aspx?returnurl=checkout.aspx">Login</a> or <a href="CreateAccount.aspx?returnurl=checkout.aspx">create a new account</a> to complete your order
    </div>
    <!-- Order Summary -->
    <!-- Get User Info -->
    <h5 style="text-align:center;" runat="server" id="ship">Ship To</h5>
    <asp:DetailsView ID="detUser" runat="server" Height="50px" Width="483px" AutoGenerateRows="False" CellPadding="4" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
        <EditRowStyle BackColor="#999999" />
        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
        <Fields>
            <asp:BoundField DataField="firstName" HeaderText="First Name:" />
            <asp:BoundField DataField="lastName" HeaderText="Last Name:" />
            <asp:BoundField DataField="street" HeaderText="Street:" />
            <asp:BoundField DataField="city" HeaderText="City:" />
            <asp:BoundField DataField="province" HeaderText="Province:" />
            <asp:BoundField DataField="postalCode" HeaderText="Postal Code:" />
            <asp:BoundField DataField="phone" HeaderText="Phone:" />
        </Fields>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    </asp:DetailsView>
    <asp:Label ID="lblUpdateAccountPrompt" runat="server">
        Not correct? You can update your account info </asp:Label>
    <asp:HyperLink Text="here" ID="hypCreateAccount" NavigateUrl="~/CreateAccount.aspx" runat="server" /><br />
    <asp:CheckBox id="chkSameAddress" AutoPostBack="true" Checked="true" Text="Billing address same as shipping address" runat="server" />

    <asp:Table id ="tblShipping" runat="server" Height="50px" Width="483px" AutoGenerateRows="False" CellPadding="4" ForeColor="#333333" GridLines="None">
        
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Label Text ="Street" runat="server" ></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtShipppingStreet" runat="server" class="form-control"></asp:TextBox>
                    </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Label Text ="City" runat="server" ></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtShippingCity" runat="server" class="form-control"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Label Text ="Province" runat="server" ></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtShippingProvince" runat="server" class="form-control"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Label Text ="PostalCode" runat="server" ></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtShippingPostalCode" runat="server" class="form-control"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
    </asp:Table>
    <br />
    <h4 class="candy-border center" runat="server" id="ccInfo">Credit Card Information</h4>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblCreditCardNumber" runat="server" Text="Credit Card Number"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtCreditCardNumber" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:RequiredFieldValidator ID="reqCreditCardNumber"
                runat="server"
                ErrorMessage="Credit Card Number is required"
                ControlToValidate="txtCreditCardNumber"
                CssClass="cursor"
                ForeColor="Red"
                ToolTip="Credit Card Number is required"
                ValidationGroup="validateCC"
                Display="Dynamic">
                        <i class="fas fa-exclamation-triangle" style="color:red;"></i>
            </asp:RequiredFieldValidator>
        </div>      
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblCreditCardType" runat="server" Text="Credit Card Type"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:DropDownList ID="ddlCreditCardType" runat="server" CssClass="form-control">
                <asp:ListItem Text="MasterCard" Value="MasterCard"></asp:ListItem>
                <asp:ListItem Text="Visa" Value="Visa"></asp:ListItem>
                <asp:ListItem Text="American Express" Value="American Express"></asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblExpiryDate" runat="server" Text="Expiry Date"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lblCVV" runat="server" Text="CVV"></asp:Label>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <br />
    <h5 class="candy-border" style="text-align:center;" runat="server" id="order">Order Details</h5>
    <!--Order Total-->
    <asp:GridView ID="grdCart" runat="server" 
        AutoGenerateColumns="False">
        <Columns>            
            <asp:BoundField HeaderText="Product Id" DataField="ProductId" />
            <asp:BoundField HeaderText="Product Name" DataField="ProductName" />
            <asp:BoundField HeaderText="Quantity" DataField="Qty" />
            <asp:BoundField DataFormatString="{0:c}" HeaderText="Price" DataField="Price" />
            <asp:BoundField HeaderText="Subtotal" DataField="LineTotal" DataFormatString="{0:c}" />            
        </Columns>
    </asp:GridView>
     <div style="text-align:center">
        <asp:Label ID="lblError" runat="server" EnableViewState="false" CssClass="red"></asp:Label>
        <asp:Label ID="lblTotal" runat="server" Text="Total:" EnableViewState="false"></asp:Label> <asp:Label ID="lblCartTotal" runat="server" Text="" Font-Bold="true" EnableViewState="false"></asp:Label>
        <asp:Label ID="lblMessage" runat="server" Text="" EnableViewState="false"></asp:Label>
     </div>
    <asp:Button ID="btnSubmitOrder" runat="server" Text="Confirm Order" OnClick="btnSubmitOrder_Click" CssClass="crs" /> 
    <asp:Button ID="btnUpdateMyCart" runat="server" Text="Make changes to my order" OnClick="btnUpdateMyCart_Click" CssClass="crs" /> 
    <asp:Button ID="btnContinueShopping" runat="server" Text="Continue Shopping" Width="151px" OnClick="btnContinueShopping_Click" CssClass="crs" />
</asp:Content>
