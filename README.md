# Student Management Web Application (JSP, Servlet & JDBC MVC)

This is a simple, lightweight Java Web Application that implements a Student Management System using the **Model-View-Controller (MVC)** design pattern. It enables authorized teachers to log in, insert student details (including uploading a student profile image), and view all student records in a formatted table.

---

## What the Project Does
1. **Authentication**: Provides a secure login portal for teachers (Credentials: `teacher` / `teacher123`).
2. **Dynamic Insertion (Teacher Only)**: Logged-in teachers get access to a dashboard form where they can input student parameters (`ID`, `Name`, `Age`, `Marks`) and upload a profile photo (`LONGBLOB` in MySQL).
3. **Session Security**: Prevents unauthorized access to the dashboard. If a student or non-logged-in user tries to access `dashboard.jsp`, they are redirected to the login page.
4. **Structured View**: Renders the complete database list of students, converting the MySQL binary image blobs into inline Base64 formatted string images on the fly.

---

## Folder Structure
```
JDBC DEMO/
│
├── lib/
│   └── jakarta.servlet-api-6.0.0.jar (Jakarta Servlet 6.0 API library for Tomcat 11 compilation)
│
├── resources/
│   └── student_placeholder.png       (Placeholder image used for initial JDBC tests)
│
├── src/
│   ├── model/
│   │   ├── Student.java              (Model: Entity class representing a student record)
│   │   └── StudentDAO.java           (Model: Handles all MySQL database JDBC CRUD operations)
│   │
│   ├── controller/
│   │   ├── LoginController.java      (Controller: Authenticates teacher sessions)
│   │   ├── LogoutController.java     (Controller: Invalidates sessions and logs out)
│   │   └── StudentController.java    (Controller: Processes student insertion and lists directory)
│   │
│   ├── Main.java                     (Standard Statement JDBC demo file - test script)
│   └── PreparedStatementDemo.java    (PreparedStatement JDBC demo file - test script)
│
└── web/
    ├── WEB-INF/
    │   └── web.xml                   (Deployment descriptor specifying application settings)
    │
    └── jsp/                          (View folder containing user interfaces)
        ├── login.jsp                 (View: Portal login screen for teachers)
        ├── dashboard.jsp             (View: Form for inserting new student records)
        └── view.jsp                  (View: Table showcasing all registered students and photos)
```

---

## System Prerequisites
* **Java JDK**: Version 21 (`C:\Program Files\Java\jdk-21`)
* **Database**: MySQL Server running locally on port `3306` with database `mydb` containing table `students` (Table description: `id INT Primary Key`, `name VARCHAR(100)`, `age INT`, `marks DOUBLE`, `image LONGBLOB`).
* **Web Server**: Apache Tomcat 11.0.24 (`C:\Users\soma4\Downloads\apache-tomcat-11.0.24`)
* **MySQL Connector**: Located at `C:\mysql-connector-j-26.7.0\mysql-connector-j-26.7.0.jar`

---

## How to Run in VS Code (Terminal)

Open the project folder in VS Code, open a new **PowerShell terminal**, and execute:

### 1. Compile Code
```powershell
javac -cp "lib/jakarta.servlet-api-6.0.0.jar;C:\mysql-connector-j-26.7.0\mysql-connector-j-26.7.0.jar" src/model/*.java src/controller/*.java
```

### 2. Deploy Web Artifacts to Tomcat
Run these commands to transfer files into Tomcat's `webapps` folder:
```powershell
$tomcatDir = "C:\Users\soma4\Downloads\apache-tomcat-11.0.24"
$appDir = "$tomcatDir\webapps\student-app"

New-Item -ItemType Directory -Force -Path "$appDir"
New-Item -ItemType Directory -Force -Path "$appDir\WEB-INF"
New-Item -ItemType Directory -Force -Path "$appDir\WEB-INF\classes"
New-Item -ItemType Directory -Force -Path "$appDir\WEB-INF\lib"
New-Item -ItemType Directory -Force -Path "$appDir\resources"

Copy-Item -Path "web\*" -Destination "$appDir" -Recurse -Force
Copy-Item -Path "resources\*" -Destination "$appDir\resources" -Recurse -Force
Copy-Item -Path "src\model" -Destination "$appDir\WEB-INF\classes" -Recurse -Force
Copy-Item -Path "src\controller" -Destination "$appDir\WEB-INF\classes" -Recurse -Force
Copy-Item -Path "C:\mysql-connector-j-26.7.0\mysql-connector-j-26.7.0.jar" -Destination "$appDir\WEB-INF\lib" -Force
```

### 3. Start Apache Tomcat
Configure environment paths and boot up the server:
```powershell
$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
$env:CATALINA_HOME = "C:\Users\soma4\Downloads\apache-tomcat-11.0.24"
& "$env:CATALINA_HOME\bin\startup.bat"
```
*(You can shut it down later using `& "$env:CATALINA_HOME\bin\shutdown.bat"`)*

### 4. Open Application Endpoint
Navigate to your web browser and open:
👉 **[http://localhost:8080/student-app/jsp/login.jsp](http://localhost:8080/student-app/jsp/login.jsp)**

---

## How to Run in IntelliJ IDEA Community Edition (2025.2.2)

### 1. Build using IntelliJ Terminal
1. Open the project in IntelliJ IDEA.
2. Click the **Terminal** tab at the bottom (or press `Alt + F12`).
3. Follow the exact same PowerShell compile, deploy, and start instructions listed in the **VS Code** section above.

### 2. Run via Tomcat Server plugin (Alternative Configuration)
If you prefer configuring a Tomcat run instance directly inside the IDE:
1. Ensure the `lib/jakarta.servlet-api-6.0.0.jar` is recognized by IntelliJ (This is already pre-configured for you in the [`JDBC DEMO.iml`](file:///c:/Users/soma4/OneDrive/Documents/prepcheck/nathan/JDBC%20DEMO/JDBC%20DEMO.iml) file).
2. Install the **Smart Tomcat** extension/plugin in IntelliJ Community Edition (*Settings -> Plugins -> Marketplace -> search for "Smart Tomcat"*).
3. Go to **Run -> Edit Configurations -> Add New Configuration (+)** and select **Smart Tomcat**.
4. Configure the settings:
   * **Tomcat Server**: Point to `C:\Users\soma4\Downloads\apache-tomcat-11.0.24`
   * **Deployment Directory**: Point to the `web` folder in your project directory.
   * **Context Path**: `/student-app`
5. Click **Apply** and click the green **Run** button to launch.
6. Open your browser to the login page endpoint: `http://localhost:8080/student-app/jsp/login.jsp`
