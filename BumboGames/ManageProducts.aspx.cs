using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace BumboGames {
    public partial class ManageProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            DBHelper.DataBinding(this.grvGamesEdit, "getProducts");
        }

        protected void lbtnCreateProducts_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateProducts.aspx");
        }
    }
}