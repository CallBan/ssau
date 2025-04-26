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
