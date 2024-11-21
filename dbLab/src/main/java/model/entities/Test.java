package model.entities;

import jakarta.persistence.*;

import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "tests", schema = "diagnosticsdb", indexes = {
        @Index(name = "fk_Tests_Equipment1_idx", columnList = "equip_name"),
        @Index(name = "fk_Tests_REF_ChoiceTypes1_idx", columnList = "outcome_type")
}, uniqueConstraints = {
        @UniqueConstraint(name = "test_name_UNIQUE", columnNames = {"test_name"})
})
public class Test {
    @Id
    @Column(name = "test_type", nullable = false, length = 5)
    private String testType;

    @Column(name = "test_name", nullable = false, length = 45)
    private String testName;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "equip_name", nullable = false)
    private Equipment equipName;

    @Column(name = "test_cost", nullable = false)
    private Double testCost;

    @Column(name = "days_valid", nullable = false)
    private Integer daysValid;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "outcome_type", nullable = false)
    private RefOutcomestype outcomeType;

    @OneToMany(mappedBy = "testType")
    private Set<Result> results = new LinkedHashSet<>();

    public String getTestType() {
        return testType;
    }

    public void setTestType(String testType) {
        this.testType = testType;
    }

    public String getTestName() {
        return testName;
    }

    public void setTestName(String testName) {
        this.testName = testName;
    }

    public Equipment getEquipName() {
        return equipName;
    }

    public void setEquipName(Equipment equipName) {
        this.equipName = equipName;
    }

    public Double getTestCost() {
        return testCost;
    }

    public void setTestCost(Double testCost) {
        this.testCost = testCost;
    }

    public Integer getDaysValid() {
        return daysValid;
    }

    public void setDaysValid(Integer daysValid) {
        this.daysValid = daysValid;
    }

    public RefOutcomestype getOutcomeType() {
        return outcomeType;
    }

    public void setOutcomeType(RefOutcomestype outcomeType) {
        this.outcomeType = outcomeType;
    }

    public Set<Result> getResults() {
        return results;
    }

    public void setResults(Set<Result> results) {
        this.results = results;
    }

}