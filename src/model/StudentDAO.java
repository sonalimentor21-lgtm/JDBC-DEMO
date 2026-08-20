package model;

import java.io.ByteArrayInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class StudentDAO {
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

    public boolean insertStudent(Student student) throws SQLException {
        String query = "INSERT INTO students (id, name, age, marks, image) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, student.getId());
            pstmt.setString(2, student.getName());
            pstmt.setInt(3, student.getAge());
            pstmt.setDouble(4, student.getMarks());
            
            if (student.getImage() != null && student.getImage().length > 0) {
                pstmt.setBinaryStream(5, new ByteArrayInputStream(student.getImage()), student.getImage().length);
            } else {
                pstmt.setNull(5, java.sql.Types.BLOB);
            }

            return pstmt.executeUpdate() > 0;
        }
    }

    public List<Student> getAllStudents() throws SQLException {
        List<Student> list = new ArrayList<>();
        String query = "SELECT id, name, age, marks, image FROM students";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Student s = new Student();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setAge(rs.getInt("age"));
                s.setMarks(rs.getDouble("marks"));
                
                byte[] imgBytes = rs.getBytes("image");
                if (imgBytes != null && imgBytes.length > 0) {
                    s.setImage(imgBytes);
                    s.setBase64Image(Base64.getEncoder().encodeToString(imgBytes));
                }
                list.add(s);
            }
        }
        return list;
    }
}
