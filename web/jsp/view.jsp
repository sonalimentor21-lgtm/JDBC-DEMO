<%@ page import="java.util.List" %>
<%@ page import="model.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String role = (String) session.getAttribute("role");
    boolean isTeacher = "teacher".equals(role);
%>
<html>
<head>
    <title>Registered Students Directory</title>
    <!-- Tailwind CSS & Bootstrap Integration via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen py-8">
    <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <!-- Top Navigation -->
        <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 mb-8 flex flex-col sm:flex-row justify-between items-center gap-4">
            <div>
                <h1 class="text-2xl font-bold text-gray-900">Student Directory</h1>
                <p class="text-sm text-gray-500">Official registry records for ABCD Institute</p>
            </div>
            <div class="flex gap-4">
                <a href="student_entry.jsp" class="px-4 py-2 border border-gray-300 text-gray-700 rounded-md text-sm font-semibold hover:bg-gray-50 transition duration-150 no-underline">Student Entry</a>
                <% if (isTeacher) { %>
                    <a href="dashboard.jsp" class="px-4 py-2 bg-blue-600 text-white rounded-md text-sm font-semibold hover:bg-blue-700 transition duration-150 no-underline">Teacher Dashboard</a>
                <% } else { %>
                    <a href="login.jsp" class="px-4 py-2 bg-blue-600 text-white rounded-md text-sm font-semibold hover:bg-blue-700 transition duration-150 no-underline">Teacher Login</a>
                <% } %>
            </div>
        </div>

        <!-- Student Database Table -->
        <div class="bg-white rounded-lg shadow-md border border-gray-200 overflow-hidden">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Photo</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">ID</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Name</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Age</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Email</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Course</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Marks</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                    <%
                        List<Student> students = (List<Student>) request.getAttribute("studentsList");
                        if (students != null && !students.isEmpty()) {
                            for (Student s : students) {
                    %>
                            <tr class="hover:bg-gray-50 transition duration-150">
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <% if (s.getBase64Image() != null) { %>
                                        <img src="data:image/png;base64,<%= s.getBase64Image() %>" class="w-12 h-12 rounded-full border border-gray-300 object-cover shadow-sm"/>
                                    <% } else { %>
                                        <div class="w-12 h-12 rounded-full bg-gray-200 border border-gray-300 flex items-center justify-center text-xs text-gray-400 font-semibold">N/A</div>
                                    <% } %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-semibold text-gray-900"><%= s.getId() %></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"><%= s.getName() %></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= s.getAge() %></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= s.getEmail() != null ? s.getEmail() : "" %></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600 font-semibold"><%= s.getCourse() != null ? s.getCourse() : "" %></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 font-bold"><%= s.getMarks() %></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm">
                                    <a href="jsp/certificate.jsp?id=<%= s.getId() %>" target="_blank" class="px-3 py-1.5 bg-blue-100 text-blue-700 rounded-md font-semibold hover:bg-blue-200 text-xs no-underline inline-block transition duration-150">
                                        Certificate
                                    </a>
                                </td>
                            </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="8" class="px-6 py-8 text-center text-sm text-gray-500 italic">No student records found in database.</td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
