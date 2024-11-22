import model.entities.*;
import model.enumerations.Gender;

import java.time.LocalDate;

public class Driver {
    public static void main(String[] args)
    {
        var insuranceService = CRUDFactory.getRefInsuranceinfo();
        var patientService = CRUDFactory.getPatient();

        var insurance = insuranceService.read("Sun Life");

//        Patient patient = new Patient();
//        patient.setLastName("Ho");
//        patient.setFirstName("Denise Liana");
//        patient.setMiddleName("Parana");
//        patient.setDateOfBirth(LocalDate.now());
//        patient.setGender(Gender.F);
//        patient.setContactNumber("09167646283");
//        patient.setStreet("B18 L 8 Valencia St.");
//        patient.setCity("Bacoor");
//        patient.setProvince("Cavite");
//        patient.setZipCode(4102);


//        patientService.create(patient);
    }
}