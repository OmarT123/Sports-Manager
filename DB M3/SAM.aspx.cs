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

namespace DB_M3
{
    public partial class SAM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void addMatch(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string host = addmatchhost.Text;
            string guest = addmatchguest.Text;
            string start = addmatchstart.Text;
            string end = addmatchend.Text;
            DateTime sdate, edate;

            if (host != "" && guest != "" && DateTime.TryParse(start, out sdate) && DateTime.TryParse(end, out edate))
            {
                SqlCommand addMatchproc = new SqlCommand("addNewMatch", conn);
                addMatchproc.CommandType = CommandType.StoredProcedure;
                addMatchproc.Parameters.Add(new SqlParameter("@hostClubName", host));
                addMatchproc.Parameters.Add(new SqlParameter("@guestClubName", guest));
                addMatchproc.Parameters.Add(new SqlParameter("@startTime", start));
                addMatchproc.Parameters.Add(new SqlParameter("@endTime", end));

                conn.Open();
                addMatchproc.ExecuteNonQuery();
                conn.Close();
            }
        }
        protected void deleteMatch(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string host = deletematchhost.Text;
            string guest = deletematchguest.Text;
            string start = deletematchstart.Text;
            string end = deletematchend.Text;
            DateTime sdate, edate;

            if (host != "" && guest != "" && DateTime.TryParse(start, out sdate) && DateTime.TryParse(end, out edate))
            {
                SqlCommand deleteMatchproc = new SqlCommand("deleteMatch", conn);
                deleteMatchproc.CommandType = CommandType.StoredProcedure;
                deleteMatchproc.Parameters.Add(new SqlParameter("@hostClubName", host));
                deleteMatchproc.Parameters.Add(new SqlParameter("@guestClubName", guest));
                deleteMatchproc.Parameters.Add(new SqlParameter("@starttime", start));
                deleteMatchproc.Parameters.Add(new SqlParameter("@endtime", end));

                conn.Open();
                deleteMatchproc.ExecuteNonQuery();
                conn.Close();
            }
        }
        protected void viewUpcomingMatches(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string sqlv = "SELECT * FROM upcomingMatches";
            SqlCommand matches = new SqlCommand(sqlv, conn);
            matches.CommandType = CommandType.Text;

            conn.Open();
            SqlDataReader rdr = matches.ExecuteReader(CommandBehavior.CloseConnection);

            datagrid.DataSource = rdr;
            datagrid.DataBind();

        }
        protected void viewPlayedMatches(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string sqlv = "SELECT * FROM playedMatches";
            SqlCommand matches = new SqlCommand(sqlv, conn);
            matches.CommandType = CommandType.Text;

            conn.Open();
            SqlDataReader rdr = matches.ExecuteReader(CommandBehavior.CloseConnection);

            datagrid.DataSource = rdr;
            datagrid.DataBind();
        }
        protected void pairsOfClubs(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string sqlv = "SELECT * FROM twoclubsneverplay";
            SqlCommand clubs = new SqlCommand(sqlv, conn);
            clubs.CommandType = CommandType.Text;

            conn.Open();
            SqlDataReader rdr = clubs.ExecuteReader(CommandBehavior.CloseConnection);

            datagrid.DataSource = rdr;
            datagrid.DataBind();
        }
        protected void logout(object sender, EventArgs e)
        {
            Session["user"] = "";
            Response.Redirect("login.aspx");

        }
    }
}