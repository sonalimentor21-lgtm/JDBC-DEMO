<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Teacher Registration</title>
    <!-- Tailwind CSS & Bootstrap Integration via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen flex flex-col justify-center items-center py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-md w-full space-y-8 bg-white p-8 rounded-xl shadow-lg border border-gray-200">
        <div>
            <h2 class="text-center text-3xl font-extrabold text-gray-900">Teacher Sign Up</h2>
            <p class="mt-2 text-center text-sm text-gray-600">Register a new profile to manage student databases</p>
        </div>

        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <div class="alert alert-danger text-center text-sm py-2" role="alert">
                Sign up failed. <%= error %>
            </div>
        <%
            }
        %>

        <form action="../SignupController" method="post" class="space-y-4">
            <div>
                <label for="name" class="block text-sm font-semibold text-gray-700">Full Name:</label>
                <input type="text" id="name" name="name" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm" placeholder="Enter your full name" required>
            </div>
            <div>
                <label for="email" class="block text-sm font-semibold text-gray-700">Email Address:</label>
                <input type="email" id="email" name="email" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm" placeholder="Enter registration email" required>
            </div>
            <div>
                <label for="password" class="block text-sm font-semibold text-gray-700">Password:</label>
                <input type="password" id="password" name="password" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm" placeholder="Choose a secure password" required>
            </div>
            
            <button type="submit" class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition duration-150">
                Register Account
            </button>
        </form>

        <div class="text-center pt-2 border-t border-gray-100">
            <span class="text-sm text-gray-600">Already registered? </span>
            <a href="login.jsp" class="text-sm font-medium text-blue-600 hover:text-blue-500 font-semibold">Sign In here</a>
        </div>
    </div>
</body>
</html>
