public class Institutes {
    private String group;
    private int instituteID;
    private int year;

    public Institutes() {
    }

    public Institutes(String group, int instituteID, int year) {
        this.group = group;
        this.instituteID = instituteID;
        this.year = year;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    public String getGroup() {
        return group;
    }

    public void setInstituteID(int instituteID) {
        this.instituteID = instituteID;
    }

    public int getInstituteID() {
        return instituteID;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getYear() {
        return year;
    }

    @Override
    public String toString() {
        return "Группа: " + group + " (" + year + " курс)" + "\nНомер института: " + instituteID + "\n";
    }
}
