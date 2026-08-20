<%@ page import="java.sql.*" %>
<%@ page import="java.util.Base64" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>All Students List</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f7f6; margin: 20px; }
        .container { background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); max-width: 900px; margin: 0 auto; }
        h2 { color: #333; text-align: center; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        .back-link { display: inline-block; margin-top: 20px; color: #2196F3; text-decoration: none; font-weight: bold; }
        .img-cell img { border-radius: 4px; object-fit: cover; border: 1px solid #ccc; }
    </style>
</head>
<body>
<div class="container">
    <h2>Student Records</h2>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Age</th>
            <th>Marks</th>
            <th>Photo</th>
        </tr>
        </thead>
        <tbody>
        <%
            String url = "jdbc:mysql://localhost:3306/mydb";
            String username = "root";
            String password = "sonali123@";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(url, username, password);
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT id, name, age, marks, image FROM students")) {
                    
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        int age = rs.getInt("age");
                        double marks = rs.getDouble("marks");
                        byte[] imgBytes = rs.getBytes("image");
                        String base64Image = "";
                        if (imgBytes != null && imgBytes.length > 0) {
                            base64Image = Base64.getEncoder().encodeToString(imgBytes);
                        }
        %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= name %></td>
                        <td><%= age %></td>
                        <td><%= marks %></td>
                        <td class="img-cell">
                            <% if (!base64Image.isEmpty()) { %>
                                <img src="data:image/png;base64,<%= base64Image %>" width="80" height="80"/>
                            <% } else { %>
                                No Image
                            <% } %>
                        </td>
                    </tr>
        <%
                    }
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='5' style='color:red;'>Error fetching data: " + e.getMessage() + "</td></tr>");
            }
        %>
        </tbody>
    </table>
    
    <div style="display: flex; justify-content: space-between; align-items: center;">
        <a href="index.jsp" class="back-link">← Back to Portal Selection</a>
        <%
            String role = (String) session.getAttribute("role");
            if ("teacher".equals(role)) {
        %>
            <a href="insert.jsp" class="back-link" style="color: #4CAF50;">Go to Insert Form →</a>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
