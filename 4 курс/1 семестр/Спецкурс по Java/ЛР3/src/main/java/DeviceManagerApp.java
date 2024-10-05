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
      System.out.println("5. Найти устройства с одинаковыми результатами бизнес-метода");
      System.out.println("6. Разделить устройства по типу");
      System.out.println("7. Выйти");

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
          findDevicesWithSameBusinessResult();
          break;
        case 6:
          splitDevicesByType();
          break;
        case 7:
          running = false;
          break;
        default:
          System.out.println("Неверный выбор, попробуйте снова.");
      }
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

  private void findDevicesWithSameBusinessResult() {
    ArrayList<ArrayList<ElectronicDevice>> resultGroups = new ArrayList<>();

    for (ElectronicDevice device : devices) {
      boolean found = false;
      try {
        for (ArrayList<ElectronicDevice> group : resultGroups) {
          if (group.get(0).calculateValue() == device.calculateValue()) {
            group.add(device);
            found = true;
            break;
          }
        }
        if (!found) {
          ArrayList<ElectronicDevice> newGroup = new ArrayList<>();
          newGroup.add(device);
          resultGroups.add(newGroup);
        }
      } catch (BusinessLogicException e) {
        System.out.println("Ошибка бизнес-логики: " + e.getMessage());
      }
    }

    System.out.println("\nГруппы устройств с одинаковыми результатами бизнес-метода:");
    for (ArrayList<ElectronicDevice> group : resultGroups) {
      if (group.size() > 1) {
        for (ElectronicDevice device : group) {
          System.out.println(device);
        }
        System.out.println("---");
      }
    }
  }

  private void splitDevicesByType() {
    ArrayList<Computer> computers = new ArrayList<>();
    ArrayList<Smartphone> smartphones = new ArrayList<>();

    for (ElectronicDevice device : devices) {
      if (device instanceof Computer) {
        computers.add((Computer) device);
      } else if (device instanceof Smartphone) {
        smartphones.add((Smartphone) device);
      }
    }

    System.out.println("\nКомпьютеры:");
    for (Computer computer : computers) {
      System.out.println(computer);
    }

    System.out.println("\nСмартфоны:");
    for (Smartphone smartphone : smartphones) {
      System.out.println(smartphone);
    }
  }
}
