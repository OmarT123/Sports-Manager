using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

namespace DB_M3
{
    public partial class RegFan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected bool isdigit(string s)
        {
            char[] arr = s.ToCharArray();
            int i = 0;
            if (arr[0] == '+') i++;
            for (;i<arr.Length;i++)
            {
                if (arr[i] < '0' || arr[i] > '9') { return false; }
            }
            return true;
        }
        protected void register(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBM3"].ConnectionString; ;
            SqlConnection conn = new SqlConnection(connStr);

            string n = name.Text;
            string user = username.Text;
            string pass = password.Text;
            string nat = national.Text;
            string birth = datetime.Text;
            string add = address.Text;
            string phoneNo = phone.Text;
            DateTime date;
            if (n == "" || user == "" || pass == "" || nat == "" || birth == "" || add == "" || phoneNo == "")
                lit_MyText.Text = "All Fields must be filled";
            else if (!isdigit(phoneNo))
                lit_MyText.Text = "Phone Number must be a Number";
            else
            {
                if (DateTime.TryParse(birth, out date))
                {
                    SqlCommand regproc = new SqlCommand("addFan", conn);
                    regproc.CommandType = CommandType.StoredProcedure;
                    regproc.Parameters.Add(new SqlParameter("@name", n));
                    regproc.Parameters.Add(new SqlParameter("@username", user));
                    regproc.Parameters.Add(new SqlParameter("@password", pass));
                    regproc.Parameters.Add(new SqlParameter("@national_id_number", nat));
                    regproc.Parameters.Add(new SqlParameter("@birth_date", birth));
                    regproc.Parameters.Add(new SqlParameter("@address", add));
                    regproc.Parameters.Add(new SqlParameter("@phone", phoneNo));

                    SqlParameter success = regproc.Parameters.Add("@successful", SqlDbType.Int);

                    success.Direction = ParameterDirection.Output;

                    conn.Open();
                    regproc.ExecuteNonQuery();
                    conn.Close();

                    if (success.Value.ToString() == "1")
                    {
                        Response.Redirect("Login.aspx");
                    }
                    else if (success.Value.ToString() == "0")
                    {
                        lit_MyText.Text = "Username already exists";
                    }
                    else
                    {
                        lit_MyText.Text = "National ID already exists";
                    }
                }
                else
                {
                    lit_MyText.Text = "Please Enter a valid birthdate YYYY-MM-DD hh:mm:ss";
                }
            }
        }
    }
}
