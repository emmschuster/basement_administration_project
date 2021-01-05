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
        <a href="index.jsp">Inventar erweitern</a>
    </div>
</div>
<p><% List<Rezept> rezepte = p.getRezepte();
    //out.append(String.valueOf(rezepte.get(0).getId()));
    //out.append(rezepte.get(0).getName()); %></p>

<div class="column right">
    <h1>Rezept hinzufügen</h1>

    <form action = "rezhinzu.jsp" method = "GET">

        <label for="name1">Rezeptname</label>
        <input id="name1" type="text" name="nameZut1" placeholder="muffin" />
        <br/>

        <label for="anleitung1" style="width: 100px">Anleitung</label>
        <input id="anleitung1" type="text" name="anleitungZut1" placeholder="einfach alles zammen schmeißen, mixen und bei 180°C 10 min backen" />
        <br/>
        <br/>

            Zutat 1 <input type = "text" name = "zutat1">
            <br/>
            <label for="amountOfIngredient1">Menge von Zutat 1</label><br>
            <input id="amountOfIngredient1" type="number" name="mengeZutat1" placeholder="Kilogramm Zutat 1" />
            <br/>

            <input type = "checkbox" name = "kg"  /> kg
            <input type = "checkbox" name = "L"  /> L
            <input type = "checkbox" name = "pkg"  /> pkg
            <br/> <br/>

        Zutat 2 <input type = "text" name = "zutat1">
        <br/>
        <label for="amountOfIngredient2">Menge von Zutat 2</label><br>
        <input id="amountOfIngredient2" type="number" name="mengeZutat2" placeholder="Kilogramm Zutat 2" />
        <br/>

        <input type = "checkbox" name = "kg"  /> kg
        <input type = "checkbox" name = "L"  /> L
        <input type = "checkbox" name = "pkg"  /> pkg
        <br/> <br/>

        <input type = "submit" value = "Submit" />



    </form>

</div>
</body>
</html>