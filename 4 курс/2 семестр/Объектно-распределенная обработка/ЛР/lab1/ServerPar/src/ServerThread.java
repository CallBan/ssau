import java.io.*;
import java.net.Socket;

public class ServerThread extends Thread {
    private int counter;
    private Socket socket;

    public ServerThread(Socket socket, int counter) {
        this.socket = socket;
        this.counter = counter;
    }

    @Override
    public void run() {
        try {
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
            while (true) {
                String messageFromClient = bufferedReader.readLine();
                String res;
                if (messageFromClient.equalsIgnoreCase("BYE"))
                    break;
                System.out.println("Client #" + counter + ": " + messageFromClient);
                res = Division(messageFromClient);
                Thread.sleep(5000);
                bufferedWriter.write(res);
                bufferedWriter.newLine();
                bufferedWriter.flush();
            }
            socket.close();
            bufferedReader.close();
            bufferedWriter.close();
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        } finally {
            System.out.println(" >> Client #" + counter + " exit!");
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
        }catch (ArrayIndexOutOfBoundsException | NumberFormatException e){
            mesForClient = "Enter 2 numbers separated by a space!";
        }
        return mesForClient;
    }
}
