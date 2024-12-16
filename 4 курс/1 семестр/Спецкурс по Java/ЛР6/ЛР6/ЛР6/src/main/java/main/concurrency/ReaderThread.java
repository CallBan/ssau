package main.concurrency;

import main.model.ElectronicDevice;

public class ReaderThread extends Thread {
  private final ElectronicDevice electronicDevice;

  public ReaderThread(ElectronicDevice electronicDevice) {
    this.electronicDevice = electronicDevice;
  }

  @Override
  public void run() {
    for (int i = 0; i < electronicDevice.getComponentsOrApps().length; i++) {
      electronicDevice.readVal(i);
    }
  }
}
