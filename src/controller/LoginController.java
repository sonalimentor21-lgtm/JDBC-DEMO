package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        // Authenticate teacher
        if ("teacher".equals(user) && "teacher123".equals(pass)) {
            HttpSession session = request.getSession();
            session.setAttribute("role", "teacher");
            response.sendRedirect("jsp/dashboard.jsp");
        } else {
            response.sendRedirect("jsp/login.jsp?error=1");
        }
    }
}
