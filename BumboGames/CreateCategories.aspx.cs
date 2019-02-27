using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BumboGames
{
    public partial class CreateCategories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbtnCreate_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                string name = txtGenreName.Text.Trim();
                string desc = txtGenreDesc.Text.Trim();
                SqlParameter[] prms = new SqlParameter[3];
                for (int i = 0; i < prms.Length; i++)
                {
                    prms[i] = new SqlParameter();
                }
                prms[0].Value = name;
                prms[0].ParameterName = "@Name";
                prms[0].Size = 50;
                prms[0].SqlDbType = System.Data.SqlDbType.NVarChar;

                prms[1].Value = desc;
                prms[1].ParameterName = "@Description";
                prms[1].Size = 255;
                prms[1].SqlDbType = System.Data.SqlDbType.NVarChar;

                prms[2].ParameterName = "@IdOutput";
                prms[2].SqlDbType = System.Data.SqlDbType.Int;
                prms[2].Direction = System.Data.ParameterDirection.Output;


                int returnId = DBHelper.Insert<int>("insertCategory", prms[2].ParameterName, prms);

                lblGenreSummary.Text = $"Genre Name: {this.txtGenreName.Text}<br />Genre Description: {this.txtGenreDesc.Text}";
            }
            else
            {
                lblGenreSummary.Text = "The card validation failed";
            }
        }
    }
}