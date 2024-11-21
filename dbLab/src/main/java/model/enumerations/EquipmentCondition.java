package model.enumerations;

public enum EquipmentCondition {
    FUNCTIONAL("Functional"),
    MAINTENANCE("Maintenance Needed"),
    OUTOFORDER("Out of Order");

    private final String value;

    EquipmentCondition(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }
}
