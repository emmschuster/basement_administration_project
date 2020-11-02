import java.io.File;
import java.io.FileNotFoundException;
import java.sql.*;
import java.util.Scanner;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;


public class DatabaseManager {
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        getConnection();
        ausfueren();
    }
    static Connection con = null;
    public static Connection getConnection()
            throws ClassNotFoundException, SQLException {
        Scanner scan = null;
        try {
            scan = new Scanner(new File("C:\\Users\\Emma Mango Jango\\Desktop\\HTL5\\SWP-Rubner\\password.txt"));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        //Class.forName("com.mysql.cj.jdbc");       //da irgendwie fehler
        if (scan.hasNext()) {
            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/kellerverw?serverTimezone=UTC&useSSL=false",  // DB
                    "root",                                 // User
                    scan.nextLine()                        // Passwort
            );
        //scan.close();
        }
        return con;

    }

    private static void ausfueren() {
        try (Statement stmt = con.createStatement()) {
            String name,rname,zname,fmenge,zeinheit;
            ResultSet rs0 = stmt.executeQuery(" SELECT name FROM rezept;");
            while (rs0.next()) {
                name = rs0.getString("name");
                System.out.println(name);
            }
            ResultSet rs1=stmt.executeQuery("SELECT r.name, z.name, f.menge, z.einheit from Rezept r " +
                    "join fusion f on f.RezID = r.RezID join Zutat z on f.ZutID = z.ZutID where r.RezID = 1;");
            while (rs1.next()) {
                rname = rs1.getString("r.name");
                zname = rs1.getString("z.name");
                fmenge = rs1.getString("f.menge");
                zeinheit = rs1.getString("z.einheit");
                System.out.println(rname +"||"+zname+"||"+fmenge+"||"+zeinheit);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void releaseConnection (Connection con)
            throws SQLException {

        if (con != null)
            con.close();
    }
}
