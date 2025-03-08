public class Students {
    private int studentID;
    private String name;
    private String group;
    private Institutes institute;

    public Students() {
    }

    public Students(int studentID, String name, Institutes institute) {
        this.studentID = studentID;
        this.name = name;
        this.institute = institute;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public int getStudentID() {
        return studentID;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    public String getGroup() {
        return group;
    }

    public void setInstitute(Institutes institute) {
        this.institute = institute;
    }

    public Institutes institutes() {
        return institute;
    }

    public String studentsToString() {
        return this.name + " (ID: " + this.studentID + ")";
    }

    @Override
    public String toString() {
        return this.name + " (ID: " + this.studentID + ")\n" + institute.toString();
    }
}
