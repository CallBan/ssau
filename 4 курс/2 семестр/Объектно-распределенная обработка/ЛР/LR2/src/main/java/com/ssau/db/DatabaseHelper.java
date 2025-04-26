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
        System.out.println("Вы действительно хотите удалить автора и все связанные записи? (1 (Да)/0 (Нет)");

        Scanner scanner = new Scanner(System.in);
        Integer answer = scanner.nextInt();
        scanner.nextLine();
        // Если пользователь подтверждает удаление
        if (answer == 1) {
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
