package model.enumerations;

public enum PaymentMethod {
    NA("N/A"),
    CASH("Cash"),
    CREDIT("Credit Card"),
    DEBIT("Debit Card"),
    ONLINE("Online Payment");

    private String value;

    PaymentMethod(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }
}
