package util;

import com.mysql.cj.x.protobuf.MysqlxDatatypes;
import models.Inventar;
import models.Rezept;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class Perform {
    static Connection conn = null;

    public Perform(Connection con) {
        this.conn = con;
    }

    public String getRezeptName(int rID) {
        try (Statement stmt = conn.createStatement()) {
            String name;
            ResultSet rs0 = stmt.executeQuery("SELECT name from rezept WHERE RezID=" + rID + ";");
            if (rs0.next()) {
                name = rs0.getString("name");
                return name;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public String getZutatenVonRezept(int rID) {
        StringBuilder builder = new StringBuilder();
        try (Statement stmt = conn.createStatement()) {
            String zName, fMenge, zEinheit;
            ResultSet rs0 = stmt.executeQuery("SELECT z.name, f.menge, z.einheit from Rezept r " +
                    "join fusion f on f.RezID = r.RezID join Zutat z on f.ZutID = z.ZutID where r.RezID = " + rID);
            while (rs0.next()) {
                zName = rs0.getString("z.name");
                fMenge = rs0.getString("f.menge");
                zEinheit = rs0.getString("z.einheit");
                builder.append(zName + "  " + fMenge + "  " + zEinheit + "\n");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return builder.toString();
    }

    public List<Inventar> getInventar() {
        List<Inventar> list = new ArrayList<>();
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs0 = stmt.executeQuery("SELECT zutid, name, minmenge, einheit FROM zutat;");
            while (rs0.next()) {
                int id = rs0.getInt("zutid");
                String name = rs0.getString("name");
                int minmenge = rs0.getInt("minmenge");
                String einheit = rs0.getString("einheit");
                Inventar inv = new Inventar(id, name, minmenge, einheit);
                list.add(inv);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<Rezept> getRezepte() {
        List<Rezept> list = new ArrayList<>();
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs0 = stmt.executeQuery("SELECT rezid, name, anleitung FROM Rezept;");
            while (rs0.next()) {
                int id = rs0.getInt("rezid");
                String name = rs0.getString("name");
                String anleitung = rs0.getString("anleitung");
                Rezept rezept = new Rezept(id, name, anleitung);
                list.add(rezept);
            }
        } catch (SQLException ex) {

        }
        return list;
    }

    public void ausfueren() {
        try (Statement stmt = conn.createStatement()) {
            String name, rname, zname, fmenge, zeinheit;
            ResultSet rs0 = stmt.executeQuery(" SELECT name FROM rezept;");
            while (rs0.next()) {
                name = rs0.getString("name");
                System.out.println(name);
            }
            ResultSet rs1 = stmt.executeQuery("SELECT r.name, z.name, f.menge, z.einheit from Rezept r " +
                    "join fusion f on f.RezID = r.RezID join Zutat z on f.ZutID = z.ZutID where r.RezID = 1;");
            while (rs1.next()) {
                rname = rs1.getString("r.name");
                zname = rs1.getString("z.name");
                fmenge = rs1.getString("f.menge");
                zeinheit = rs1.getString("z.einheit");
                System.out.println(rname + "||" + zname + "||" + fmenge + "||" + zeinheit);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
