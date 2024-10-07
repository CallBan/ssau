package FirstPackage;

class SecondClass {
    private int num1;
    private int num2;

    public int getNum1() { return num1; }
    public int getNum2() { return num2; }

    public void setNum1(int val) { num1 = val; }
    public void setNum2(int val) { num2 = val; }

    public SecondClass(int num1, int num2) {
        this.num1 = num1;
        this.num2 = num2;
    }

    public int sumNums() {
        return num1 + num2;
    }
}