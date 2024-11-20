import enumerations.PaymentMethod;

public class Payment {
    private int payment_id;
    private Appointment appointment_id;
    private double total_cost;
    private PaymentMethod payment_method;
    private Date date_paid;

    public int getPayment_id() {
        return payment_id;
    }

    public void setPayment_id(int payment_id) {
        this.payment_id = payment_id;
    }

    public Appointment getAppointment_id() {
        return appointment_id;
    }

    public void setAppointment_id(Appointment appointment_id) {
        this.appointment_id = appointment_id;
    }

    public double getTotal_cost() {
        return total_cost;
    }

    public void setTotal_cost(double total_cost) {
        this.total_cost = total_cost;
    }

    public PaymentMethod getPayment_method() {
        return payment_method;
    }

    public void setPayment_method(PaymentMethod payment_method) {
        this.payment_method = payment_method;
    }

    public Date getDate_paid() {
        return date_paid;
    }

    public void setDate_paid(Date date_paid) {
        this.date_paid = date_paid;
    }
}
