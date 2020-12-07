<%@ page import="java.sql.Connection"%>
<%@ page import="util.DatabaseManager"%>
<%@ page import="util.Perform" %>
<%@ page import="models.Rezept" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link 	rel="StyleSheet" href="allinall.css">
    <title>out.append(rezepte.get(0).getName());</title>
</head>

<body>
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
<h1>out.append(rezepte.get(0).getName());</h1>
    <%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    DatabaseManager dm = new DatabaseManager();
    Connection con = dm.getConnection();
    Perform p = new Perform(con);
    int rezeptId = Integer.parseInt((String) request.getAttribute("id"));
    List<Rezept> rezepte = p.getRezepte();
    out.append(String.valueOf(rezepte.get(0).getId())); %>
</body>
</html>
