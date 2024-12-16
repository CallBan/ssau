package main.model;

import main.BusinessLogicException;

import java.io.IOException;
import java.io.OutputStream;
import java.io.Writer;
import java.util.Iterator;


public class ThreadSafeDevice implements ElectronicDevice {

  final private ElectronicDevice device;

    public ThreadSafeDevice(ElectronicDevice device) {
        this.device = device;
    }

    @Override
  public synchronized String getModel() {
    return device.getModel();
  }

  @Override
  public synchronized void setModel(String model) {
    device.setModel(model);
  }

  @Override
  public synchronized int getPriceOrMemory() {
    return device.getPriceOrMemory();
  }

  @Override
  public synchronized void setPriceOrMemory(int value) {
    device.setPriceOrMemory(value);
  }

  @Override
  public String getElement(int index) {
    return device.getElement(index);
  }

  @Override
  public synchronized String[] getComponentsOrApps() {
    return device.getComponentsOrApps();
  }

  @Override
  public synchronized void setComponentsOrApps(String[] array) {
    device.setComponentsOrApps(array);
  }

  @Override
  public synchronized int calculateValue() throws BusinessLogicException {
    return device.calculateValue();
  }

  @Override
  public synchronized void output(OutputStream out) throws IOException {
    device.output(out);
  }

  @Override
  public synchronized void write(Writer out) throws IOException {
    device.write(out);
  }

  @Override
  public synchronized void writeVal(String val, int index) {
    device.writeVal(val, index);
  }

  @Override
  public synchronized String readVal(int index) {
    return device.readVal(index);
  }

  @Override
  public synchronized void fillItemsWithDefaultValues(int count) {
    device.fillItemsWithDefaultValues(count);
  }

  @Override
  public Iterator<String> iterator() {
    return device.iterator();
  }
}
