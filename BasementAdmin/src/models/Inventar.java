package models;

public class Inventar {
        private int id;
        private float minmenge;
        private float vorhandeneM;
        private String name;
        private String einheit;

    public Inventar(int id, String name, float minmenge, float vorhandeneM, String einheit) {
        this.id = id;
        this.minmenge = minmenge;
        this.vorhandeneM = vorhandeneM;
        this.name = name;
        this.einheit = einheit;
    }

    public int getId() {
        return id;
    }

    public float getMinmenge() {
        return minmenge;
    }

    public String getName() {
        return name;
    }

    public String getEinheit() {
        return einheit;
    }

    public float getVorhandeneM() {return vorhandeneM;}
}
