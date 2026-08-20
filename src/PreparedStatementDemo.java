import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class PreparedStatementDemo {

    private static final String url = "jdbc:mysql://localhost:3306/mydb";
    private static final String username = "root";
    private static final String password = "sonali123@";

    public static void main(String[] args) {
        // Load JDBC driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        // Connection
        try (Connection connection = DriverManager.getConnection(url, username, password)) {
            
            // 1. Clear old test data with ID 102 to allow clean insert
            try (Statement statement = connection.createStatement()) {
                statement.executeUpdate("DELETE FROM students WHERE id = 102");
            }

            // 2. Prepare the insert query with PreparedStatement placeholders
            String insertQuery = "INSERT INTO students (id, name, age, marks, image) VALUES (?, ?, ?, ?, ?)";
            
            File imgFile = new File("resources/student_placeholder.png");
            if (!imgFile.exists()) {
                System.out.println("Error: resources/student_placeholder.png not found.");
                return;
            }

            try (PreparedStatement pstmt = connection.prepareStatement(insertQuery);
                 FileInputStream fis = new FileInputStream(imgFile)) {
                
                pstmt.setInt(1, 102);
                pstmt.setString(2, "Bob");
                pstmt.setInt(3, 22);
                pstmt.setDouble(4, 90.0);
                // setBinaryStream directly streams the file into the database blob field
                pstmt.setBinaryStream(5, fis, (int) imgFile.length());

                int rowsAffected = pstmt.executeUpdate();
                System.out.println("Inserted student using PreparedStatement.");
                System.out.println("Rows inserted: " + rowsAffected);
            }

            // 3. Verify inserted data
            try (Statement stmt = connection.createStatement();
                 ResultSet resultSet = stmt.executeQuery("SELECT id, name, age, marks, OCTET_LENGTH(image) as img_size FROM students WHERE id = 102")) {
                System.out.println("\n--- Inserted Data Verification (PreparedStatement) ---");
                if (resultSet.next()) {
                    System.out.println("ID: " + resultSet.getInt("id"));
                    System.out.println("Name: " + resultSet.getString("name"));
                    System.out.println("Age: " + resultSet.getInt("age"));
                    System.out.println("Marks: " + resultSet.getDouble("marks"));
                    System.out.println("Image Size (bytes): " + resultSet.getInt("img_size"));
                }
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
