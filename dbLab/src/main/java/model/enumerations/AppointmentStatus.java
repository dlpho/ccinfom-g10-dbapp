package model.enumerations;

public enum AppointmentStatus {
    SCHEDULED("Scheduled"),
    PROGRESS("In Progress"),
    PAYMENT("Pending Payment"),
    COMPLETED("Completed"),
    FOLLOWUP("Follow-Up (w/ Follow-up Advised)"),
    CANCELED("Canceled");

    private final String value;

    AppointmentStatus(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }
}
