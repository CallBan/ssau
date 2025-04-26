package com.ssau.client;

import com.ssau.dto.Author;
import com.ssau.dto.Book;
import com.ssau.rmi.RemoteDatabaseService;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.List;
import java.util.Scanner;

public class RMIClient {
  public static void main(String[] args) {
    try {
      Registry registry = LocateRegistry.getRegistry("localhost", 1099);
      RemoteDatabaseService service = (RemoteDatabaseService) registry.lookup("DatabaseService");
      System.out.println("Подключение к удалённому объекту выполнено.");

      Scanner scanner = new Scanner(System.in);
      while (true) {
        System.out.println("\nМеню:");
        System.out.println("1. Вывести все книги с авторами");
        System.out.println("2. Добавить автора");
        System.out.println("3. Добавить книгу");
        System.out.println("4. Удалить автора по id");
        System.out.println("5. Удалить книгу по id");
//        System.out.println("6. Получить список авторов");
//        System.out.println("7. Получить список книг");
        System.out.println("0. Выход");
        System.out.print("Выберите опцию: ");
        int choice = Integer.parseInt(scanner.nextLine());

        switch (choice) {
          case 1:
            service.printAllBooksWithAuthors();
            break;
          case 2:
            System.out.print("Введите firstname: ");
            String fn = scanner.nextLine();
            System.out.print("Введите lastname: ");
            String ln = scanner.nextLine();
            System.out.print("Введите birthdate (YYYY-MM-DD): ");
            String bd = scanner.nextLine();
            System.out.print("Введите gender: ");
            String gender = scanner.nextLine();
            System.out.print("Введите country: ");
            String country = scanner.nextLine();
            Author author = new Author(0, fn, ln, java.sql.Date.valueOf(bd), gender, country);
            service.addAuthor(author);
            break;
          case 3:
            System.out.print("Введите название книги: ");
            String bookName = scanner.nextLine();
            System.out.print("Введите publisher: ");
            String publisher = scanner.nextLine();
            System.out.print("Введите author_id: ");
            int authorId = Integer.parseInt(scanner.nextLine());
            System.out.print("Введите rating: ");
            int rating = Integer.parseInt(scanner.nextLine());
            Book book = new Book(0, bookName, publisher, authorId, rating);
            service.addBook(book);
            break;
          case 4:
            System.out.print("Введите id автора для удаления: ");
            int delAuthorId = Integer.parseInt(scanner.nextLine());
            service.deleteAuthorById(delAuthorId);
            break;
          case 5:
            System.out.print("Введите id книги для удаления: ");
            int delBookId = Integer.parseInt(scanner.nextLine());
            service.deleteBookById(delBookId);
            break;
          case 6:
            List<Author> authors = service.getAllAuthors();
            System.out.println("Список авторов:");
            for (Author a : authors) {
              System.out.println(a);
            }
            break;
          case 7:
            List<Book> books = service.getAllBooks();
            System.out.println("Список книг:");
            for (Book b : books) {
              System.out.println(b);
            }
            break;
          case 0:
            System.out.println("Выход.");
            scanner.close();
            return;
          default:
            System.out.println("Неверный выбор.");
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}
