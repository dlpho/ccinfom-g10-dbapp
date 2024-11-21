package model.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import org.hibernate.Hibernate;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class ResultId implements Serializable {
    private static final long serialVersionUID = -850915538142445629L;
    @Column(name = "appointment_id", nullable = false)
    private Integer appointmentId;

    @Column(name = "test_type", nullable = false, length = 5)
    private String testType;

    public Integer getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(Integer appointmentId) {
        this.appointmentId = appointmentId;
    }

    public String getTestType() {
        return testType;
    }

    public void setTestType(String testType) {
        this.testType = testType;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        ResultId entity = (ResultId) o;
        return Objects.equals(this.appointmentId, entity.appointmentId) &&
                Objects.equals(this.testType, entity.testType);
    }

    @Override
    public int hashCode() {
        return Objects.hash(appointmentId, testType);
    }

}