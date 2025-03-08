package Server;

import java.rmi.registry.Registry;
import java.rmi.registry.LocateRegistry;
import java.rmi.server.UnicastRemoteObject;

public class CalculationServer {

    public static void main(String args[]) {

        try {
            CalculationImpl obj = new CalculationImpl("point1");
            Calculation stub = (Calculation) UnicastRemoteObject.exportObject(obj, 0);


            Registry registry = LocateRegistry.createRegistry(2732);
            registry.bind("lab2", stub);

            System.out.println("Server started...");
        } catch (Exception e) {
            System.err.println("Server exception: " + e.toString());
            e.printStackTrace();
        }
    }


}
