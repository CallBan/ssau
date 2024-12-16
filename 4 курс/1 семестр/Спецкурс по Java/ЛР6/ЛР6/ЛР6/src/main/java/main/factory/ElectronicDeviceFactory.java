package main.factory;

import main.model.ElectronicDevice;

public interface ElectronicDeviceFactory {
    ElectronicDevice createInstance(int count);

    ElectronicDevice createInstance(String[] componentsOrApps, String model, int priceOrMemory);
}
