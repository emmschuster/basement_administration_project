package servleeet;

import util.DatabaseManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "UpdateZutat", urlPatterns = "/updateZutat")
public class UpdateZutat extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int zutid;
        int menge;
        try {
            zutid = Integer.parseInt(request.getParameter("zutID"));
            menge = Integer.parseInt(request.getParameter("menge"));
        } catch (NumberFormatException ex) {
            ex.printStackTrace();
            return;
        }

        DatabaseManager m=null;
        try {
            m = new DatabaseManager();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("Rip Me");
            return;
        }

        Connection con = null;
        try {
            con = m.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Rip Me x2");
            return;
        }

        try {
            con.createStatement().executeUpdate(String.format("UPDATE zutat SET vorhandeneM = %d WHERE ZutID = %d;", menge, zutid));
            m.releaseConnection(con);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
