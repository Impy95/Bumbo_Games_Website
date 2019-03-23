using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/** Author: Greg VanKampen and Vaughn Rowse
 * Date:3-22-2019
 * File: ImageValidation.cs
 **/
namespace BumboGames.admin
{
    public partial class ImageValidation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadImagesGridView();

        }
        /// <summary>
        /// Update grid view
        /// </summary>
        private void LoadImagesGridView()
        {
            DBHelper.DataBindingWithPaging(this.grdImages, "SelectImageMaintenance");

        }
        /// <summary>
        /// Change grid page index to current index
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdImages_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdImages.PageIndex = e.NewPageIndex;
        }
        /// <summary>
        /// delete a product associated with an image
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void deleteProduct(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            //Fetch the row the button exists in
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            try
            {
                Label id = (Label)row.FindControl("lblProductId");
                List<SqlParameter> prms = new List<SqlParameter>
            {
                new SqlParameter
                {
                    ParameterName = "@ProductId",
                    SqlDbType = System.Data.SqlDbType.Int,
                    Value = id.Text
                }
            };
                DBHelper.NonQuery("DeleteProduct", prms.ToArray());
            }
            catch(Exception ex)
            {
                lblError.Text = ex.Message;
            }
            LoadImagesGridView();

        }
        /// <summary>
        /// Approve an image for on site use
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void validateImage(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            //Fetch the row the button exists in
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Label id = (Label)row.FindControl("lblProductId");
            List<SqlParameter> prms = new List<SqlParameter>()
            {
               new SqlParameter
               {
                   ParameterName="@ProductId",
                   SqlDbType=System.Data.SqlDbType.Int,
                   Value = id.Text
               }
            };
            DBHelper.NonQuery("ValidateImage", prms.ToArray());
            LoadImagesGridView();
        }
    }
}