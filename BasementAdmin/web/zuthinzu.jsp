<%@ page import="java.sql.Connection" %>
<%@ page import="util.DatabaseManager" %>
<%@ page import="util.Perform" %>
<%@ page import="models.Rezept" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="util.Einheit" %>
<%@ page import="static java.lang.Integer.parseInt" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

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

        .delete {
            color: indianred;
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
    <h1>Zutat hinzufügen </h1>
    <p>Das Inventar durch ein neues Produkt erweitern</p>

    <form action = "zuthinzu.jsp" method = "GET">

        <label for="zutname">Zutatname</label>
        <input id="zutname" type="text" name="name" placeholder="Dinkelmehl Typ 630" />
        <br/>

        <input type="radio" id="kg" name="einheit" value="g">
        <label for="kg">kg</label><br>
        <input type="radio" id="L" name="einheit" value="mL">
        <label for="L">L</label><br>
        <input type="radio" id="Stk" name="einheit" value="Stk">
        <label for="Stk">Stk</label><br>

        <label for="minMenge">Mindest Bestand</label>
        <input id="minMenge" type="number" name="minMenge" placeholder="1" />
        <br/>
        <br/>
        <input type = "submit" value = "Submit" />
    </form>
    <%
        if (request.getParameter("name") == null) {
            return;
        }
        String name = request.getParameter("name");
        int minmenge=Integer.parseInt(request.getParameter("minMenge"));
        String einheit=request.getParameter("einheit");

        try {
            p.insertZutat(name, minmenge, 0, Einheit.valueOf(einheit.toUpperCase()));
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>

</div>
</body>
</html>