<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Teacher Login</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f7f6; margin: 0; padding: 0; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .container { background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); width: 320px; }
        h2 { color: #333; text-align: center; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #666; font-weight: bold; }
        input[type="password"], input[type="text"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn { width: 100%; padding: 12px; background-color: #4CAF50; border: none; border-radius: 4px; color: white; font-size: 16px; cursor: pointer; }
        .error { color: red; text-align: center; margin-bottom: 15px; font-size: 14px; }
        .back-link { display: block; text-align: center; margin-top: 15px; color: #2196F3; text-decoration: none; font-size: 14px; }
    </style>
</head>
<body>
<div class="container">
    <h2>Teacher Login</h2>
    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
        <div class="error">Invalid username or password!</div>
    <%
        }
    %>
    <form action="LoginServlet" method="post">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit" class="btn">Login</button>
    </form>
    <a href="index.jsp" class="back-link">Back to Home</a>
</div>
</body>
</html>
