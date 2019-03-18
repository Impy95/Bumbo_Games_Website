using BumboGames.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace BumboGames.admin
{
    public partial class AccountManagement : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            if (!IsPostBack)
            {
                LoadAccountsGridView();
            }
        }
        private void LoadAccountsGridView()
        {
            DBHelper.DataBindingWithPaging(this.grdAccounts, "SelectCustomers");
        }

        protected void grdAccounts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdAccounts.PageIndex = e.NewPageIndex;
            LoadAccountsGridView();
        }

        protected void btnArchive_onclick(Object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            //Fetch the row the button exists in
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            try
            {
                CheckBox archiveAccount = (CheckBox)this.grdAccounts.Rows[row.RowIndex].FindControl("chkArchive");
                Label usernameAccount = (Label)this.grdAccounts.Rows[row.RowIndex].FindControl("lblUserName");
                string username = usernameAccount.Text;
                bool archive = !archiveAccount.Checked;
                List<SqlParameter> prms = new List<SqlParameter> {
                new SqlParameter
                {
                ParameterName = "@Archived",
                SqlDbType = SqlDbType.Bit,
                Value = archive
                },
                new SqlParameter
                {
                    ParameterName = "@UserName",
                    SqlDbType= SqlDbType.NVarChar,
                    Value=username
                }
            };
                DBHelper.NonQuery("UpdateCustomer", prms.ToArray());
                LoadAccountsGridView();
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }

        }

        protected void grdAccounts_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdAccounts.EditIndex = e.NewEditIndex;
            LoadAccountsGridView();
        }

        protected void grdAccounts_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                Label lblUsername = (Label)this.grdAccounts.Rows[e.RowIndex].FindControl("lblUserName");
                TextBox txtFirstName = (TextBox)this.grdAccounts.Rows[e.RowIndex].FindControl("txtFirstName");
                TextBox txtMiddleName = (TextBox)this.grdAccounts.Rows[e.RowIndex].FindControl("txtMiddleName");
                TextBox txtLastName = (TextBox)this.grdAccounts.Rows[e.RowIndex].FindControl("txtLastName");
                TextBox txtStreet = (TextBox)this.grdAccounts.Rows[e.RowIndex].FindControl("txtStreet");
                TextBox txtCity = (TextBox)this.grdAccounts.Rows[e.RowIndex].FindControl("txtCity");
                TextBox txtProvince = (TextBox)this.grdAccounts.Rows[e.RowIndex].FindControl("txtProvince");
                TextBox txtCountry = (TextBox)this.grdAccounts.Rows[e.RowIndex].FindControl("txtCountry");
                TextBox txtPostalCode = (TextBox)this.grdAccounts.Rows[e.RowIndex].FindControl("txtPostalCode");
                TextBox txtPhone = (TextBox)this.grdAccounts.Rows[e.RowIndex].FindControl("txtPhone");
                TextBox txtEmail = (TextBox)this.grdAccounts.Rows[e.RowIndex].FindControl("txtEmail");

                string username = lblUsername.Text;
                string firstName = txtFirstName.Text;
                string middleName = txtMiddleName.Text;
                string lastName = txtLastName.Text;
                string street = txtStreet.Text;
                string city = txtCity.Text;
                string province = txtProvince.Text;
                string country = txtCountry.Text;
                string postalCode = txtPostalCode.Text;
                string phone = txtPhone.Text;
                string email = txtEmail.Text;

                List<SqlParameter> prms = new List<SqlParameter>() { 
                new SqlParameter
                {
                    ParameterName = "@UserName",
                    SqlDbType= SqlDbType.NVarChar,
                    Value=username
                },
                new SqlParameter
                {
                    ParameterName = "@FirstName",
                    SqlDbType= SqlDbType.NVarChar,
                    Value=firstName
                },
                new SqlParameter
                {
                    ParameterName = "@MiddleName",
                    SqlDbType= SqlDbType.NVarChar,
                    Value=middleName
                },
                new SqlParameter
                {
                    ParameterName = "@LastName",
                    SqlDbType= SqlDbType.NVarChar,
                    Value=lastName
                },
                new SqlParameter
                {
                    ParameterName = "@Street",
                    SqlDbType= SqlDbType.NVarChar,
                    Value=street
                },
                new SqlParameter
                {
                    ParameterName = "@City",
                    SqlDbType= SqlDbType.NVarChar,
                    Value=city
                },
                new SqlParameter
                {
                    ParameterName = "@Province",
                    SqlDbType= SqlDbType.NVarChar,
                    Value=province
                },
                new SqlParameter
                {
                    ParameterName = "@Country",
                    SqlDbType= SqlDbType.NVarChar,
                    Value=country
                },
                new SqlParameter
                {
                    ParameterName = "@Email",
                    SqlDbType= SqlDbType.NVarChar,
                    Value=email
                },
                new SqlParameter
                {
                    ParameterName = "@Phone",
                    SqlDbType= SqlDbType.NVarChar,
                    Value=phone
                },
            };
                DBHelper.NonQuery("UpdateCustomer", prms.ToArray());
                grdAccounts.EditIndex = -1;
                LoadAccountsGridView();
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }


        protected void grdAccounts_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdAccounts.EditIndex = -1;
            LoadAccountsGridView();
        }
    }
}