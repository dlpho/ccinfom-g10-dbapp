package model.entities;

import model.enumerations.*;
import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;

@Entity
@Table(name = "payment", schema = "diagnosticsdb", indexes = {
        @Index(name = "order_id_idx", columnList = "appointment_id")
})
public class Payment {
    @Id
    @Column(name = "payment_id", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "appointment_id", nullable = false)
    private Appointment appointment;

    @Column(name = "total_cost", nullable = false)
    private Double totalCost;

    @Lob
    @Column(name = "payment_method", nullable = false)
    private PaymentMethod paymentMethod;

    @ColumnDefault("'9999-01-01 00:00:00'")
    @Column(name = "date_paid", nullable = false)
    private Instant datePaid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    public Double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(Double totalCost) {
        this.totalCost = totalCost;
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Instant getDatePaid() {
        return datePaid;
    }

    public void setDatePaid(Instant datePaid) {
        this.datePaid = datePaid;
    }

}