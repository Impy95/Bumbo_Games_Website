using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BumboGames
{
    public partial class DisplayProductInformation : System.Web.UI.Page
    {
        private void GetData()
        {
            
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                DBHelper.DataBinding(this.grvGames, "getProducts");
            }
            catch (Exception ex)
            {
                this.lblMessage.Text = ex.Message;
            }
        }

        protected void grvGames_DataBound(object sender, EventArgs e)
        {
            
        }

        protected void grvGames_PageIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void grvGames_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvGames.PageIndex = e.NewPageIndex;
            //grvGames.DataBind();
            DBHelper.DataBinding(this.grvGames, "getProducts");
        }
    }
}