<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Verify login session
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("teacher")) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
%>
<html>
<head>
    <title>Teacher Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f7f6; margin: 0; padding: 20px; }
        .container { background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); max-width: 500px; margin: 40px auto; box-sizing: border-box; }
        h2 { color: #333; text-align: center; margin-top: 0; margin-bottom: 25px; }
        .form-group { margin-bottom: 18px; }
        label { display: block; margin-bottom: 6px; color: #555; font-weight: bold; font-size: 14px; }
        input[type="text"], input[type="number"], input[type="file"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 14px; }
        .btn { width: 100%; padding: 12px; background-color: #4CAF50; border: none; border-radius: 4px; color: white; font-size: 16px; font-weight: bold; cursor: pointer; display: block; text-align: center; text-decoration: none; box-sizing: border-box; margin-top: 15px; }
        .btn-view { background-color: #2196F3; }
        .btn-logout { background-color: #f44336; }
        .alert { padding: 12px; border-radius: 4px; margin-bottom: 20px; text-align: center; font-weight: bold; }
        .alert-success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .header-bar { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee; padding-bottom: 15px; margin-bottom: 20px; }
        .header-bar span { font-weight: bold; color: #666; }
    </style>
</head>
<body>
<div class="container">
    <div class="header-bar">
        <span>Logged in as: Teacher</span>
        <a href="../LogoutController" style="color: #f44336; text-decoration: none; font-weight: bold;">Logout</a>
    </div>
    
    <h2>Student Insertion Portal</h2>

    <%
        String msg = request.getParameter("msg");
        String detail = request.getParameter("detail");
        if ("success".equals(msg)) {
    %>
        <div class="alert alert-success">
            Record successfully saved!
            <a href="../StudentController" class="btn btn-view">View Updated Student Table</a>
        </div>
    <%
        } else if ("error".equals(msg)) {
    %>
        <div class="alert alert-error">
            Failed to save record. <%= (detail != null) ? detail : "" %>
        </div>
    <%
        }
    %>

    <form action="../StudentController?action=insert" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="id">Student ID:</label>
            <input type="number" id="id" name="id" placeholder="Enter student ID" required>
        </div>
        <div class="form-group">
            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name" placeholder="Enter name" required>
        </div>
        <div class="form-group">
            <label for="age">Age:</label>
            <input type="number" id="age" name="age" min="5" max="100" placeholder="Enter age" required>
        </div>
        <div class="form-group">
            <label for="marks">Marks:</label>
            <input type="text" id="marks" name="marks" placeholder="Enter marks (e.g. 85.50)" required>
        </div>
        <div class="form-group">
            <label for="image">Upload Student Image:</label>
            <input type="file" id="image" name="image" accept="image/*" required>
        </div>
        <button type="submit" class="btn">Submit Data</button>
    </form>

    <a href="../StudentController" class="btn btn-view" style="margin-top: 10px;">Go to Student Records Directory</a>
</div>
</body>
</html>
