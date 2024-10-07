public class Vector {
    private double[] coords;

    // Конструктор
    public Vector(int length) {
        if (length <= 0) {
            throw new IllegalArgumentException("Длина вектора должна быть больше 0.");
        }
        coords = new double[length];
    }

    // Методы доступа к элементам
    public double getCoord(int index) {
        if (index < 0 || index >= coords.length) {
            throw new IndexOutOfBoundsException("Индекс за пределами допустимого диапазона.");
        }
        return coords[index];
    }

    public void setCoord(int index, double value) {
        if (index < 0 || index >= coords.length) {
            throw new IndexOutOfBoundsException("Индекс за пределами допустимого диапазона.");
        }
        coords[index] = value;
    }

    // Получение "длины" вектора
    public int getLength() {
        return coords.length;
    }

    // Поиск минимального и максимального значений
    public double findMin() {
        if (coords.length == 0) {
            throw new IllegalArgumentException("Вектор пустой.");
        }
        double min = coords[0];
        for (double component : coords) {
            if (component < min) {
                min = component;
            }
        }
        return min;
    }

    public double findMax() {
        if (coords.length == 0) {
            throw new IllegalArgumentException("Вектор пустой.");
        }
        double max = coords[0];
        for (double component : coords) {
            if (component > max) {
                max = component;
            }
        }
        return max;
    }

    // Сортировка вектора по возрастанию
    public void sort() {
        for (int i = 0; i < coords.length - 1; i++) {
            for (int j = i + 1; j < coords.length; j++) {
                if (coords[i] > coords[j]) {
                    double temp = coords[i];
                    coords[i] = coords[j];
                    coords[j] = temp;
                }
            }
        }
    }

    // Нахождение евклидовой нормы
    public double norm() {
        double sumSquares = 0;
        for (double component : coords) {
            sumSquares += component * component;
        }
        return Math.sqrt(sumSquares);
    }

    // Умножение вектора на число
    public void multiply(double scalar) {
        for (int i = 0; i < coords.length; i++) {
            this.setCoord(i, coords[i] * scalar);
        }
    }

    // Статический метод сложения векторов
    public static Vector add(Vector v1, Vector v2) {
        if (v1.getLength() != v2.getLength()) {
            throw new IllegalArgumentException("Векторы должны иметь одинаковую длину.");
        }
        Vector result = new Vector(v1.getLength());
        for (int i = 0; i < v1.getLength(); i++) {
            result.setCoord(i, v1.getCoord(i) + v2.getCoord(i));
        }
        return result;
    }

    // Статический метод скалярного произведения
    public static double dotProduct(Vector v1, Vector v2) {
        if (v1.getLength() != v2.getLength()) {
            throw new IllegalArgumentException("Векторы должны иметь одинаковую длину.");
        }
        double product = 0;
        for (int i = 0; i < v1.getLength(); i++) {
            product += v1.getCoord(i) * v2.getCoord(i);
        }
        return product;
    }

    // Метод для вывода вектора в консоль
    public void print() {
        System.out.print("[");
        for (int i = 0; i < coords.length; i++) {
            System.out.print(coords[i]);
            if (i < coords.length - 1) {
                System.out.print(", ");
            }
        }
        System.out.println("]");
    }
}