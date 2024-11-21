import model.entities.*;
import model.enumerations.Gender;
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
}
