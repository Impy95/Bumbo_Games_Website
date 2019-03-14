using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BumboGames
{
    public partial class StorePage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GetCartCount();
        }

        private void GetCartCount()
        {
            string cartId = Common.GetCartId(Request, Response);
            int count = Common.GetCartCount(cartId);
            //this.lblCartItemsCount.Text = count == 1 ? $"{count} item in cart" : count > 1 ? $"{count} items in cart" : "";
        }
    }
}