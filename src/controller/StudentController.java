package controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Student;
import model.StudentDAO;

@WebServlet("/StudentController")
@MultipartConfig(maxFileSize = 16177215) // up to 16MB image size
public class StudentController extends HttpServlet {
    private StudentDAO studentDAO;

    public void init() {
        studentDAO = new StudentDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // List students and forward to view.jsp
        try {
            List<Student> list = studentDAO.getAllStudents();
            request.setAttribute("studentsList", list);
            request.getRequestDispatcher("jsp/view.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error retrieving students", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Verify teacher role
        HttpSession session = request.getSession(false);
        if (session == null || !"teacher".equals(session.getAttribute("role"))) {
            response.sendRedirect("jsp/login.jsp?error=Access Denied!");
            return;
        }

        String action = request.getParameter("action");
        if ("insert".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                int age = Integer.parseInt(request.getParameter("age"));
                double marks = Double.parseDouble(request.getParameter("marks"));
                
                Part filePart = request.getPart("image");
                byte[] imageBytes = null;
                if (filePart != null && filePart.getSize() > 0) {
                    try (InputStream is = filePart.getInputStream()) {
                        imageBytes = is.readAllBytes();
                    }
                }

                Student student = new Student(id, name, age, marks, imageBytes);
                boolean success = studentDAO.insertStudent(student);

                if (success) {
                    response.sendRedirect("jsp/dashboard.jsp?msg=success");
                } else {
                    response.sendRedirect("jsp/dashboard.jsp?msg=error");
                }
            } catch (Exception e) {
                response.sendRedirect("jsp/dashboard.jsp?msg=error&detail=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
            }
        }
    }
}
