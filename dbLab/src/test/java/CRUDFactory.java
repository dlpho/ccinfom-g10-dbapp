import model.entities.*;

public class CRUDFactory {

    public static CRUD<Appointment> getAppointment()
    {
        return new CRUD<>(Appointment.class);
    }

    public static CRUD<Equipment> getEquipment()
    {
        return new CRUD<>(Equipment.class);
    }

    public static CRUD<Patient> getPatient()
    {
        return new CRUD<>(Patient.class);
    }

    public static CRUD<Payment> getPayment()
    {
        return new CRUD<>(Payment.class);
    }

    public static CRUD<RefInsuranceinfo> getRefInsuranceinfo()
    {
        return new CRUD<>(RefInsuranceinfo.class);
    }

    public static CRUD<RefOutcome> getRefOutcome()
    {
        return new CRUD<>(RefOutcome.class);
    }

    public static CRUD<RefOutcomeId> getRefOutcomeId()
    {
        return new CRUD<>(RefOutcomeId.class);
    }

    public static CRUD<RefOutcomestype> getRefOutcomestype()
    {
        return new CRUD<>(RefOutcomestype.class);
    }

    public static CRUD<ResultId> getResultId()
    {
        return new CRUD<>(ResultId.class);
    }

    public static CRUD<Staff> getStaff()
    {
        return new CRUD<>(Staff.class);
    }

    public static CRUD<Test> getTest()
    {
        return new CRUD<>(Test.class);
    }
}
