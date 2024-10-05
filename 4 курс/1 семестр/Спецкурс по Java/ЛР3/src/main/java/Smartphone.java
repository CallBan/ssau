import java.util.Arrays;
import java.util.Objects;

public class Smartphone implements ElectronicDevice {
  private String[] apps;
  private String model;
  private int memory;

  public Smartphone() {
    this.apps = new String[]{};
    this.model = "";
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
}
