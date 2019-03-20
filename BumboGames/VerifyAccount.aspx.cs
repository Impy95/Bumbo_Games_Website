using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BumboGames
{
    public partial class VerifyAccount : System.Web.UI.Page
    {
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