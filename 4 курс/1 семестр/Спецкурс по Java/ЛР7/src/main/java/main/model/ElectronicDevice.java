package main.model;

import main.BusinessLogicException;

import java.io.IOException;
import java.io.OutputStream;
import java.io.Writer;

public interface ElectronicDevice extends Iterable<String> {
  String getModel();

  void setModel(String model);

  int getPriceOrMemory();

  void setPriceOrMemory(int value);

  String getElement(int index);

  String[] getComponentsOrApps();

  void setComponentsOrApps(String[] array);

  int calculateValue() throws BusinessLogicException;

  void output(OutputStream out) throws IOException;

  void write(Writer out) throws IOException, IOException;

  void writeVal(String val, int index);

  String readVal(int index);

  void fillItemsWithDefaultValues(int count);
}
