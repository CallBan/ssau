import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "MyServlet", value = "/image.jpg")
public class MyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("image/jpg");
        OutputStream out = response.getOutputStream();
        try {
            BufferedImage bf = new BufferedImage(640, 120, BufferedImage.TYPE_INT_RGB);
            Graphics g = bf.getGraphics();
            Font font = new Font("Times New Roman", Font.BOLD, 72);
            g.setFont(font);
            Random random = new Random();
            Color color = new Color(random.nextInt(256), random.nextInt(256), random.nextInt(256));
            g.setColor(color);
            g.drawString("Hello world ", 100, 100);
            g.dispose();
            ImageIO.write(bf, "jpg", out);
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
