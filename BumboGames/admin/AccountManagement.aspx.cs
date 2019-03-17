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
            LoadAccountsGridView();
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

        protected void btnUpdate_onClick(Object sender, EventArgs e)
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
    }
}