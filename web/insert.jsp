<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if the user is logged in as a teacher
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("teacher")) {
        response.sendRedirect("index.jsp?error=Access Denied! Please log in as a teacher.");
        return;
    }
%>
<html>
<head>
    <title>Insert Student Details</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f7f6; margin: 0; padding: 20px; }
        .container { background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); max-width: 450px; margin: 30px auto; }
        h2 { color: #333; text-align: center; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #666; font-weight: bold; }
        input[type="text"], input[type="number"], input[type="file"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn { width: 100%; padding: 12px; background-color: #4CAF50; border: none; border-radius: 4px; color: white; font-size: 16px; cursor: pointer; margin-top: 10px; }
        .btn-logout { background-color: #f44336; margin-top: 10px; }
        .message { padding: 10px; border-radius: 4px; margin-bottom: 15px; text-align: center; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .nav-links { display: flex; justify-content: space-between; margin-top: 20px; font-size: 14px; }
        .nav-links a { color: #2196F3; text-decoration: none; }
    </style>
</head>
<body>
<div class="container">
    <h2>Insert Student Record</h2>
    
    <%
        String msg = request.getParameter("msg");
        String error = request.getParameter("error");
        if (msg != null) {
    %>
        <div class="message success"><%= msg %></div>
    <%
        } else if (error != null) {
    %>
        <div class="message error"><%= error %></div>
    <%
        }
    %>

    <form action="StudentServlet" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="id">Student ID (Optional / Auto-generated):</label>
            <input type="number" id="id" name="id" placeholder="Leave blank for auto-increment">
        </div>
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="age">Age:</label>
            <input type="number" id="age" name="age" min="1" max="150" required>
        </div>
        <div class="form-group">
            <label for="marks">Marks:</label>
            <input type="text" id="marks" name="marks" required>
        </div>
        <div class="form-group">
            <label for="image">Student Photo (Image):</label>
            <input type="file" id="image" name="image" accept="image/*" required>
        </div>
        <button type="submit" class="btn">Insert Student</button>
    </form>

    <div class="nav-links">
        <a href="view_students.jsp">View All Students</a>
        <a href="LogoutServlet" style="color: red;">Logout</a>
    </div>
</div>
</body>
</html>
