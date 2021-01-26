package models;

import util.Einheit;

public class Inventar {
        private int id;
        private int minmenge;
        private int vorhandeneM;
        private String name;
        private Einheit einheit;

    public Inventar(int id, String name, int minmenge, int vorhandeneM, int einheit) {
        this.id = id;
        this.minmenge = minmenge;
        this.vorhandeneM = vorhandeneM;
        this.name = name;
        this.einheit = Einheit.getEinheitById(einheit);
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

    public Einheit getEinheit() {
        return einheit;
    }

    public int getVorhandeneM() {return vorhandeneM;}
}
