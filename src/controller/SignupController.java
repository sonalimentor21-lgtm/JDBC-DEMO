package controller;

import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Teacher;
import model.TeacherDAO;

@WebServlet("/SignupController")
public class SignupController extends HttpServlet {
    private TeacherDAO teacherDAO;

    public void init() {
        teacherDAO = new TeacherDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Teacher teacher = new Teacher(0, name, email, password);

        try {
            boolean success = teacherDAO.registerTeacher(teacher);
            if (success) {
                response.sendRedirect("jsp/login.jsp?msg=signup_success");
            } else {
                response.sendRedirect("jsp/signup.jsp?error=failed");
            }
        } catch (SQLException e) {
            response.sendRedirect("jsp/signup.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
            e.printStackTrace();
        }
    }
}
