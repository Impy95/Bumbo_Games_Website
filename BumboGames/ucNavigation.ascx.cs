using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/** Author: Greg VanKampen and Vaughn Rowse
 * Date:3-22-2019
 * File: ucNavigation.cs
 **/
namespace BumboGames
{
    public partial class ucNavigation : System.Web.UI.UserControl
    {
        /// <summary>
        /// sets up the navigation bar to dynamically change based on the users current status
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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

            if (Session["authenticated"] != null)
            {
                lnkCreate.Text = Session["authenticatedUser"].ToString();;
                lnkLogin.Text = "Log Out";
                lnkLogin.NavigateUrl = "~/LoggedOut.aspx";
            }
            else
            {
                lnkCreate.Text = "Sign Up";
                lnkLogin.Text = "Log In";
                lnkLogin.NavigateUrl = "~/Login.aspx";
            }
        }
    }
}