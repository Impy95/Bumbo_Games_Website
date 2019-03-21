using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BumboGames.admin
{
    public partial class ImageValidation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadImagesGridView();

        }
        private void LoadImagesGridView()
        {
            DBHelper.DataBindingWithPaging(this.grdImages, "SelectProductMaintenance");

        }

        protected void grdImages_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdImages.PageIndex = e.NewPageIndex;
        }

        protected void grdImages_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Image image = (Image)grdImages.Rows[e.RowIndex].FindControl("imgProduct");
            string file = image.ImageUrl;
            File.Delete(file);

        }
        protected void validateImage(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            //Fetch the row the button exists in
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Image image = (Image)row.FindControl("imgProduct");
            List<SqlParameter> prms = new List<SqlParameter>()
            {
               new SqlParameter
               {
                   ParameterName="@ImageName",
                   Size=50,
                   SqlDbType=System.Data.SqlDbType.NVarChar,
                   Value = image.ImageUrl
               }
            };
            DBHelper.NonQuery("ValidateImage", prms.ToArray());

        }
    }
}