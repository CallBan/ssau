package Client;

import Server.Calculation;
import Object.Point;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.Scanner;

public class CalculationClient {

    private CalculationClient() {
    }

    public static void main(String[] args) {

        try {
            Scanner in = new Scanner(System.in);

            Registry registry = LocateRegistry.getRegistry(2732);
            Calculation stub = (Calculation) registry.lookup("lab2");

            System.out.println("Координата X для точки A: ");
            int xA = in.nextInt();
            System.out.println("Координата Y для точки A: ");
            int yA = in.nextInt();
            Point A = new Point(xA, yA);

            System.out.println("Координата X для точки B: ");
            int xB = in.nextInt();
            System.out.println("Координата Y для точки B: ");
            int yB = in.nextInt();
            Point B = new Point(xB, yB);

            while (true) {
                double response;
                System.out.println("\n--------------------------------------------------------------------------------------------------------");
                System.out.println("Меню:");
                System.out.println("1) Расчёт длины отрезка между точками");
                System.out.println("2) Расчёт длины окружности, центром которой является одна из точек, а радиусом расстояние между точками");
                System.out.println("3) Расчёт площади круга, центром которого является одна из точек, а радиусом расстояние между точками");
                System.out.println("4) Расчёт длины окружности, диаметром которой является расстояние между точками");
                System.out.println("5) Расчёт площади круга, диаметром которого является расстояние между точками");
                System.out.println("0) Выход");
                System.out.println("\nВаш выбор: ");
                int choice = in.nextInt();
                System.out.println("--------------------------------------------------------------------------------------------------------\n");
                switch (choice) {
                    case 1: {
                        response = stub.lengthOfSegment(A, B);
                        System.out.println("Server >> Длина отрезка: " + response);
                        break;
                    }
                    case 2: {
                        response = stub.lengthOfCircumferenceByRadius(A, B);
                        System.out.println("Server >> Длина окружности: " + response);
                        break;
                    }
                    case 3: {
                        response = stub.areaOfCircleByRadius(A, B);
                        System.out.println("Server >> Площадь круга: " + response);
                        break;
                    }
                    case 4: {
                        response = stub.lengthOfCircumferenceByDiameter(A, B);
                        System.out.println("Server >> Длина окружности: " + response);
                        break;
                    }
                    case 5: {
                        response = stub.areaOfCircleByDiameter(A, B);
                        System.out.println("Server >> Площадь круга: " + response);
                        break;
                    }
                    case 0: {
                        return;
                    }
                    default: {
                        System.out.println("Wrong input! Try again");
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Client exception: " + e.toString());
            e.printStackTrace();
        }
    }
}
