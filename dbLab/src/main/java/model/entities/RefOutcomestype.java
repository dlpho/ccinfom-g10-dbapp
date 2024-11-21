package model.entities;

import jakarta.persistence.*;

import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "ref_outcomestypes", schema = "diagnosticsdb")
public class RefOutcomestype {
    @Id
    @Column(name = "outcome_type", nullable = false)
    private Byte id;

    @OneToMany(mappedBy = "outcomeType")
    private Set<RefOutcome> refOutcomes = new LinkedHashSet<>();

    @OneToMany(mappedBy = "outcomeType")
    private Set<Test> tests = new LinkedHashSet<>();

    public Byte getId() {
        return id;
    }

    public void setId(Byte id) {
        this.id = id;
    }

    public Set<RefOutcome> getRefOutcomes() {
        return refOutcomes;
    }

    public void setRefOutcomes(Set<RefOutcome> refOutcomes) {
        this.refOutcomes = refOutcomes;
    }

    public Set<Test> getTests() {
        return tests;
    }

    public void setTests(Set<Test> tests) {
        this.tests = tests;
    }

}