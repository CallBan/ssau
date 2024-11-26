package main;

import main.concurrency.*;
import main.model.Computer;
import main.model.ElectronicDevice;
import main.model.Smartphone;

import java.io.*;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Scanner;

public class DeviceManagerApp {

  private final ArrayList<ElectronicDevice> devices = new ArrayList<>();
  private final Scanner scanner = new Scanner(System.in);

  public static void main(String[] args) {
    DeviceManagerApp app = new DeviceManagerApp();
    app.start();
  }

  public void start() {
    boolean running = true;
    while (running) {
      System.out.println("\nМеню:");
      System.out.println("1. Добавить компьютер");
      System.out.println("2. Добавить смартфон");
      System.out.println("3. Заполнить устройства по умолчанию");
      System.out.println("4. Вывести все устройства");
      System.out.println("5. Записать устройства в байтовый поток");
      System.out.println("6. Прочитать устройства из байтового потока");
      System.out.println("7. Записать устройства в текстовый поток");
      System.out.println("8. Прочитать устройства из текстового потока");
      System.out.println("9. Сериализовать устройства");
      System.out.println("10. Десериализовать устройства");
      System.out.println("11. Форматированный вывод устройств");
      System.out.println("12. Форматированный ввод устройств");
      System.out.println("13. Несинхронизированные чтение и запись");
      System.out.println("14. Синхронизированные чтение и запись");
      System.out.println("15. Протестировать синхронизированный электронный девайс");
      System.out.println("0. Выйти");

      System.out.print("Выберите действие: ");
      int choice = scanner.nextInt();

      switch (choice) {
        case 1:
          addComputer();
          break;
        case 2:
          addSmartphone();
          break;
        case 3:
          fillDefaultDevices();
          break;
        case 4:
          showAllDevices();
          break;
        case 5:
          writeDevicesToByteStream();
          break;
        case 6:
          readDevicesFromByteStream();
          break;
        case 7:
          writeDevicesToCharStream();
          break;
        case 8:
          readDevicesFromCharStream();
          break;
        case 9:
          serializeDevices();
          break;
        case 10:
          deserializeDevices();
          break;
        case 11:
          formatWriteDevices();
          break;
        case 12:
          formatReadDevices();
          break;
        case 13:
          nonSynchReadWrite();
          break;
        case 14:
          synchReadWrite();
          break;
        case 15:
          testThreadSafeDevice();
          break;
        case 0:
          running = false;
          break;
        default:
          System.out.println("Неверный выбор, попробуйте снова.");
      }
    }
  }

  private void synchReadWrite() {
    ElectronicDevice device = new Smartphone(100);

    device.fillItemsWithDefaultValues(100);

    SimpleSemaphore semaphore = new SimpleSemaphore();

    WriterThreadSimple writerThread = new WriterThreadSimple(device, semaphore);
    ReaderThreadSimple readerThread = new ReaderThreadSimple(device, semaphore);

    Thread t1 = new Thread(writerThread);
    t1.start();
    Thread t2 = new Thread(readerThread);
    t2.start();

    try {
      t1.join();
      t2.join();
    } catch (InterruptedException e) {
      System.err.println("Нить прервана: " + e.getMessage());
    }
  }

  private void nonSynchReadWrite() {
    ElectronicDevice device = new Computer(100);

    device.fillItemsWithDefaultValues(100);

    WriterThread writerThread = new WriterThread(device);
    ReaderThread readerThread = new ReaderThread(device);

    writerThread.start();
    readerThread.start();

    try {
      writerThread.join();
      readerThread.join();
    } catch (InterruptedException e) {
      System.err.println("Нить прервана: " + e.getMessage());
    }
  }

  public static void  testThreadSafeDevice() {
    ElectronicDevice device = new Computer(100);
    device.fillItemsWithDefaultValues(100);
    device = DeviceIO.getThreadSafeDevice(device);

    WriterThread writerThread = new WriterThread(device);
    ReaderThread readerThread = new ReaderThread(device);

    writerThread.start();
    readerThread.start();

    try {
      writerThread.join();
      readerThread.join();
    } catch (InterruptedException e) {
      System.err.println("Нить прервана: " + e.getMessage());
    }
  }

  private void addComputer() {
    System.out.print("Введите модель компьютера: ");
    String model = scanner.next();
    System.out.print("Введите стоимость компьютера: ");
    int price = scanner.nextInt();
    System.out.print("Введите количество комплектующих: ");
    int componentsCount = scanner.nextInt();
    String[] components = new String[componentsCount];
    for (int i = 0; i < componentsCount; i++) {
      System.out.print("Введите название комплектующей #" + (i + 1) + ": ");
      components[i] = scanner.next();
    }

    devices.add(new Computer(components, model, price));
  }

