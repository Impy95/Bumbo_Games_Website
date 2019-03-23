using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/** Author: Greg VanKampen and Vaughn Rowse
 * Date:3-22-2019
 * File: StorePage.cs
 **/
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
            
        }
    }
}