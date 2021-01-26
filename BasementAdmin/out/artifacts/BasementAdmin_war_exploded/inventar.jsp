<%@ page import="java.sql.Connection" %>
<%@ page import="util.DatabaseManager" %>
<%@ page import="util.Perform" %>
<%@ page import="models.Rezept" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Inventar" %>
<%@ page import="java.sql.SQLException" %>
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

        .plus-minus-input {
            float: right;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.0/css/font-awesome.css" integrity="sha512-72McA95q/YhjwmWFMGe8RI3aZIMCTJWPBbV8iQY3jy1z9+bi6+jHnERuNrDPo/WGYEzzNs4WdHNyyEr/yXJ9pA==" crossorigin="anonymous" />
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
                <td><!--<input id="minMenge" type="number" name="minMe" placeholder="//<%out.append(String.valueOf(invi.getVorhandeneM()));%>" /> -->
                    <%out.append("<span id=\"menge").append(String.valueOf(invi.getId())).append("\">").append(String.valueOf(invi.getVorhandeneM())).append("</span>");%>
                    <div class="input-group plus-minus-input">
                        <div class="input-group-button">
                            <button onclick="setInventoryChange(true, <% out.append(String.valueOf(invi.getId())); %>)" type="button" class="button hollow circle" data-quantity="plus" data-field="quantity">
                                <i class="fa fa-plus" aria-hidden="true"></i>
                            </button>
                        </div>
                        <div class="input-group-button">
                            <button onclick="setInventoryChange(false, <% out.append(String.valueOf(invi.getId())); %>)" type="button" class="button hollow circle" data-quantity="minus" data-field="quantity">
                                <i class="fa fa-minus" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>
                </td>
                <td><% out.append(invi.getEinheit().getEinheitLabel());%></td>
            </tr>
            <% } %>
        </table>
        <button onclick="submit()">Speichern</button>
    </div>
</div>
<script>
    function setInventoryChange(increase, id) {
        let node = document.getElementById('menge' + id);
        let value = parseInt(node.innerHTML);
        if (value <= 0 && !increase) {
            alert("Wir haben nichts mehr :(");
            return;
        }
        node.innerHTML = String(value + (increase ? 1 : - 1));
    }

    function submit() {
        for (let i = 1; i <= <% out.append(String.valueOf(zutaten.size())); %>; i++) {
            let node = document.getElementById('menge' + i);
            let xhr = new XMLHttpRequest();
            xhr.open('GET', 'updateZutat?zutID=' + i + '&menge=' + node.innerHTML);
            xhr.send();
            alert("wurde gespeichert")  //lüüüügner
        }
    }
</script>
</body>
</html>


