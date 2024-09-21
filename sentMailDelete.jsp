<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Enumeration"%>
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
    try {
        connection = DriverManager.getConnection(connectionUrl + database, userid, password);
        statement = connection.createStatement();
        String[] deleteIds = request.getParameterValues("deleteIds");
        if (deleteIds != null) {
            for (String id : deleteIds) {
                String sql = "update mails set sentbox=0 where mid="+id+"";
                statement.executeUpdate(sql);
            }
        }
        connection.close();
    } catch (Exception e) {
        out.println(e.getMessage());
    }
    response.sendRedirect("SentBox.jsp");
%>
