package Server;

import Object.Point;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class CalculationImpl implements Calculation {

    private String name;

    public CalculationImpl(String n) throws RemoteException {
        name = n;
    }

    @Override
    public String getDescription() throws RemoteException {
        return "I am a " + name + ". Buy me!";
    }

    @Override
    public double areaOfCircleByDiameter(Point A, Point B) throws RemoteException {
        return (Math.PI * Math.pow(lengthOfSegment(A, B), 2)) / 4;
    }

    @Override
    public double lengthOfCircumferenceByDiameter(Point A, Point B) throws RemoteException {
        return Math.PI * lengthOfSegment(A, B);
    }

    @Override
    public double areaOfCircleByRadius(Point A, Point B) throws RemoteException {
        return Math.PI * Math.pow(lengthOfSegment(A, B), 2);
    }

    @Override
    public double lengthOfCircumferenceByRadius(Point A, Point B) throws RemoteException {
        return 2 * Math.PI * lengthOfSegment(A, B);
    }

    @Override
    public double lengthOfSegment(Point A, Point B) throws RemoteException {
        return Math.sqrt(Math.pow((B.getX() - A.getX()), 2) + Math.pow((B.getY() - A.getY()), 2));
    }
}

