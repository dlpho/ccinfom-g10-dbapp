import enumerations.ResultOutcome;
import enumerations.ResultStatus;

public class Result {
    private int result_id;
    private ResultOutcome outcome;
    private String comments;
    private ResultStatus status;

    private Appointment appointment;
    private Staff staff;
    private Test test;

    public int getResult_id() {
        return result_id;
    }

    public void setResult_id(int result_id) {
        this.result_id = result_id;
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

    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public Test getTest() {
        return test;
    }

    public void setTest(Test test) {
        this.test = test;
    }
}
