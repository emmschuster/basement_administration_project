package util;

import java.io.File;
import java.io.FileNotFoundException;
import java.sql.*;
import java.util.Scanner;
import java.util.function.Supplier;

public class DatabaseManager {
    Connection con = null;

    public DatabaseManager() throws SQLException, ClassNotFoundException {
        getConnection();
    }

    private static <T> T getOrDefault(T value, T defaultValue) {
        return value != null ? value : defaultValue;
    }

    public Connection getConnection()
            throws ClassNotFoundException, SQLException {
        if (con != null) {
            return con;
        }

        final String mySQLurl = getOrDefault(
            "jdbc:mysql://" + System.getenv("MYSQL_HOST") + "/" + System.getenv("MYSQL_DB"),
            "jdbc:mysql://localhost:3306/kellerverw?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true"
        );
        final String mySQLusername = getOrDefault(
            System.getenv("MYSQL_USERNAME"),
            "root"
        );
        final String mySQLpassword = getOrDefault(
            System.getenv("MYSQL_PASSWORD"),
            ((Supplier<String>) () -> {
                try (Scanner scan = new Scanner(
                    new File("C:\\Users\\Emma Mango Jango\\Desktop\\HTL5\\SWP-Rubner\\password.txt")
                )) {
                    if (scan.hasNext()) {
                        return scan.nextLine();
                    }
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                }
                return null;
            }).get()
        );

        con = DriverManager.getConnection(
            mySQLurl, // DB
            mySQLusername, // User
            mySQLpassword // Passwort
        );
        return con;
    }

    public void releaseConnection (Connection con)
            throws SQLException {

        if (con != null)
            con.close();
    }

    private static DatabaseManager instance = null;
    public static DatabaseManager getInstance () throws SQLException, ClassNotFoundException {
        if (instance == null) {
            instance = new DatabaseManager();
        }
        return instance;
    }

    public boolean rezeptVorhanden(Connection con, String rezID) throws SQLException {
        boolean vorhanden = false;
        PreparedStatement stm=null;
        ResultSet rs = null;
        try {
            String sql = "SELECT COUNT(*) FROM rezept WHERE rezID = ? ";
            stm = con.prepareStatement(sql);
            stm.setString( 1, rezID);
            rs=stm.executeQuery();
            if (rs.next()) {
                int anzahl = rs.getInt(1);
                vorhanden = anzahl == 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
        return vorhanden;
    }

    public boolean zutatExisitertbyID(Connection con, final String zutID) throws SQLException {
        boolean vorhanden = false;
        PreparedStatement stm=null;
        ResultSet rs = null;
        try {
            String sql = "SELECT COUNT(*) FROM zutat WHERE zutID = ? ";
            stm = con.prepareStatement(sql);
            stm.setString( 1, zutID);
            rs=stm.executeQuery();
            if (rs.next()) {
                int anzahl = rs.getInt(1);
                vorhanden = anzahl == 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
        return vorhanden;
    }
}
