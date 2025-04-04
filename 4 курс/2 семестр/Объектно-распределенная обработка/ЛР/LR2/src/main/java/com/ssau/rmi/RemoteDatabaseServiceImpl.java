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
