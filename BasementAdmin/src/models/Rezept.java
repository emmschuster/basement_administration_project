package models;

public class Rezept {
    private int id;
    private String name;
    private String anleitung;

    public int getId() {
        return id;
    }

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
