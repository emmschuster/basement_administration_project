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
        if (con != null) {
            return con;
        }

        try (Scanner scan = new Scanner(new File("C:\\Users\\Emma Mango Jango\\Desktop\\HTL5\\SWP-Rubner\\password.txt"))) {
            if (scan.hasNext()) {
                con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/kellerverw?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true",  // DB
                        "root",                                 // User
                        scan.nextLine()                        // Passwort
                );
                return con;
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return null;
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
