using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/** Author: Greg VanKampen and Vaughn Rowse
 * Date:3-22-2019
 * File: VerifyAccount.cs
 **/
namespace BumboGames
{
    public partial class VerifyAccount : System.Web.UI.Page
    {
        /// <summary>
        /// Loads verify hash send by Query and checks the db if an account exists with the hash
        /// Validates that account
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string guid = Request["verifyHash"];
                List<SqlParameter> prms = new List<SqlParameter>
            {
                new SqlParameter
                {
                    ParameterName="@VerifyHash",
                    SqlDbType = System.Data.SqlDbType.NVarChar,
                    Value = guid
                }
            };
                DBHelper.NonQuery("VerifyAccount", prms.ToArray());
                lblResults.Text = "You are now verified";
            }
            catch(Exception ex)
            {
                lblResults.Text = ex.Message;
            }


        }
    }
}