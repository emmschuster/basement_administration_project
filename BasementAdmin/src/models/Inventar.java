package models;

public class Inventar {
        private int id;
        private int minmenge;
        private String name;
        private String einheit;

    public Inventar(int id, String name, int minmenge, String einheit) {
        this.id = id;
        this.minmenge = minmenge;
        this.name = name;
        this.einheit = einheit;
    }

    public int getId() {
        return id;
    }

    public int getMinmenge() {
        return minmenge;
    }

    public String getName() {
        return name;
    }

    public String getEinheit() {
        return einheit;
    }
}
