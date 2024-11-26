package model.entities;

import jakarta.persistence.*;
import model.enumerations.ResultOutcome;
import model.enumerations.ResultStatus;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "results", schema = "diagnosticsdb", indexes = {
        @Index(name = "fk_Results_Appointments2_idx", columnList = "appointment_id"),
        @Index(name = "fk_Results_Tests2_idx", columnList = "test_type"),
        @Index(name = "fk_Results_Staff2_idx", columnList = "staff_id")
})
public class Result {
    @EmbeddedId
    private ResultId id;

    @MapsId("appointmentId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "appointment_id", nullable = false)
    private Appointment appointment;

    @MapsId("testType")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "test_type", nullable = false)
    private Test testType;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "staff_id", nullable = false)
    private Staff staff;

    @ColumnDefault("'N/A'")
    @Enumerated(EnumType.STRING)
    @Column(name = "outcome", nullable = false)
    private ResultOutcome outcome;

    @ColumnDefault("''")
    @Column(name = "comments", nullable = false, length = 256)
    private String comments;

    @ColumnDefault("'Pending'")
    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private ResultStatus status;

    public ResultId getId() {
        return id;
    }

    public void setId(ResultId id) {
        this.id = id;
    }

    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    public Test getTestType() {
        return testType;
    }

    public void setTestType(Test testType) {
        this.testType = testType;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public ResultOutcome getOutcome() {
        return outcome;
    }

    public void setOutcome(ResultOutcome outcome) {
        this.outcome = outcome;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public ResultStatus getStatus() {
        return status;
    }

    public void setStatus(ResultStatus status) {
        this.status = status;
    }

}