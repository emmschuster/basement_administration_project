<%@ page import="java.sql.Connection"%>
<%@ page import="util.DatabaseManager"%>
<%@ page import="util.Perform" %>
<%@ page import="models.Rezept" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link 	rel="StyleSheet" href="allinall.css">
    <title>Kellerverwaltung</title>
</head>

<body>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    DatabaseManager dm = new DatabaseManager();
    Connection con = dm.getConnection();
    Perform p = new Perform(con);
%>
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
    <p><% List<Rezept> rezepte = p.getRezepte();
    out.append(String.valueOf(rezepte.get(0).getId()));
        out.append(rezepte.get(0).getName()); %></p>

    <h1>Rezepte</h1>
<ul>
    <li>
        <a href="/rezept.jsp?id=1">hi</a>
    </li>
    <li>
        <a href=""><% out.append(String.valueOf(rezepte.get(0).getId())); %> </a>
    </li>
    <li>
        <a href=""><!-- rezeptname --></a>
    </li>
</ul>
</body>
</html>


