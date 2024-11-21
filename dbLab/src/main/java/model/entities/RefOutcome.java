package model.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "ref_outcomes", schema = "diagnosticsdb", indexes = {
        @Index(name = "fk_REF_Outcomes_REF_OutcomesTypes1_idx", columnList = "outcome_type")
})
public class RefOutcome {
    @EmbeddedId
    private RefOutcomeId id;

    @MapsId("outcomeType")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "outcome_type", nullable = false)
    private RefOutcomestype outcomeType;

    public RefOutcomeId getId() {
        return id;
    }

    public void setId(RefOutcomeId id) {
        this.id = id;
    }

    public RefOutcomestype getOutcomeType() {
        return outcomeType;
    }

    public void setOutcomeType(RefOutcomestype outcomeType) {
        this.outcomeType = outcomeType;
    }

}