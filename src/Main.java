import java.io.File;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Main {

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
        try (Connection connection = DriverManager.getConnection(url, username, password);
             Statement statement = connection.createStatement()) {

            // 1. Add the image column if it doesn't exist
            try {
                statement.executeUpdate("ALTER TABLE students ADD COLUMN image LONGBLOB");
                System.out.println("Column 'image' added successfully.");
            } catch (SQLException e) {
                // Error 1060 is "Duplicate column name" in MySQL
                if (e.getErrorCode() == 1060) {
                    System.out.println("Column 'image' already exists.");
                } else {
                    throw e;
                }
            }

            // 2. Clear old test data with ID 101 to allow clean insert
            statement.executeUpdate("DELETE FROM students WHERE id = 101");

            // 3. Read image file and convert it to hex for Statement insert
            File imgFile = new File("resources/student_placeholder.png");
            if (!imgFile.exists()) {
                System.out.println("Error: resources/student_placeholder.png not found.");
                return;
            }
            byte[] fileBytes = Files.readAllBytes(imgFile.toPath());
            String hexImage = bytesToHex(fileBytes);

            // 4. Insert data using standard Statement
            String insertQuery = "INSERT INTO students (id, name, age, marks, image) VALUES (101, 'Alice', 20, 85.5, 0x" + hexImage + ")";
            int rowsAffected = statement.executeUpdate(insertQuery);
            System.out.println("Rows inserted: " + rowsAffected);

            // 5. Describe table to confirm the new column exists
            try (ResultSet resultSet = statement.executeQuery("DESCRIBE students")) {
                System.out.println("\n--- Table Description ---");
                System.out.printf("%-15s %-15s %-10s %-10s %-10s %-15s%n", "Field", "Type", "Null", "Key", "Default", "Extra");
                System.out.println("--------------------------------------------------------------------------------");
                while (resultSet.next()) {
                    System.out.printf("%-15s %-15s %-10s %-10s %-10s %-15s%n",
                            resultSet.getString("Field"),
                            resultSet.getString("Type"),
                            resultSet.getString("Null"),
                            resultSet.getString("Key") == null ? "" : resultSet.getString("Key"),
                            resultSet.getString("Default") == null ? "" : resultSet.getString("Default"),
                            resultSet.getString("Extra") == null ? "" : resultSet.getString("Extra"));
                }
            }

            // 6. Verify inserted data
            try (ResultSet resultSet = statement.executeQuery("SELECT id, name, age, marks, OCTET_LENGTH(image) as img_size FROM students WHERE id = 101")) {
                System.out.println("\n--- Inserted Data Verification ---");
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

    private static String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }
}
