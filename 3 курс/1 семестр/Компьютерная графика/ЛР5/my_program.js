// базовый набор цветов, который может пригодится
let Colors = {
    WHITE: "rgb(255,255,255)",
    WHITE_SAVE: "rgb(250,245,245)",
    BLACK: "rgb(0,0,0)",
    BLACK_SAVE: "rgb(5,3,3)",
    RED: "rgb(255,0,0)",
    YELLOW: "rgb(255,255,0)",
    ORANGE: "rgb(255,69,0)",
    BLUE: "rgb(0,0,255)"
}

// класс работы с холстом
class CanvasFrame2D{
    // id элемента холста в html, высота и ширина канваса соответственно
    constructor(id_element, width, height){
        this.canvas = document.getElementById(id_element);
        this.ctx = this.canvas.getContext('2d');
        this.set_height_width(width, height);
        this.Image_data = this.ctx.getImageData(0, 0, width, height)
        this.fill_canvas();
        console.log("Отработал конструктор CanvasFrame2D");
    }

    // метод получения данных картинки с холста
    get_image_data(){
        let imageData = this.ctx.getImageData(0, 0, this.canvas.getBoundingClientRect().width, this.canvas.getBoundingClientRect().height)
        return imageData;
    }

    // метод изменения ширины окна холаста
    set_height_width(width, height){
        this.canvas.width  = width;
        this.canvas.height = height;
        console.log("Отработал метод set_height_width класса CanvasFrame2D");
    }

    // метод закраски окна канвас
    fill_canvas(color="white"){
        this.ctx.fillStyle = color
        this.ctx.fillRect(0,0,this.canvas.width,this.canvas.height)
        console.log("Отработал метод fill_canvas класса CanvasFrame2D");
    }

    // метод очистки содержимого холста
    clear_canvas(){
        this.ctx.beginPath();
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
        console.log("Отработал метод clear_canvas класса CanvasFrame2D");
    }
}

// класс точки, хранит координаты
class Points{
    constructor(x,y,z){
        this.X = x;
        this.Y = y;
        this.Z = z;
    }
}

// класс для отрисовки 3d приколюх
class Graphic3D{
    constructor(canv){
        this.canv = canv;
        this.ctx = canv.ctx;
        this.color_border = Colors.BLACK
        this.color_pixel = Colors.BLACK

        // получаем элементы из html по id
        this.oftb_x = document.getElementById("oftrackbar_x");
        this.oftb_y = document.getElementById("oftrackbar_y");
        this.oftb_z = document.getElementById("oftrackbar_z");
        this.rtb_x = document.getElementById("rtrackbar_x");
        this.rtb_y = document.getElementById("rtrackbar_y");
        this.rtb_z = document.getElementById("rtrackbar_z");
        this.stb = document.getElementById("strackbar");

        // ставим слушатели на слайдеры
        this.oftb_x.setAttribute("oninput", "graph.draw_elipsoid()")
        this.oftb_y.setAttribute("oninput", "graph.draw_elipsoid()")
        this.oftb_z.setAttribute("oninput", "graph.draw_elipsoid()")
        this.rtb_x.setAttribute("oninput", "graph.draw_elipsoid()")
        this.rtb_y.setAttribute("oninput", "graph.draw_elipsoid()")
        this.rtb_z.setAttribute("oninput", "graph.draw_elipsoid()")
        this.stb.setAttribute("oninput", "graph.draw_elipsoid()")

        console.log("Отработал констркутор Graphic3D")
    }

    // метод изменения данных слайдера(на страничке сайта)
    edit_data_trackBar(){
        let step;
        step = document.getElementById('oftrackbar_x').value;
        document.getElementById('oftrackbar_xValue').innerHTML = step;

        step = document.getElementById('oftrackbar_y').value;
        document.getElementById('oftrackbar_yValue').innerHTML = step;

        step = document.getElementById('oftrackbar_z').value;
        document.getElementById('oftrackbar_zValue').innerHTML = step;

        step = document.getElementById('rtrackbar_x').value;
        document.getElementById('rtrackbar_xValue').innerHTML = step;

        step = document.getElementById('rtrackbar_y').value;
        document.getElementById('rtrackbar_yValue').innerHTML = step;

        step = document.getElementById('rtrackbar_z').value;
        document.getElementById('rtrackbar_zValue').innerHTML = step;

        step = document.getElementById('strackbar').value;
        document.getElementById('strackbarValue').innerHTML = step;
        
        //console.log("Отработал edit_data_trackBar")
    }

