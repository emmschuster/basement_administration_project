<%@ page import="java.sql.Connection" %>
<%@ page import="util.DatabaseManager" %>
<%@ page import="util.Perform" %>
<%@ page import="models.Rezept" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!-- <link 	rel="StyleSheet" href="allinall.css">
    <jsp:include page="allinall.css"/> -->
    <title>Rezept</title>
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
    //out.append(String.valueOf(rezepte.get(0).getId()));
    //out.append(rezepte.get(0).getName()); %></p>
<div float="right">
    <h1 style="color:blue;" >Rezepte</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Anleitung</th>
        </tr>
        <tr>
            <td><% out.append((char) rezepte.get(0).getId());%></td>
            <td><% out.append(rezepte.get(0).getName());%></td>
            <td><% out.append(rezepte.get(0).getAnleitung());%></td>
        </tr>
        <tr>
            <td>Centro comercial Moctezuma</td>
            <td>Francisco Chang</td>
            <td>Mexico</td>
        </tr>
        <tr>
            <td>Ernst Handel</td>
            <td>Roland Mendel</td>
            <td>Austria</td>
        </tr>
        <tr>
            <td>Island Trading</td>
            <td>Helen Bennett</td>
            <td>UK</td>
        </tr>
    </table>
</div>
</body>
</html>
