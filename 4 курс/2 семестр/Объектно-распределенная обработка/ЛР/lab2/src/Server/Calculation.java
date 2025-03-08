package Server;

import Object.Point;

import java.rmi.Remote;
import java.rmi.RemoteException;

public interface Calculation extends Remote {
    String getDescription() throws RemoteException;

    double lengthOfSegment(Point A, Point B) throws RemoteException;
    double lengthOfCircumferenceByRadius(Point A, Point B) throws RemoteException;
    double areaOfCircleByRadius(Point A, Point B) throws RemoteException;
    double lengthOfCircumferenceByDiameter(Point A, Point B) throws RemoteException;
    double areaOfCircleByDiameter(Point A, Point B) throws RemoteException;
}
