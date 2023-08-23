using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Remoting.Messaging;
using System.Web.Caching;

namespace DB_M3
{
    public partial class SM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void stadiumInfo(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string stadium = Session["stadium"].ToString();

            SqlCommand stadiuminfoproc = new SqlCommand("stadiumInfo", conn);
            stadiuminfoproc.CommandType = CommandType.StoredProcedure;
            stadiuminfoproc.Parameters.Add(new SqlParameter("@sname", stadium));

            conn.Open();
            SqlDataReader rdr = stadiuminfoproc.ExecuteReader(CommandBehavior.CloseConnection);

            datagrid.DataSource = rdr;
            datagrid.DataBind();
        }
        protected void viewRequest(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string user = Session["user"].ToString();

            SqlCommand requestproc = new SqlCommand("allStadRequests", conn);
            requestproc.CommandType = CommandType.StoredProcedure;
            requestproc.Parameters.Add(new SqlParameter("@username", user));

            conn.Open();
            SqlDataReader rdr = requestproc.ExecuteReader(CommandBehavior.CloseConnection);

            datagrid.DataSource = rdr;
            datagrid.DataBind();

        }
        protected void acceptRequest(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string user = Session["user"].ToString();
            string h = host.Text;
            string g = guest.Text;
            string t = time.Text;

            SqlCommand getNameproc = new SqlCommand("acceptRequest", conn);
            getNameproc.CommandType = CommandType.StoredProcedure;
            getNameproc.Parameters.Add(new SqlParameter("@stadium_manager_username", user));
            getNameproc.Parameters.Add(new SqlParameter("@host_club_name", h));
            getNameproc.Parameters.Add(new SqlParameter("@guest_club_name", g));
            getNameproc.Parameters.Add(new SqlParameter("@start_time", t));

            conn.Open();
            getNameproc.ExecuteNonQuery();
            conn.Close();
        }
        protected void rejectRequest(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string user = Session["user"].ToString();
            string h = host.Text;
            string g = guest.Text;
            string t = time.Text;

            SqlCommand getNameproc = new SqlCommand("rejectRequest", conn);
            getNameproc.CommandType = CommandType.StoredProcedure;
            getNameproc.Parameters.Add(new SqlParameter("@stadium_manager_username", user));
            getNameproc.Parameters.Add(new SqlParameter("@host_club_name", h));
            getNameproc.Parameters.Add(new SqlParameter("@guest_club_name", g));
            getNameproc.Parameters.Add(new SqlParameter("@start_time", t));

            conn.Open();
            getNameproc.ExecuteNonQuery();
            conn.Close();
        }
        protected void logout(object sender, EventArgs e)
        {
            Session["user"] = "";
            Response.Redirect("login.aspx");

        }

    }
}