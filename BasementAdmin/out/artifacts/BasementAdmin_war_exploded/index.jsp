<%@ page import="java.sql.Connection"%>
<%@ page import="util.DatabaseManager"%>
<%@ page import="util.Perform" %>
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
<%

    Connection con;
    DatabaseManager dm = new DatabaseManager();
    con = dm.getConnection();
    Perform p = new Perform(con);
    p.getRezeptName(1);
%>
<p><%out.print(" Penis");%></p>
<p><%p.getRezeptName(1);%></p>
<script src="myScript.js"></script>
<div class="column left">
    <h3>Inhaltsverzeichnis</h3>
    <div class="column small">
        <a href="index.html">Startseite</a>
    </div>
    <div class="column small">
        <a href="rezepte.html">Rezepte</a>
    </div>
    <div class="column small">
        <a href="inventar.html">Inventar</a>
    </div>
    <div class="column small">
        <a href="rhinzu.html">Rezept hinzufügen</a>
    </div>
    <div class="column small">
        <a href="invhinzu.html">Inventar erweitern</a>
    </div>
</div>
<div class="column right">
    <h2> Willkommen im Keller </h2>
    <button type="button" onclick="myFunction()">Try it</button>
</div>
</body>
</html>
