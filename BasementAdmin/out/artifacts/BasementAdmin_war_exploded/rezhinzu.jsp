<%@ page import="models.Rezept" %>
<%@ page import="util.DatabaseManager" %>
<%@ page import="util.Einheit" %>
<%@ page import="util.Perform" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
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

        .delete {
            color: indianred;
        }

    </style>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            var max_fields      = 20;
            var wrapper         = $(".container1");
            var add_button      = $(".add_form_field");

            var x = 1;
            $(add_button).click(function(e){
                e.preventDefault();
                if(x < max_fields){
                    $(wrapper).append('<div>zutat<input type="text" name="nameZutat' + x + '" ><br/>\n' +
                        '            <label for="amountOfIngredient">Menge von Zutat</label> \n' +
                        '            <input id="amountOfIngredient" type="number" name="mengeZutat' + x + '" placeholder="27 " /><br/>\n' +
                        '            <input type = "radio" name = "einheit' + x + '"  value="1"/> kg\n' +
                        '            <input type = "radio" name = "einheit' + x + '"  value="2"> L\n' +
                        '            <input type = "radio" name = "einheit' + x + '"  value="3"/> pkg<a href="#" class="delete">Delete</a></div>');
                    x++;
                }
                else
                {
                    alert('You Reached the limits')
                }
            });

            $(wrapper).on("click",".delete", function(e){
                e.preventDefault();
                $(this).parent('div').remove();
                x--;
            });
        });
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
    //out.append(rezepte.get(0).getName()); %></p>
<div class="column right">
    <h1>Rezept hinzufügen</h1>

    <form action = "rezhinzu.jsp" method = "GET">

        <label for="rezname">Rezeptname</label>
        <input id="rezname" type="text" name="rezname" placeholder="muffin" />
        <br/>

        <label for="anleitung" style="width: 100px">Anleitung</label>
        <textarea id="anleitung" type="text" name="anleitungRez" name="message" rows="10" cols="30">schreib rein</textarea>
        <!--<input id="anleitung" type="text" name="anleitungRez" placeholder="einfach alles zammen schmeißen, mixen
        und bei 180°C 10 min backen" /> -->
        <br/>
        <br/>

        <div class="container1">
            <button class="add_form_field">Add Zutat &nbsp; <span style="font-size:16px; font-weight:bold;">+ </span></button>
        </div>

        <br/> <br/>

        <input type = "submit" value = "Submit" />
    </form>
    <%

        String rezname=request.getParameter("rezname");         //hier wurde breakpoint gesetzt
        String anleitung=request.getParameter("anleitungRez");


        HashMap<String, HashMap<String, Object>> map = new HashMap<String, HashMap<String, Object>>();
        for (int i = 1; i <= 20; i++) {
            final String nameZutat = request.getParameter("nameZutat" + i);
            if (nameZutat == null || nameZutat.isEmpty()) {
                break;
            }
            final int mengeZutat = Integer.parseInt(request.getParameter("mengeZutat"+ i));    //da isch 0 irgendwie,,,, httpsrequest findet koa menge
            final Einheit einheit = Einheit.getEinheitById(Integer.parseInt(request.getParameter("einheit" +i)));

            map.put(nameZutat, new HashMap<String, Object>() {{
                put("Menge", mengeZutat);
                put("Einheit", einheit);
            }});
        }
        if (rezname == null || rezname.isEmpty()) {
            return;
        }
        try {
            p.insertRezept(rezname, anleitung, map);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Perform.ZutatDoesNotExistException ex) {
            out.append("OIDA de Zutat existiert ned in deiner Welt");
        }
    %>

    </div>
</body>
</html>