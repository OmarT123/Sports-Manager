<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegSM.aspx.cs" Inherits="DB_M3.RegSM" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="container">
                <div class="center">
                    <h2>Register as Stadium Manager</h2>
                    <div class="data">
                        <asp:TextBox ID="name" CssClass="input" runat="server" placeholder="Name..."></asp:TextBox>
                        <br />
                        <asp:TextBox ID="username" CssClass="input" runat="server" placeholder="Username..."></asp:TextBox>
                        <br />
                        <asp:TextBox ID="password" CssClass="input" TextMode="Password" runat="server" placeholder="Password..."/>
                        <br />
                        <asp:TextBox ID="stadium" CssClass="input" runat="server" placeholder="Stadium Name..."></asp:TextBox>
                        <p><asp:Literal id="lit_MyText" runat="server" /></p> 
                    </div>
                        <br />
                    <div class="button">
                        <asp:Button ID="Button1" CssClass="bt" runat="server" Text="Register" OnClick="register"/>
        </div>
            </div>
            </div>
            </div>
    </form>
</body>
</html>
<style>
    body {
      background-color: crimson;
      font-family: "Rubik", sans-serif;
      display: flex;
      justify-content: center;
    }
    .container {
      width: 700px;
      height: 640px;
    }
    .center {
      background-color: white;
      margin: auto;
      width: 80%;
      height: 80%;
      position: relative;
      top: 50%;
      border-radius: 10px;
      -webkit-transform: translateY(-50%);
      -ms-transform: translateY(-50%);
      transform: translateY(-50%);
    }
    form {
      padding: 15px;
    }
    h2 {
      padding: 35px 35px 0 35px;
      font-weight: 300;
    }
    .data {
      padding: 30px;
      margin: 5px;
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
    .bts {
      width: 100%;
      display: flex;
      flex-direction: column;
    }
    .button {
      width: 100%;
      margin: 0 auto;
      display:flex;
      justify-content:center;
    }
    .bt{
      width: 90%;
      margin: 0 auto;
      border: none;
      padding: 20px;
      background-color: #1b3a67;
      color: white;
      margin: 5px;
      border-radius: 5px;
      cursor: pointer;
    }
    p {
        height: 10px;
        margin-bottom:-13px;
    }
  </style>