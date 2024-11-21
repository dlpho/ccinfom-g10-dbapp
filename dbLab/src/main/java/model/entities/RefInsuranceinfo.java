package model.entities;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "ref_insuranceinfo", schema = "diagnosticsdb")
public class RefInsuranceinfo {
    @Id
    @Column(name = "insurance_provider", nullable = false, length = 45)
    private String insuranceProvider;

    @Column(name = "pct_coverage", nullable = false, precision = 3, scale = 2)
    private BigDecimal pctCoverage;

    @Column(name = "min_amount", nullable = false)
    private Double minAmount;

    @OneToMany(mappedBy = "insuranceProvider")
    private Set<Patient> patients = new LinkedHashSet<>();

    public String getInsuranceProvider() {
        return insuranceProvider;
    }

    public void setInsuranceProvider(String insuranceProvider) {
        this.insuranceProvider = insuranceProvider;
    }

    public BigDecimal getPctCoverage() {
        return pctCoverage;
    }

    public void setPctCoverage(BigDecimal pctCoverage) {
        this.pctCoverage = pctCoverage;
    }

    public Double getMinAmount() {
        return minAmount;
    }

    public void setMinAmount(Double minAmount) {
        this.minAmount = minAmount;
    }

    public Set<Patient> getPatients() {
        return patients;
    }

    public void setPatients(Set<Patient> patients) {
        this.patients = patients;
    }

}