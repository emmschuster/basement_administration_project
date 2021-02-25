<%@ page import="util.DatabaseManager" %>
<%@ page import="util.Perform" %>
<%@ page import="java.sql.Connection" %><%--
  Created by IntelliJ IDEA.
  User: Emma Mango Jango
  Date: 25.02.2021
  Time: 17:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% try {
    Class.forName("com.mysql.cj.jdbc.Driver");
} catch (ClassNotFoundException e) {
    e.printStackTrace();
}
    DatabaseManager dm = new DatabaseManager();
    Connection con = dm.getConnection();
    Perform p = new Perform(con);
    p.dropZutat(Integer.parseInt(request.getParameter("id")));
%>

<script language="javascript" type="text/javascript"> document.location="inventar.jsp"; </script>
