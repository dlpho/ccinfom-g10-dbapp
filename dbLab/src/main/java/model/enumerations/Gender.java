package model.enumerations;

public enum Gender {
    M("M"),
    F("F");

    private final String value;

    Gender(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        switch(value) {
            case "M": return "Male";
            case "F": return "Female";
            default: throw new IllegalArgumentException("Invalid gender: " + value);
        }
    }
}
