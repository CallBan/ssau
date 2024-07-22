class Figure {
    #x;
    #y;

    constructor(x, y) {
        this.#x = x;
        this.#y = y;
    }

    square() {
        return undefined;
    }
}

class Circle extends Figure {
    #r;

    constructor(x, y, r) {
        super(x, y);
        this.#r = r;
    }

    square() {
        return Math.PI * this.#r ** 2;
    }
}

class Rectangle extends Figure {
    #h;
    #w;

    constructor(x, y, h, w) {
        super(x, y);
        this.#h = h;
        this.#w = w;
    }

    square() {
        return this.#h * this.#w;
    }
}

let circle = new Circle(0, 0, 5);
let rectangle = new Rectangle(0, 0, 3, 5);

console.log(`Площадь круга - ${circle.square()}`);
console.log(`Площадь прямоугольника - ${rectangle.square()}`);
