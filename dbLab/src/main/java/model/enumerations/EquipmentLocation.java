package model.enumerations;

public enum EquipmentLocation {
    HEMATOLOGY("Hematology Lab"),
    BIOCHEMISTRY("Biochemistry Lab"),
    MICROBIOLOGY("Microbiology Lab"),
    IMAGING("Imaging Lab");

    private final String value;

    EquipmentLocation(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }
}
