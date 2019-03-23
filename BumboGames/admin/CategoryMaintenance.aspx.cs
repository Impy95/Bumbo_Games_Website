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
 * File: CategoryMaintenance.cs
 **/
namespace BumboGames.admin
{
    public partial class CategoryMaintenance : App_Code.AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            lblMessage.Text = "";

            if (!IsPostBack)
            {
                LoadCategoryGridView();

            }
        }
        /// <summary>
        /// Rebinds category grid
        /// </summary>
        private void LoadCategoryGridView()
        {
            DBHelper.DataBindingWithPaging(this.grdCategories, "SelectCategoryMaintenance");
        }
        /// <summary>
        /// Creates a new account with footer files
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdCategories_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "btnNew")
            {
                //New Category
                AddNewCategory();

                LoadCategoryGridView();
            }
        }

        /// <summary>
        /// Calls the insert category procedure
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void AddNewCategory()
        {


            TextBox txtCategoryName = (TextBox)this.grdCategories.FooterRow.FindControl("txtCategoryNameNew");
            TextBox txtCategoryDesc = (TextBox)this.grdCategories.FooterRow.FindControl("txtCategoryDescNew");

            try
            {
                string categoryName = txtCategoryName.Text.Trim();
                string categoryDescription = txtCategoryDesc.Text.Trim();

                List<SqlParameter> prms = new List<SqlParameter> {
                new SqlParameter
                {
                ParameterName = "@Name",
                SqlDbType = SqlDbType.NVarChar,
                Size = 255,
                Value = categoryName
                },
                new SqlParameter
                {
                ParameterName = "@Description",
                SqlDbType = SqlDbType.NVarChar,
                Size = 255,
                Value = categoryDescription
                }
        };
                prms.Add(new SqlParameter()
                {
                    ParameterName = "@IdOutput",
                    SqlDbType = SqlDbType.Int,
                    Direction = ParameterDirection.Output
                });

                int id = DBHelper.Insert<int>("InsertCategory", "@IdOutput", prms.ToArray());

                lblMessage.Text = $"Category was created. Id: {id.ToString()}";
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }

        /// <summary>
        /// Deletes a category from the database
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdCategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int categoryId = Convert.ToInt32(this.grdCategories.DataKeys[e.RowIndex].Values[0]);
                SqlParameter prmCategoryId = new SqlParameter() { ParameterName = "@CategoryId", SqlDbType = SqlDbType.Int, Value = categoryId };

                DBHelper.NonQuery("DeleteCategory", new SqlParameter[] { prmCategoryId });
            }
            catch(Exception ex)
            {
                lblError.Text = ex.Message; 
            }

            LoadCategoryGridView();
        }
        /// <summary>
        /// Update Category with current inputted data
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdCategories_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            TextBox txtCategoryName = (TextBox)this.grdCategories.Rows[e.RowIndex].FindControl("txtCategoryName");
            TextBox txtCategoryDesc = (TextBox)this.grdCategories.Rows[e.RowIndex].FindControl("txtCategoryDesc");
            try
            {
                string categoryName = txtCategoryName.Text.Trim();
                string categoryDescription = txtCategoryDesc.Text.Trim();

                List<SqlParameter> prms = new List<SqlParameter> {
                new SqlParameter
                {
                ParameterName = "@CategoryName",
                SqlDbType = SqlDbType.NVarChar,
                Size = 255,
                Value = categoryName
                },
                new SqlParameter
                {
                ParameterName = "@CategoryDesc",
                SqlDbType = SqlDbType.NVarChar,
                Size = 255,
                Value = categoryDescription
                }
        };
                prms.Add(new SqlParameter()
                {
                    ParameterName = "@CategoryId",
                    SqlDbType = SqlDbType.Int,
                    Value = Convert.ToInt32(this.grdCategories.DataKeys[e.RowIndex].Values[0])
            });
                DBHelper.NonQuery("UpdateCategory", prms.ToArray());
            }
            catch (Exception ex)
            {

                this.lblError.Text = ex.Message;
            }
            grdCategories.EditIndex = -1;
            LoadCategoryGridView();
        }
        /// <summary>
        /// disable grid edit mode
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdCategories_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdCategories.EditIndex = -1;
            LoadCategoryGridView();
        }

        
        /// <summary>
        /// enable grid edit mode
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdCategories_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdCategories.EditIndex = e.NewEditIndex;
            LoadCategoryGridView();
        }
        /// <summary>
        /// change current page
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdCategories_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdCategories.PageIndex = e.NewPageIndex;
            LoadCategoryGridView();
        }
    }
}