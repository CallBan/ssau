package main.concurrency;

import main.model.ElectronicDevice;

public class ReaderThreadSimple implements Runnable {
  private ElectronicDevice device;
  private final SimpleSemaphore semaphore;

  public ReaderThreadSimple(ElectronicDevice device, SimpleSemaphore semaphore) {
    this.device = device;
    this.semaphore = semaphore;
  }

  @Override
  public void run() {
    for (int i = 0; i < device.getComponentsOrApps().length; i++) {
      try {
        semaphore.read(device, i);
      } catch (Exception e) {
      }
    }
  }
}
