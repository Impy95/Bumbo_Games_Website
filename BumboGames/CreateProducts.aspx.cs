using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BumboGames
{
    public partial class CreateProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbtnCreate_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                //generate parameters
                string name = txtGameName.Text.Trim();
                string desc = txtGameDescription.Text.Trim();
                float dPrice = float.Parse(txtGameDisplayPrice.Text.Trim());
                float oPrice = float.Parse(txtGameOriginPrice.Text.Trim());
                string image = txtGameImage.Text.Trim();
                bool hidden = chkbGameHidden.Checked;

                SqlParameter[] prms = new SqlParameter[7];
                for(int i = 0; i < prms.Length; i++)
                {
                    prms[i] = new SqlParameter();
                }
                prms[0].Value = name;
                prms[0].ParameterName = "@Name";
                prms[0].Size = 50;
                prms[0].SqlDbType = System.Data.SqlDbType.NVarChar;

                prms[1].ParameterName = "@Description";
                prms[1].Value = desc;
                prms[1].Size = 255;
                prms[1].SqlDbType = System.Data.SqlDbType.NVarChar;

                prms[2].ParameterName = "@DisplayCost";
                prms[2].Value = dPrice;
                prms[2].SqlDbType = System.Data.SqlDbType.Money;

                prms[3].ParameterName = "@UnitCost";
                prms[3].Value = oPrice;
                prms[3].SqlDbType = System.Data.SqlDbType.Money;

                prms[4].ParameterName = "@Image";
                prms[4].Value = image;
                prms[4].Size = 255;
                prms[4].SqlDbType = System.Data.SqlDbType.NVarChar;

                prms[5].ParameterName = "@Hidden";
                prms[5].Value = hidden;
                prms[5].SqlDbType = System.Data.SqlDbType.Bit;

                prms[6].ParameterName = "@IdOutput";
                prms[6].SqlDbType = System.Data.SqlDbType.Int;
                prms[6].Direction = System.Data.ParameterDirection.Output;

                DBHelper.Insert("insertProduct",prms[6].ParameterName, prms);



                //display results
                lblvalidatProductSummary.Text = $"Game Name: {this.txtGameName.Text}<br />Game Description: {this.txtGameDescription.Text}" +
                    $"<br />Game Price: {this.txtGameDisplayPrice.Text}";
            }
            else
            {
                lblvalidatProductSummary.Text = "The card validation failed";
            }
        }
    }
}