using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BumboGames
{
    public partial class ucNavigation : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["cartSize"]!= null)
            {
                lblCartSize.Text = Session["cartSize"].ToString();
            }
            else
            {
                lblCartSize.Text = "";
            }
        }
    }
}