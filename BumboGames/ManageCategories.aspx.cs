using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BumboGames
{
    public partial class ManageCategories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbtnCreateCategories_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateCategories.aspx");
        }
    }
}