  private void addSmartphone() {
    System.out.print("Введите модель смартфона: ");
    String model = scanner.next();
    System.out.print("Введите объём памяти смартфона: ");
    int memory = scanner.nextInt();
    System.out.print("Введите количество приложений: ");
    int appsCount = scanner.nextInt();
    String[] apps = new String[appsCount];
    for (int i = 0; i < appsCount; i++) {
      System.out.print("Введите название приложения #" + (i + 1) + ": ");
      apps[i] = scanner.next();
    }

    devices.add(new Smartphone(apps, model, memory));
  }

  // Метод для заполнения devices элементами по умолчанию с одинаковым результатом бизнес-метода
  private void fillDefaultDevices() {
    // Для компьютера: price + components.length * 10
    // Для смартфона: memory - apps.length * 10

    devices.add(new Computer(new String[]{"CPU", "GPU", "RAM", "HDD", "Motherboard", "SSD"},
            "Office PC", 1000));

    devices.add(new Smartphone(new String[]{"Instagram", "WhatsApp", "Facebook", "Telegram", "Spotify", "YouTube"},
            "Samsung Galaxy S22", 1120));

    System.out.println("Устройства по умолчанию с одинаковыми результатами бизнес-метода добавлены.");
  }

  private void showAllDevices() {
    for (ElectronicDevice device : devices) {
      System.out.println(device.toString());
    }
  }

  private void writeDevicesToByteStream() {
    try (FileOutputStream fos = new FileOutputStream("devices.dat")) {
      for (ElectronicDevice device : devices) {
        DeviceIO.outputElectronicDevice(device, fos);
      }
      System.out.println("Устройства успешно записаны в байтовый поток.");
    } catch (IOException e) {
      System.out.println("Ошибка при записи устройств: " + e.getMessage());
    }
  }

  private void readDevicesFromByteStream() {
    try (FileInputStream fis = new FileInputStream("devices.dat")) {
      ElectronicDevice device;
      while ((device = DeviceIO.inputElectronicDevice(fis)) != null) {
        devices.add(device);
      }
      System.out.println("Устройства успешно прочитаны из байтового потока.");
    } catch (IOException e) {
      System.out.println("Ошибка при чтении устройств: " + e.getMessage());
    }
  }

  private void writeDevicesToCharStream() {
    try (FileWriter writer = new FileWriter("devices.txt")) {
      for (ElectronicDevice device : devices) {
        DeviceIO.writeElectronicDevice(device, writer);
      }
      System.out.println("Устройства успешно записаны в текстовый поток.");
    } catch (IOException e) {
      System.out.println("Ошибка при записи устройств: " + e.getMessage());
    }
  }

  private void readDevicesFromCharStream() {
    try (FileReader reader = new FileReader("devices.txt")) {
      ArrayList<ElectronicDevice> devices = DeviceIO.readElectronicDevice(reader);
      System.out.println("Устройства успешно прочитаны из текстового потока.");
      this.devices.addAll(devices);
    } catch (IOException e) {
      System.out.println("Ошибка при чтении устройств: " + e.getMessage());
    }
  }

  // Методы для Задания 2

  private void serializeDevices() {
    try (FileOutputStream fos = new FileOutputStream("devices.ser")) {
      for (ElectronicDevice device : devices) {
        DeviceIO.serializeElectronicDevice(device, fos);
      }
      System.out.println("Устройства успешно сериализованы.");
    } catch (IOException e) {
      System.out.println("Ошибка при сериализации устройств: " + e.getMessage());
    }
  }

  private void deserializeDevices() {
    try (FileInputStream fis = new FileInputStream("devices.ser")) {
      while (fis.available() > 0) {
        ElectronicDevice device = DeviceIO.deserializeElectronicDevice(fis);
        devices.add(device);
      }
      System.out.println("Устройства успешно десериализованы.");
    } catch (IOException | ClassNotFoundException e) {
      System.out.println("Ошибка при десериализации устройств: " + e.getMessage());
    }
  }

  private void formatReadDevices() {
    try (Scanner sc = new Scanner(Paths.get("devices.format.txt"), "UTF-8")) {
      ElectronicDevice device;
      while ((device = DeviceIO.readFormat(sc)) != null) {
        devices.add(device);
      }
      System.out.println("Устройства успешно прочитаны из байтового потока.");
    } catch (Exception e) {
      System.out.println("Ошибка при чтении устройств: " + e.getMessage());
    }
  }

  private void formatWriteDevices() {
    try (FileWriter writer = new FileWriter("devices.format.txt")) {
      for (ElectronicDevice device : devices) {
        DeviceIO.writeFormat(device, writer);
      }
      System.out.println("Устройства успешно записаны в текстовый поток.");
    } catch (IOException e) {
      System.out.println("Ошибка при записи устройств: " + e.getMessage());
    }
  }

}
