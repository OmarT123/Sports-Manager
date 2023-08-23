using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace DB_M3
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string user = username.Text;
            string pass = password.Text;

            SqlCommand loginproc = new SqlCommand("userLogin", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@username", user));
            loginproc.Parameters.Add(new SqlParameter("@password", pass));

            SqlParameter success = loginproc.Parameters.Add("@success",SqlDbType.Int);
            SqlParameter type = loginproc.Parameters.Add("@type", SqlDbType.Int);
            SqlParameter error = loginproc.Parameters.Add("@error", SqlDbType.Int);

            error.Direction = ParameterDirection.Output;
            success.Direction = ParameterDirection.Output;
            type.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();
            if (user == "" || pass == "")
            {
                lit_MyText.Text = "All Fields must be filled";
            }
            else
            {
                if (success.Value.ToString() == "1")
                {
                    Session["user"] = user;
                    //Response.Write("Successful");
                    switch (type.Value)
                    {
                        case 1: loadAdmin(null, null); break;
                        case 2: loadSAM(null, null); break;
                        case 3: loadCR(null, null); break;
                        case 4: loadSM(null, null); break;
                        case 5: loadFan(null, null); break;
                    }
                }
                else
                {
                    //display an error message
                    //lit_MyText.Text = "a bunch of text goes here.";
                    switch (error.Value)
                    {
                        case 1: lit_MyText.Text = "Wrong Username or Password"; break;
                        case 2: lit_MyText.Text = "Account Blocked"; break;
                    }

                }
            }
        }


        protected void loadFan(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string user = Session["user"].ToString();

            SqlCommand getNameproc = new SqlCommand("getNatId", conn);
            getNameproc.CommandType = CommandType.StoredProcedure;
            getNameproc.Parameters.Add(new SqlParameter("@username", user));

            SqlParameter nat = getNameproc.Parameters.Add("@nat", SqlDbType.VarChar, 20);

            nat.Direction = ParameterDirection.Output;

            conn.Open();
            getNameproc.ExecuteNonQuery();
            conn.Close();

            Session["nat"] = nat.Value.ToString();
            //Response.Write(Session["nat"]);
            Response.Redirect("Fan.aspx");
        }
        protected void loadAdmin(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
        protected void loadSAM(object sender, EventArgs e)
        {
            Response.Redirect("SAM.aspx");
        }
        protected void loadSM(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string user = Session["user"].ToString();

            SqlCommand getNameproc = new SqlCommand("getStadiumName", conn);
            getNameproc.CommandType = CommandType.StoredProcedure;
            getNameproc.Parameters.Add(new SqlParameter("@username", user));

            SqlParameter sname = getNameproc.Parameters.Add("@sname", SqlDbType.VarChar, 20);

            sname.Direction = ParameterDirection.Output;

            conn.Open();
            getNameproc.ExecuteNonQuery();
            conn.Close();

            Session["stadium"] = sname.Value;
            //Response.Write(Session["stadium"]);
            Response.Redirect("SM.aspx");
        }
        protected void loadCR(object sender, EventArgs e)
        {
            Response.Redirect("CR.aspx");
        }
        protected void loadRegFan(object sender, EventArgs e)
        {
            Response.Redirect("RegFan.aspx");
        }
        protected void loadRegSAM(object sender, EventArgs e)
        {
            Response.Redirect("RegSAM.aspx");
        }
        protected void loadRegSM(object sender, EventArgs e)
        {
            Response.Redirect("RegSM.aspx");
        }
        protected void loadRegCR(object sender, EventArgs e)
        {
            Response.Redirect("RegCR.aspx");
        }
    }

}