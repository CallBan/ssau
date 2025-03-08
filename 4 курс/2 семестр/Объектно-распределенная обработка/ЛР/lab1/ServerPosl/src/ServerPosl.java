import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;

public class ServerPosl {

    public static void main(String[] args) throws IOException {
        BufferedReader bufferedReader;
        BufferedWriter bufferedWriter;
        ServerSocket serverSocket = new ServerSocket(1234);
        int counter = 0;
        System.out.println("Server started...");
        while (true) {
            counter++;
            try {
                Socket socket = serverSocket.accept();
                System.out.println(" >> Client #" + counter + " started!");
                bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                bufferedWriter = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
                while (true) {
                    String messageFromClient = bufferedReader.readLine();
                    if (messageFromClient.equalsIgnoreCase("BYE")) {
                        System.out.println(" >> Client #" + counter + " exit!");
                        break;
                    }
                    String res = Division(messageFromClient);
                    System.out.println("Client #" + counter + ": " + messageFromClient);
                    bufferedWriter.write(res);
                    bufferedWriter.newLine();
                    bufferedWriter.flush();
                }
                socket.close();
                bufferedReader.close();
                bufferedWriter.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static String Division(String mes) {
        String mesForClient;
        String[] numbers = mes.split(" ");
        int a, b;
        try {
            a = Integer.parseInt(numbers[0]);
            b = Integer.parseInt(numbers[1]);
            if (b == 0) {
                mesForClient = "You can't divide by 0!";
            } else {
                int result = a / b;
                int remainder = a % b;
                mesForClient = "The result of dividing " + a + " by " + b + " - " + result + ". The remainder - " + remainder;
            }
        } catch (ArrayIndexOutOfBoundsException | NumberFormatException e) {
            mesForClient = "Enter 2 numbers separated by a space!";
        }
        return mesForClient;
    }
}
