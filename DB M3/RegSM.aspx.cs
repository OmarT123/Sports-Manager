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
    public partial class RegSM : System.Web.UI.Page
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
            string stad = stadium.Text;

            if (n == "" || user == "" || pass == "" || stad == "")
            {
                lit_MyText.Text = "All Fields Must Be Filled";
            }
            else
            {
                SqlCommand loginproc = new SqlCommand("addStadiumManager", conn);
                loginproc.CommandType = CommandType.StoredProcedure;
                loginproc.Parameters.Add(new SqlParameter("@name", n));
                loginproc.Parameters.Add(new SqlParameter("@st_name", stad));
                loginproc.Parameters.Add(new SqlParameter("@user_name", user));
                loginproc.Parameters.Add(new SqlParameter("@password", pass));

                SqlParameter success = loginproc.Parameters.Add("@successful", SqlDbType.Int);
                success.Direction = ParameterDirection.Output;

                conn.Open();
                loginproc.ExecuteNonQuery();
                conn.Close();

                if (success.Value.ToString() == "1")
                {
                    Response.Redirect("login.aspx");
                }
                else if (success.Value.ToString() == "2")
                {
                    lit_MyText.Text = "Invalid Stadium Name";
                }
                else
                {
                    lit_MyText.Text="Username already exists";
                }
            }
        }

    }
}