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
      Thread.currentThread().join();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

}
