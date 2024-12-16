package main.factory;

import main.model.Computer;
import main.model.ElectronicDevice;

public class ComputerFactory implements ElectronicDeviceFactory{
    @Override
    public ElectronicDevice createInstance(int count) {
        ElectronicDevice computer = new Computer(count);
        computer.fillItemsWithDefaultValues(count);
        return computer;
    }
    @Override
    public ElectronicDevice createInstance(String[] componentsOrApps, String model, int priceOrMemory)
    {
        return new Computer(componentsOrApps,  model,  priceOrMemory);
    };
}
