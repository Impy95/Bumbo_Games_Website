using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BumboGames.App_Code
{
    public class AdminPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = Request.Url.AbsolutePath.ToString().Replace("/admin/", "");

            if (!Common.IsAdminAuthenticated(Session))
                Response.Redirect($"~/admin/Login.aspx?returnurl={url}");
        }
    }
}