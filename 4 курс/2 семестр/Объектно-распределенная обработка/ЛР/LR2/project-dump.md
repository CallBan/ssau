### docker-compose.yaml
```yaml
services:
  postgres:
    image: postgres:15
    container_name: postgres_db_lab-1
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: 12345
      POSTGRES_DB: mydb
    ports:
      - "1616:5432"
    volumes:
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql

```

### init.sql
```sql
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS author;

CREATE TABLE author (
    id SERIAL PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    birthdate DATE,
    gender VARCHAR(10),
    country VARCHAR(50)
);

CREATE TABLE book (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    publisher VARCHAR(100),
    author_id INTEGER NOT NULL,
    rating INTEGER,
    CONSTRAINT fk_author FOREIGN KEY (author_id)
        REFERENCES author(id)
        ON DELETE RESTRICT
);

INSERT INTO author (firstname, lastname, birthdate, gender, country) VALUES
('Leo', 'Tolstoy', '1828-09-09', 'Male', 'Russia'),
('Fyodor', 'Dostoevsky', '1821-11-11', 'Male', 'Russia'),
('Anton', 'Chekhov', '1860-07-29', 'Male', 'Russia');

INSERT INTO book (name, publisher, author_id, rating) VALUES
('War and Peace', 'The Russian Messenger', 1, 10),
('Anna Karenina', 'The Russian Messenger', 1, 9),
('Crime and Punishment', 'The Russian Messenger', 2, 10),
('The Seagull', 'Modern Library', 3, 8);

```

### pom.xml
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.ssau</groupId>
  <artifactId>lab2</artifactId>
  <version>1.0-SNAPSHOT</version>
  <packaging>jar</packaging>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>

  <dependencies>
    <dependency>
      <groupId>org.postgresql</groupId>
      <artifactId>postgresql</artifactId>
      <version>42.7.4</version>
    </dependency>
    <dependency>
      <groupId>org.projectlombok</groupId>
      <artifactId>lombok</artifactId>
      <version>1.18.34</version>
      <scope>provided</scope>
    </dependency>
  </dependencies>

  <build>
    <plugins>
      <plugin>
        <groupId>org.codehaus.mojo</groupId>
        <artifactId>exec-maven-plugin</artifactId>
        <version>3.1.0</version>
      </plugin>
    </plugins>
  </build>

</project>
```

### src\main\java\com\ssau\client\RMIClient.java
```java
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
        System.out.println("6. Получить список авторов");
        System.out.println("7. Получить список книг");
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
```

### src\main\java\com\ssau\db\DatabaseHelper.java
```java
package com.ssau.db;

import com.ssau.dto.Author;
import com.ssau.dto.Book;
import lombok.NoArgsConstructor;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

@NoArgsConstructor
public class DatabaseHelper {
  private static final String URL = "jdbc:postgresql://localhost:1616/mydb";
  private static final String USER = "postgres";
  private static final String PASSWORD = "12345";

  private Connection getConnection() throws SQLException {
    return DriverManager.getConnection(URL, USER, PASSWORD);
  }

