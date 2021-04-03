<%@ page import="util.DatabaseManager" %>
<%@ page import="util.Perform" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Array" %><%--
  Created by IntelliJ IDEA.
  User: Emma Mango Jango
  Date: 25.02.2021
  Time: 16:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% try {
    Class.forName("com.mysql.cj.jdbc.Driver");
} catch (ClassNotFoundException e) {
    e.printStackTrace();
}
    DatabaseManager dm = new DatabaseManager();
    Connection con = dm.getConnection();
    Perform p = new Perform(con);

    ArrayList<ArrayList<String>> zutaten = p.getZutatenIdMengeVonRezept(Integer.parseInt(request.getParameter("id")));
    int zID;
    float menge;
    for(int i=0;i<zutaten.size();i++) {
        zID=Integer.parseInt(zutaten.get(i).get(0));
        menge = p.getZutatenMenge(zID) - Float.parseFloat(zutaten.get(i).get(1));
        con.createStatement().executeUpdate("UPDATE zutat SET vorhandeneM = "+menge+" WHERE ZutID = "+ zID + ";");
    }
    //couter für statistik
    con.createStatement().executeUpdate("UPDATE rezept SET counterstatistik=counterstatistik+1 where rezid="+request.getParameter("id")+";");
%>

<script language="javascript" type="text/javascript"> document.location="zumRez.jsp?id=<%out.append(request.getParameter("id"));%>"; </script>
