package models;

public class Rezept {
    private int id;
    private String name;
    private String anleitung;

    /* public String getId() {
        String s = Integer.toString(id);
        return s;
    }*/
    public int getId() {
        return id;
    }

    /* public String getId() {
        String s = String.valueOf(id);
        return s;
    } */

    public String getName() {
        return name;
    }

    public String getAnleitung() {
        return anleitung;
    }

    public Rezept(int id, String name, String anleitung) {
        this.id = id;
        this.name = name;
        this.anleitung=anleitung;
    }
}
