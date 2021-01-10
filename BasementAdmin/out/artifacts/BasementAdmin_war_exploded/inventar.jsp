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
        <a href="rezhinzu.jsp">Rezept hinzufügen</a>
    </div>
    <div class="column small">
        <a href="zuthinzu.jsp">Inventar erweitern</a>
    </div>
</div>

<div class="column right">
    <h1>Inventar</h1>
    <%  List<Inventar> zutaten = p.getInventar();
        //Inventar inv = p.getZutatById(Integer.parseInt(request.getParameter("id")));
    %>
    <div>
        <table style="width:100%; text-align: center">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>min Menge</th>
                <th>aktuelle Menge</th>
                <th>Einheit</th>
            </tr>
            <% for (Inventar invi : zutaten) { %>
            <tr>
                <td><% out.append(String.valueOf(invi.getId()));%></td>
                <td><% out.append(invi.getName());%></td>
                <td><%out.append(String.valueOf(invi.getMinmenge()));%></td>
                <td>no ned vorhanden</td>
                <td><% out.append(invi.getEinheit());%></td>
            </tr>
            <%}%>
        </table>
    </div>
</div>
</body>
</html>


