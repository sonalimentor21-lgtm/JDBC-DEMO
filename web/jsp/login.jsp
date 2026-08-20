<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Teacher Login</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f7f6; margin: 0; padding: 0; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .container { background-color: #fff; padding: 35px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); width: 340px; box-sizing: border-box; }
        h2 { color: #333; text-align: center; margin-top: 0; margin-bottom: 25px; font-weight: 600; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #555; font-weight: bold; font-size: 14px; }
        input[type="password"], input[type="text"] { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 14px; }
        .btn { width: 100%; padding: 12px; background-color: #2196F3; border: none; border-radius: 4px; color: white; font-size: 16px; font-weight: bold; cursor: pointer; transition: background-color 0.2s; }
        .btn:hover { background-color: #0b7dda; }
        .error { color: #d9534f; text-align: center; margin-bottom: 20px; font-size: 14px; font-weight: 500; }
    </style>
</head>
<body>
<div class="container">
    <h2>Teacher Login</h2>
    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
        <div class="error">Access Denied! Invalid credentials.</div>
    <%
        }
    %>
    <form action="../LoginController" method="post">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" placeholder="Enter username" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" placeholder="Enter password" required>
        </div>
        <button type="submit" class="btn">Log In</button>
    </form>
</div>
</body>
</html>
