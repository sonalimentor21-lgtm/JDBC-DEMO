package model;

import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

public class TeacherDAO {
    private static final String url = "jdbc:mysql://localhost:3306/mydb";
    private static final String username = "root";
    private static final String password = "sonali123@";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }

    public static String hashPassword(String base) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(base.getBytes("UTF-8"));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }

    public boolean registerTeacher(Teacher teacher) throws SQLException {
        String query = "INSERT INTO teachers (name, email, password) VALUES (?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, teacher.getName());
            pstmt.setString(2, teacher.getEmail());
            pstmt.setString(3, hashPassword(teacher.getPassword()));
            
            return pstmt.executeUpdate() > 0;
        }
    }

    public Teacher findByEmail(String email) throws SQLException {
        String query = "SELECT id, name, email, password FROM teachers WHERE email = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Teacher(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password")
                    );
                }
            }
        }
        return null;
    }

    public Teacher authenticate(String email, String rawPassword) throws SQLException {
        Teacher teacher = findByEmail(email);
        if (teacher != null) {
            String dbHashedPassword = teacher.getPassword();
            String inputHashedPassword = hashPassword(rawPassword);
            if (dbHashedPassword.equals(inputHashedPassword)) {
                return teacher;
            }
        }
        return null;
    }

    public Teacher registerOrGetGoogleTeacher(String name, String email) throws SQLException {
        Teacher teacher = findByEmail(email);
        if (teacher != null) {
            return teacher;
        }
        // Create a new teacher if this is their first time logging in with Google
        String randomPassword = UUID.randomUUID().toString(); // Random secure password for Google users
        Teacher newTeacher = new Teacher(0, name, email, randomPassword);
        registerTeacher(newTeacher);
        return findByEmail(email);
    }
}
