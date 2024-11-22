import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.SessionFactory;


public class DBConnection {
    private static SessionFactory factory;

    static
    {
        final StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();

        try
        {
            factory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
        }
        catch (Exception e)
        {
            // Log the error to understand the cause
            System.err.println("Error building SessionFactory: " + e.getMessage());
            e.printStackTrace();  // Log stack trace
            StandardServiceRegistryBuilder.destroy(registry); // Destroy registry to clean up resources
        }
    }

    public static SessionFactory getFactory()
    {
        return factory;
    }

    public static void closeConnection()
    {
        if (factory != null)
        {
            factory.close();
        }
    }
}