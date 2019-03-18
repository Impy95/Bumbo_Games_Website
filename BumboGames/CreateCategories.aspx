<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/StorePage.Master" CodeBehind="CreateCategories.aspx.cs" Inherits="BumboGames.CreateCategories" %>

<asp:Content ID="Content3" ContentPlaceHolderID="categorySideBar" runat="server">
</asp:Content>
<asp:Content ID="CategoryForm" ContentPlaceHolderID="phrContent" runat="server">
    <div class="col-md-8">
        <h3 class="center">New Genre</h3>
        <br />
        <div class="container">
            <div class="row">
                <div class="col-md-5">
                    <label>Genre Name</label>
                </div>
                <div class="col-md-5">
                    <asp:TextBox ID="txtGenreName" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <asp:RequiredFieldValidator ID="reqGenreName"
                        runat="server"
                        ErrorMessage="Genre name is required"
                        ControlToValidate="txtGenreName"
                        CssClass="cursor"
                        ForeColor="Red"
                        ToolTip="Genre name is required"
                        ValidationGroup="validateGenre">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row">
                <div class="col-md-5">
                    <label>Genre Description</label>
                </div>
                <div class="col-md-5">
                    <asp:TextBox ID="txtGenreDesc" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <asp:RequiredFieldValidator ID="reqGenreDesc"
                        runat="server"
                        ErrorMessage="Genre description is required"
                        ControlToValidate="txtGenreDesc"
                        CssClass="cursor"
                        ForeColor="Red"
                        ToolTip="Genre Description is required"
                        ValidationGroup="validateGenre">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="validateGenre" ForeColor="Red" />
                </div>
                </div>
            <div class="row">
                <div class="col-md-5"></div>
                <div class="col-md-5">
                    <asp:LinkButton ID="lbtnCreate"
                        runat="server"
                        CssClass="btn btn-dark"
                        ValidationGroup="validateGenre" OnClick="lbtnCreate_Click"
                        Width="97px">Create</asp:LinkButton>
                </div>
                <div class="col-md-3">
                    <asp:Label ID="lblGenreSummary" runat="server" Text=""></asp:Label>
                </div>
            </div>
        </div>
    </div>
    <br />
</asp:Content>
<%--<body>
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
                        <h3 class="center">New Genre</h3>
                        <div class="container">
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Genre Name:</label>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="txtGenreName" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <asp:RequiredFieldValidator ID="reqGenreName"
                                        runat="server"
                                        ErrorMessage="Genre name is required"
                                        ControlToValidate="txtGenreName"
                                        CssClass="cursor"
                                        ForeColor="Red"
                                        ToolTip="Genre name is required"
                                        ValidationGroup="validateGenre">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Genre Description:</label>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="txtGenreDesc" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <asp:RequiredFieldValidator ID="reqGenreDesc"
                                        runat="server"
                                        ErrorMessage="Genre description is required"
                                        ControlToValidate="txtGenreDesc"
                                        CssClass="cursor"
                                        ForeColor="Red"
                                        ToolTip="Genre Description is required"
                                        ValidationGroup="validateGenre">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="validateGenre" ForeColor="Red" />
                                </div>
                                <div class="col-md-3">
                                    <asp:LinkButton ID="lbtnCreate"
                                        runat="server"
                                        CssClass="btn btn-dark"
                                        ValidationGroup="validateGenre" OnClick="lbtnCreate_Click"
                                        Width="97px">Create</asp:LinkButton>
                                </div>
                                <div class="col-md-3">
                                    <asp:Label ID="lblGenreSummary" runat="server" Text=""></asp:Label>
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
</html>--%>



