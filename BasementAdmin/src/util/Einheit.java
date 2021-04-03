package util;

public enum Einheit {
    G(1, "g"),
    L(2, "ml "),
    STK(3, "STK");

    final int id;
    final String einheitLabel;

    Einheit(final int id, final String label) {
        this.id = id;
        this.einheitLabel = label;
    }

    public static Einheit getEinheitById(final int id) {
        for (Einheit einheit : values()) {
            if (einheit.getId() == id) {
                return einheit;
            }
        }
        return null;
    }

    public String getEinheitLabel() {
        return this.einheitLabel;
    }

    public int getId() {
        return this.id;
    }
}
