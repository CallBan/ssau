public class Main {
    public static void main(String[] args) {
        Vector v1 = new Vector(3);
        v1.setCoord(0, 1.0);
        v1.setCoord(1, 2.0);
        v1.setCoord(2, 3.0);

        Vector v2 = new Vector(3);
        v2.setCoord(0, 4.0);
        v2.setCoord(1, 5.0);
        v2.setCoord(2, 6.0);


        System.out.println("Вектор v1:");
        v1.print();

        System.out.println("Вектор v2:");
        v2.print();

        // Вычисление евклидовой нормы
        System.out.println("Норма вектора v1: " + v1.norm());

        // Умножение вектора на число
        v1.multiply(2.0);
        System.out.println("Вектор v1 * 2.0:");
        v1.print();

        // Сложение векторов
        Vector v4 = Vector.add(v1, v2);
        System.out.println("Вектор v1 + v2:");
        v4.print();

        // Скалярное произведение векторов
        double dotProduct = Vector.dotProduct(v1, v2);
        System.out.println("Скалярное произведение v1 и v2: " + dotProduct);
    }
}