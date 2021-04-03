<%@ page import="com.google.gson.Gson" %>
<%@ page import="models.Rezept" %>
<%@ page import="util.DatabaseManager" %>
<%@ page import="util.Perform" %>
<%@ page import="java.sql.Connection" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<html>
<head>
    <!-- <link 	rel="StyleSheet" href="allinall.css">
    <jsp:include page="allinall.css"/> -->

    <script src="canvasjs.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/canvasjs/1.7.0/canvasjs.js"
            integrity="sha512-P0pdbdTHc6MzepVlBNGN/c+lBFfFk0ISSc/GLLnQzR5QzfgVdQMvOhVK4RvnhylawHSn2QxgAjb3f+zxSMfyNg=="
            crossorigin="anonymous"></script>

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
<p>
    <%
        List<Rezept> rezepte = p.getRezepte();

        Gson gsonObj = new Gson();
        Map<Object,Object> map = null;
        List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();

        for(int i=0;i<rezepte.size();i++){
            map = new HashMap<Object,Object>();
            map.put("label", rezepte.get(i).getName());
            map.put("y", rezepte.get(i).getCounter());
            list.add(map);
        }

        String dataPoints = gsonObj.toJson(list);
    %>
    <script type="text/javascript">
        window.onload = function() {

            var chart = new CanvasJS.Chart("chartContainer", {
                title: {
                    text: "was wurde wie oft gebacken?"
                },
                axisX: {
                    title: "Gebäck"
                },
                axisY: {
                    title: "Anzahl",
                    includeZero: true
                },
                data: [{
                    type: "column",
                    dataPoints: <%out.print(dataPoints);%>
                }]
            });
        }
    </script>
</p>

<div class="column right">
    <h1>Willkommen im Keller</h1>

    <div id="chartContainer" style="height: 370px; width: 100%;"></div>

</div>
</body>
</html>


