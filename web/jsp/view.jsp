<%@ page import="java.util.List" %>
<%@ page import="model.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Students Directory</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f7f6; margin: 20px; }
        .container { background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); max-width: 950px; margin: 0 auto; }
        h2 { color: #333; text-align: center; margin-top: 0; margin-bottom: 25px; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #2196F3; color: white; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        tr:hover { background-color: #f1f1f1; }
        .img-cell { text-align: center; }
        .img-cell img { border-radius: 4px; border: 1px solid #ccc; object-fit: cover; }
        .footer-nav { display: flex; justify-content: space-between; align-items: center; margin-top: 25px; }
        .btn { padding: 10px 20px; border-radius: 4px; font-weight: bold; text-decoration: none; display: inline-block; }
        .btn-back { background-color: #e7e7e7; color: black; }
        .btn-add { background-color: #4CAF50; color: white; }
    </style>
</head>
<body>
<div class="container">
    <h2>Registered Student List</h2>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Age</th>
            <th>Marks</th>
            <th style="text-align: center; width: 120px;">Image</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Student> students = (List<Student>) request.getAttribute("studentsList");
            if (students != null && !students.isEmpty()) {
                for (Student s : students) {
        %>
                <tr>
                    <td><%= s.getId() %></td>
                    <td><%= s.getName() %></td>
                    <td><%= s.getAge() %></td>
                    <td><%= s.getMarks() %></td>
                    <td class="img-cell">
                        <% if (s.getBase64Image() != null) { %>
                            <img src="data:image/png;base64,<%= s.getBase64Image() %>" width="80" height="80"/>
                        <% } else { %>
                            <span style="color: #999; font-style: italic;">No Photo</span>
                        <% } %>
                    </td>
                </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="5" style="text-align: center; color: #777; font-style: italic;">No student records found in database.</td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <div class="footer-nav">
        <a href="jsp/dashboard.jsp" class="btn btn-back">← Back to Dashboard</a>
        <a href="jsp/dashboard.jsp" class="btn btn-add">Add New Student</a>
    </div>
</div>
</body>
</html>
