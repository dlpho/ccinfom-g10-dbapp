package model.enumerations;

public enum ResultStatus {
    Completed("Completed"),
    Pending("Pending"),
    Canceled("Canceled");

    private final String value;

    ResultStatus(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }
}
