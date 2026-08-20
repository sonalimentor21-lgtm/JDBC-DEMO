package controller;

import java.io.IOException;
import java.util.Base64;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Teacher;
import model.TeacherDAO;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    private TeacherDAO teacherDAO;

    public void init() {
        teacherDAO = new TeacherDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String googleCredential = request.getParameter("credential");

        try {
            if (googleCredential != null && !googleCredential.trim().isEmpty()) {
                // 1. Handle Google Sign-In Authentication
                String[] jwtParts = googleCredential.split("\\.");
                if (jwtParts.length >= 2) {
                    String payloadJson = new String(Base64.getUrlDecoder().decode(jwtParts[1]), "UTF-8");
                    String email = extractJsonField(payloadJson, "email");
                    String name = extractJsonField(payloadJson, "name");

                    if (email != null && name != null) {
                        Teacher teacher = teacherDAO.registerOrGetGoogleTeacher(name, email);
                        if (teacher != null) {
                            HttpSession session = request.getSession();
                            session.setAttribute("role", "teacher");
                            session.setAttribute("teacherName", teacher.getName());
                            response.sendRedirect("jsp/dashboard.jsp");
                            return;
                        }
                    }
                }
                response.sendRedirect("jsp/login.jsp?error=google_failed");
            } else {
                // 2. Handle Custom Credentials Authentication
                String email = request.getParameter("email");
                String pass = request.getParameter("password");

                Teacher teacher = teacherDAO.authenticate(email, pass);
                if (teacher != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("role", "teacher");
                    session.setAttribute("teacherName", teacher.getName());
                    response.sendRedirect("jsp/dashboard.jsp");
                } else {
                    response.sendRedirect("jsp/login.jsp?error=invalid_credentials");
                }
            }
        } catch (Exception e) {
            response.sendRedirect("jsp/login.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
            e.printStackTrace();
        }
    }

    private String extractJsonField(String json, String field) {
        String pattern = "\"" + field + "\":\"";
        int index = json.indexOf(pattern);
        if (index == -1) {
            return null;
        }
        int start = index + pattern.length();
        int end = json.indexOf("\"", start);
        if (end == -1) return null;
        return json.substring(start, end);
    }
}
