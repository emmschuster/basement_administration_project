<%@ page import="java.sql.Connection" %>
<%@ page import="util.DatabaseManager" %>
<%@ page import="util.Perform" %>
<%@ page import="models.Rezept" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Inventar" %>
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
    <div class="column small">
        <a href="inventar.jsp">Inventar</a>
    </div>
    <div class="column small">
        <a href="rhinzu.html">Rezept hinzufügen</a>
    </div>
    <div class="column small">
        <a href="invhinzu.html">Inventar erweitern</a>
    </div>
</div>
<p><% List<Inventar> inv = p.getInventar();
    //out.append(String.valueOf(rezepte.get(0).getId()));
    //out.append(rezepte.get(0).getName()); %></p>
<div class="column right">
    <h1>Inventar</h1>
     <div>
        <table style="width:100%; text-align: center">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>min Menge</th>
                <th>Einheit</th>
            </tr>
            <tr>
                <td><% //out.append((char) inv.get(0).getId());%></td>
                <td><% //out.append(inv.get(0).getName());%></td>
                <td><% //out.append((char) inv.get(0).getMinmenge());%></td>
                <td><% //out.append(inv.get(0).getEinheit());%></td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>


