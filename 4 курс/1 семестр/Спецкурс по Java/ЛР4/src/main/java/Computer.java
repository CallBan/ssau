import java.io.IOException;
import java.io.OutputStream;
import java.io.Serializable;
import java.io.Writer;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.Objects;

public class Computer implements ElectronicDevice, Serializable {
  private static final long serialVersionUID = 11832498L;

  private String[] components;
  private String model;
  private int price;

  public Computer() {
    this.components = new String[0];
    this.model = "";
    this.price = 0;
  }

  public Computer(String[] components, String model, int price) {
    if (components == null || components.length == 0) {
      throw new InvalidDataException("Массив компонентов не может быть пустым.");
    }
    if (price < 0) {
      throw new InvalidDataException("Цена не может быть отрицательной.");
    }
    this.components = components;
    this.model = model;
    this.price = price;
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
    return price;
  }

  @Override
  public void setPriceOrMemory(int price) {
    this.price = price;
  }

  @Override
  public String[] getComponentsOrApps() {
    return components;
  }

  @Override
  public void setComponentsOrApps(String[] components) {
    this.components = components;
  }

  // Бизнес-метод: подсчёт общей стоимости компьютера с учётом всех комплектующих
  @Override
  public int calculateValue() throws BusinessLogicException {
    int result = price + components.length * 10;
    if (result < 0) {
      throw new BusinessLogicException("Цена не может быть отрицательной");
    }
    return result;
  }

  @Override
  public String toString() {
    return "Computer{" +
            "components=" + Arrays.toString(components) +
            ", model='" + model + '\'' +
            ", price=" + price +
            '}';
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;

    Computer computer = (Computer) o;
    return price == computer.price && Arrays.equals(components, computer.components) && Objects.equals(model, computer.model);
  }

  @Override
  public int hashCode() {
    int result = Arrays.hashCode(components);
    result = 31 * result + Objects.hashCode(model);
    result = 31 * result + price;
    return result;
  }

  @Override
  public void output(OutputStream out) throws IOException {
    StringBuilder sb = new StringBuilder();
    sb.append(model).append("\n");
    sb.append(price).append("\n");
    sb.append(String.join(",", components)).append("\n");
    out.write(sb.toString().getBytes(StandardCharsets.UTF_8));
  }

  @Override
  public void write(Writer out) throws IOException {
    out.write(model + "&");
    out.write(price + "&");
    out.write(String.join(" ", components) + "\n");
  }

}
