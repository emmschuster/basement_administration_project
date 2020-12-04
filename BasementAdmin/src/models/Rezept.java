package models;

public class Rezept {
    private int id;
    private String name;

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Rezept(int id, String name) {
        this. id = id;
        this.name = name;
    }
}
