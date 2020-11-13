package util;

import java.io.File;
import java.io.FileNotFoundException;
import java.sql.*;
import java.util.Scanner;

public class DatabaseManager {
    Connection con = null;

    public DatabaseManager() throws SQLException, ClassNotFoundException {
        getConnection();
    }

    public Connection getConnection()
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
