<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateProducts.aspx.cs" Inherits="BumboGames.CreateProducts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Product Information</title>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <link href="styles/styles.css" rel="stylesheet" />

    <!--Font Awesome-->
    <link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mx-auto">
                        <li class="nav-item active px-4">
                            <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item dropdown active px-4">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Genres
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="#">Action</a>
                                <a class="dropdown-item" href="#">Adventure</a>
                                <!--<div class="dropdown-divider"></div>-->
                                <a class="dropdown-item" href="#">Platforming</a>
                                <a class="dropdown-item" href="#">RPG</a>
                                <a class="dropdown-item" href="#">Sports</a>
                                <a class="dropdown-item" href="#">Survival</a>
                                <a class="dropdown-item" href="#">Text Adventure</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">All Genres</a>
                            </div>
                        </li>
                        <!--
                        <li class="nav-item">
                            <a class="nav-link" href="#">Genres</a>
                        </li>
                        -->
                        <li class="nav-item active px-4">
                            <a class="nav-link" href="#">Top Products</a>
                        </li>
                        <li class="nav-item active px-4">
                            <a class="nav-link" href="#">Sign In</a>
                        </li>
                        <li class="nav-item active px-4">
                            <a class="nav-link" href="#">Cart</a>
                        </li>
                        <li class="px-4">
                            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search" CssClass="form-control"></asp:TextBox>
                        </li>
                        <li>
                            <asp:Button ID="btnSearch" runat="server" Text="Go" CssClass="btn btn-outline-dark my-2 my-sm-0" />
                        </li>
                    </ul>
                </div>
            </nav>
            <br />
            <div>
                <div class="row">
                    <div class="col-md-2 genremargin">
                        Top Genres
                        <br />
                        Genre
                        <br />
                        Genre
                        <br />
                        Genre
                        <br />
                        Genre
                        <br />
                        Genre
                        <br />
                        Genre
                        <br />
                        Genre
                        <br />
                        Genre
                    </div>
                    <div class="col-md-8">
                        <h3 class="center">New Product</h3>
                        <div class="container">
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Game Name:</label>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="txtGameName" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <asp:RequiredFieldValidator ID="reqGameName"
                                        runat="server"
                                        ErrorMessage="Game name is required"
                                        ControlToValidate="txtGameName"
                                        CssClass="cursor"
                                        ForeColor="Red"
                                        ToolTip="Game name is required"
                                        ValidationGroup="Card1">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Game Description:</label>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="txtGameDescription" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <asp:RequiredFieldValidator ID="reqGameDesc"
                                        runat="server"
                                        ErrorMessage="Game description is required"
                                        ControlToValidate="txtGameDescription"
                                        CssClass="cursor"
                                        ForeColor="Red"
                                        ToolTip="Game Description is required"
                                        ValidationGroup="Card1">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Game Price:</label>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="txtGamePrice" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <asp:RequiredFieldValidator ID="reqGamePrice"
                                        runat="server"
                                        ErrorMessage="Game price is required"
                                        ControlToValidate="txtGamePrice"
                                        CssClass="cursor"
                                        ForeColor="Red"
                                        ToolTip="Game price is required"
                                        ValidationGroup="Card1">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <asp:LinkButton ID="lbtnCreate"
                                        runat="server"
                                        CssClass="btn btn-dark"
                                        ValidationGroup="Card1" OnClick="lbtnCreate_Click">Create</asp:LinkButton>
                                </div>
                                <div class="col-md-4">
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Card1" ForeColor="Red"/>
                                </div>
                                <div class="col-md-3">
                                    <asp:Label ID="lblCard1Summary" runat="server" Text=""></asp:Label>
                                </div>
                            </div>                   
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <div>
                <div class="row">
                    <div class="col-md-2 center">
                        <h5>About Us</h5>
                        <p>Placeholder Text</p>
                    </div>
                    <div class="col-md-4 center">
                        <h5>Locations</h5>
                        <p>Placeholder Text</p>
                    </div>
                    <div class="col-md-4 center">
                        <h5>Contact us</h5>
                        <p>Placeholder Text</p>
                    </div>
                    <div class="col-md-2 center">
                        <h5>Help</h5>
                        <p>Placeholder Text</p>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-12 center">
                        <p>Copyright stuff</p>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
