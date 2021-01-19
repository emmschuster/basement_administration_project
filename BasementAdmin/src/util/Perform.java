package util;

import models.Inventar;
import models.Rezept;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
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

    public String getZutatName (int zid) {
        try (Statement stmt = conn.createStatement()) {
            String name;
            ResultSet rs0 = stmt.executeQuery("SELECT name from zutat WHERE ZutID=" + zid + ";");
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
            //builder.append("Datenbankfehler!!!");
        }
        return builder.toString();
    }

    public List<Inventar> getInventar() {
        List<Inventar> list = new ArrayList<>();
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs0 = stmt.executeQuery("SELECT zutid, name, minmange, vorhandeneM, einheit FROM zutat;");
            while (rs0.next()) {
                int id = rs0.getInt("zutid");
                String name = rs0.getString("name");
                int minmenge = rs0.getInt("minmange");
                float vorhandeneM = rs0.getInt("vorhandeneM");
                String einheit = rs0.getString("einheit");
                Inventar inv = new Inventar(id, name, minmenge, vorhandeneM, einheit);
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

    public Rezept getRezeptById(int id) {
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs0 = stmt.executeQuery("SELECT * FROM Rezept WHERE rezid = " + id + ";");
            if (rs0.next()) {
                String name = rs0.getString("name");
                String anleitung = rs0.getString("anleitung");
                return(new Rezept(id, name, anleitung));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    //gleiches wie getRezeptById, fürs inventar darstellen (damit des auch immer angezeigt wird)
    public Inventar getZutatById(int id) {
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs0 = stmt.executeQuery("SELECT * FROM zutat WHERE zutID = " + id + ";");
            if (rs0.next()) {
                String name = rs0.getString("name");
                float minmenge = rs0.getInt("anleitung");
                String einheit = rs0.getString("einheit");
                float vorhandeneM = rs0.getInt("vorhandeneM");
                return(new Inventar(id,name,minmenge,vorhandeneM, einheit));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public Rezept insertRezept(String rezname, String anleitung, LinkedHashMap<String, HashMap<String, Object>> zutaten) throws SQLException {
        // Checken ob irgenda zutat de übergeben wead scho in da datenbank existiert, wenn ja => wiederverwenden.
        // Wenn Zutat nid in DB dann neue eintragen.
        // Neues Rezept in Rezept-Table eintragen.
        // In Fusions-Table grad erzeugtes Rezept mit ID eintragen und alle Zutaten + deren Menge entsprechend eintragen.

        // Alle nicht vorhandenen Zutaten eintragen.
        for (String key : zutaten.keySet()) {
            if (!this.zutatExisitert(key)) {
                this.insertZutat(key, (Float) zutaten.get(key).get("Menge"), (Einheit) zutaten.get(key).get("Einheit"));
            }
        }

        // Neues Rezept einfügen.
        conn.createStatement().executeUpdate(String.format("INSERT INTO rezept (Name, Anleitung) VALUES(%s, %s);", rezname, anleitung));

        // Rezept und Zutaten in Fusions-Table eintragen
        // ---------------------------------------------
        // rezeptID vom gerade erstellten Rezept
        final int rezeptID = conn.createStatement().executeUpdate(
                String.format("SELECT RezID FROM rezept WHERE Name = %s AND Anleitung = %s", rezname, anleitung));

        // IDs aller benötigten Zutaten
        /*
        ArrayList<Integer> zutatenIDs = new ArrayList<>();
        for (String key : zutaten.keySet()) {
            zutatenIDs.add(conn.createStatement().executeUpdate(String.format("SELECT ZutID FROM zutat WHERE Name = %s;", key)));
        }
        */

        int[] zutatenIDs = new int[zutaten.size()];
        for (int i = 0; i < zutaten.size(); i++) {
            zutatenIDs[i] = conn.createStatement().executeUpdate(String.format("SELECT ZutID FROM zutat WHERE Name = %s;",
                    zutaten.keySet().toArray()[i]));
        }

        // Rezept und zugehörige Zutaten in Fusions-Table eintragen.
        // TODO: zutatID irgendwie herbekommen ... -> ZutatID zum String Key herbekommen !
        /*for (String key : zutaten.keySet()) {
            conn.createStatement().executeUpdate(String.format("INSERT INTO fusion (Menge, ZutID, RezID) VALUES()",
                    (float) zutaten.get(key).get("Menge"),
                    zutatenIDs[new ArrayList(zutaten.keySet()).get()],
                    rezeptID));
        }*/

        /*

            "Reismehl": {
                "Menge": 0.3F,
                "Einheit: Einheit.KG
            }

         */




        Statement stm=conn.createStatement();

        int i=stm.executeUpdate("INSERT INTO rezept (name,anleitung) values ('"+rezname+"','"+anleitung+"')");
        return null;        //is return 0 da ok? oder soll i void machen? oida besser eig ge
    }

    public boolean zutatExisitert(final String zutatName) throws SQLException {
        final int i = conn.createStatement().executeUpdate(String.format("SELECT COUNT(*) FROM zutat WHERE NAME = %s;", zutatName));
        if (i > 0) {
            return true;
        }
        return false;
    }

    public void insertZutat(final String zutat, final float minMenge, final Einheit einheit) throws SQLException {
        conn.createStatement().executeUpdate(
                String.format("INSERT INTO zutat (Name, minMange, Einheit) VALUES(%s, %s, %s)",
                zutat, minMenge, einheit.getEinheitLabel()));
    }       //Fetter Denkfehler: wo trag i ein wenn i einkaufen war?? => lösung : mach i dann alles im Inventar
}
