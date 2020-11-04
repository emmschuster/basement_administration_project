import java.io.File;
import java.io.FileNotFoundException;
import java.sql.*;
import java.util.Scanner;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class DatabaseManager {
    static Connection con = null;
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        getConnection();
        Perform p = new Perform(con);
        //p.ausfueren();
        p.getRezeptName(1);
        p.getZutatenVonRezept(1);
    }
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
                    "jdbc:mysql://localhost:3306/kellerverw?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true",  // DB
                    "root",                                 // User
                    scan.nextLine()                        // Passwort
            );
        //scan.close();
        }
        return con;
    }

    public void releaseConnection (Connection con)
            throws SQLException {

        if (con != null)
            con.close();
    }
}
