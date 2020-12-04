<%@ page import="models.Rezept" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Emma Mango Jango
  Date: 04.12.2020
  Time: 21:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1></h1>
<% int rezeptId = Integer.parseInt((String) request.getAttribute("id"));
    List<Rezept> rezepte = p.getRezepte();
    out.append(String.valueOf(rezepte.get(0).getId())); %>
</body>
</html>
