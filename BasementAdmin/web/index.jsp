<%@ page import="java.sql.Connection"%>
<%@ page import="util.DatabaseManager"%>
<%@ page import="util.Perform" %>

<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>


<%--
  Created by IntelliJ IDEA.
  User: Emma Mango Jango
  Date: 14.10.2020
  Time: 09:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link 	rel="StyleSheet" href="allinall.css">
    <title>Kellerverwaltung</title>
</head>
<body>
<sql:setDataSource var = "snapshot" driver = "mysql-connector-java-8.0.21"
                   url = "jdbc:mysql://localhost:3306/kellerverw?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true"
                   user = "root"  password = "BonsaiEmma123"/>

<sql:query dataSource = "${snapshot}" var = "result">
    SELECT z.name, f.menge, z.einheit from Rezept r join fusion f on f.RezID = r.RezID join Zutat z on f.ZutID = z.ZutID where r.RezID = 1;
</sql:query>
    <h1>${row.name}</h1>
<table border = "1" width = "100%">
    <tr>
        <th>Zuatet</th>
        <th>Menge</th>
        <th>Einheit</th>
    </tr>
    <c:forEach var = "row" items = "${result.rows}">
        <tr>
            <td><c:out value = "${row.z.name}"/></td>
            <td><c:out value = "${row.f.menge}"/></td>
            <td><c:out value = "${row.z.einheit}"/></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
