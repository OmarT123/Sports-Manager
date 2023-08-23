<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan.aspx.cs" Inherits="DB_M3.Fan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server" onkeydown="return event.key != 'Enter';">
        
        <div class="container">
            <div class="row">
                <div class="col">
                <h2>Purchase Ticket</h2>
                <asp:TextBox ID="host" CssClass="input" runat="server" placeholder="Host Club..."></asp:TextBox>
                <br />
                <asp:TextBox ID="guest" CssClass="input" runat="server" placeholder="Guest Club..."></asp:TextBox>
                <br />
                <asp:TextBox ID="time" CssClass="input" runat="server" TextMode="DateTime" placeholder="Start Time..."></asp:TextBox>
                <br />
                <asp:Button ID="Button2" CssClass="button" runat="server" Text="Purchase Ticket" OnClick="purchaseTicket"/>
                </div>
                <br />
                <div class="col2">
                <asp:Button ID="Button1" CssClass="button" runat="server" Text="View All Matches" OnClick="viewMatches"/>
                </div>
                </div>
            <div class="row">
                <div class="table">
            <asp:GridView ID="datagrid" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" ></asp:GridView>
                </div>
            </div>
             <div class="logout">
                <asp:Button ID="Button6" CssClass="button" runat="server" Text="Logout" OnClick="logout"/>
                </div>
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
      flex-direction:column;
      padding:50px;
    }
    .row {
        display:flex;
        flex-direction:row;
        height:50%;
        margin: 5px;
    }
    .col {
        display: flex;
        flex-direction:column;
        width:20%;
        margin:0 auto;
    }
    .col2 {
        display:grid;
        place-content:center;
        width:20%;
        margin:0 auto;
        margin-top: 20px;
    }
    .input {
      font-size: 13px;
      display: block;
      width: 100%;
      padding: 10px 1px;
      border: 0;
      border-bottom: 1px solid #747474;
      outline: none;
      margin-top: 5px;
    }
    .button {
      margin: 0 auto;
      border: none;
      padding: 15px;
      background-color: #1b3a67;
      color: white;
      margin: 5px;
      border-radius: 5px;
      cursor: pointer;
      overflow-wrap:break-word;
    }
    .logout {
        width:10%;
        position: absolute;
        right:    40px;
        bottom:   40px;
    }
    .table {
        margin: 0 auto;
        padding: 20px;
        width: 100%;
    }
    .mydatagrid
    {
    width: 90%;
    border: solid 2px black;
    min-width: 80%;
    }
    .header
    {
    background-color: #646464;
    font-family: Arial;
    color: White;
    border: none 0px transparent;
    height: 25px;
    text-align: center;
    font-size: 16px;
    }

    .rows
    {
    background-color: #fff;
    font-family: Arial;
    font-size: 14px;
    color: #000;
    min-height: 25px;
    text-align: left;
    border: none 0px transparent;
    }
    .rows:hover
    {
    background-color: #ff8000;
    font-family: Arial;
    color: #fff;
    text-align: left;
    }
    .pager
    {
    background-color: #646464;
    font-family: Arial;
    color: White;
    height: 30px;
    text-align: left;
    }

    .mydatagrid td
    {
    padding: 5px;
    }
    .mydatagrid th
    {
    padding: 5px;
    }
</style>
