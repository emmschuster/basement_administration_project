<%@ page import="java.sql.Connection" %>
<%@ page import="util.DatabaseManager" %>
<%@ page import="util.Perform" %>
<%@ page import="models.Rezept" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%//@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%//@ page import="java.util.*" %>
<%//@ page import="com.google.gson.Gson"%>
<%//@ page import="com.google.gson.JsonObject"%>

<% //irgendwie geht ned aml es versuchsbeispiel aufn internet
    /*Gson gsonObj = new Gson();
    Map<Object,Object> map = null;
    List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();

    map = new HashMap<Object,Object>(); map.put("x", 10); map.put("y", 31); list.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 20); map.put("y", 65); list.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 30); map.put("y", 40); list.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 40); map.put("y", 84); map.put("indexLabel", "Highest"); list.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 50); map.put("y", 68); list.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 60); map.put("y", 64); list.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 70); map.put("y", 38); list.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 80); map.put("y", 71); list.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 90); map.put("y", 54); list.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 100); map.put("y", 60); list.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 110); map.put("y", 21); map.put("indexLabel", "Lowest"); list.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 120); map.put("y", 49); list.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 130); map.put("y", 41); list.add(map);

    String dataPoints = gsonObj.toJson(list);
    */
%>

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


    <script type="text/javascript">
        window.onload = function() {

            var chart = new CanvasJS.Chart("chartContainer", {
                animationEnabled: true,
                exportEnabled: true,
                title: {
                    text: "Simple Column Chart with Index Labels"
                },
                axisY:{
                    includeZero: true
                },
                data: [{
                    type: "column", //change type to bar, line, area, pie, etc
                    //indexLabel: "{y}", //Shows y value on all Data Points
                    indexLabelFontColor: "#5A5757",
                    indexLabelPlacement: "outside",
                    dataPoints: <%//out.print(dataPoints);%>
                }]
            });
            chart.render();

        }
    </script>

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
<p><% List<Rezept> rezepte = p.getRezepte();
    //out.append(String.valueOf(rezepte.get(0).getId()));
    //out.append(rezepte.get(0).getName());
%></p>

<div class="column right">
    <h1>Willkommen im Keller</h1>
    <h2 style="margin: 100px">Statistik?!</h2>

    <!--
    <div id="chartContainer" style="height: 370px; width: 100%;"></div>
    <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
    -->

</div>
</body>
</html>


