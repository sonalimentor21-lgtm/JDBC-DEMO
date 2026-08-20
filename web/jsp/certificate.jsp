<%@ page import="model.Student" %>
<%@ page import="model.StudentDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String idStr = request.getParameter("id");
    Student student = null;
    if (idStr != null) {
        try {
            int id = Integer.parseInt(idStr);
            StudentDAO dao = new StudentDAO();
            List<Student> students = dao.getAllStudents();
            for (Student s : students) {
                if (s.getId() == id) {
                    student = s;
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    if (student == null) {
        out.println("<h3>Error: Student record not found.</h3>");
        return;
    }
%>
<html>
<head>
    <title>Certificate of Achievement - <%= student.getName() %></title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @media print {
            .no-print {
                display: none;
            }
            body {
                background-color: #ffffff;
                margin: 0;
            }
        }
        .certificate-border {
            border: 15px double #a3704c;
            outline: 4px solid #a3704c;
            outline-offset: -25px;
        }
    </style>
</head>
<body class="bg-gray-100 flex flex-col items-center justify-center min-h-screen py-10">

    <!-- Action Toolbar (Hidden during print) -->
    <div class="no-print mb-6 flex gap-4">
        <button onclick="window.print()" class="px-5 py-2 bg-blue-600 hover:bg-blue-700 text-white font-bold rounded shadow transition duration-150">
            Print Certificate (PDF)
        </button>
        <button onclick="window.close()" class="px-5 py-2 bg-gray-600 hover:bg-gray-700 text-white font-bold rounded shadow transition duration-150">
            Close Tab
        </button>
    </div>

    <!-- Certificate Container -->
    <div class="certificate-border bg-white text-gray-800 p-16 shadow-2xl relative w-[850px] h-[600px] flex flex-col justify-between items-center font-serif">
        
        <!-- Header Ribbon -->
        <div class="text-center">
            <h1 class="text-4xl font-extrabold text-[#8c5630] tracking-widest uppercase">ABCD Institute</h1>
            <p class="text-xs tracking-widest text-gray-500 uppercase mt-1">Certificate of Academic Excellence</p>
        </div>

        <!-- Certification Text -->
        <div class="text-center space-y-4">
            <p class="text-lg italic text-gray-600">This is proudly presented to</p>
            <h2 class="text-4xl font-bold text-gray-900 border-b-2 border-gray-200 pb-2 px-8 inline-block"><%= student.getName() %></h2>
            <p class="text-md leading-relaxed text-gray-600 max-w-xl mx-auto">
                for outstanding performance and successful completion of the course
                <br>
                <span class="font-bold text-gray-900 text-lg italic mt-1 inline-block">"<%= student.getCourse() != null ? student.getCourse() : "General Studies" %>"</span>
                <br>
                with a final examination score of <span class="font-bold text-gray-900"><%= student.getMarks() %>%</span>.
            </p>
        </div>

        <!-- Signatures & Footer -->
        <div class="w-full flex justify-between px-12 pt-6">
            <!-- Teacher Signature -->
            <div class="text-center w-48">
                <div class="border-b border-gray-400 h-10 flex items-end justify-center">
                    <span class="italic text-gray-400 font-sans text-sm">Instructor Signature</span>
                </div>
                <p class="text-xs text-gray-500 font-semibold mt-2">Class Instructor</p>
            </div>

            <!-- Emblem Placeholder -->
            <div class="flex items-center justify-center">
                <div class="w-16 h-16 rounded-full border-4 border-[#a3704c] flex items-center justify-center text-xs font-bold text-[#a3704c] tracking-tighter">
                    OFFICIAL
                </div>
            </div>

            <!-- Principal Signature -->
            <div class="text-center w-48">
                <div class="border-b border-gray-400 h-10 flex items-end justify-center">
                    <span class="italic text-gray-400 font-sans text-sm">Principal Signature</span>
                </div>
                <p class="text-xs text-gray-500 font-semibold mt-2">School Principal</p>
            </div>
        </div>

        <!-- Award Date -->
        <div class="text-center text-xs text-gray-400 mt-2">
            Date of Issue: <%= new java.text.SimpleDateFormat("MMMM dd, yyyy").format(new java.util.Date()) %>
        </div>
    </div>
</body>
</html>
