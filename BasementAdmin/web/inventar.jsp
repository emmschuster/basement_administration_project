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
            width: 1100px;
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
    <%  List<Inventar> zutaten = p.getInventar();%>
    <div>
        <table style="width:100%; text-align: center">
            <tr>
                <th style="width:10%;">ID</th>
                <th style="width:40%;">Name</th>
                <th style="width:15%;">min Menge</th>
                <th style="width:15%;">aktuelle Menge</th>
                <th style="width:10%;">Einheit</th>
                <th style="width:10%;">drop?</th>
            </tr>
            <% for (Inventar invi : zutaten) { %>
            <tr>
                <td style="width:10%;"><% out.append(String.valueOf(invi.getId()));%></td>
                <td style="width:40%;"><% out.append(invi.getName());%></td>
                <td style="width:15%;"><%out.append(String.valueOf(invi.getMinmenge()));%></td>
                <td style="width:15%;"><!--<input id="minMenge" type="number" name="minMe" placeholder="//<%out.append(String.valueOf(invi.getVorhandeneM()));%>" /> -->
                    <%out.append("<span id=\"menge").append(String.valueOf(invi.getId())).append("\">").append(String.valueOf(invi.getVorhandeneM())).append("</span>");%>
                    <div class="input-group plus-minus-input">
                        <div class="input-group-button">
                            <button type="button" onclick="setInventoryChange(true, <% out.append(String.valueOf(invi.getId())); %>)" type="button" class="button hollow circle" data-quantity="plus" data-field="quantity">
                                <i class="fa fa-plus" aria-hidden="true"></i>
                            </button>
                        </div>
                        <div class="input-group-button">
                            <button type="button" onclick="setInventoryChange(false, <% out.append(String.valueOf(invi.getId())); %>)" type="button" class="button hollow circle" data-quantity="minus" data-field="quantity">
                                <i class="fa fa-minus" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>
                </td>
                <td style="width:10%;"><% out.append(invi.getEinheit().getEinheitLabel());%></td>

            <td style="width:10%;">
                <form action="zutDelete.jsp?id=<%= invi.getId() %>" method="post">
                    <input type="image" id="zutloesch" src="data:image/png;base64,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" style="width: 20px; border: none;"/>
                </form>
            </td>
            </tr>
            <% } %>
        </table>
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
        let xhr = new XMLHttpRequest();
        xhr.open('GET', 'updateZutat?zutID=' + id + '&menge=' + node.innerHTML);
        xhr.send();
    }
</script>
</body>
</html>


