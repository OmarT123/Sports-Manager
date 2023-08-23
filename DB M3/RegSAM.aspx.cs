using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DB_M3
{
    public partial class RegSAM : System.Web.UI.Page
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

            if (n == "" || user == "" || pass == "")
            {
                lit_MyText.Text = "All Fields Must Be Filled";
            }
            else
            {
                SqlCommand loginproc = new SqlCommand("addAssociationManager", conn);
                loginproc.CommandType = CommandType.StoredProcedure;
                loginproc.Parameters.Add(new SqlParameter("@name", n));
                loginproc.Parameters.Add(new SqlParameter("@username", user));
                loginproc.Parameters.Add(new SqlParameter("@password", pass));

                SqlParameter success = loginproc.Parameters.Add("@successful", SqlDbType.Int);
                success.Direction = ParameterDirection.Output;

                conn.Open();
                loginproc.ExecuteNonQuery();
                conn.Close();

                if (success.Value.ToString() == "1")
                {
                    //Response.Redirect("Login.aspx");
                    Response.Redirect("login.aspx");
                }
                else
                {
                    lit_MyText.Text="Username already exists";
                }
            }
        }
        

    }
}