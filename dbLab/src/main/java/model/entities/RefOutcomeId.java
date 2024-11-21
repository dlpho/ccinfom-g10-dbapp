package model.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import model.enumerations.ResultOutcome;
import org.hibernate.Hibernate;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class RefOutcomeId implements Serializable {
    private static final long serialVersionUID = 3319169700294804535L;
    @Column(name = "outcome", nullable = false, length = 45)
    private ResultOutcome outcome;

    @Column(name = "outcome_type", nullable = false)
    private Byte outcomeType;

    public ResultOutcome getOutcome() {
        return outcome;
    }

    public void setOutcome(ResultOutcome outcome) {
        this.outcome = outcome;
    }

    public Byte getOutcomeType() {
        return outcomeType;
    }

    public void setOutcomeType(Byte outcomeType) {
        this.outcomeType = outcomeType;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        RefOutcomeId entity = (RefOutcomeId) o;
        return Objects.equals(this.outcomeType, entity.outcomeType) &&
                Objects.equals(this.outcome, entity.outcome);
    }

    @Override
    public int hashCode() {
        return Objects.hash(outcomeType, outcome);
    }

}