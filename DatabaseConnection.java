import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Single database connection instance.
 * Ensures that only one instance of the database connection 
 * is created throught the application lifecycle.
 */
public class DatabaseConnection {
        
    private static DatabaseConnection instance;
    private Connection connection;

    // Database connection fields
    private final String url = "";  // "jdbc:mysql://localhost:3306/database_name"
    private final String user = ""; // "username"
    private final String password = ""; // "password"

    /**
     * Private constructor 
     * Establish a connection to the database
     * 
     * @throws RuntimeException if the JDBC driver is not found or if connections fails.
     */
    private DatabaseConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(url, user, password);
        } catch(ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Connection failed", e);
        }
    }

    /**
     * Provides a single instance to DatabaseConnection class.
     * If instance is null, it initialize a new one.
     * 
     * @return single instance of the DatabaseConnection.
     */
    public static DatabaseConnection getInstance() {
        if(instance == null)
            instance = new DatabaseConnection();

        return instance;
    }

    /**
     * Provides active database connection
     * 
     * @return {@link Connection} object.
     */
    public Connection getConnection() {
        return this.connection;
    }

    /**
     * Closes the active database connection.
     * Ensures that the connection is properly closed.
     */
    public void closeConnection() {
        try {
            if(connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            connection = null;
        }
    }
}