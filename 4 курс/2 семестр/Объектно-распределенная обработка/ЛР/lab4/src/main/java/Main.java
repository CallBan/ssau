import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        try {
            Driver driver = new com.mysql.cj.jdbc.Driver();
            DriverManager.registerDriver(driver);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Scanner in = new Scanner(System.in);
        ConnectionToDB connectionToDB = new ConnectionToDB();
        while (true) {
            System.out.println("\n--------------------------------------------------------------------------------------------------------");
            System.out.println("Меню:");
            System.out.println("1) Вывод полной информации о студентах");
            System.out.println("2) Добавление группы");
            System.out.println("3) Добавление студента");
            System.out.println("4) Удаление группы");
            System.out.println("5) Удаление студента");
            System.out.println("0) Выход");
            System.out.println("\nВаш выбор: ");
            int choice = in.nextInt();
            System.out.println("--------------------------------------------------------------------------------------------------------\n");
            switch (choice) {
                case 1: {
                    List<Students> students = connectionToDB.getInfo();
                    for (int i = 0; i < students.size(); i++) {
                        System.out.println(students.get(i).toString());
                    }
                    break;
                }
                case 2: {
                    System.out.println("Введите номер группы");
                    in.nextLine();
                    String group = in.nextLine();
                    System.out.println("Введите номер института");
                    int instituteID = in.nextInt();
                    System.out.println("Введите номер курса");
                    int year = in.nextInt();
                    connectionToDB.addGroup(group, instituteID, year);
                    System.out.println("Данные успешно добавлены в таблицу");
                    break;
                }
                case 3: {
                    System.out.println("Введите имя студента");
                    in.nextLine();
                    String name = in.nextLine();
                    System.out.println("Введите ID студента");
                    int studentID = in.nextInt();
                    in.nextLine();
                    System.out.println("\nСписок групп:");
                    List<String> groups = connectionToDB.getGroups();
                    for (int i = 0; i < groups.size(); i++) {
                        System.out.println(i + 1 + ")" + groups.get(i));
                    }
                    System.out.println("\nВыберите группy");
                    int curr = in.nextInt();
                    String group = groups.get(curr - 1);
                    connectionToDB.addStudent(studentID, name, group);
                    System.out.println("Данные успешно добавлены в таблицу");
                    break;
                }
                case 4: {
                    List<String> groups = connectionToDB.getGroups();
                    for (int i = 0; i < groups.size(); i++) {
                        System.out.println(i + 1 + ")" + groups.get(i));
                    }
                    System.out.println("\nВыберите группy");
                    int curr = in.nextInt();
                    String group = groups.get(curr - 1);
                    System.out.println("Вы уверены, что хотите удалить эту группу?\n1-да, 0-нет");
                    in.nextLine();
                    int choice2 = in.nextInt();
                    switch (choice2) {
                        case 1: {
                            connectionToDB.deleteInstitute(group);
                            System.out.println("Данные удалены");
                            break;
                        }
                        case 0: {
                            System.out.println("Хорошо");
                            break;
                        }
                        default: {
                            System.out.println("Введите 1(да) или 0(нет)");
                        }
                    }
                    break;
                }
                case 5: {
                    List<Students> students = connectionToDB.getStudents();
                    for (int i = 0; i < students.size(); i++) {
                        System.out.println(i + 1 + ")" + students.get(i).studentsToString());
                    }
                    System.out.println("\nВыберите студента");
                    int curr = in.nextInt();
                    int studentID = students.get(curr - 1).getStudentID();
                    connectionToDB.deleteStudent(studentID);
                    System.out.println("Данные удалены");
                    break;
                }
                case 0: {
                    return;
                }
                default: {
                    System.out.println("Такого пункта меню нет!");
                }
            }
        }
    }
}
