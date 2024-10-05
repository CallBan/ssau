public interface ElectronicDevice {
  String getModel();
  void setModel(String model);

  int getPriceOrMemory();
  void setPriceOrMemory(int value);

  String[] getComponentsOrApps();
  void setComponentsOrApps(String[] array);

  int calculateValue() throws BusinessLogicException;
}
