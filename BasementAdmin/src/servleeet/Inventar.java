package servleeet;

import util.DatabaseManager;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "Inventar")
public class Inventar extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String zutid = request.getParameter("zutID");
        boolean x = true;
        DatabaseManager m=null;
        try {
            m = DatabaseManager.getInstance();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        Connection con = null;
        try {
            con = m.getConnection();
            x = m.zutatExisitertbyID(con, zutid);
        } catch (Exception e) {
            System.out.println("Rip ME");
        }
        //Weiterleitung:
        if (x) {
            HttpSession session = request.getSession();
            session.setAttribute("zutat", zutid);
            RequestDispatcher d = request.getRequestDispatcher("inventar.jsp");
            // Weiterleitung durchführen
            d.forward(request, response);
        }else {
            HttpSession session = request.getSession(false);
            if (session != null) session.invalidate();
            RequestDispatcher d = request.getRequestDispatcher("index.jsp");   // hm wenns die ID ned gibt... des geht ja eig ned
            d.forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }
}
