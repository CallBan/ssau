package main.concurrency;

import main.model.ElectronicDevice;

import java.util.Random;

public class WriterThreadSimple implements Runnable {
  private ElectronicDevice device;
  private final SimpleSemaphore semaphore;

  public WriterThreadSimple(ElectronicDevice device, SimpleSemaphore semaphore) {
    this.device = device;
    this.semaphore = semaphore;
  }

  @Override
  public void run() {
    Random random = new Random();
    for (int i = 0; i < device.getComponentsOrApps().length; i++) {
      try {
        String val = "new-random-value#" + random.nextInt(100) + 1;
        semaphore.write(device, val, i);
      } catch (Exception e) { }
    }
  }
}
