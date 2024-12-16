package main.model;

import java.util.Iterator;
import java.util.NoSuchElementException;

public class ElectronicIterator implements Iterator<String> {
    private final ElectronicDevice electronicDevice;
    private int index;

    public ElectronicIterator(ElectronicDevice electronicDevice) {
        this.electronicDevice = electronicDevice;
        index = 0;
    }

    @Override
    public boolean hasNext() {
        return index < electronicDevice.getComponentsOrApps().length;
    }

    @Override
    public String next() {
        if (!hasNext()){
            throw new NoSuchElementException();
        }
        return electronicDevice.getElement(index++);
    }
}
