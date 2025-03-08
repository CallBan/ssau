package server;

import java.io.*;
import java.net.*;

public class Sequential {
    public static void main(String[] args) {
        int port = 12345;
        try (ServerSocket serverSocket = new ServerSocket(port)) {
            System.out.println("Сервер запущен на порту " + port);
            while (true) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("Подключен клиент: " + clientSocket.getInetAddress());
                handleClient(clientSocket);
                clientSocket.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    private static void handleClient(Socket socket) {
        try (BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
             PrintWriter out = new PrintWriter(socket.getOutputStream(), true)) {
            String line;
            while ((line = in.readLine()) != null) {
                String[] tokens = line.trim().split("\\s+");
                if (tokens.length != 4) {
                    out.println("Неверный формат данных. Ожидается 4 числа.");
                    continue;
                }
                try {
                    double x1 = Double.parseDouble(tokens[0]);
                    double y1 = Double.parseDouble(tokens[1]);
                    double x2 = Double.parseDouble(tokens[2]);
                    double y2 = Double.parseDouble(tokens[3]);

                    double distance = Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
                    if (distance == 0) {
                        out.println("Ошибка: расстояние равно 0");
                    } else {
                        out.println("Расстояние: " + distance);
                    }
                } catch (NumberFormatException ex) {
                    out.println("Ошибка: введены некорректные числовые значения.");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

