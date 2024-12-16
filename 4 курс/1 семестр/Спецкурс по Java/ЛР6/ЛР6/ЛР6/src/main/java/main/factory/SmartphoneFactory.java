package main.factory;

import main.model.ElectronicDevice;
import main.model.Smartphone;

public class SmartphoneFactory implements ElectronicDeviceFactory{

    @Override
    public ElectronicDevice createInstance(int count) {
        ElectronicDevice device = new Smartphone(count);
        device.fillItemsWithDefaultValues(count);
        return device;
    }

    @Override
    public ElectronicDevice createInstance(String[] componentsOrApps, String model, int priceOrMemory) {
        return new Smartphone(componentsOrApps, model, priceOrMemory);
    }
}
