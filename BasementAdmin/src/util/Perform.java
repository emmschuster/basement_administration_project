package util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Perform {
    static Connection conn = null;

    public Perform(Connection con) {
        this.conn=con;
    }

    public void getRezeptName(int rID) {
        try (Statement stmt = conn.createStatement()) {
            String name;
            ResultSet rs0 = stmt.executeQuery("SELECT name from rezept WHERE RezID="+rID+";");
            while (rs0.next()) {
                name = rs0.getString("name");
                System.out.println(name);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void getZutatenVonRezept(int rID) {
        try (Statement stmt = conn.createStatement()) {
            String zName,fMenge,zEinheit;
            ResultSet rs0 = stmt.executeQuery("SELECT z.name, f.menge, z.einheit from Rezept r " +
                    "join fusion f on f.RezID = r.RezID join Zutat z on f.ZutID = z.ZutID where r.RezID = "+rID);
            while (rs0.next()) {
                zName = rs0.getString("z.name");
                fMenge = rs0.getString("f.menge");
                zEinheit = rs0.getString("z.einheit");
                System.out.println(zName+"  "+fMenge+"  "+zEinheit);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void ausfueren() {
        try (Statement stmt = conn.createStatement()) {
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
}
