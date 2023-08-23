<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DB_M3.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <div class="container">
        <div class="center">
    <form id="form1" runat="server">
        <div>
        <h2>Login</h2>
        <br />
        <div class="data">
        <asp:TextBox ID="username" CssClass="input" runat="server" placeholder="Username..."></asp:TextBox>
        <br/>
        <asp:TextBox ID="password" CssClass="input" TextMode="Password" runat="server" placeholder="Password..."></asp:TextBox>
        
            <p><asp:Literal id="lit_MyText" runat="server" /></p>
        <br />
            <div class="bts">
        <asp:Button ID="loginBT" CssClass="login" runat="server" Text="Login" OnClick="login"/>
            <br />
                <div class="register">
            <asp:Button ID="Button2" CssClass="button" runat="server" Text="Register Fan" OnClick="loadRegFan" />
            <br />
            <asp:Button ID="Button3" CssClass="button" runat="server" Text="Register SAM" OnClick="loadRegSAM"/>
            <br />
            <asp:Button ID="Button4" CssClass="button" runat="server" Text="Register SM" OnClick="loadRegSM"/>
            <br />
            <asp:Button ID="Button5" CssClass="button" runat="server" Text="Register CR" OnClick="loadRegCR" />
            </div>
                </div>
            </div>
    </form>
        </div>
    </div>
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
      background-color: #FCF6F5FF;
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
      padding: 10px 35px 0 35px;
      font-weight: 300;
    }
    .data {
      padding: 30px;
      margin: 5px;
    }
    .h1 {
        justify-content: center;
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
      margin-top: 15px;
      display: flex;
      flex-direction: column;
    }
    .register {
      width: 100%;
      margin: 0 auto;
      margin-top: 15px;
      display: flex;
      flex-direction: row;
    }
    .button {
      width: 23%;
      margin: 0 auto;
      border: none;
      padding: 20px;
      background-color: #1b3a67;
      color: white;
      margin: 5px;
      border-radius: 5px;
      cursor: pointer;
      overflow-wrap:break-word;
      align-content:center;
      text-align:center;
    }
    .login{
      width: 98%;
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
        height:10px;
        padding-top:10px;
    }
  </style>
