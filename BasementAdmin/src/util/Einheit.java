package util;

public enum Einheit {
    KG("KG"),
    L("L"),
    STK("STK");

    final String einheitLabel;

    Einheit(final String label) {
        this.einheitLabel = label;
    }

    public String getEinheitLabel() {
        return this.einheitLabel;
    }
}
