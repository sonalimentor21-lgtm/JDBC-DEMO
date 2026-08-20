<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student Portal - Registration</title>
    <!-- Tailwind CSS & Bootstrap Integration via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen py-6">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <!-- Header Panel -->
        <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 mb-6 flex justify-between items-center">
            <div>
                <h1 class="text-xl font-bold text-gray-900">ABCD Institute</h1>
                <p class="text-sm text-gray-500">Student Self-Registration Portal</p>
            </div>
            <div>
                <a href="login.jsp" class="text-sm font-semibold text-blue-600 hover:text-blue-800 transition duration-150">Teacher Login</a>
            </div>
        </div>

        <!-- Alert messages -->
        <%
            String msg = request.getParameter("msg");
            String detail = request.getParameter("detail");
            if ("success".equals(msg)) {
        %>
            <div class="alert alert-success text-center font-semibold mb-6" role="alert">
                Your registration was submitted successfully! 
                <a href="../StudentController" class="ml-4 px-3 py-1 bg-green-700 text-white rounded hover:bg-green-800 text-xs no-underline inline-block">View student list</a>
            </div>
        <%
            } else if ("error".equals(msg)) {
        %>
            <div class="alert alert-danger text-center mb-6" role="alert">
                Registration failed. <%= (detail != null) ? detail : "" %>
            </div>
        <%
            }
        %>

        <!-- Main Form Card -->
        <div class="bg-white rounded-lg shadow-md border border-gray-200 p-8">
            <h2 class="text-2xl font-bold text-gray-900 mb-6 border-b pb-4 text-center">Enter Your Details</h2>

            <form action="../StudentController?action=insert" method="post" enctype="multipart/form-data" class="space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label for="id" class="block text-sm font-semibold text-gray-700">Choose Student ID / Roll No:</label>
                        <input type="number" id="id" name="id" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm" placeholder="Enter custom roll ID" required>
                    </div>
                    <div>
                        <label for="name" class="block text-sm font-semibold text-gray-700">Full Name:</label>
                        <input type="text" id="name" name="name" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm" placeholder="Enter your full name" required>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <div>
                        <label for="age" class="block text-sm font-semibold text-gray-700">Age:</label>
                        <input type="number" id="age" name="age" min="5" max="100" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm" placeholder="Your age" required>
                    </div>
                    <div>
                        <label for="marks" class="block text-sm font-semibold text-gray-700">Marks / Score:</label>
                        <input type="text" id="marks" name="marks" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm" placeholder="e.g. 95.0" required>
                    </div>
                    <div>
                        <label for="course" class="block text-sm font-semibold text-gray-700">Course / Stream:</label>
                        <input type="text" id="course" name="course" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm" placeholder="e.g. Mechanical Eng." required>
                    </div>
                </div>

                <div>
                    <label for="email" class="block text-sm font-semibold text-gray-700">Email Address:</label>
                    <input type="email" id="email" name="email" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm" placeholder="yourname@domain.com" required>
                </div>

                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1">Upload Your Profile Photo:</label>
                    <input type="file" id="image" name="image" accept="image/*" class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-md file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100" required>
                </div>

                <div class="pt-4 flex flex-col sm:flex-row gap-4 justify-between">
                    <a href="../StudentController" class="w-full sm:w-auto text-center py-2 px-6 border border-gray-300 text-gray-700 rounded-md text-sm font-medium hover:bg-gray-50 transition duration-150 no-underline">
                        View Records Directory
                    </a>
                    <button type="submit" class="w-full sm:w-auto py-2 px-8 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition duration-150">
                        Submit Registration
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
