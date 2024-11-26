import model.entities.*;
import model.enumerations.*;
import model.enumerations.StaffRole;
import org.hibernate.Session;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

import org.hibernate.SessionFactory;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.time.LocalDate;

public class TestCURD {

    private SessionFactory sessionFactory;

    @BeforeEach
    protected void setUp() throws Exception {
        final StandardServiceRegistry registry = new StandardServiceRegistryBuilder()
                .configure() // configures settings from hibernate.cfg.xml
                .build();
        try {
            sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
        } catch (Exception e) {
            // Log the error to understand the cause
            System.err.println("Error building SessionFactory: " + e.getMessage());
            e.printStackTrace();  // Log stack trace
            StandardServiceRegistryBuilder.destroy(registry); // Destroy registry to clean up resources
        }
    }


    @AfterEach
    protected void tearDown() throws Exception {
        if ( sessionFactory != null ) {
            sessionFactory.close();
        }
    }

    @SuppressWarnings("unchecked")
    @Test
    public void save_patient() {
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            // thing
            RefInsuranceinfo insuranceInfo = session.get(RefInsuranceinfo.class, "Sun Life");
            Patient patient = new Patient("Ho", "Denise Liana", "Parana", LocalDate.now(), Gender.F, "09167646283", "B18 L 8 Valencia St.", "Bacoor", "Cavite", 4102, insuranceInfo);

            session.persist(patient);
            session.getTransaction().commit();
            System.out.println("Success added.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testConnection() {
        try (Session session = sessionFactory.openSession()) {
            // Attempt to start a transaction and perform a simple operation
            session.beginTransaction();
            // You can perform any operation here like querying an entity or checking metadata
            System.out.println("SessionFactory connection is good.");
            session.getTransaction().commit();
        } catch (Exception e) {
            System.err.println("SessionFactory connection failed: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Test
    public void tryThis(){
        System.out.println(StaffRole.ADMINISTRATOR);
    }

    @Test
    public void matchPatient() {
        int patientId = 1001;
        System.out.println(Gender.F);

        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            Patient patient = session.get(Patient.class, patientId);  // Retrieve patient by ID
            session.getTransaction().commit();
            if (patient != null) {
                System.out.println("Patient ID: " + patient.getId());
                System.out.println("Name: " + patient.getFirstName() + " " + patient.getMiddleName() + " " + patient.getLastName());// Convert code to String
                System.out.println("Gender: " + patient.getGender().toString());
                System.out.println("Contact Number: " + patient.getContactNumber());
                System.out.println("Address: " + patient.getStreet() + ", " + patient.getCity() + ", " + patient.getProvince() + ", " + patient.getZipCode());
            }
        } catch (Exception e) {
            e.printStackTrace();  // Log any exceptions
        }
    }

}
