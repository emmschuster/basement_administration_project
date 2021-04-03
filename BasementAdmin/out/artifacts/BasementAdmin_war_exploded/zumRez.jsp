<%@ page import="models.Inventar" %>
<%@ page import="models.Rezept" %>
<%@ page import="util.DatabaseManager" %>
<%@ page import="util.Perform" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!-- <link 	rel="StyleSheet" href="allinall.css">
    <jsp:include page="allinall.css"/> -->
    <title>Kellerverwaltung</title>
    <style>
        .column{
            text-align : center;
            color : black;
            background-color : #d6d6c2;
            border: 2px solid white;
            border-radius: 0px;
            float:left;
            padding: 10px;
        }
        a {
            text-decoration: none;
            text-align: center;
            color: black;
            padding: 20px;
            margin: 30px;
        }

        h2, h3, h4, h5 {
            font-family: arial black;
            color: darkred;
        }

        .column.right {
            width: 1000px;
            margin: 20px;
            height: 600px;
            background-color: #AFABAB;
        }

        .column.left {
            width: 200px;
            background-color: #AFABAB;
            margin: 20px;
            height: 600px;
        }
        .column.smallMini {
            width: 100px;
            background-color: #3B3838;
            margin-left: 50px;
            margin-right: 50px;
            margin-top: 20px;
            border: #767171;
        }
    </style>
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
        <a href="index.jsp">Startseite</a>
    </div>
    <div class="column small">
        <a href="rezept.jsp">Rezepte</a>
    </div>
    <!-- <div class="column smallMini">
        <a href="zumRez.jsp">Rezept Details</a>
    </div> -->
    <div class="column small">
        <a href="inventar.jsp">Inventar</a>
    </div>
    <div class="column small">
        <a href="rezhinzu.jsp">Rezept hinzufügen</a>
    </div>
    <div class="column small">
        <a href="zuthinzu.jsp">Inventar erweitern</a>
    </div>
</div>
<p><% Rezept rezept = p.getRezeptById(Integer.parseInt(request.getParameter("id"))); %></p>
<div class="column right">
    <form action="rezept.jsp">
        <div>
            <input type="submit" value="zurück">
        </div>
    </form>
    <h1><% out.append(rezept.getName()); %></h1>
    <table style="width:100%; text-align: center; table-layout: fixed; margin-bottom: 50px">
        <tr>
            <th>Name</th>
            <th>Zutaten</th>
            <th>Anleitung</th>
        </tr>
        <tr>
            <td><% out.append(rezept.getName());%></td>
            <td><% out.append(p.getZutatenVonRezept(rezept.getId()));%></td>
            <td><% out.append(rezept.getAnleitung());%></td>
        </tr>
    </table>

    <form action="rezDelete.jsp?id=<%= rezept.getId() %>" method="post">
        <button type="submit" id="rezeloesch" >Rezept l&ouml;schen</button>
    </form>

    <form action="rezBacken.jsp?id=<%= rezept.getId() %>" method="post">
        <button type="submit" id="rezBacken" >BACKEN</button>
    </form>

    <!-- <button type="button" id="drucken">als PDF runterladen</button> -->


</div>
</body>
</html>
