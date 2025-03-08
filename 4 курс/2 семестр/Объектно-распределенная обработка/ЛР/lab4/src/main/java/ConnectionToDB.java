import java.sql.*;
import java.util.*;

public class ConnectionToDB {
    private static final String url = "jdbc:mysql://localhost:3306/univerdb";
    private static final String user = "root";
    private static final String password = "lera";

    public List<Students> getInfo() {
        List<Students> students = new ArrayList<Students>();
        Students student;
        Institutes institute;
        try (Connection connection = DriverManager.getConnection(url, user, password); Statement statement = connection.createStatement()) {
            String request = "select * from students,institute where students.groupID=institute.groupID";
            ResultSet resultSet = statement.executeQuery(request);
            while (resultSet.next()) {
                student = new Students();
                institute = new Institutes();
                student.setStudentID(resultSet.getInt(1));
                student.setName(resultSet.getString(2));
                institute.setGroup(resultSet.getString(4));
                institute.setInstituteID(resultSet.getInt(5));
                institute.setYear(resultSet.getInt(6));
                student.setInstitute(institute);
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    public void addGroup(String group, int instituteID, int year) {
        try (Connection connection = DriverManager.getConnection(url, user, password); Statement statement = connection.createStatement()) {
            String request = "INSERT INTO institute (groupID, instituteID, year) VALUES('" + group + "', " + instituteID + ", " + year + ")";
            statement.executeUpdate(request);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<String> getGroups() {
        List<String> groups = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(url, user, password); Statement statement = connection.createStatement()) {
            String request = "select * from institute";
            ResultSet resultSet = statement.executeQuery(request);
            while (resultSet.next()) {
                groups.add(resultSet.getString(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return groups;
    }

    public List<Students> getStudents() {
        List<Students> students = new ArrayList<Students>();
        Students student;
        try (Connection connection = DriverManager.getConnection(url, user, password); Statement statement = connection.createStatement()) {
            String request = "select * from students";
            ResultSet resultSet = statement.executeQuery(request);
            while (resultSet.next()) {
                student = new Students();
                student.setStudentID(resultSet.getInt(1));
                student.setName(resultSet.getString(2));
                student.setGroup(resultSet.getString(3));
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    public void addStudent(int studentID, String name, String group) {
        try (Connection connection = DriverManager.getConnection(url, user, password); Statement statement = connection.createStatement()) {
            String request = "INSERT INTO students (studentID, name, groupID) VALUES(" + studentID + ", '" + name + "', '" + group + "')";
            statement.executeUpdate(request);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteInstitute(String group) {
        String request = "delete from institute where groupID=?";
        try (Connection connection = DriverManager.getConnection(url, user, password); PreparedStatement statement = connection.prepareStatement(request)) {
            statement.setString(1, group);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteStudent(int studentID) {
        String request = "delete from students where studentID=?";
        try (Connection connection = DriverManager.getConnection(url, user, password); PreparedStatement statement = connection.prepareStatement(request)) {
            statement.setInt(1, studentID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
