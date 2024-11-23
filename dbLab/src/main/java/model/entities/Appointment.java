package model.entities;
import jakarta.persistence.*;
import model.enumerations.AppointmentStatus;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;


import java.time.Instant;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "appointments", schema = "diagnosticsdb", indexes = {
        @Index(name = "patient_id_idx", columnList = "patient_id")
})
public class Appointment {
    @Id
    @Column(name = "appointment_id", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @Column(name = "num_tests", nullable = false)
    private Integer numTests;

    @Column(name = "order_date", nullable = false)
    private Instant orderDate;

    @Column(name = "scheduled_date", nullable = false)
    private Instant scheduledDate;

    @ColumnDefault("'9999-01-01 00:00:00'")
    @Column(name = "test_date", nullable = false)
    private Instant testDate;

    @Lob
    @Column(name = "status", nullable = false)
    private AppointmentStatus status;

    @OneToMany(mappedBy = "appointment")
    private Set<Payment> payments = new LinkedHashSet<>();

    @OneToMany(mappedBy = "appointment")
    private Set<Result> results = new LinkedHashSet<>();

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public Integer getNumTests() {
        return numTests;
    }

    public void setNumTests(Integer numTests) {
        this.numTests = numTests;
    }

    public Instant getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Instant orderDate) {
        this.orderDate = orderDate;
    }

    public Instant getScheduledDate() {
        return scheduledDate;
    }

    public void setScheduledDate(Instant scheduledDate) {
        this.scheduledDate = scheduledDate;
    }

    public Instant getTestDate() {
        return testDate;
    }

    public void setTestDate(Instant testDate) {
        this.testDate = testDate;
    }

    public AppointmentStatus getStatus() {
        return status;
    }

    public void setStatus(AppointmentStatus status) {
        this.status = status;
    }

    public Set<Payment> getPayments() {
        return payments;
    }

    public void setPayments(Set<Payment> payments) {
        this.payments = payments;
    }

    public Set<Result> getResults() {
        return results;
    }

    public void setResults(Set<Result> results) {
        this.results = results;
    }

}