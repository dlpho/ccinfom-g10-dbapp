package model.enumerations;

public enum ResultOutcome {
    NORMAL(""),
    BELOW("Abnormal (Below Range)"),
    ABOVE("Abnormal (Above Range)"),
    POSITIVE("Positive"),
    NEGATIVE("Negative"),
    LOW("Low Risk"),
    MODERATE("Moderate Risk"),
    HIGH("High Risk");

    private final String value;

    ResultOutcome(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }
}
