<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Academic Portal Login</title>
    <!-- Tailwind CSS & Bootstrap Integration via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://accounts.google.com/gsi/client" async defer></script>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col justify-center items-center py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-md w-full space-y-8 bg-white p-8 rounded-xl shadow-lg border border-gray-200">
        <div>
            <h2 class="text-center text-3xl font-extrabold text-gray-900">ABCD Institute</h2>
            <p class="mt-2 text-center text-sm text-gray-600">Teacher & Student Portal Access</p>
        </div>

        <%
            String error = request.getParameter("error");
            String msg = request.getParameter("msg");
            if ("invalid_credentials".equals(error)) {
        %>
            <div class="alert alert-danger text-center text-sm py-2" role="alert">
                Invalid email or password. Please try again.
            </div>
        <%
            } else if ("google_failed".equals(error)) {
        %>
            <div class="alert alert-danger text-center text-sm py-2" role="alert">
                Google Authentication failed.
            </div>
        <%
            } else if ("signup_success".equals(msg)) {
        %>
            <div class="alert alert-success text-center text-sm py-2" role="alert">
                Registration successful! Please log in below.
            </div>
        <%
            }
        %>

        <div class="space-y-4">
            <form action="../LoginController" method="post" class="space-y-4">
                <div>
                    <label for="email" class="block text-sm font-semibold text-gray-700">Email Address:</label>
                    <input type="email" id="email" name="email" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm" required>
                </div>
                <div>
                    <label for="password" class="block text-sm font-semibold text-gray-700">Password:</label>
                    <input type="password" id="password" name="password" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm" required>
                </div>
                <button type="submit" class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition duration-150">
                    Sign In as Teacher
                </button>
            </form>

            <div class="relative flex py-2 items-center">
                <div class="flex-grow border-t border-gray-300"></div>
                <span class="flex-shrink mx-4 text-gray-400 text-xs uppercase">Or Authentication with Google</span>
                <div class="flex-grow border-t border-gray-300"></div>
            </div>

            <!-- Google Sign-in Button integration -->
            <div class="flex justify-center">
                <!-- Replace data-client_id with your actual Google Client ID from Google Cloud Console -->
                <div id="g_id_onload"
                     data-client_id="1048892186835-placeholder.apps.googleusercontent.com"
                     data-context="signin"
                     data-ux_mode="popup"
                     data-login_uri="http://localhost:8080/student-app/LoginController"
                     data-auto_prompt="false">
                </div>
                <div class="g_id_signin w-full"
                     data-type="standard"
                     data-shape="rectangular"
                     data-theme="outline"
                     data-text="signin_with"
                     data-size="large"
                     data-logo_alignment="left">
                </div>
            </div>

            <div class="text-center pt-2">
                <span class="text-sm text-gray-600">New teacher? </span>
                <a href="signup.jsp" class="text-sm font-medium text-blue-600 hover:text-blue-500 font-semibold">Create an Account</a>
            </div>
            
            <div class="border-t border-gray-200 pt-4 flex flex-col items-center">
                <span class="text-xs text-gray-400 mb-2">Are you a Student?</span>
                <a href="student_entry.jsp" class="w-full text-center py-2 px-4 border border-blue-500 text-blue-500 rounded-md text-sm font-medium hover:bg-blue-50 transition duration-150">
                    Go to Student Entry Portal
                </a>
            </div>
        </div>
    </div>
</body>
</html>
