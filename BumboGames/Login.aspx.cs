using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BumboGames
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        //TODO: Update Redirect
        protected void lgnUser_Authenticate(object sender, AuthenticateEventArgs e)
        {
            e.Authenticated = false;
            string loginUser = lgnUser.UserName;
            string loginPassword = lgnUser.Password;

            e.Authenticated = AuthenticateUser(loginUser, loginPassword);

            if (e.Authenticated)
            {
                if (Request.QueryString["returnurl"] != null)
                    Response.Redirect($"~/{Request.QueryString["returnurl"]}");
                else
                    Response.Redirect("~/Default.aspx");
            }
        }

        private bool AuthenticateUser(string userName, string password)
        {
            bool result = false;

            bool verified = DBHelper.GetQueryValue<bool>("SelectCustomers", "verified", new SqlParameter[]{ new SqlParameter() {
                    ParameterName = "@UserName",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value = userName
                }});
            bool archived = DBHelper.GetQueryValue<bool>("SelectCustomers", "archived", new SqlParameter[]{ new SqlParameter() {
                    ParameterName = "@UserName",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value = userName
                }});
            if (!verified || archived)
            {
                return false;
            }

            try
            {
                List<SqlParameter> prms = new List<SqlParameter>();

                prms.Add(new SqlParameter()
                {
                    ParameterName = "@Username",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value = userName
                });

                prms.Add(new SqlParameter()
                {
                    ParameterName = "@Password",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value = password
                });

                result = !string.IsNullOrEmpty(DBHelper.GetScalarValue<string>("Login", prms.ToArray()));

                if (result)
                {
                    Session["authenticated"] = true;
                    Session["authenticatedUser"] = userName;
                }
                else
                {
                    Session["authenticated"] = null;
                    Session["authenticatedUser"] = null;
                }
            }
            catch (SqlException ex)
            {
                lgnUser.FailureText = ex.Message;
            }

            return result;
        }
    }
}