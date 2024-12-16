package main.model;

import main.BusinessLogicException;

import java.io.IOException;
import java.io.OutputStream;
import java.io.Writer;
import java.util.Iterator;

public class ElectronicDeviceUnmodifiable implements ElectronicDevice {
    private final ElectronicDevice device;

    public ElectronicDeviceUnmodifiable(ElectronicDevice device) {this.device = device;}

    @Override
    public String getModel() {
        return device.getModel();
    }

    @Override
    public void setModel(String model) {
        throw new UnsupportedOperationException("Внесение изменений не допускается");
    }

    @Override
    public int getPriceOrMemory() {
        return device.getPriceOrMemory();
    }

    @Override
    public void setPriceOrMemory(int value) {
        throw new UnsupportedOperationException("Внесение изменений не допускается");
    }

    @Override
    public String getElement(int index) {
        return device.getElement(index);
    }

    @Override
    public String[] getComponentsOrApps() {
        return device.getComponentsOrApps();
    }

    @Override
    public void setComponentsOrApps(String[] array) {
        throw new UnsupportedOperationException("Внесение изменений не допускается");
    }

    @Override
    public int calculateValue() throws BusinessLogicException {
        return device.calculateValue();
    }

    @Override
    public void output(OutputStream out) throws IOException {
        device.output(out);
    }

    @Override
    public void write(Writer out) throws IOException, IOException {
        device.write(out);
    }

    @Override
    public void writeVal(String val, int index) {
        device.writeVal(val, index);
    }

    @Override
    public String readVal(int index) {
        return device.readVal(index);
    }

    @Override
    public void fillItemsWithDefaultValues(int count) {
        device.fillItemsWithDefaultValues(count);
    }

    @Override
    public Iterator<String> iterator() {
        return device.iterator();
    }
}
