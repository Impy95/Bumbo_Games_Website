using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BumboGames
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Common.IsUserAuthenticated(Session))
            {
                notLoggedIn.Visible = true;
                btnSubmitOrder.Visible = false;
                lblTotal.Visible = false;
                ship.Visible = false;
                order.Visible = false;
                lblUpdateAccountPrompt.Visible = false;
                hypCreateAccount.Visible = false;
                chkSameAddress.Visible = false;
                this.lblCreditCardNumber.Visible = false;
                this.txtCreditCardNumber.Visible = false;
                this.ccInfo.Visible = false;
                this.lblCreditCardType.Visible = false;
                this.ddlCreditCardType.Visible = false;
                this.lblExpiryDate.Visible = false;
                this.txtExpiryDate.Visible = false;
                this.lblCVV.Visible = false;
                this.txtCVV.Visible = false;
            }
            else
            {
                notLoggedIn.Visible = false;
                btnSubmitOrder.Visible = true;
                LoadUserDetails();
                Common.GetCart(this.grdCart, Request, Response);
                decimal total = Common.GetCartTotal(Request, Response) ;
                total += total * (decimal)0.15;
                this.lblCartTotal.Text = total.ToString("c2");
            }
            

            if (chkSameAddress.Checked)
            {
                detUser.Visible = true;
                tblShipping.Visible = false;
            }
            else
            {
                detUser.Visible = false;
                tblShipping.Visible = true;
                
            }

        }

        private void LoadUserDetails()
        {
            string user = Common.GetAuthenticatedUser(Session);
            SqlParameter userPrm = new SqlParameter()
            {
                ParameterName = "@UserName",
                SqlDbType = SqlDbType.NVarChar,
                Size = 50,
                Value = user
            };

            DBHelper.DataBinding(this.detUser, "SelectCustomers", new SqlParameter[] { userPrm });
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Default.aspx");
        }

        protected void btnUpdateMyCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Cart.aspx");
        }

        protected void btnSubmitOrder_Click(object sender, EventArgs e)
        {
            lblError.Text = "";

            try
            {
                int orderNumber = SubmitOrder();
                SendEmail(orderNumber);
                lblMessage.Text = $"Your Bumbo games order has now been processed.<br />Order No: { orderNumber.ToString() }<br />An email has been sent as confirmation.";

                //Remove the cart cookies from the user's system
                Response.Cookies["CartUId"].Expires = DateTime.Now.AddDays(-1);

                //Clear MasterPage Label
                Label lblCartItemsCount = (Label)this.Page.Master.FindControl("lblCartItemsCount");

                if (lblCartItemsCount != null)
                    lblCartItemsCount.Text = "";

                this.lblTotal.Text = "";

                this.grdCart.DataSource = null;
                this.grdCart.DataBind();

                this.btnSubmitOrder.Visible = false;
                this.btnUpdateMyCart.Visible = false;
                Session["cartSize"] = 0;
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }

        private int SubmitOrder()
        {
            List<SqlParameter> prms = new List<SqlParameter>();
            DateTime orderDate = DateTime.Now;
            string authUser = Common.GetAuthenticatedUser(Session);

            int customerId = DBHelper.GetQueryValue<int>("SelectCustomers", "id", new SqlParameter[]{ new SqlParameter() {
                    ParameterName = "@UserName",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value = authUser
                }});

            string cartUId = Common.GetCartId(Request, Response);
            prms.Add(new SqlParameter() { ParameterName = "@CustomerId", SqlDbType = SqlDbType.Int, Value = customerId });
            prms.Add(new SqlParameter() { ParameterName = "@OrderDate", SqlDbType = SqlDbType.Date, Value = orderDate });
            prms.Add(new SqlParameter() { ParameterName = "@CartUId", SqlDbType = SqlDbType.VarChar, Size = 50, Value = cartUId });
            prms.Add(new SqlParameter() { ParameterName = "@OrderNo", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Output });



            if (!chkSameAddress.Checked)
            {
                TextBox txtaddress = (TextBox)tblShipping.Rows[0].Cells[0].FindControl("txtShipppingStreet");
                TextBox txtCity = (TextBox)tblShipping.Rows[1].Cells[0].FindControl("txtShippingCity");
                TextBox txtProvince = (TextBox)tblShipping.Rows[2].Cells[0].FindControl("txtShippingProvince");

                TextBox txtPostalCode = (TextBox)tblShipping.Rows[3].Cells[0].FindControl("txtShippingPostalCode");
                prms.Add(new SqlParameter() { ParameterName = "@ShippingStreet", SqlDbType = SqlDbType.NVarChar, Size = 255, Value = txtaddress.Text });
                prms.Add(new SqlParameter() { ParameterName = "@ShippingCity", SqlDbType = SqlDbType.NVarChar, Size = 255, Value = txtCity.Text });
                prms.Add(new SqlParameter() { ParameterName = "@ShippingProvince", SqlDbType = SqlDbType.NVarChar, Size = 255, Value = txtProvince.Text });
                prms.Add(new SqlParameter() { ParameterName = "@ShippingPostalCode", SqlDbType = SqlDbType.NVarChar, Size = 255, Value = txtPostalCode.Text });
            }
            else
            {
                prms.Add(new SqlParameter() { ParameterName = "@ShippingStreet", SqlDbType = SqlDbType.NVarChar, Size = 255, Value = detUser.Rows[2].Cells[1].Text.ToString() });
                prms.Add(new SqlParameter() { ParameterName = "@ShippingCity", SqlDbType = SqlDbType.NVarChar, Size = 255, Value = detUser.Rows[3].Cells[1].Text.ToString() });
                prms.Add(new SqlParameter() { ParameterName = "@ShippingProvince", SqlDbType = SqlDbType.NVarChar, Size = 255, Value = detUser.Rows[4].Cells[1].Text.ToString() });
                prms.Add(new SqlParameter() { ParameterName = "@ShippingPostalCode", SqlDbType = SqlDbType.NVarChar, Size = 255, Value = detUser.Rows[5].Cells[1].Text.ToString() });
            }

            int orderNo = DBHelper.Insert<int>("InsertOrder", "@OrderNo", prms.ToArray());

            return orderNo;
        }

        private void SendEmail(int orderNumber)
        {
            try
            {
                string html = "<html><head><style>body{font-family:Arial; color:#000;} </style></head><body>";

                //create the mail message
                MailMessage mail = new MailMessage();

                string authUser = Common.GetAuthenticatedUser(Session);
                string email = DBHelper.GetQueryValue<string>("SelectCustomers", "email", new SqlParameter[]{ new SqlParameter() {
                    ParameterName = "@UserName",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value = authUser
                }});

                //set the addresses
                mail.From = new MailAddress("noreply@bumbogames.com");
                mail.To.Add(email);
                //mail.To.Add("Customer@dog.com");
                //set the content
                mail.Subject = $"Bumbo Games Order Confirmation No: {orderNumber.ToString()}";
                mail.Body = $"{html}Your order from the Bumbo Games store has now be confirmed. It will be released for delivery within 3 business days.<br /><br />Order No:{orderNumber.ToString()}<br /><br />Order Details<br />{BuildEmailOrderTable(orderNumber)}</body></html>";
                mail.IsBodyHtml = true;

                string emailLogDir = Server.MapPath("~/SentEmailLog");
                DirectoryInfo dirInfo = new DirectoryInfo(emailLogDir);

                if (!dirInfo.Exists)
                    Directory.CreateDirectory(emailLogDir);

                SmtpClient smtp = new SmtpClient();
                smtp.DeliveryMethod = SmtpDeliveryMethod.SpecifiedPickupDirectory;
                smtp.PickupDirectoryLocation = emailLogDir;
                smtp.Send(mail);
            }
            catch(Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }

        private string BuildEmailOrderTable(int orderNumber)
        {
            StringBuilder sb = new StringBuilder();
            DataTable orderDetails = DBHelper.GetQuery("SelectOrderDetails", new SqlParameter[] { new SqlParameter(){
                ParameterName="@OrderId",
                SqlDbType = SqlDbType.Int,
                Value = orderNumber
            }});

            sb.Append("<table>");
            sb.Append("<tr><td>ProductId</td><td>Qty</td><td>Price</td><td>Subtotal</td></tr>");
            double orderTotal = 0.0;

            foreach (DataRow r in orderDetails.Rows)
            {
                orderTotal += double.Parse(r["linetotal"].ToString());
                sb.Append("<tr>");
                sb.Append($"<td>{r["ProductId"].ToString()}</td>");
                sb.Append($"<td>{r["quantity"].ToString()}</td>");
                sb.Append($"<td>{double.Parse(r["price"].ToString()).ToString("c2")}</td>");
                sb.Append($"<td>{double.Parse(r["linetotal"].ToString()).ToString("c2")}</td>");
                sb.Append("</tr>");
            }

            sb.Append("</table>");
            sb.Append($"Order Total: {(orderTotal * 0.15).ToString("c2") }");
            return sb.ToString();
        }
    }
}