    // метод аффинные преобразования
    conversion(vector){
        let x = vector.X;
        let y = vector.Y;
        let z = vector.Z;
        let deg = Math.PI / 180;
        
        // перемещение объекта
        x = x + Number(this.oftb_x.value)
        y = y + Number(this.oftb_y.value)
        z = z + Number(this.oftb_z.value)

        let x_0;
        let y_0 = y;
        let z_0 = z;

        // поворот вокруг X
        y = y_0 * Math.cos(Number(this.rtb_x.value) * deg) - z_0 * Math.sin(Number(this.rtb_x.value) * deg);
        z = y_0 * Math.sin(Number(this.rtb_x.value) * deg) + z_0 * Math.cos(Number(this.rtb_x.value) * deg);

        x_0 = x;
        z_0 = z;

        // поворот вокруг Y
        x = x_0 * Math.cos(Number(this.rtb_y.value) * deg) + z_0 * Math.sin(Number(this.rtb_y.value) * deg);
        z = -x_0 * Math.sin(Number(this.rtb_y.value) * deg) + z_0 * Math.cos(Number(this.rtb_y.value) * deg);

        x_0 = x;
        y_0 = y;

        // поворот вокруг Z
        x = x_0 * Math.cos(Number(this.rtb_z.value) * deg) - y_0 * Math.sin(Number(this.rtb_z.value) * deg);
        y = x_0 * Math.sin(Number(this.rtb_z.value) * deg) + y_0 * Math.cos(Number(this.rtb_z.value) * deg);

        x_0 = x;
        y_0 = y;
        z_0 = z;

        // проецирование (аксонометрическое)
        let angleB = -45 * deg;
        let angleA = -45 * deg;
        x = x_0 * Math.cos(angleA) + y_0 * Math.sin(angleA);
        y = -x_0 * Math.sin(angleA) * Math.cos(angleB) + y_0 * Math.cos(angleA) * Math.cos(angleB) + z_0 * Math.sin(angleB);
        z = x_0 * Math.sin(angleA) * Math.sin(angleB) - y_0 * Math.cos(angleA) * Math.sin(angleB) + z_0 * Math.cos(angleB);

        // масштабирование
        x = 4 * x * Number(this.stb.value);
        y = 4 * y * Number(this.stb.value);
        z = 4 * z * Number(this.stb.value);

        // сдвиг
        x = x + this.canv.canvas.width / 2;
        y = y + this.canv.canvas.height / 2;

        //console.log("Отработал conversion")
        return new Points(x,y,z)
    }

    // метод установки пикселя по координатам + цвет
    set_pixel(x_pos, y_pos, color=Colors.BLACK){
        this.ctx.fillStyle = color
        this.ctx.fillRect(x_pos, y_pos, 1, 1);
        //console.log("Отработал set_pixel")
    }

    // метод отрисовки линии от начальных до конечных координат
    line_algorithm_Bresenham_full(x_0, y_0, x_1, y_1){
        let steep = Math.abs(y_1 - y_0) > Math.abs(x_1 - x_0)
        if (steep){
            let swap = this.swap_cord(x_0, y_0)
            x_0 = swap[0]
            y_0 = swap[1]

            swap = this.swap_cord(x_1, y_1)
            x_1 = swap[0]
            y_1 = swap[1]
        }

        if(x_0 > x_1){
            let swap = this.swap_cord(x_0, x_1)
            x_0 = swap[0]
            x_1 = swap[1]

            swap = this.swap_cord(y_0, y_1)
            y_0 = swap[0]
            y_1 = swap[1]
        }
        
        let dx = x_1 - x_0
        let dy = Math.abs(y_1 - y_0)
        let err = dx/2
        let y_step;
        
        if (y_0 < y_1) {
            y_step = 1
        }
        else{
            y_step = -1
        }

        let y = y_0

        for (let x = x_0; x <= x_1; x++){
            this.set_pixel(steep ? y : x, steep ? x : y, this.color_pixel)
            err -= dy
            if (err < 0) {
                y += y_step
                err += dx
            }
        
        }
        //console.log("Отработал line_algorithm_Bresenham_full")
    }

    // метод смены значений местами
    swap_cord(cord_1, cord_2){
    return [cord_2, cord_1]
    }

    // метод отрисовки 3-х мерного объекта
    draw_elipsoid(){
        this.edit_data_trackBar();

        this.canv.clear_canvas();

        let vertices = Array(31).fill().map(() => Array(31).fill(0));

        for (let i = 0; i < 31; i++) {
            let r = 2;
            let K = 3;
            let A = 6;
            for (let j = 0; j < 31; j++) {
                
                let b = i * 12 * (Math.PI / 180)
                let a = j * 6 * (Math.PI / 180)
                

                // МЕНЯЙ ФОРМУЛУ ТУТА (Формула по варианту)
                let x = r * Math.sin(a) * Math.cos(b) * (1 + 0.5 * Math.abs(Math.sin(K * b)));
                let y = r * Math.sin(a) * Math.sin(b) * (1 + 0.5 * Math.abs(Math.sin(K * b)));
                let z = -r * Math.sqrt(A * Math.sin(0.5 * a) ^ 1.5) + 1.5 * r;

                vertices[i][j] = this.conversion(new Points(x, y, z))
            }
        }

        let array_points;

        for (let i = 0; i < 30; i++) {
            for (let j = 0; j < 30; j++) {
                array_points = [
                    [vertices[i][j].X, vertices[i][j].Y], 
                    [vertices[i][j+1].X, vertices[i][j+1].Y], 
                    [vertices[i+1][j+1].X, vertices[i+1][j+1].Y],
                    [vertices[i+1][j].X, vertices[i+1][j].Y]
                ];

                this.line_algorithm_Bresenham_full(Math.round(array_points[0][0]), Math.round(array_points[0][1]), Math.round(array_points[1][0]), Math.round(array_points[1][1]))
                this.line_algorithm_Bresenham_full(Math.round(array_points[1][0]), Math.round(array_points[1][1]), Math.round(array_points[2][0]), Math.round(array_points[2][1]))
                this.line_algorithm_Bresenham_full(Math.round(array_points[2][0]), Math.round(array_points[2][1]), Math.round(array_points[3][0]), Math.round(array_points[3][1]))
            } 
        }
        console.log("Отработал draw_elipsoid")
    }
}



// !!!!!!!!!!!!Сам скрипт начала работы!!!!!!!!!!!!!!!!

let resolution = {"X": 1280, "Y": 1000};
let canv = new CanvasFrame2D("image_1", resolution["X"], resolution["Y"]);

let graph = new Graphic3D(canv);
graph.draw_elipsoid()