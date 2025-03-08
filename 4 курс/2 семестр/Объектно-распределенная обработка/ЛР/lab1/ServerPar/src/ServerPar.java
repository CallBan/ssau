import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;

public class ServerPar {

    public static void main(String[] args) throws IOException {
        try {
            ServerSocket serverSocket = new ServerSocket(1234);
            int counter = 0;
            System.out.println("Server started...");
            while (true) {
                counter++;
                Socket socket = serverSocket.accept();
                System.out.println(" >> Client #" + counter + " started!");
                ServerThread serverThread = new ServerThread(socket, counter);
                serverThread.start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}