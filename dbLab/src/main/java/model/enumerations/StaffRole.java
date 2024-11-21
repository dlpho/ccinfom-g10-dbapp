package model.enumerations;

public enum StaffRole {
    TECHNICIAN("Technician"),
    DOCTOR("Doctor"),
    NURSE("Nurse"),
    ADMINISTRATOR("Administrator"),
    RECEPTIONIST("Receptionist"),
    BILLING_CLERK("Billing Clerk");

    private String value;

    StaffRole(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }
}
