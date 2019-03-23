using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/** Author: Greg VanKampen and Vaughn Rowse
 * Date:3-22-2019
 * File: ProductMaintenance.cs
 **/
namespace BumboGames
{
    public partial class ProductMaintenance : App_Code.AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            lblMessage.Text = "";

            if (!IsPostBack)
            {
                string categoryId = Request.QueryString["categoryId"];
                string searchKeyword = Request.QueryString["word1"];
                if (!string.IsNullOrEmpty(categoryId))
                {
                    int category = 0;

                    if (Int32.TryParse(categoryId, out category))
                    {
                        List<SqlParameter> prms = new List<SqlParameter>();
                        prms.Add(CategoryParamHelper(category));
                        this.lblMessage.Text = $"Products in Category: {DBHelper.GetQueryValue<string>("SelectCategories", "name", prms.ToArray())}";

                        LoadProductsGridViewByCategory(category);
                    }
                    else
                    {
                        this.lblMessage.Text = "No such category";
                    }
                }
                else if (Request.QueryString["word1"] != null)
                {
                    LoadProductsGridViewByKeyword(searchKeyword);
                }
                else
                {
                    LoadProductsGridView();
                }

            }
        }
        /// <summary>
        /// Updates grid view with new search results
        /// </summary>
        /// <param name="searchKeyword"></param>
        private void LoadProductsGridViewByKeyword(string searchKeyword)
        {
            List<SqlParameter> prms = new List<SqlParameter>()
            {
                new SqlParameter()
                {
                ParameterName = "@Keyword",
                SqlDbType = SqlDbType.NVarChar,
                Value = searchKeyword
                }
            };
            DBHelper.DataBindingWithPaging(this.grdProducts, "SelectProductMaintenance", prms.ToArray());
            //test if the table exists
            if (grdProducts.Rows.Count != 0)
            {
                //Load the dropdown list in the create row
                DropDownList ddlCategoriesInFooter = (DropDownList)(this.grdProducts.FooterRow.FindControl("ddlCategoriesNew"));
                BindCategoryDropdownList(ddlCategoriesInFooter);
            }
            else
            {
                lblError.Text = "No products found for this category";
            }

        }
        /// <summary>
        /// Genrtaes a category id parameter
        /// </summary>
        /// <param name="categoryId"></param>
        /// <returns></returns>
        private SqlParameter CategoryParamHelper(int categoryId)
        {
            return new SqlParameter()
            {
                ParameterName = "@CategoryId",
                SqlDbType = SqlDbType.Int,
                Value = categoryId
            };
        }

        /// <summary>
        /// Reloads grid view based on category selected
        /// </summary>
        /// <param name="category"></param>
        private void LoadProductsGridViewByCategory(int category)
        {
            List<SqlParameter> prms = new List<SqlParameter>();
            prms.Add(CategoryParamHelper(category));
            DBHelper.DataBindingWithPaging(this.grdProducts, "SelectProductMaintenance",prms.ToArray());
            //Load the dropdown list in the create row
            if (grdProducts.Rows.Count != 0)
            {
                DropDownList ddlCategoriesInFooter = (DropDownList)(this.grdProducts.FooterRow.FindControl("ddlCategoriesNew"));
                BindCategoryDropdownList(ddlCategoriesInFooter);
            }
            else
            {
                lblError.Text = "No products found for this category";
            }
        }

        /// <summary>
        /// Reloads grid view
        /// </summary>
        private void LoadProductsGridView()
        {
            DBHelper.DataBindingWithPaging(this.grdProducts, "SelectProductMaintenance");
            //Load the dropdown list in the create row
            DropDownList ddlCategoriesInFooter = (DropDownList)(this.grdProducts.FooterRow.FindControl("ddlCategoriesNew"));
            BindCategoryDropdownList(ddlCategoriesInFooter);

        }
        /// <summary>
        /// Creates a new product
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "btnNew")
            {
                //New product
                AddNewProduct();

                LoadProductsGridView();
            }
        }


        /// <summary>
        /// Deletes a product beloging to a row
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int productId = Convert.ToInt32(this.grdProducts.DataKeys[e.RowIndex].Values[0]);
            SqlParameter prmProductId = new SqlParameter() { ParameterName = "@ProductId", SqlDbType = SqlDbType.Int, Value = productId };

            DBHelper.NonQuery("DeleteProduct", new SqlParameter[] { prmProductId });

            LoadProductsGridView();
        }
        /// <summary>
        /// Updates a produuct with new inputed values
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdProducts_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            List<SqlParameter> prms = new List<SqlParameter>();

            TextBox txtProductName = (TextBox)this.grdProducts.Rows[e.RowIndex].FindControl("txtProductName");
            TextBox txtBriefDesc = (TextBox)this.grdProducts.Rows[e.RowIndex].FindControl("txtBriefDesc");
            TextBox txtFullDesc = (TextBox)this.grdProducts.Rows[e.RowIndex].FindControl("txtFullDesc");
            TextBox txtPrice = (TextBox)this.grdProducts.Rows[e.RowIndex].FindControl("txtPrice");
            CheckBox chkFeatured = (CheckBox)this.grdProducts.Rows[e.RowIndex].FindControl("chkFeatured");
            CheckBox chkStatus = (CheckBox)this.grdProducts.Rows[e.RowIndex].FindControl("chkStatus");
            FileUpload uplImage = (FileUpload)this.grdProducts.Rows[e.RowIndex].FindControl("uplUpdateImage");
            DropDownList ddlCategories = (DropDownList)this.grdProducts.Rows[e.RowIndex].FindControl("ddlCategories");

            try
            {
                string productName = txtProductName.Text.Trim();
                string productBriefDesc = txtBriefDesc.Text.Trim();
                string productFullDesc = txtFullDesc.Text.Trim();
                decimal price = Convert.ToDecimal(txtPrice.Text.Trim());
                bool featured = chkFeatured.Checked;
                bool status = chkStatus.Checked;
                string fileName = $"{ Server.MapPath("~/images/")}{ uplImage.FileName}";
                string imageName = $"images/{ uplImage.FileName }";
                string altText = uplImage.FileName;
                int categoryId = ddlCategories.SelectedIndex > 0 ? Convert.ToInt32(ddlCategories.SelectedValue) : 0;
                int productId = Convert.ToInt32(this.grdProducts.DataKeys[e.RowIndex].Values[0]);

                uplImage.SaveAs(fileName);

                prms.Add(DBHelper.SetProductIdParam(productId));
                prms.Add(DBHelper.SetProductNameParam(productName));
                prms.Add(DBHelper.SetProductBriefDescParam(productBriefDesc));
                prms.Add(DBHelper.SetProductFullDescParam(productFullDesc));
                prms.Add(DBHelper.SetProductPriceParam(price));
                prms.Add(DBHelper.SetProductFeaturedParam(featured));
                prms.Add(DBHelper.SetProductHiddenParam(status));

                if (fileName != "") //Don't make changes to the current image
                {
                    prms.Add(DBHelper.SetProductImageName(imageName));
                    prms.Add(DBHelper.SetProductImageAlt(altText));
                    prms.Add(DBHelper.SetProductImageName(DateTime.Now));
                }

                prms.Add(DBHelper.SetCategoryIdParam(categoryId));

                DBHelper.NonQuery("UpdateProduct", prms.ToArray());

                lblMessage.Text = "Product was updated";
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
            grdProducts.EditIndex = -1;
            LoadProductsGridView();
        }
        /// <summary>
        /// Puts a product row in edit mode
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdProducts_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdProducts.EditIndex = e.NewEditIndex;
            LoadProductsGridView();
            Control ddlToFind = this.grdProducts.Rows[e.NewEditIndex].FindControl("ddlCategories");
            DropDownList ddlCategory = ddlToFind != null ? (DropDownList)(ddlToFind) : null;

            if (ddlCategory != null)
            {
                int productId = Convert.ToInt32(this.grdProducts.DataKeys[e.NewEditIndex].Values[0]);
                SqlParameter prmProductId = new SqlParameter() { ParameterName = "@ProductId", SqlDbType = SqlDbType.Int, Value = productId };
                int categoryId = DBHelper.GetQueryValue<int>("SELECT categoryId FROM Products WHERE id=@ProductId", "categoryId", new SqlParameter[] { prmProductId }, CommandType.Text);

                BindCategoryDropdownList(ddlCategory);

                ddlCategory.SelectedValue = categoryId.ToString();
            }
        }
        /// <summary>
        /// binds a category drop down list to all categories
        /// </summary>
        /// <param name="ddlCategory"></param>
        private void BindCategoryDropdownList(DropDownList ddlCategory)
        {
            ddlCategory.DataValueField = "id";
            ddlCategory.DataTextField = "name";
            DBHelper.DataBinding(ddlCategory, "SelectCategories");
            ddlCategory.Items.Insert(0, new ListItem("--Select Category--"));
        }
        /// <summary>
        /// Cancel a row in edit mode
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdProducts_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdProducts.EditIndex = -1;
            LoadProductsGridView();
        }
        /// <summary>
        /// update grids current index
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdProducts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdProducts.PageIndex = e.NewPageIndex;
            LoadProductsGridView();
        }
        /// <summary>
        /// collects data and inputs them into the database as a new product
        /// </summary>
        private void AddNewProduct()
        {
            List<SqlParameter> prms = new List<SqlParameter>();

            TextBox txtProductName = (TextBox)this.grdProducts.FooterRow.FindControl("txtProductNameNew");
            TextBox txtBriefDesc = (TextBox)this.grdProducts.FooterRow.FindControl("txtBriefDescNew");
            TextBox txtFullDesc = (TextBox)this.grdProducts.FooterRow.FindControl("txtFullDescNew");
            TextBox txtPrice = (TextBox)this.grdProducts.FooterRow.FindControl("txtPriceNew");
            CheckBox chkFeatured = (CheckBox)this.grdProducts.FooterRow.FindControl("chkFeaturedNew");
            CheckBox chkStatus = (CheckBox)this.grdProducts.FooterRow.FindControl("chkStatusNew");
            FileUpload uplImage = (FileUpload)this.grdProducts.FooterRow.FindControl("uplNewImage");
            DropDownList ddlCategories = (DropDownList)this.grdProducts.FooterRow.FindControl("ddlCategoriesNew");

            try
            {
                string productName = txtProductName.Text.Trim();
                string productBriefDesc = txtBriefDesc.Text.Trim();
                string productFullDesc = txtFullDesc.Text.Trim();
                decimal price = Convert.ToDecimal(txtPrice.Text.Trim());
                bool featured = chkFeatured.Checked;
                bool status = chkStatus.Checked;
                string fileName = $"{ Server.MapPath("~/images/")}{ uplImage.FileName}";
                string imageName = $"images/{ uplImage.FileName }";
                string altText = uplImage.FileName;
                int categoryId = ddlCategories.SelectedIndex > 0 ? Convert.ToInt32(ddlCategories.SelectedValue) : 0;

                uplImage.SaveAs(fileName);

                prms.Add(DBHelper.SetProductNameParam(productName));
                prms.Add(DBHelper.SetProductBriefDescParam(productBriefDesc));
                prms.Add(DBHelper.SetProductFullDescParam(productFullDesc));
                prms.Add(DBHelper.SetProductPriceParam(price));
                prms.Add(DBHelper.SetProductFeaturedParam(featured));
                prms.Add(DBHelper.SetProductHiddenParam(status));
                prms.Add(DBHelper.SetProductImageName(imageName));
                prms.Add(DBHelper.SetProductImageAlt(altText));
                prms.Add(DBHelper.SetProductImageName(DateTime.Now));
                prms.Add(DBHelper.SetCategoryIdParam(categoryId));

                prms.Add(new SqlParameter()
                {
                    ParameterName = "@Id",
                    SqlDbType = SqlDbType.Int,
                    Direction = ParameterDirection.Output
                });

                int id = DBHelper.Insert<int>("InsertProduct", "@Id", prms.ToArray());

                lblMessage.Text = $"Product was created. Id: {id.ToString()}";
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }
        /// <summary>
        /// Searches the grid for products based on keyword
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Response.Redirect($"~/admin/ProductMaintenance.aspx?word1=" + txtMaintenanceSearch.Text);
        }
    }
}