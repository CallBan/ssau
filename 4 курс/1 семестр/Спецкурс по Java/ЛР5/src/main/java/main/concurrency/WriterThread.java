package main.concurrency;

import java.util.Random;
import main.model.ElectronicDevice;

public class WriterThread extends Thread {
  private final ElectronicDevice device;

  public WriterThread(ElectronicDevice device) {
    this.device = device;
  }

  @Override
  public void run() {
    Random random = new Random();
    for (int i = 0; i < device.getComponentsOrApps().length; i++) {
      String val = "new-random-value#" + random.nextInt(100) + 1;
      device.writeVal(val, i);
    }
  }
}
