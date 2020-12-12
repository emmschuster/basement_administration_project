import util.DatabaseManager;
import util.Perform;

import java.sql.SQLException;
import java.sql.*;

public class MainClass {
    static Connection con;

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        DatabaseManager dm = new DatabaseManager();
        con = dm.getConnection();
        Perform p = new Perform(con);
        System.out.println(p.getRezeptName(1));
        System.out.print(p.getZutatenVonRezept(1));
        System.out.print(p.getZutatName(1));
    }
}
