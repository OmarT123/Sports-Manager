<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegFan.aspx.cs" Inherits="DB_M3.RegFan" %>

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
                    <h2>Register as Fan</h2>
                    <div class="data">
                        <div class="box">
                            <div class="left">
                                <asp:TextBox ID="name" CssClass="input" runat="server" placeholder="Name..."></asp:TextBox>
                                <br />
                                <asp:TextBox ID="username" CssClass="input" runat="server" placeholder="Username..."></asp:TextBox>
                                <br />
                                <asp:TextBox ID="password" CssClass="input" TextMode="Password" runat="server" placeholder="Password..."/>
                                <br />
                                <asp:TextBox ID="national" CssClass="input" runat="server" placeholder="National ID Number..."></asp:TextBox>
                            </div>
                            <br />
                            <div class="divider"></div>
                            <div class="right">
                                <asp:TextBox ID="datetime" CssClass="input" TextMode="DateTime" runat="server" placeholder="BirthDate..."/>
                                <br />
                                <asp:TextBox ID="address" CssClass="input" runat="server" placeholder="Address..."></asp:TextBox>
                                <br />
                                <asp:TextBox ID="phone" CssClass="input" runat="server" placeholder="Phone Number..."></asp:TextBox>
                            </div>
                        </div>
                         <p><asp:Literal id="lit_MyText" runat="server" /></p>
                    </div>
                    <br />
                    <div class="button">
                        <asp:Button ID="Button1" CssClass="bt" runat="server" Text="Register" OnClick="register" />
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
      height: 680px;
    }
    .center {
      background-color: white;
      margin: auto;
      width: 80%;
      height: 80%;
      position: relative;
      top: 45%;
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
    .box {
        display:flex;
        flex-direction:row;
        align-content: center;
    }
    .divider {
        width:20%;
    }
    .right{
        margin-top:40px;
    }
    p {
        height:5px;
        padding-top:10px;
    }
  </style>