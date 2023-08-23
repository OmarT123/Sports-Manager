<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="DB_M3.Admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server" onkeydown="return event.key != 'Enter';">
        <div class="container">
            <div class="col">
                <div>
                    <h2>Add Club</h2>
                    <asp:TextBox ID="addname" CssClass="input" runat="server" placeholder="Club Name..."></asp:TextBox>
                    <br />
                    <asp:TextBox ID="addlocation" CssClass="input" runat="server" placeholder="Club Location..."></asp:TextBox>
                    <br />
                    <asp:Button ID="Button1" CssClass="button" runat="server" Text="Add Club" OnClick="addClub"/>
                </div>
                <br />
                <div class="div1"></div>
                <div>
                    <h2>Delete Club</h2>
                    <asp:TextBox ID="deletename" CssClass="input" runat="server" placeholder="Club Name..."></asp:TextBox>
                    <br />
                    <asp:Button ID="Button2" CssClass="button" runat="server" Text="Delete Club" OnClick="deleteClub"/>
                </div>
               
                <br />
                </div>
                
            <div class="col">
                 <div>
                    <h2>Add Stadium</h2>
                    <asp:TextBox ID="addstadname" CssClass="input" runat="server" placeholder="Stadium Name..." ></asp:TextBox>
                    <br />
                    <asp:TextBox ID="addstadloc" CssClass="input" runat="server" placeholder="Stadium Location..."></asp:TextBox>
                    <br />
                    <asp:TextBox ID="addstadcap" CssClass="input" runat="server" placeholder="Stadium Capacity..."></asp:TextBox>
                    <br />
                    <asp:Button ID="Button3" CssClass="button" runat="server" Text="Add Stadium" OnClick="addStadium"/>
                </div>
                <br />
                <div>
                    <h2>Delete Stadium</h2>
                    <asp:TextBox ID="deletestad" CssClass="input" runat="server" placeholder="Stadium Name..."></asp:TextBox>
                    <br />
                    <asp:Button ID="Button4" CssClass="button" runat="server" Text="Delete Stadium" OnClick="deleteStad"/>
                </div>
                </div>
                <div class="col">
                <div>
                    <h2>Block Fan</h2>
                    <asp:TextBox ID="fanid" CssClass="input" runat="server" placeholder="National ID Number..."></asp:TextBox>
                    <br />
                    <asp:Button ID="Button5" CssClass="button" runat="server" Text="Block Fan" OnClick="blockFan"/>
                
                    <br /><br /><br /><br /><br /><br /><br /><br /><br />

                    <h2>UnBlock Fan</h2>
                    <asp:TextBox ID="unfanid" CssClass="input" runat="server" placeholder="National ID Number..."></asp:TextBox>
                    <br />
                    <asp:Button ID="Button7" CssClass="button" runat="server" Text="UnBlock Fan" OnClick="unblockFan"/>
                </div>
                <br />
                <div class="div2"></div>
                    <div class="logout">
                <asp:Button ID="Button6" CssClass="button" runat="server" Text="Logout" OnClick="logOut"/>
                        </div>


                </div>
                <br />
                
                </div>
    </form>
</body>
</html>
<style>
     body {
      background-color: #6883BC;
      font-family: "Rubik", "sans-serif";
      display: flex;
      margin: 0;
      padding: 20px;
      display:grid;
      place-content:center;
      justify-content: center;
    }
    .container {
      width: 90vw;
      height: 80vh;
      max-width: 95vw;
      max-height: 93vh;
      background-color: white;
      border-radius: 5px;
      display:flex;
      flex-direction:row;
      padding:50px;
      }
    .col {
        margin:auto;
        width:25%;
    }
    .input {
      font-size: 16px;
      display: block;
      width: 100%;
      padding: 10px 1px;
      border: 0;
      border-bottom: 1px solid #747474;
      outline: none;
      margin-top: 11px;
    }
    .button {
      margin: 0 auto;
      border: none;
      padding: 20px;
      background-color: #1b3a67;
      color: white;
      margin: 5px;
      border-radius: 5px;
      cursor: pointer;
      overflow-wrap:break-word;
    }
    .div1 {
        height:40px
    }
    .div2 {
        height:250px
    }

    .logout {
        position: absolute;
        right:    40px;
        bottom:   40px;
    }
</style>