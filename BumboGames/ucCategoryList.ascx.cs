using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/** Author: Greg VanKampen and Vaughn Rowse
 * Date:3-22-2019
 * File: ucCategoryList.cs
 **/
namespace BumboGames
{
    public partial class ucCategoryList : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DBHelper.DataBinding(this.dtvCategories, "SelectCategories");
        }
    }
}