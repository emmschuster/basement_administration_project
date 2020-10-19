import java.io.File;
import java.io.FileNotFoundException;
import java.sql.*;
import java.util.Scanner;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;


public class DatabaseManager {
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        //getConnection();
        //ausfueren();
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

        Class.forName("mysql-connector-java-8.0.21");       //da irgendwie fehler
        while (scan.hasNext()) {
        con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/artikeldbschule1?serverTimezone=UTC&useSSL=false",  // DB
                "root",                                 // User
                scan.nextLine()                        // Passwort
        );
        scan.close();
        }
        return con;

    }

    private static void ausfueren() {
        try {
            //Class.forName("org.sqlite.JDBC");
            Statement stmt = con.createStatement();
            String name;
            try (ResultSet rs0 = stmt.executeQuery(" SELECT name FROM rezept;")) {
                while (rs0.next()) {
                    name = rs0.getString("Name vom Rezept");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void releaseConnection (Connection con)
            throws SQLException {

        if (con != null)
            con.close();
    }
}
