using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BumboGames
{
    public partial class CreateCategories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbtnCreate_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                lblCard1Summary.Text = $"Genre Name: {this.txtGenreName.Text}<br />Genre Description: {this.txtGenreDesc.Text}";
            }
            else
            {
                lblCard1Summary.Text = "The card validation failed";
            }
        }
    }
}