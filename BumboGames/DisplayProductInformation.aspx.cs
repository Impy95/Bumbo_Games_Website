using System;
using System.Collections.Generic;
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
            grvGames.DataSource = new string[] { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P" };
            grvGames.DataBind();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.GetData();
            }
        }

        protected void grvGames_DataBound(object sender, EventArgs e)
        {
            for (int i = grvGames.Rows.Count + 1; i <= grvGames.PageSize; i++)
            {
                GridViewRow row = new GridViewRow(
                    0,
                    0,
                    DataControlRowType.DataRow,
                    (i % 2 > 0) ? DataControlRowState.Normal : DataControlRowState.Alternate);

                foreach (DataControlField field in grvGames.Columns)
                {
                    TableCell cell = new TableCell();
                    cell.Text = String.Format("Row {0} added.", i);
                    row.Cells.Add(cell);
                }

                grvGames.Controls[0].Controls.AddAt(i, row);
            }
        }

        protected void grvGames_PageIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void grvGames_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GetData();
            grvGames.PageIndex = e.NewPageIndex;
            grvGames.DataBind();
        }
    }
}