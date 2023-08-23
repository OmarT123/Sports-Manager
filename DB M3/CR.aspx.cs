using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DB_M3
{
    public partial class CR : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string user = Session["user"].ToString();

            SqlCommand getNameproc = new SqlCommand("getClubName", conn);
            getNameproc.CommandType = CommandType.StoredProcedure;
            getNameproc.Parameters.Add(new SqlParameter("@username", user));

            SqlParameter cname = getNameproc.Parameters.Add("@cname", SqlDbType.VarChar,20);

            cname.Direction = ParameterDirection.Output;

            conn.Open();
            getNameproc.ExecuteNonQuery();
            conn.Close();

            Session["club"] = cname.Value;
        }
        protected void clubInfo(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);
            
            string user = Session["user"].ToString();
            
            SqlCommand clubinfoproc = new SqlCommand("repClubInfo", conn);
            clubinfoproc.CommandType = CommandType.StoredProcedure;
            clubinfoproc.Parameters.Add(new SqlParameter("@username", user));

            conn.Open();
            SqlDataReader rdr = clubinfoproc.ExecuteReader(CommandBehavior.CloseConnection);

            datagrid.DataSource = rdr;
            datagrid.DataBind();

        }
        protected void upcomingMatches(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string user = Session["user"].ToString();

            SqlCommand clubinfoproc = new SqlCommand("repUpcomingMatch", conn);
            clubinfoproc.CommandType = CommandType.StoredProcedure;
            clubinfoproc.Parameters.Add(new SqlParameter("@username", user));

            conn.Open();
            SqlDataReader rdr = clubinfoproc.ExecuteReader(CommandBehavior.CloseConnection);

            datagrid.DataSource = rdr;
            datagrid.DataBind();
        }
        protected void availableStadiums(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string date = staddate.Text;
            DateTime dt;
            if (DateTime.TryParse(date, out dt))
            {
                SqlCommand availablestadproc = new SqlCommand("viewAvailableStadiumsOnDate", conn);
                availablestadproc.CommandType = CommandType.StoredProcedure;
                availablestadproc.Parameters.Add(new SqlParameter("@date", date));

                conn.Open();
                SqlDataReader rdr = availablestadproc.ExecuteReader(CommandBehavior.CloseConnection);

                datagrid.DataSource = rdr;
                datagrid.DataBind();
            }
        }
        protected void requestStad(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string name = stadname.Text;
            string date = start.Text;
            DateTime dt;
            if (name != "" && DateTime.TryParse(date,out dt))
            {
                SqlCommand requeststadproc = new SqlCommand("addHostRequest", conn);
                requeststadproc.CommandType = CommandType.StoredProcedure;
                requeststadproc.Parameters.Add(new SqlParameter("@club_name", Session["club"]));
                requeststadproc.Parameters.Add(new SqlParameter("@stadium_name", name));
                requeststadproc.Parameters.Add(new SqlParameter("@start_time", date));


                conn.Open();
                requeststadproc.ExecuteNonQuery();
                conn.Close();

            }
        }
        protected void logout(object sender, EventArgs e)
        {
            Session["user"] = "";
            Response.Redirect("login.aspx");

        }
    }
}