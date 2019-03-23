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
/** Author: Greg VanKampen and Vaughn Rowse
 * Date:3-22-2019
 * File: CreateAccount.cs
 **/
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
        /// <summary>
        /// Validates and creates an account
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnCreateAccount_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                string firstName = this.txtFirstName.Text.Trim();
                string middleName = this.txtMiddleName.Text.Trim();
                string lastName = this.txtLastName.Text.Trim();
                string username = this.txtUsername.Text.Trim();
                string emailAddress = this.txtEmail.Text.Trim();
                string password = this.txtPassword.Text.Trim();
                string birthday = this.txtBirthday.Text.Trim();
                string street = this.txtStreet.Text.Trim();
                string city = this.txtCity.Text.Trim();
                string province = this.txtProvince.Text.Trim();
                string postalCode = this.txtPostalCode.Text.Trim();
                //string phone = this.txtPhone1.Text.Trim() + this.txtPhone2.Text.Trim() + this.txtPhone3.Text.Trim();
                string phone = this.txtPhone1.Text.Trim();
                Guid guid = Guid.NewGuid();

                if (insertAccount(
                    firstName,
                    middleName,
                    lastName,
                    username,
                    emailAddress,
                    password,
                    birthday,
                    street,
                    city,
                    province,
                    postalCode,
                    phone,
                    guid.ToString()) != 0)
                {

                    Session["authenticated"] = true;
                    Session["authenticatedUser"] = username;

                    if (Request.QueryString["returnurl"] != null)
                        Response.Redirect($"~/{Request.QueryString["returnurl"]}");
                    else
                        Response.Redirect("~/Default.aspx");
                }
                else
                {
                    //this.lblError.Text = "The account was not created";
                }
            }
        }
        /// <summary>
        /// inserts an account into the database
        /// </summary>
        /// <param name="firstName"></param>
        /// <param name="middleName"></param>
        /// <param name="lastName"></param>
        /// <param name="userName"></param>
        /// <param name="emailAddress"></param>
        /// <param name="password"></param>
        /// <param name="birthday"></param>
        /// <param name="street"></param>
        /// <param name="city"></param>
        /// <param name="province"></param>
        /// <param name="postalCode"></param>
        /// <param name="phone"></param>
        /// <param name="guid"></param>
        /// <returns></returns>
        private int insertAccount(
        string firstName,
        string middleName,
        string lastName,
        string userName,
        string emailAddress,
        string password,
        string birthday,
        string street,
        string city,
        string province,
        string postalCode,
        string phone,
        string guid
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
                    ParameterName = "@MiddleName",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 20,
                    Value=middleName
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
                    ParameterName = "@Birthday",
                    SqlDbType = SqlDbType.Date,
                    Size = 15,
                    Value = birthday
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
                    ParameterName = "@Country",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value= "Canada"
                },
                new SqlParameter()
                {
                    ParameterName = "@VerifyHash",
                    SqlDbType = SqlDbType.NVarChar,
                    Value = guid
                },
                new SqlParameter()
                {
                    ParameterName = "@Identity",
                    SqlDbType = SqlDbType.Int,
                    Direction=ParameterDirection.Output
                }
            };

            id = DBHelper.Insert<int>("InsertCustomer", "@Identity", prms.ToArray());
            SendVerifycationEmail(guid, userName);
            return id;

        }
        /// <summary>
        /// loads an account for updating
        /// </summary>
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
                txtPhone1.Text = phone;
                //txtPhone2.Text = phone.Substring(3, 3);
                //txtPhone3.Text = phone.Substring(6);
            }
            catch (Exception e)
            {
                String ex = e.Message;
            }


        }
        /// <summary>
        /// Loasd the fields for account updating
        /// </summary>
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
        /// <summary>
        /// update account with new inputted values
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnUpdateAccount_Click(object sender, EventArgs e)
        {
            //add an if admin
            updateAccount(null, txtLastName.Text, txtEmail.Text, txtStreet.Text, txtCity.Text, txtProvince.Text, txtPostalCode.Text, txtPhone1.Text);
        }
        /// <summary>
        /// inserts updated account into database
        /// </summary>
        /// <param name="firstName"></param>
        /// <param name="lastName"></param>
        /// <param name="emailAddress"></param>
        /// <param name="street"></param>
        /// <param name="city"></param>
        /// <param name="province"></param>
        /// <param name="postalCode"></param>
        /// <param name="phone"></param>
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
        /// <summary>
        /// sends an account verification email to new users
        /// </summary>
        /// <param name="guid"></param>
        /// <param name="userName"></param>
        private void SendVerifycationEmail(string guid, string userName)
        {
            MailMessage mail = new MailMessage();
            string html = "<html><head><style>body{font-family:Arial; color:#000;} </style></head><body>" + generateVerificationEmail(guid, userName) + "</body></html>";
            string email = DBHelper.GetQueryValue<string>("SelectCustomers", "email", new SqlParameter[]{ new SqlParameter() {
                    ParameterName = "@UserName",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 50,
                    Value = userName
                }});
            mail.IsBodyHtml = true;
            mail.From = new MailAddress("noreply@bumbogames.com");
            mail.To.Add(email);
            mail.Subject = "Bumbo Games Account Verification";
            mail.Body = html;


            string emailLogDir = Server.MapPath("~/SentEmailLog");
            DirectoryInfo dirInfo = new DirectoryInfo(emailLogDir);

            if (!dirInfo.Exists)
                Directory.CreateDirectory(emailLogDir);

            SmtpClient smtp = new SmtpClient();
            smtp.DeliveryMethod = SmtpDeliveryMethod.SpecifiedPickupDirectory;
            smtp.PickupDirectoryLocation = emailLogDir;
            smtp.Send(mail);
        }
        /// <summary>
        /// builds string contents of account email
        /// </summary>
        /// <param name="guid"></param>
        /// <param name="fullName"></param>
        /// <returns></returns>
        private string generateVerificationEmail(string guid, string fullName)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<p>Hello " + fullName + "<br />");
            sb.Append("Thank you for registering with Bumbo Games.<br />");
            sb.Append("Your account is not ready for use, however.<br />");
            sb.Append("Please click the following link to verify your email:");
            sb.Append("<a href=http://" + HttpContext.Current.Request.Url.Authority + "/VerifyAccount.aspx?verifyHash=" + guid + ">Click Here</a>");
            sb.Append("</p>");

            return sb.ToString();
        }
        
    }
}