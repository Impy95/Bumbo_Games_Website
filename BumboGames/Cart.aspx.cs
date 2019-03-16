﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BumboGames
{
    public partial class Cart : System.Web.UI.Page
    { 
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetCart();
                GetCartTotal();
            }
        }
        private void GetCart()
        {
            Common.GetCart(this.grdCart, Request, Response);

            if (this.grdCart.Rows.Count == 0)
            {
                this.btnCheckout.Visible = false;
                this.btnContinueShopping.Visible = false;
                this.btnUpdateCart.Visible = false;
                this.lblTotal.Text = "No items in cart";
                this.lblCartTotal.Visible = false;
                
            }

        }
        private void GetCartTotal()
        {
            this.lblCartTotal.Text = Common.GetCartTotal(Request, Response).ToString("c2");
        }
        protected void btnUpdateCart_Click(object sender, EventArgs e)
        {
            string CartUId = Common.GetCartId(Request, Response);

            //One form of saving changes. One item at a time when there is a change
            foreach (GridViewRow row in this.grdCart.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    TextBox txt = (TextBox)row.FindControl("txtQty");
                    HiddenField hdn = (HiddenField)row.FindControl("hdnCurrentQty");
                    CheckBox chkRemove = (CheckBox)row.FindControl("chkRemove");
                    
                    int qty = chkRemove.Checked ? 0 : Convert.ToInt32(txt.Text.Trim());
                    int currentQty = Convert.ToInt32(hdn.Value);
                    int productId = Convert.ToInt32(this.grdCart.DataKeys[row.RowIndex].Value);

                    //Save us a round trip
                    if (currentQty != qty)
                    {
                        UpdateCartItem(CartUId, productId, qty);
                    }
                    //get the cart quantity for the icon
                    List<SqlParameter> prms = new List<SqlParameter>()
                    {
                        new SqlParameter
                        {
                            ParameterName="@CartUId",
                            SqlDbType = SqlDbType.VarChar,
                            Size = 50,
                            Value = CartUId

                        }
                    };
                    int cartQuantity = DBHelper.GetScalarValue<int>("GetCartSize",prms.ToArray());
                    Session["cartSize"] = cartQuantity;
                }
            }

            GetCart();
            GetCartTotal();

            //Update the MasterPage label
            string cartId = Common.GetCartId(Request, Response);
            int count = Common.GetCartCount(cartId);
            Label lblCartItemsCount = (Label)this.Page.Master.FindControl("lblCartItemsCount");

            if (lblCartItemsCount != null)
                lblCartItemsCount.Text = count == 1 ? $"{count} item in cart" : count > 1 ? $"{count} items in cart" : "";
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Default.aspx");
        }

        //todo: implement "UpdateCart" SProc
        private void UpdateCartItem(string CartUId, int productId, int qty)
        {
            List<SqlParameter> prms = new List<SqlParameter>();
            prms.Add(new SqlParameter()
            {
                ParameterName = "@CartUId",
                SqlDbType = SqlDbType.VarChar,
                Size = 50,
                Value = CartUId
            });
            prms.Add(new SqlParameter()
            {
                ParameterName = "@ProdId",
                SqlDbType = SqlDbType.Int,
                Value = productId
            });
            prms.Add(new SqlParameter()
            {
                ParameterName = "@Qty",
                SqlDbType = SqlDbType.Int,
                Value = qty
            });

            DBHelper.NonQuery("UpdateCart", prms.ToArray());
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Checkout.aspx");
        }
    }
}