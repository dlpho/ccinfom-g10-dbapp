public class REFInsuranceInfo {
    private String insurance_provider;
    private double pct_coverage;
    private double min_amount;

    private Patient patient;

    public String getInsurance_provider() {
        return insurance_provider;
    }

    public void setInsurance_provider(String insurance_provider) {
        this.insurance_provider = insurance_provider;
    }

    public double getPct_coverage() {
        return pct_coverage;
    }

    public void setPct_coverage(double pct_coverage) {
        this.pct_coverage = pct_coverage;
    }

    public double getMin_amount() {
        return min_amount;
    }

    public void setMin_amount(double min_amount) {
        this.min_amount = min_amount;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }
}
