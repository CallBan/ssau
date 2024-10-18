import java.io.*;
import java.lang.reflect.Array;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import java.io.StreamTokenizer;
import java.nio.*;
import java.util.stream.Collectors;

public class DeviceIO {

  public static void outputElectronicDevice(ElectronicDevice device, OutputStream out) throws IOException {
    device.output(out);
  }

  private static String readLine(InputStream in) throws IOException {
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    int b;
    while ((b = in.read()) != -1) {
      if (b == '\n') {
        break;
      }
      baos.write(b);
    }
    if (baos.size() == 0 && b == -1) {
      return null; // Конец потока
    }
    return baos.toString(StandardCharsets.UTF_8);
  }

  public static ElectronicDevice inputElectronicDevice(InputStream in) throws IOException {
    String model = readLine(in);
    if (model == null || model.isEmpty()) return null;

    String priceOrMemoryStr = readLine(in);
    if (priceOrMemoryStr == null || priceOrMemoryStr.isEmpty()) return null;
    int priceOrMemory;
    priceOrMemory = Integer.parseInt(priceOrMemoryStr);

    String componentsOrAppsStr = readLine(in);
    if (componentsOrAppsStr == null || componentsOrAppsStr.isEmpty()) return null;
    String[] componentsOrApps = componentsOrAppsStr.split(",");

    return new Computer(componentsOrApps, model, priceOrMemory);
  }

  public static void writeElectronicDevice(ElectronicDevice device, Writer out) throws IOException {
    device.write(out);
  }


public static ElectronicDevice readElectronicDevice(Reader in) throws IOException {
  BufferedReader reader = new BufferedReader(in);

  String line = reader.readLine();
  if (line == null) return null;

  String[] parts = line.split("&");
  return new Computer(parts[2].split(" "), parts[0], Integer.parseInt(parts[1]));
}


  public static void serializeElectronicDevice(ElectronicDevice device, OutputStream out) throws IOException {
    ObjectOutputStream oos = new ObjectOutputStream(out);
    oos.writeObject(device);
    oos.flush();
  }

  public static ElectronicDevice deserializeElectronicDevice(InputStream in) throws IOException, ClassNotFoundException {
    ObjectInputStream ois = new ObjectInputStream(in);
    Object obj = ois.readObject();
    if (obj instanceof ElectronicDevice) {
      return (ElectronicDevice) obj;
    } else {
      throw new IOException("Прочитанный объект не является ElectronicDevice.");
    }
  }


  public static void writeFormat(ElectronicDevice device, Writer out) throws IOException {
    if (device instanceof Smartphone) {
      Smartphone smartphone = (Smartphone) device;
      out.write(String.format("Smartphone&%s&%d&%s\n",
              smartphone.getModel(),
              smartphone.getPriceOrMemory(),
              String.join(" ", smartphone.getComponentsOrApps())
      ));
    } else if (device instanceof Computer) {
      Computer computer = (Computer) device;
      out.write(String.format("Computer&%s&%d&%s\n",
              computer.getModel(),
              computer.getPriceOrMemory(),
              String.join(" ", computer.getComponentsOrApps())
      ));
    }
  }

  public static ElectronicDevice readFormat(Scanner in) {
    if (!in.hasNext()) return null;
    in.useDelimiter("&");

    String type = in.next();
    String model = in.next();
    int priceOrMemory = in.nextInt();

    String[] componentsOrApps = in.nextLine().split(" ");

    if (type.equals("Smartphone")) {
      return new Smartphone(componentsOrApps, model, priceOrMemory);
    } else if (type.equals("Computer")) {
      return new Computer(componentsOrApps, model, priceOrMemory);
    } else {
      throw new IllegalArgumentException("Неподдерживаемый тип устройства.");
    }
  }

}
