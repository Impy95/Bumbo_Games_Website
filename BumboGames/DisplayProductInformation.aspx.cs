using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BumboGames
{
    public partial class DisplayProductInformation : System.Web.UI.Page
    {
        private void GetData()
        {
            
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                DBHelper.DataBinding(this.grvGames, "getProducts");
            }
            catch (Exception ex)
            {
                this.lblMessage.Text = ex.Message;
            }
        }

        protected void grvGames_DataBound(object sender, EventArgs e)
        {
            
        }

        protected void grvGames_PageIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void grvGames_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvGames.PageIndex = e.NewPageIndex;
            //grvGames.DataBind();
            DBHelper.DataBinding(this.grvGames, "getProducts");
        }

        string[] removedSearchWords = { "the", "at", "a", "and", "or", "this", "is" };
        //TODO: Add Category Specific Search
        //TODO: Find missing Databinding
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string[] searchWords = txtSearch.Text.Split(new Char[] { ',', ' ' });
            List<SqlParameter> prms = new List<SqlParameter>();

            //Match all words checkbox
            prms.Add(new SqlParameter {
                ParameterName = "@MatchAllWords",
                SqlDbType = System.Data.SqlDbType.Bit,
                Value = chkMatchAllWords.Checked
            });

            for (int i = 0; i < searchWords.Length; i++)
            {
                prms.Add(new SqlParameter
                {
                    ParameterName = $"@Keyword{(i+1).ToString()}",
                    SqlDbType = System.Data.SqlDbType.NVarChar,
                    Size = 50,
                    Value = searchWords[i]
                });
            }
            DBHelper.DataBinding(this.grvGames, "SearchProducts", prms.ToArray());
        }
    }
}