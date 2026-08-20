<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student management system</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f7f6; margin: 0; padding: 0; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .container { background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); text-align: center; width: 350px; }
        h2 { color: #333; margin-bottom: 20px; }
        .btn { display: block; width: 100%; padding: 12px; margin: 10px 0; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; text-decoration: none; box-sizing: border-box; }
        .btn-teacher { background-color: #4CAF50; color: white; }
        .btn-student { background-color: #2196F3; color: white; }
        .error { color: red; margin-bottom: 15px; font-size: 14px; }
    </style>
</head>
<body>
<div class="container">
    <h2>Student Management</h2>
    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
        <div class="error"><%= error %></div>
    <%
        }
    %>
    <p>Please select your portal:</p>
    <a href="login.jsp" class="btn btn-teacher">Teacher Portal (Insert Data)</a>
    <a href="view_students.jsp" class="btn btn-student">Student Portal (View Data Only)</a>
</div>
</body>
</html>