  public void printAllBooksWithAuthors() {
    String query = "SELECT b.id, b.name, b.publisher, b.rating, a.firstname, a.lastname " +
            "FROM book b JOIN author a ON b.author_id = a.id";
    try (Connection conn = getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(query)) {

      System.out.println("ID | Book Name | Publisher | Rating | Author Firstname | Author Lastname");
      while (rs.next()) {
        int id = rs.getInt("id");
        String name = rs.getString("name");
        String publisher = rs.getString("publisher");
        int rating = rs.getInt("rating");
        String firstName = rs.getString("firstname");
        String lastName = rs.getString("lastname");
        System.out.printf("%d | %s | %s | %d | %s | %s%n", id, name, publisher, rating, firstName, lastName);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  public void addAuthor(Author author) {
    String query = "INSERT INTO author (firstname, lastname, birthdate, gender, country) VALUES (?, ?, ?, ?, ?)";
    try (Connection conn = getConnection();
         PreparedStatement pstmt = conn.prepareStatement(query)) {

      pstmt.setString(1, author.getFirstname());
      pstmt.setString(2, author.getLastname());
      pstmt.setDate(3, author.getBirthdate());
      pstmt.setString(4, author.getGender());
      pstmt.setString(5, author.getCountry());
      pstmt.executeUpdate();
      System.out.println("Автор успешно добавлен.");
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  public void addBook(Book book) {
    String query = "INSERT INTO book (name, publisher, author_id, rating) VALUES (?, ?, ?, ?)";
    try (Connection conn = getConnection();
         PreparedStatement pstmt = conn.prepareStatement(query)) {

      pstmt.setString(1, book.getName());
      pstmt.setString(2, book.getPublisher());
      pstmt.setInt(3, book.getAuthorId());
      pstmt.setInt(4, book.getRating());
      pstmt.executeUpdate();
      System.out.println("Книга успешно добавлена.");
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

//  public void deleteAuthorById(int authorId) {
//    String checkQuery = "SELECT COUNT(*) FROM book WHERE author_id = ?";
//    String deleteAuthorQuery = "DELETE FROM author WHERE id = ?";
//
//    try (Connection conn = getConnection();
//         PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
//
//      checkStmt.setInt(1, authorId);
//      ResultSet rs = checkStmt.executeQuery();
//      if (rs.next() && rs.getInt(1) > 0) {
//        String dependentDeletionQuery = "DELETE FROM book WHERE author_id = " + authorId;
//        System.out.println("Обнаружены связанные записи в таблице book.");
//        System.out.println("Для удаления автора необходимо сначала выполнить запрос:");
//        System.out.println(dependentDeletionQuery);
//        System.out.println("Удаление автора отменено.");
//      } else {
//        try (PreparedStatement deleteStmt = conn.prepareStatement(deleteAuthorQuery)) {
//          deleteStmt.setInt(1, authorId);
//          int rows = deleteStmt.executeUpdate();
//          if (rows > 0) {
//            System.out.println("Автор успешно удалён.");
//          } else {
//            System.out.println("Автор с указанным id не найден.");
//          }
//        }
//      }
//    } catch (SQLException e) {
//      e.printStackTrace();
//    }
//  }

  public void deleteAuthorById(int authorId) {
    String checkQuery = "SELECT COUNT(*) FROM book WHERE author_id = ?";
    String deleteBooksQuery = "DELETE FROM book WHERE author_id = ?";
    String deleteAuthorQuery = "DELETE FROM author WHERE id = ?";

    try (Connection conn = getConnection();
         PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {

      // Проверка на связанные записи в таблице book
      checkStmt.setInt(1, authorId);
      ResultSet rs = checkStmt.executeQuery();
      if (rs.next() && rs.getInt(1) > 0) {
        System.out.println("Обнаружены связанные записи в таблице book.");
        System.out.println("Вы действительно хотите удалить автора и все связанные записи? (Да/Нет)");

        Scanner scanner = new Scanner(System.in);
        String answer = scanner.nextLine();
        // Если пользователь подтверждает удаление
        if (answer.equalsIgnoreCase("Да")) {
          try (PreparedStatement deleteBooksStmt = conn.prepareStatement(deleteBooksQuery);
               PreparedStatement deleteAuthorStmt = conn.prepareStatement(deleteAuthorQuery)) {

            // Удаляем связанные записи из таблицы book
            deleteBooksStmt.setInt(1, authorId);
            int booksDeleted = deleteBooksStmt.executeUpdate();

            // Удаляем автора
            deleteAuthorStmt.setInt(1, authorId);
            int authorsDeleted = deleteAuthorStmt.executeUpdate();

            if (authorsDeleted > 0) {
              System.out.println("Автор и " + booksDeleted + " связанных записей успешно удалены.");
            } else {
              System.out.println("Автор с указанным id не найден.");
            }
          }
        } else {
          System.out.println("Удаление автора отменено.");
        }
      } else {
        // Если связанных записей нет – просто удаляем автора
        try (PreparedStatement deleteAuthorStmt = conn.prepareStatement(deleteAuthorQuery)) {
          deleteAuthorStmt.setInt(1, authorId);
          int rows = deleteAuthorStmt.executeUpdate();
          if (rows > 0) {
            System.out.println("Автор успешно удалён.");
          } else {
            System.out.println("Автор с указанным id не найден.");
          }
        }
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  public void deleteBookById(int bookId) {
    String query = "DELETE FROM book WHERE id = ?";
    try (Connection conn = getConnection();
         PreparedStatement pstmt = conn.prepareStatement(query)) {

      pstmt.setInt(1, bookId);
      int rows = pstmt.executeUpdate();
      if (rows > 0) {
        System.out.println("Книга успешно удалена.");
      } else {
        System.out.println("Книга с указанным id не найдена.");
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  public List<Author> getAllAuthors() {
    List<Author> authors = new ArrayList<>();
    String query = "SELECT * FROM author";
    try (Connection conn = getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(query)) {

      while (rs.next()) {
        Author author = new Author();
        author.setId(rs.getInt("id"));
        author.setFirstname(rs.getString("firstname"));
        author.setLastname(rs.getString("lastname"));
        author.setBirthdate(rs.getDate("birthdate"));
        author.setGender(rs.getString("gender"));
        author.setCountry(rs.getString("country"));
        authors.add(author);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return authors;
  }

  public List<Book> getAllBooks() {
    List<Book> books = new ArrayList<>();
    String query = "SELECT * FROM book";
    try (Connection conn = getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(query)) {

      while (rs.next()) {
        Book book = new Book();
        book.setId(rs.getInt("id"));
        book.setName(rs.getString("name"));
        book.setPublisher(rs.getString("publisher"));
        book.setAuthorId(rs.getInt("author_id"));
        book.setRating(rs.getInt("rating"));
        books.add(book);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return books;
  }
}
```

### src\main\java\com\ssau\dto\Author.java
```java
package com.ssau.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.sql.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Author implements Serializable {
  private int id;
  private String firstname;
  private String lastname;
  private Date birthdate;
  private String gender;
  private String country;
}
```

### src\main\java\com\ssau\dto\Book.java
```java
package com.ssau.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Book implements Serializable {
  private int id;
  private String name;
  private String publisher;
  private int authorId;
  private int rating;
}
```

### src\main\java\com\ssau\rmi\RemoteDatabaseService.java
```java
package com.ssau.rmi;

import com.ssau.dto.Author;
import com.ssau.dto.Book;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.List;

public interface RemoteDatabaseService extends Remote {
  void printAllBooksWithAuthors() throws RemoteException;

  void addAuthor(Author author) throws RemoteException;

  void addBook(Book book) throws RemoteException;

  void deleteAuthorById(int authorId) throws RemoteException;

  void deleteBookById(int bookId) throws RemoteException;

  List<Author> getAllAuthors() throws RemoteException;

  List<Book> getAllBooks() throws RemoteException;
}
```

### src\main\java\com\ssau\rmi\RemoteDatabaseServiceImpl.java
```java
package com.ssau.rmi;

import com.ssau.db.DatabaseHelper;
import com.ssau.dto.Author;
import com.ssau.dto.Book;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.List;

public class RemoteDatabaseServiceImpl extends UnicastRemoteObject implements RemoteDatabaseService {
  private DatabaseHelper dbHelper;

  public RemoteDatabaseServiceImpl() throws RemoteException {
    super();
    dbHelper = new DatabaseHelper();
  }

  @Override
  public void printAllBooksWithAuthors() throws RemoteException {
    dbHelper.printAllBooksWithAuthors();
  }

  @Override
  public void addAuthor(Author author) throws RemoteException {
    dbHelper.addAuthor(author);
  }

  @Override
  public void addBook(Book book) throws RemoteException {
    dbHelper.addBook(book);
  }

  @Override
  public void deleteAuthorById(int authorId) throws RemoteException {
    dbHelper.deleteAuthorById(authorId);
  }

  @Override
  public void deleteBookById(int bookId) throws RemoteException {
    dbHelper.deleteBookById(bookId);
  }

  @Override
  public List<Author> getAllAuthors() throws RemoteException {
    return dbHelper.getAllAuthors();
  }

  @Override
  public List<Book> getAllBooks() throws RemoteException {
    return dbHelper.getAllBooks();
  }
}
```

### src\main\java\com\ssau\server\RMIServer.java
```java
package com.ssau.server;

import com.ssau.rmi.RemoteDatabaseService;
import com.ssau.rmi.RemoteDatabaseServiceImpl;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class RMIServer {

  public static void main(String[] args) {
    try {
      Registry registry = LocateRegistry.createRegistry(1099);
      RemoteDatabaseService service = new RemoteDatabaseServiceImpl();
      registry.rebind("DatabaseService", service);
      System.out.println("RMI-сервер запущен и объект зарегистрирован под именем 'DatabaseService'");
      System.in.read();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

}
```

