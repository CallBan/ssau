package main.concurrency;

import main.model.ElectronicDevice;

public class SimpleSemaphore {
  private boolean write = true;

  synchronized public void write(ElectronicDevice device, String val, int idx) {
    try {
      while (!write) {
        wait();
      }
      device.writeVal(val, idx);
      write = false;
      notifyAll();
    } catch (InterruptedException e) {
      throw new RuntimeException(e);
    }
  }

  synchronized public void read(ElectronicDevice device, int idx) {
    try {
      while (write) {
        wait();
      }
      device.readVal(idx);
      write = true;
      notifyAll();
    } catch (InterruptedException e) {
      throw new RuntimeException(e);
    }
  }
}
