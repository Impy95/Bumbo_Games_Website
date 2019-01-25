using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace BumboGames
{
    internal class DBHelper
    {
        public static string ConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        }
        public static T Insert<T>(string sqlStatement, string OutputParamName, SqlParameter[] prms, CommandType cmdType = CommandType.StoredProcedure)
        {
            object returnId = null;
            T id;
            using (SqlConnection conn = new SqlConnection(ConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = sqlStatement;
                    cmd.CommandType = cmdType;

                    if (prms != null)
                    {
                        cmd.Parameters.AddRange(prms);
                    }
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    returnId = cmd.Parameters[OutputParamName].Value;
                    conn.Close();
                }
            }
            if (returnId != null)
            {
                id = (T)returnId;
            }
            else
            {
                id = default(T);
            }
            return id;
        }
        public static int Insert(string sqlStatement, string OutputParamName, SqlParameter[] prms, CommandType cmdType = CommandType.StoredProcedure)
        {
            int returnId = 0;
            using (SqlConnection conn = new SqlConnection(ConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = sqlStatement;
                    cmd.CommandType = cmdType;

                    if (prms != null)
                    {
                        cmd.Parameters.AddRange(prms);
                    }
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    Int32.TryParse(cmd.Parameters[OutputParamName].Value.ToString(), out returnId);
                    conn.Close();
                }
            }
            return returnId;
        }
        public static void DataBinding(object bindableControl, string sqlStatement, CommandType cmdType = CommandType.StoredProcedure, SqlParameterCollection prms = null)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString()))
            {
                using (SqlCommand objCmd = new SqlCommand())
                {
                    objCmd.Connection = conn;
                    objCmd.CommandText = sqlStatement;
                    objCmd.CommandType = cmdType;
                    if (prms != null)
                    {
                        objCmd.Parameters.Add(prms);
                    }
                    conn.Open();

                    using (SqlDataReader dr = objCmd.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            BindControl(bindableControl, dr);
                        }
                    }
                    conn.Close();
                }
            }
        }

        private static void BindControl(object bindableControl, SqlDataReader dr)
        {
            if (bindableControl is BaseDataBoundControl)
            {
                ((BaseDataBoundControl)bindableControl).DataSource = dr;
                ((BaseDataBoundControl)bindableControl).DataBind();
            }

            if (bindableControl is BaseDataList)
            {
                ((BaseDataList)bindableControl).DataSource = dr;
                ((BaseDataList)bindableControl).DataBind();
            }
        }
    }
}
