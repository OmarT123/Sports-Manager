using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DB_M3
{
    public partial class RegCR : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void register(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string n = name.Text;
            string user = username.Text;
            string pass = password.Text;
            string clubName = club.Text;

            
            if (n == "" || user == "" || pass == "" || clubName == "")
            {
                lit_MyText.Text = "         All Fields Must Be Filled";
            }
            else
            {
                SqlCommand regcrproc = new SqlCommand("addRepresentative", conn);
                regcrproc.CommandType = CommandType.StoredProcedure;
                regcrproc.Parameters.Add(new SqlParameter("@name", n));
                regcrproc.Parameters.Add(new SqlParameter("@club_name", clubName));
                regcrproc.Parameters.Add(new SqlParameter("@user_name", user));
                regcrproc.Parameters.Add(new SqlParameter("@password", pass));

                SqlParameter success = regcrproc.Parameters.Add("@successful", SqlDbType.Int);
                success.Direction = ParameterDirection.Output;

                conn.Open();
                regcrproc.ExecuteNonQuery();
                if (success.Value.ToString() == "1")
                {
                    Response.Redirect("login.aspx");
                }
                else if (success.Value.ToString() == "2")
                {
                    lit_MyText.Text = "Invalid Club Name";
                }
                else
                {
                    lit_MyText.Text = "Username already exists";
                }
                conn.Close();
                
            }
        }

    }
}