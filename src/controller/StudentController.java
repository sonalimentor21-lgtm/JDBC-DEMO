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
        // List students and forward to view.jsp (viewable by anyone: teacher or student)
        try {
            List<Student> list = studentDAO.getAllStudents();
            request.setAttribute("studentsList", list);
            request.getRequestDispatcher("jsp/view.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error retrieving students", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("insert".equals(action)) {
            HttpSession session = request.getSession(false);
            boolean isTeacher = (session != null && "teacher".equals(session.getAttribute("role")));
            String redirectTarget = isTeacher ? "jsp/dashboard.jsp" : "jsp/student_entry.jsp";

            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                int age = Integer.parseInt(request.getParameter("age"));
                double marks = Double.parseDouble(request.getParameter("marks"));
                String email = request.getParameter("email");
                String course = request.getParameter("course");
                
                Part filePart = request.getPart("image");
                byte[] imageBytes = null;
                if (filePart != null && filePart.getSize() > 0) {
                    try (InputStream is = filePart.getInputStream()) {
                        imageBytes = is.readAllBytes();
                    }
                }

                Student student = new Student(id, name, age, marks, imageBytes, email, course);
                boolean success = studentDAO.insertStudent(student);

                if (success) {
                    response.sendRedirect(redirectTarget + "?msg=success");
                } else {
                    response.sendRedirect(redirectTarget + "?msg=error");
                }
            } catch (Exception e) {
                response.sendRedirect(redirectTarget + "?msg=error&detail=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
                e.printStackTrace();
            }
        }
    }
}
