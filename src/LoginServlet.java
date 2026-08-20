import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        // Simple check: allow "teacher" with password "teacher123"
        if ("teacher".equals(user) && "teacher123".equals(pass)) {
            HttpSession session = request.getSession();
            session.setAttribute("role", "teacher");
            response.sendRedirect("insert.jsp");
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}
