let root = document.getElementById('root')
let canvas = document.getElementById('canvasik')
let ctx = canvas.getContext('2d');

function slider(id, value, min, max, step) {
    let slider = document.getElementById(id)
    slider.type = "range"
    slider.max = max ?? 2 * 3.14 * 100
    slider.min = min ?? 0
    slider.step = step ?? 1
    slider.value = value ?? 0;
    return slider
}

class Point {
    constructor(x, y, z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }
}

function transform(point, a, b, g, scale, shifts) {
    let X = point.x * Math.cos(a) + point.y * Math.sin(a)
    let Y = -point.x * Math.sin(a)*Math.cos(b) + point.y * Math.cos(a)*Math.cos(b) + point.z*Math.sin(b)
    let Z = point.x*Math.sin(a)*Math.sin(b) - point.y*Math.cos(a)*Math.sin(b) + point.z*Math.cos(b)

    X = X * Math.cos(g) - Z * Math.sin(g)
    Z = X * Math.sin(g) + Z * Math.cos(g)

    X = X + shifts[0]
    Y = Y + shifts[1]
    Z = Z + shifts[2]

    return new Point(X * scale, Y * scale, Z * scale)
}

function generatePoints(R, A = 6, K = 3) {
    let alphaSteps = 30;
    let betaSteps = 30;
    
    let layers = []
    for(let j = 0; j < alphaSteps; j++) {
        let layer = []
        for(let i = 0; i < betaSteps; i++) {
            let beta = i * 2 * Math.PI / betaSteps
            let alpha = j * Math.PI / alphaSteps
        
            let { cos, sin, abs, sqrt, pow } = Math;

            x = R * sin(alpha)*cos(beta)*(1 + 0.5 * abs(sin(K * beta)));
            y = R * sin(alpha)*sin(beta)*(1 + 0.5 * abs(sin(K * beta)));
            z = -R * sqrt(A * pow(sin(0.5 * alpha), 1.5)) + 1.5 * R

            layer.push(new Point(x, y, z))
        }
        layers.push(layer)
    }
    let polygons_ = polygons(layers)
    return polygons_;
}

function polygons(layers) {
    let polygons = []
    for(let i = 0; i < layers.length - 1; i++) {
        let layer = layers[i]
        let next_layer = layers[i + 1]
        for(let j = 0; j < layer.length; j++) {
            let n = layer.length;
            let polygonPoints = [
                layer[j % n],
                layer[(j+1) % n],
                next_layer[(j+1) % n],
                next_layer[(j+2) % n]
            ];
            polygons.push(polygonPoints)
        }
    }
    return polygons
}

function drawPoints(points) {
    ctx.beginPath();
    let dx = canvas.width / 2
    let dy = canvas.height / 2
    for(let i = 0; i < points.length; i++) {
        ctx.lineTo(dx + points[i].x, dy + points[i].y)
    }
    ctx.stroke()
}

function drawPolygon(polygon) {
    let points = polygon;
    let angles = slidersAngle.map(slider => slider.value / 100);
    let shifts = slidersShift.map(shifts => +shifts.value)
    let t_points = points.map(p => transform(p, ...angles, scaleSlider.value, shifts))
    drawPoints(t_points);
}

function drawPolygons() {
    ctx.clearRect(0, 0, 900, 900)
    let polys = generatePoints(rSlider.value, aSlider.value, kSlider.value)
    polys.forEach(poly => drawPolygon(poly))
}

let slidersAngle = [slider("alpha"), slider("beta"), slider("gamma")]
slidersAngle.forEach(slider => slider.oninput = drawPolygons)

let slidersShift = [slider('dx', 0, -300, 300), slider('dy', 0, -300, 300), slider('dz', 0, -300, 300)]
slidersShift.forEach(slider =>slider.oninput = drawPolygons)

let scaleSlider = slider('scale', 1, 0.5, 5, 0.1)
scaleSlider.oninput = drawPolygons

let rSlider = slider('R', 100, 30, 600, 1);
rSlider.oninput = drawPolygons

let kSlider = slider('K', 3, 0.5, 6, 0.5)
kSlider.oninput = drawPolygons

let aSlider = slider('A', 6, 1, 15)
aSlider.oninput = drawPolygons

drawPolygons()