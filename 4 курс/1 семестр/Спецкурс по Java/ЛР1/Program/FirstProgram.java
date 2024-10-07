import FirstPackage.*;

class FirstClass {
    public static void main(String[] s) {
        SecondClass o = new SecondClass(1, 1);
        int i, j;
        for (i = 1; i <= 8; i++) {
            for (j = 1; j <= 8; j++) {
                o.setNum1(i);
                o.setNum2(j);
                System.out.print(o.sumNums());
                System.out.print(" ");
            }
            System.out.println();
        }
    }
}