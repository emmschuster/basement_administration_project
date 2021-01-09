<%@ page import="java.sql.Connection" %>
<%@ page import="util.DatabaseManager" %>
<%@ page import="util.Perform" %>
<%@ page import="models.Rezept" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.LinkedHashMap" %>
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
                var counter = 2; //oida wie kann i de variable nach zutat einfuegen?!
                if(x < max_fields){
                    x++;
                    $(wrapper).append('<div>zutat<input type="text" name="mytext[]" >\n' +
                        '            <label for="amountOfIngredient2">Menge von Zutat</label> <br>\n' +
                        '            <input id="amountOfIngredient" type="number" name="mengeZutat" placeholder="Kilogramm Zutat " />\n' +
                        '            <input type = "checkbox" name = "kg"  /> kg\n' +
                        '            <input type = "checkbox" name = "L"  /> L\n' +
                        '            <input type = "checkbox" name = "pkg"  /> pkg<a href="#" class="delete">Delete</a></div>');

                            counter++;
                }
                else
                {
                    alert('You Reached the limits')
                }
            });

            $(wrapper).on("click",".delete", function(e){
                e.preventDefault(); $(this).parent('div').remove(); x--;
            })
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
        <input id="rezname" type="text" name="nameZut1" placeholder="muffin" />
        <br/>

        <label for="anleitung" style="width: 100px">Anleitung</label>
        <input id="anleitung" type="text" name="anleitungRez" placeholder="einfach alles zammen schmeißen, mixen und bei 180°C 10 min backen" />
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

        <div class="container1">
            <button class="add_form_field">Add Zutat &nbsp; <span style="font-size:16px; font-weight:bold;">+ </span></button>
        </div>

        <br/> <br/>

        <input type = "submit" value = "Submit" />
    </form>
    <%
        /*String rezname=request.getParameter("rezname");
        String anleitung=request.getParameter("anleitungrez");
        String Zutat=request.getParameter("zutat");
        String Einheit=request.getParameter("einheit");
        float Menge = Float.parseFloat(request.getParameter("menge"));
        HashMap<String, HashMap<String, Object>> map = new HashMap<String, HashMap<String, Object>>() {{
            put("Zutat", new HashMap<String, Object>() {{
                put("Menge", Menge);
                put("Einheit", Einheit);
            }});
        }};
        p.insertRezept(rezname, anleitung, (LinkedHashMap<String, HashMap<String, Object>>) map); */
    %>

    </div>
</body>
</html>