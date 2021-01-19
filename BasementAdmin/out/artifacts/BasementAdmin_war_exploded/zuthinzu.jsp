<%@ page import="java.sql.Connection" %>
<%@ page import="util.DatabaseManager" %>
<%@ page import="util.Perform" %>
<%@ page import="models.Rezept" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="util.Einheit" %>
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
    <p>als Kommer bitte [.] benutzen</p>

    <form action = "zuthinzu.jsp" method = "GET">

        <label for="zutname">Zutatname</label>
        <input id="zutname" type="text" name="namez" placeholder="Dinkelmehl Typ 630" />
        <br/>

        <label for="jetztstand">Hinzufügen</label>
        <input id="jetztstand" type="number" name="jetztSt" placeholder="1" />
        <br/>

        <!--<input type = "radio" name = "kg" checked /> kg
        <input type = "radio" name = "L"  /> L
        <input type = "radio" name = "pkg"  /> pkg/Stk
        <br/>-->

        <input type="radio" id="kg" name="einheit" value="kg">
        <label for="kg">kg</label><br>
        <input type="radio" id="L" name="einheit" value="L">
        <label for="L">L</label><br>
        <input type="radio" id="Pkg/Stk" name="einheit" value="Pkg/Stk">
        <label for="Pkg/Stk">Pkg/Stk</label><br>

        <label for="minMenge">Mindest Bestand</label>
        <input id="minMenge" type="number" name="minMe" placeholder="0.5" />
        <br/>
        <br/>
        <input type = "submit" value = "Submit" />
    </form>
    <%
        /*String zutname=request.getParameter("zutname");
        //int jetztstand= Integer.parseInt(request.getParameter("jetztstand"));
        float minmenge=Float.parseFloat(request.getParameter("minMenge"));
        //String Einheit=request.getParameter("einheit");     //wie die Einheit? --> oida na geht schu passt danke

        p.insertZutat(zutname,minmenge, Einheit.valueOf(request.getParameter("einheit")));*/
    %>

</div>
</body>
</html>