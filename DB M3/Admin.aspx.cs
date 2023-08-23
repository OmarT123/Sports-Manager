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
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == "")
                Response.Redirect("login.aspx");
        }
        protected void addClub(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string name = addname.Text;
            string location = addlocation.Text;

            if (name != "" && location != "")
            {
                SqlCommand addClubproc = new SqlCommand("addClub", conn);
                addClubproc.CommandType = CommandType.StoredProcedure;
                addClubproc.Parameters.Add(new SqlParameter("@club_name", name));
                addClubproc.Parameters.Add(new SqlParameter("@club_location", location));

                conn.Open();
                addClubproc.ExecuteNonQuery();
                conn.Close();
            }
        }
        protected void deleteClub(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string name = deletename.Text;

            if (name != "")
            {
                SqlCommand deleteClubproc = new SqlCommand("deleteClub", conn);
                deleteClubproc.CommandType = CommandType.StoredProcedure;
                deleteClubproc.Parameters.Add(new SqlParameter("@club_name", name));

                conn.Open();
                deleteClubproc.ExecuteNonQuery();
                conn.Close();
            }

        }
        protected void addStadium(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string name = addstadname.Text;
            string location = addstadloc.Text;
            string capacity = addstadcap.Text;

            if (name != "" && location != "" && capacity != "") {
                SqlCommand addStadiumproc = new SqlCommand("addStadium", conn);
                addStadiumproc.CommandType = CommandType.StoredProcedure;
                addStadiumproc.Parameters.Add(new SqlParameter("@stadium_name", name));
                addStadiumproc.Parameters.Add(new SqlParameter("@stadium_location", location));
                addStadiumproc.Parameters.Add(new SqlParameter("@capacity", capacity));

                conn.Open();
                addStadiumproc.ExecuteNonQuery();
                conn.Close();
            }
        }
        protected void deleteStadium(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string name = deletestad.Text;

            if (name != "")
            {
                SqlCommand deleteStadiumproc = new SqlCommand("deleteStadium", conn);
                deleteStadiumproc.CommandType = CommandType.StoredProcedure;
                deleteStadiumproc.Parameters.Add(new SqlParameter("@st_name", name));

                conn.Open();
                deleteStadiumproc.ExecuteNonQuery();
                conn.Close();
            }
        }
        protected void blockFan(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string id = fanid.Text;
            if (id != "")
            {
                SqlCommand deleteStadiumproc = new SqlCommand("blockFan", conn);
                deleteStadiumproc.CommandType = CommandType.StoredProcedure;
                deleteStadiumproc.Parameters.Add(new SqlParameter("@id", id));

                conn.Open();
                deleteStadiumproc.ExecuteNonQuery();
                conn.Close();
            }
        }
        protected void unblockFan(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string id = unfanid.Text;
            if (id != "")
            {
                SqlCommand deleteStadiumproc = new SqlCommand("unblockFan", conn);
                deleteStadiumproc.CommandType = CommandType.StoredProcedure;
                deleteStadiumproc.Parameters.Add(new SqlParameter("@id", id));

                conn.Open();
                deleteStadiumproc.ExecuteNonQuery();
                conn.Close();
            }
        }
        protected void deleteStad(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string name = deletestad.Text;

            if (name != "")
            {
                SqlCommand deleteStadiumproc = new SqlCommand("deleteStadium", conn);
                deleteStadiumproc.CommandType = CommandType.StoredProcedure;
                deleteStadiumproc.Parameters.Add(new SqlParameter("@st_name", name));

                conn.Open();
                deleteStadiumproc.ExecuteNonQuery();
                conn.Close();
            }
        }

        protected void logOut(object sender, EventArgs e)
        {
            Session["user"] = "";
            Response.Redirect("login.aspx");
        }
    }
}