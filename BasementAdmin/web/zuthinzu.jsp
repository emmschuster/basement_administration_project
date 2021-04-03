<%@ page import="models.Inventar" %>
<%@ page import="util.DatabaseManager" %>
<%@ page import="util.Einheit" %>
<%@ page import="util.Perform" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="static java.lang.Integer.parseInt" %>
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

        <input type="radio" id="kg" name="einheit" value="kg">
        <label for="kg">g</label><br>
        <input type="radio" id="L" name="einheit" value="L">
        <label for="L">ml</label><br>
        <input type="radio" id="Stk" name="einheit" value="Stk">
        <label for="Stk">Stk</label><br>

        <label for="minMenge">Mindest Bestand</label>
        <input id="minMenge" type="number" name="minMenge" placeholder="1" />
        <br/>
        <br/>
        <input type = "submit" value = "Submit" />
    </form>

    <div class="column middle">
        <% List<Inventar> zutaten = p.getInventar(); %>
        <table style="width:100%; text-align: center">
            <tr>
                <th style="width:40%;">vorhandene Zutaten:</th>
            </tr>
                <% for (Inventar invi : zutaten) { %>
            <tr>
                <td style="width:40%;"><% out.append(invi.getName());%></td>
                </td>
            </tr>
                <% } %>
    </div>

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