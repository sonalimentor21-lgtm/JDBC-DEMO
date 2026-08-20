import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/StudentServlet")
@MultipartConfig(maxFileSize = 16177215) // upload file up to 16MB
public class StudentServlet extends HttpServlet {

    private static final String url = "jdbc:mysql://localhost:3306/mydb";
    private static final String username = "root";
    private static final String password = "sonali123@";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Double-check security
        HttpSession session = request.getSession(false);
        if (session == null || !"teacher".equals(session.getAttribute("role"))) {
            response.sendRedirect("index.jsp?error=Unauthorized access!");
            return;
        }

        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String ageStr = request.getParameter("age");
        String marksStr = request.getParameter("marks");
        
        Part filePart = request.getPart("image");
        InputStream inputStream = null;
        if (filePart != null) {
            inputStream = filePart.getInputStream();
        }

        boolean hasId = idStr != null && !idStr.trim().isEmpty();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, username, password)) {
                
                String query;
                if (hasId) {
                    query = "INSERT INTO students (id, name, age, marks, image) VALUES (?, ?, ?, ?, ?)";
                } else {
                    query = "INSERT INTO students (name, age, marks, image) VALUES (?, ?, ?, ?)";
                }

                try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                    int age = Integer.parseInt(ageStr);
                    double marks = Double.parseDouble(marksStr);

                    if (hasId) {
                        pstmt.setInt(1, Integer.parseInt(idStr));
                        pstmt.setString(2, name);
                        pstmt.setInt(3, age);
                        pstmt.setDouble(4, marks);
                        if (inputStream != null && filePart.getSize() > 0) {
                            pstmt.setBinaryStream(5, inputStream, (int) filePart.getSize());
                        } else {
                            pstmt.setNull(5, java.sql.Types.BLOB);
                        }
                    } else {
                        pstmt.setString(1, name);
                        pstmt.setInt(2, age);
                        pstmt.setDouble(3, marks);
                        if (inputStream != null && filePart.getSize() > 0) {
                            pstmt.setBinaryStream(4, inputStream, (int) filePart.getSize());
                        } else {
                            pstmt.setNull(4, java.sql.Types.BLOB);
                        }
                    }

                    int row = pstmt.executeUpdate();
                    if (row > 0) {
                        response.sendRedirect("insert.jsp?msg=Student record inserted successfully!");
                    } else {
                        response.sendRedirect("insert.jsp?error=Failed to insert record.");
                    }
                }
            }
        } catch (Exception e) {
            response.sendRedirect("insert.jsp?error=Database error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
        }
    }
}
