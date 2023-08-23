using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace DB_M3
{
    public partial class Fan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
        protected void viewMatches(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string query = "SELECT * FROM allMatches2";         
            SqlCommand requestproc = new SqlCommand(query, conn);
            requestproc.CommandType = CommandType.Text;

            conn.Open();
            SqlDataReader rdr = requestproc.ExecuteReader(CommandBehavior.CloseConnection);

            datagrid.DataSource = rdr;
            datagrid.DataBind();
        }
        protected void purchaseTicket(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string nat = Session["nat"].ToString();
            string h = host.Text;
            string g = guest.Text;
            string t = time.Text;
            DateTime dt;

            if (h != "" && g != "" && DateTime.TryParse(t, out dt))
            {
                SqlCommand purchaseproc = new SqlCommand("purchaseTicket", conn);
                purchaseproc.CommandType = CommandType.StoredProcedure;
                purchaseproc.Parameters.Add(new SqlParameter("@fan_national_id", nat));
                purchaseproc.Parameters.Add(new SqlParameter("@host_club_name", h));
                purchaseproc.Parameters.Add(new SqlParameter("@guest_club_name", g));
                purchaseproc.Parameters.Add(new SqlParameter("@start_time", t));
                
                conn.Open();
                purchaseproc.ExecuteNonQuery();
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