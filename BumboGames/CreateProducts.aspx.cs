using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BumboGames
{
    public partial class CreateProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbtnCreate_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                lblCard1Summary.Text = $"Game Name: {this.txtGameName.Text}<br />Game Description: {this.txtGameDescription.Text}" +
                    $"<br />Game Price: {this.txtGamePrice.Text}";
            }
            else
            {
                lblCard1Summary.Text = "The card validation failed";
            }
        }
    }
}