package main.model;

import main.BusinessLogicException;
import main.InvalidDataException;

import java.io.IOException;
import java.io.OutputStream;
import java.io.Serializable;
import java.io.Writer;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.Objects;

public class Smartphone implements ElectronicDevice, Serializable {
  private static final long serialVersionUID = 17549239L;

  private String[] apps;
  private String model;
  private int memory;

  public Smartphone() {
    this.apps = new String[]{};
    this.model = "";
    this.memory = 0;
  }

  public Smartphone(int size) {
    this.apps = new String[size];
    this.model = "Smartphone::Default";
    this.memory = 0;
  }

  public Smartphone(String[] apps, String model, int memory) {
    if (apps == null || apps.length == 0) {
      throw new InvalidDataException("Массив приложений не может быть пустым.");
    }
    if (memory < 0) {
      throw new InvalidDataException("Объем памяти не может быть отрицательным.");
    }
    this.apps = apps;
    this.model = model;
    this.memory = memory;
  }

  @Override
  public String getModel() {
    return model;
  }

  @Override
  public void setModel(String model) {
    this.model = model;
  }

  @Override
  public int getPriceOrMemory() {
    return memory;
  }

  @Override
  public void setPriceOrMemory(int memory) {
    this.memory = memory;
  }

  @Override
  public String[] getComponentsOrApps() {
    return apps;
  }

  @Override
  public void setComponentsOrApps(String[] apps) {
    this.apps = apps;
  }

  // Бизнес-метод: расчёт оставшегося объёма памяти после установки приложений
  @Override
  public int calculateValue() throws BusinessLogicException {
    if (memory < apps.length + 10) {
      throw new BusinessLogicException("Недостаточно памяти для всех установленных приложений.");
    }
    return memory - apps.length * 10;
  }

  @Override
  public String toString() {
    return "Smartphone{" +
            "apps=" + Arrays.toString(apps) +
            ", model='" + model + '\'' +
            ", memory=" + memory +
            '}';
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;

    Smartphone that = (Smartphone) o;
    return memory == that.memory && Arrays.equals(apps, that.apps) && Objects.equals(model, that.model);
  }

  @Override
  public int hashCode() {
    int result = Arrays.hashCode(apps);
    result = 31 * result + Objects.hashCode(model);
    result = 31 * result + memory;
    return result;
  }

  @Override
  public void output(OutputStream out) throws IOException {
    StringBuilder sb = new StringBuilder();
    sb.append(model).append("\n");
    sb.append(memory).append("\n");
    sb.append(String.join(",", apps)).append("\n");
    out.write(sb.toString().getBytes(StandardCharsets.UTF_8));
  }

  @Override
  public void write(Writer out) throws IOException {
    out.write(model + "&");
    out.write(memory + "&");
    out.write(String.join(" ", apps) + "\n");
  }

  @Override
  public void writeVal(String val, int index) {
    if (index < apps.length) {
      apps[index] = val;
    } else {
      apps = Arrays.copyOf(apps, apps.length + 1);
      apps[apps.length - 1] = val;
    }
    System.out.println("Smartphone Write: " + val + " to position " + index);
  }

  @Override
  public String readVal(int index) {
    String comp = apps[index];
    System.out.println("Smartphone Read: " + comp + " from position " + index);
    return comp;
  }

  @Override
  public void fillItemsWithDefaultValues(int count) {
    for (int i = 0; i < count; i++) {
      apps[i] = "Smartphone::DefaultApp#" + i;
    }
    System.out.println("Smartphone filled with default values.");
  }
}
