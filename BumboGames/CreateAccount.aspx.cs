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
    public partial class CreateAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Session["authenticated"] != null)
                {
                    lblHeader.Text = "Update Account";
                    bindAccountDetails();
                    intializeUpdateFields();
                }
                else
                {
                    lblHeader.Text = "Create Account";
                }
            }
        }

        protected void btnCreateAccount_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                string firstName = this.txtFirstName.Text.Trim();
                string lastName = this.txtLastName.Text.Trim();
                string username = this.txtUsername.Text.Trim();
                string emailAddress = this.txtEmail.Text.Trim();
                string password = this.txtPassword.Text.Trim();
                string street = this.txtStreet.Text.Trim();
                string city = this.txtCity.Text.Trim();
                string province = this.txtProvince.Text.Trim();
                string postalCode = this.txtPostalCode.Text.Trim();
                string phone = this.txtPhone1.Text.Trim() + this.txtPhone2.Text.Trim() + this.txtPhone3.Text.Trim();

                if (insertAccount(
                    firstName,
                    lastName,
                    username,
                    emailAddress,
                    password,
                    street,
                    city,
                    province,
                    postalCode,
                    phone) != 0)
                {
                    //TODO:: Impliment Login Sessions

                    Session["authenticated"] = true;
                    Session["authenticatedUser"] = emailAddress;

                    //if (Request.QueryString["returnurl"] != null)
                    //    Response.Redirect($"~/{Request.QueryString["returnurl"]}");
                    //else
                    //    Response.Redirect("~/MyAccount.aspx?created");
                }
                else
                {
                    //this.lblError.Text = "The account was not created";
                }
            }
        }

        private int insertAccount(
        string firstName,
        string lastName,
        string userName,
        string emailAddress,
        string password,
        string street,
        string city,
        string province,
        string postalCode,
        string phone
    )
        {
            int id = 0;

            List<SqlParameter> prms = new List<SqlParameter>()
            {
                new SqlParameter()
                {
                    ParameterName = "@FirstName",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 20,
                    Value = firstName
                },
                new SqlParameter()
                {
                    ParameterName = "@LastName",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 20,
                    Value = lastName
                },
                new SqlParameter()
                {
                    ParameterName = "@Email",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value = emailAddress
                },
                new SqlParameter()
                {
                    ParameterName = "@Pwd",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 15,
                    Value = password
                },
                new SqlParameter()
                {
                    ParameterName = "@Street",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value = street
                },
                new SqlParameter()
                {
                    ParameterName = "@City",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 20,
                    Value= city
                },
                new SqlParameter()
                {
                    ParameterName = "@Province",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 2,
                    Value= province
                },
                new SqlParameter()
                {
                    ParameterName = "@Pcode",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 6,
                    Value= postalCode
                },
                new SqlParameter()
                {
                    ParameterName = "@Phone",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 10,
                    Value= phone
                },
                new SqlParameter()
                {
                    ParameterName = "@Username",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value= userName
                },
                new SqlParameter()
                {
                    ParameterName = "@Identity",
                    SqlDbType = SqlDbType.Int,
                    Direction=ParameterDirection.Output
                }
            };

            id = DBHelper.Insert<int>("InsertCustomer", "@Identity", prms.ToArray());

            return id;

        }
        //loads values into textboxes of existing account
        private void bindAccountDetails()
        {
            try
            {
                List<SqlParameter> prms = new List<SqlParameter>()
            {
                new SqlParameter()
                {
                    ParameterName = "@UserName",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 20,
                    Value = Session["authenticatedUser"]
                }
            };

                DataTable customerItems = DBHelper.GetQuery("SelectCustomers", prms.ToArray());

                txtFirstName.Text = customerItems.Rows[0]["firstName"].ToString();
                txtEmail.Text = customerItems.Rows[0]["email"].ToString();
                txtLastName.Text = customerItems.Rows[0]["lastName"].ToString();
                txtStreet.Text = customerItems.Rows[0]["street"].ToString();
                txtCity.Text = customerItems.Rows[0]["city"].ToString();
                txtProvince.Text = customerItems.Rows[0]["province"].ToString();
                txtPostalCode.Text = customerItems.Rows[0]["postalCode"].ToString();
                string phone = customerItems.Rows[0]["phone"].ToString();
                txtPhone1.Text = phone.Substring(0, 3);
                txtPhone2.Text = phone.Substring(3, 3);
                txtPhone3.Text = phone.Substring(6);
            }
            catch (Exception e)
            {
                String ex = e.Message;
            }


        }
        //TODO::Create second form
        //converts form to update display
        private void intializeUpdateFields()
        {
            txtUsername.Enabled = false;
            txtPassword.Enabled = false;
            txtConfirmPassword.Enabled = false;
            //todo:: add "If admin"
            if (Session["admin"] != null)
            {
                txtFirstName.Enabled = false;
                txtMiddleName.Enabled = false;
            }
            btnCreateAccount.Visible = false;
            btnUpdateAccount.Visible = true;
        }

        protected void btnUpdateAccount_Click(object sender, EventArgs e)
        {
            //add an if admin
            updateAccount(null, txtLastName.Text, txtEmail.Text, txtStreet.Text, txtCity.Text, txtProvince.Text, txtPostalCode.Text, txtPhone1.Text + txtPhone2.Text + txtPhone3.Text);
        }

        private void updateAccount(
            string firstName,
            string lastName,
            string emailAddress,
            string street,
            string city,
            string province,
            string postalCode,
            string phone
        )
        {

            List<SqlParameter> prms = new List<SqlParameter>()
            {
                new SqlParameter()
                {
                    ParameterName = "@LastName",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 20,
                    Value = lastName
                },
                new SqlParameter()
                {
                    ParameterName = "@Email",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value = emailAddress
                },
                new SqlParameter()
                {
                    ParameterName = "@Street",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value = street
                },
                new SqlParameter()
                {
                    ParameterName = "@City",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 20,
                    Value = city
                },
                new SqlParameter()
                {
                    ParameterName = "@Province",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 2,
                    Value = province
                },
                new SqlParameter()
                {
                    ParameterName = "@Pcode",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 6,
                    Value = postalCode
                },
                new SqlParameter()
                {
                    ParameterName = "@Phone",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 10,
                    Value = phone
                },
                new SqlParameter()
                {
                    ParameterName = "@Username",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value = Session["authenticatedUser"]
                },
            };
            if (firstName != null)
                prms.Add(new SqlParameter()
                {
                    ParameterName = "@FirstName",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 20,
                    Value = firstName
                });

            DBHelper.NonQuery("UpdateCustomer", prms.ToArray());
        }
    }
   

    }