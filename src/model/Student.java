package model;

public class Student {
    private int id;
    private String name;
    private int age;
    private double marks;
    private byte[] image;
    private String base64Image;
    private String email;
    private String course;

    // Constructors
    public Student() {}

    public Student(int id, String name, int age, double marks, byte[] image, String email, String course) {
        this.id = id;
        this.name = name;
        this.age = age;
        this.marks = marks;
        this.image = image;
        this.email = email;
        this.course = course;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public double getMarks() { return marks; }
    public void setMarks(double marks) { this.marks = marks; }

    public byte[] getImage() { return image; }
    public void setImage(byte[] image) { this.image = image; }

    public String getBase64Image() { return base64Image; }
    public void setBase64Image(String base64Image) { this.base64Image = base64Image; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getCourse() { return course; }
    public void setCourse(String course) { this.course = course; }
}
