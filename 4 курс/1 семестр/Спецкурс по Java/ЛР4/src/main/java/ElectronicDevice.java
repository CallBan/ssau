import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.Scanner;

public interface ElectronicDevice {
  String getModel();

  void setModel(String model);

  int getPriceOrMemory();

  void setPriceOrMemory(int value);

  String[] getComponentsOrApps();

  void setComponentsOrApps(String[] array);

  int calculateValue() throws BusinessLogicException;

  void output(OutputStream out) throws IOException;
  void write(Writer out) throws IOException;
}
