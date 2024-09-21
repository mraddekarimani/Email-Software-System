<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
    <style>
        th, td {
            font-size: 32px;
            width: 32px;
        }
        .myCheckBox {
            font-size: 32px;
            width: 48px;
        }
        .myButton {
            font-size: 32px;
        }
    </style>
</head>
<body>
    <table border=1 width="90%" align=center><tr><td align=center><a href="inbox.jsp">Inbox</a></td><td align=center><a href="SentBox.jsp">Sentbox</a></td><td align=center><a href="ComposeMail.jsp">ComposeMail</a></td><td align=center><a href="logout.jsp">Logout</a></td></tr></table><br><br>
    <center><h1>My SentBox</h1></center><br><br><br><br>
    <form name="deleteForm" action="sentMailDelete.jsp" method="post">
        <table border="1" align="center" width="60%">
            <tr>
                <th>Select</th>
                <th>To</th>
                <th>Subject</th>
            </tr>
            <%
                String driver = "com.mysql.jdbc.Driver";
                String connectionUrl = "jdbc:mysql://localhost:3306/";
                String database = "emailsoftware";
                String userid = "mani";
                String password = "Kanta@123";
                try {
                    Class.forName(driver);
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;
                String user_id = session.getAttribute("emailid").toString();
                try {
                    connection = DriverManager.getConnection(connectionUrl + database, userid, password);
                    statement = connection.createStatement();
                    String sql = "select * from mails where mfrom='" + user_id + "' and sentbox=1";
                    resultSet = statement.executeQuery(sql);
                    while (resultSet.next()) {
                        int mid = resultSet.getInt("mid");
            %>
            <tr>
                <td align="center"><input type="checkbox" class="myCheckBox" name="deleteIds" value="<%= mid %>"></td>
                <td><%= resultSet.getString("mto") %></td>
                <td><%= resultSet.getString("subject") %></td>
            </tr>
            <%
                    }
                    connection.close();
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
        </table>
        <br>
        <div align="center">
            <input type="submit" value="Delete Selected" class="myButton">
        </div>
    </form>
</body>
</html>

