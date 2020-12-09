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
    <title>Kellerverwaltung</title>
    <style>
        h2, h3, h4, h5 {
            font-family: arial black;
            color: darkred;
        }

        .column.right {
            width: 1000px;
            margin: 20px;
            height: 600px;
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
        <a href="/index.jsp">Startseite</a>
    </div>
    <div class="column small">
        <a href="/rezept.jsp">Rezepte</a>
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
    <h1>Rezepte</h1>
    <ul>
        <li>
            <!-- request.getRequestDispatcher("rezept.jsp").forward(request, response); -->
            <a href="rezept.jsp"><% out.append(rezepte.get(5).getName()); //rezept.jsp?id=1%></a>
        </li>
        <li>
            <!-- request.getRequestDispatcher("index.jsp").forward(request, response); -->
            <a href="index.jsp"><% out.append(rezepte.get(0).getName()); %></a>
        </li>
        <li>
            <a href=""><% out.append(rezepte.get(3).getName()); %></a>
        </li>
    </ul>
</div>
</body>
</html>


