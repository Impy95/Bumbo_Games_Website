using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/** Author: Greg VanKampen and Vaughn Rowse
 * Date:3-22-2019
 * File: LoggedOut.cs
 **/
namespace BumboGames
{
    public partial class LoggedOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["authenticated"] = null;
            Session["authenticatedUser"] = null;
            Session["admin"] = null;

        }
    }
}