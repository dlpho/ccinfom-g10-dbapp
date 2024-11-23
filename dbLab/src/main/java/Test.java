import java.util.List;

public class Test {
    private String test_type;
    private String test_name;
    private double test_cost;
    private int days_valid;

    private List<Result> results;
    private Equipment equipment;
    private REFOutcomeType outcome_type;

    public String getTest_type() {
        return test_type;
    }

    public void setTest_type(String test_type) {
        this.test_type = test_type;
    }

    public String getTest_name() {
        return test_name;
    }

    public void setTest_name(String test_name) {
        this.test_name = test_name;
    }

    public Equipment getEquipment() {
        return equipment;
    }


    public void setTest_cost(double test_cost) {
        this.test_cost = test_cost;
    }

    public int getDays_valid() {
        return days_valid;
    }

    public void setDays_valid(int days_valid) {
        this.days_valid = days_valid;
    }

    public List<Result> getResults() {
        return results;
    }

    public void setResults(List<Result> results) {
        this.results = results;
    }

    public void setEquipment(Equipment equipment) {
        this.equipment = equipment;
    }

    public double getTest_cost() {
        return test_cost;
    }

    public REFOutcomeType getOutcome_type() {
        return outcome_type;
    }

    public void setOutcome_type(REFOutcomeType outcome_type) {
        this.outcome_type = outcome_type;
    }
}
