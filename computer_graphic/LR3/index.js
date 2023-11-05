const width = 800;
const height = 800;
const title = document.getElementById("title");
const canv = document.getElementById("canvas");
canv.width = width;
canv.height = height;
const ctx = canv.getContext("2d");
let imageData = ctx.createImageData(width, height);

blankCanvas(imageData);

brezenhamLine(imageData, 100, 500, 700, 500, [255, 0, 0]);
bezier3(imageData, 100, 500, 400, 800, 700, 500, [255, 0, 0]);
brezenhamLine(imageData, 400, 500, 400, 100, [255, 0, 0]);

bezier3(imageData, 400, 150, 450, 300, 700, 450, [0, 0, 255]);
brezenhamLine(imageData, 400, 450, 700, 450, [0, 0, 255]);
brezenhamCircle(imageData, 550, 550, 10, [0, 0, 0]);
brezenhamCircle(imageData, 600, 550, 10, [0, 0, 0]);
brezenhamCircle(imageData, 500, 550, 10, [0, 0, 0]);

brezenhamLine(imageData, 350, 125, 400, 100, [255, 0, 0]);
brezenhamLine(imageData, 350, 125, 400, 150, [255, 0, 0]);

seededAlgorithm(imageData, 550, 550, [0, 0, 255]);
seededAlgorithm(imageData, 600, 550, [0, 0, 255]);
seededAlgorithm(imageData, 500, 550, [0, 0, 255]);

pattern1 = [[0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0],
            [1,1,1,1,1,1,1],
            [0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0]];

beetleAlgorithm(imageData, 200, 510, pattern1, [255, 0, 0]);

ctx.putImageData(imageData, 0, 0);

function brezenhamLine(imageData, x0, y0, x1, y1, color) {
  let steep = Math.abs(y1 - y0) > Math.abs(x1 - x0);

  if (steep) {
    brezenhamLineY(imageData, x0, y0, x1, y1, color);
    return;
  }

  let xStep = 1;
  let yStep = 1;

  if (x1 < x0) {
    xStep = -1;
  }

  if (y1 < y0) {
    yStep = -1;
  }

  let x = x0;
  let y = y0;
  let dx = Math.abs(x1 - x0);
  let dy = Math.abs(y1 - y0);
  let m = dy / dx;
  let e = m - 1 / 2;
  let i = 0;

  while (i < dx) {
    if (e >= 0) {
      y += yStep;
      e = e + m - 1;
    } else {
      e = e + m;
    }
    x += xStep;
    setPoint(imageData, x, y, (pattern = [[1]]), color);
    i++;
  }
}

function brezenhamLineY(imageData, x0, y0, x1, y1, color) {
  let xStep = 1;
  let yStep = 1;

  if (x1 < x0) {
    xStep = -1;
  }

  if (y1 < y0) {
    yStep = -1;
  }

  let x = x0;
  let y = y0;
  let dx = Math.abs(x1 - x0);
  let dy = Math.abs(y1 - y0);
  let m = dx / dy;
  let e = m - 1 / 2;
  let i = 0;

  while (i < dy) {
    if (e >= 0) {
      x += xStep;
      e = e + m - 1;
    } else {
      e = e + m;
    }
    y += yStep;
    setPoint(imageData, x, y, (pattern = [[1]]), color);
    i++;
  }
}

function lissaFigure(imageData, x, y, R1, R2, w1, w2, color) {
  let x1 = x + R1;
  let y1 = y;
  let x2, y2;
  for (let t = 1; t <= 360; t++) {
    x2 = Math.round(x + R1 * Math.cos(t * w1));
    y2 = Math.round(y + R2 * Math.sin(t * w2));
    brezenhamLine(imageData, x1, y1, x2, y2, color);
    x1 = x2;
    y1 = y2;
  }
}

function brezenhamCircle(imageData, x0, y0, r, color) {
  let x = 0;
  let y = r;
  let d = 3 - 2 * r;
  while (y >= x) {
    setPoint(imageData, x0 + x, y0 + y, (pattern = [[1]]), color);
    setPoint(imageData, x0 + x, y0 - y, (pattern = [[1]]), color);
    setPoint(imageData, x0 - x, y0 + y, (pattern = [[1]]), color);
    setPoint(imageData, x0 - x, y0 - y, (pattern = [[1]]), color);
    setPoint(imageData, x0 + y, y0 + x, (pattern = [[1]]), color);
    setPoint(imageData, x0 + y, y0 - x, (pattern = [[1]]), color);
    setPoint(imageData, x0 - y, y0 + x, (pattern = [[1]]), color);
    setPoint(imageData, x0 - y, y0 - x, (pattern = [[1]]), color);
    if (d <= 0) {
      d = d + 4 * x + 6;
    } else {
      d = d + 4 * (x - y) + 10;
      y--;
    }
    x++;
  }
}

function bezier3(imageData, x0, y0, x1, y1, x2, y2, color) {
  let x, y;
  for (let t = 0; t <= 1; t = t + 0.0001) {
    x = (1 - t) ** 2 * x0 + 2 * (1 - t) * t * x1 + t ** 2 * x2;
    y = (1 - t) ** 2 * y0 + 2 * (1 - t) * t * y1 + t ** 2 * y2;
    setPoint(imageData, Math.round(x), Math.round(y), (pattern = [[1]]), color);
  }
}

function beetleAlgorithm(imageData, x0, y0, pattern = [[1]], color) {
  let pixelColor = getColor(imageData, x0, y0);
  imageDataForPattern = new ImageData(imageData.width, imageData.height);
  blankCanvas(imageDataForPattern);
  let stack = [];
  let pixel = { x: x0, y: y0 };
  stack.push(pixel);
  do {
    pixel = stack.pop();
    setPoint(imageData, pixel.x, pixel.y, [[1]], color);
    setPoint(imageDataForPattern, pixel.x, pixel.y, [[1]], [0, 0, 0]);
    let adjacent = getAdjacent(imageData, pixel.x, pixel.y, pixelColor);
    for (let i = 0; i < adjacent.length; i++) {
      stack.push(adjacent[i]);
    }
  } while (stack.length != 0);
  applyPattern(imageData, imageDataForPattern, pattern, color, pixelColor);
}

function applyPattern(
  imageData,
  imageDataForPattern,
  pattern,
  color,
  prevColor
) {
  for (let x = 0; x < imageData.width; x++) {
    for (let y = 0; y < imageData.height; y++) {
      if (checkColor(imageDataForPattern, x, y, [0, 0, 0])) {
        setPoint(imageData, x, y, pattern, color, prevColor);
      }
    }
  }
}

function seededAlgorithm(imageData, x, y, color) {
  let backColor = getColor(imageData, x, y);

  setPoint(imageData, x, y, [[1]], color);

  if (checkColor(imageData, x, y + 1, backColor)) {
    seededAlgorithm(imageData, x, y + 1, color);
  }
  if (checkColor(imageData, x, y - 1, backColor)) {
    seededAlgorithm(imageData, x, y - 1, color);
  }
  if (checkColor(imageData, x + 1, y, backColor)) {
    seededAlgorithm(imageData, x + 1, y, color);
  }
  if (checkColor(imageData, x - 1, y, backColor)) {
    seededAlgorithm(imageData, x - 1, y, color);
  }
}

function getAdjacent(imageData, x, y, color) {
  let result = [];
  if (y + 1 < imageData.height && checkColor(imageData, x, y + 1, color)) {
    result.push({ x: x, y: y + 1 });
  }
  if (x + 1 < imageData.width && checkColor(imageData, x + 1, y, color)) {
    result.push({ x: x + 1, y: y });
  }
  if (y - 1 >= 0 && checkColor(imageData, x, y - 1, color)) {
    result.push({ x: x, y: y - 1 });
  }
  if (x - 1 >= 0 && checkColor(imageData, x - 1, y, color)) {
    result.push({ x: x - 1, y: y });
  }
  return result;
}

function checkColor(imageData, x, y, color) {
  return (
    imageData.data[y * (imageData.width * 4) + x * 4 + 0] == color[0] &&
    imageData.data[y * (imageData.width * 4) + x * 4 + 1] == color[1] &&
    imageData.data[y * (imageData.width * 4) + x * 4 + 2] == color[2]
  );
}

function blankCanvas(imageData) {
  for (let x = 0; x < imageData.width; x++) {
    for (let y = 0; y < imageData.height; y++) {
      imageData.data[y * (imageData.width * 4) + x * 4 + 0] = 255;
      imageData.data[y * (imageData.width * 4) + x * 4 + 1] = 255;
      imageData.data[y * (imageData.width * 4) + x * 4 + 2] = 255;
      imageData.data[y * (imageData.width * 4) + x * 4 + 3] = 255;
    }
  }
}

function setPoint(imageData, x, y, pattern = [[1]], color, prevColor = color) {
  if (pattern[y % pattern.length][x % pattern[0].length] == 1) {
    imageData.data[y * (imageData.width * 4) + x * 4 + 0] = color[0];
    imageData.data[y * (imageData.width * 4) + x * 4 + 1] = color[1];
    imageData.data[y * (imageData.width * 4) + x * 4 + 2] = color[2];
  } else {
    imageData.data[y * (imageData.width * 4) + x * 4 + 0] = prevColor[0];
    imageData.data[y * (imageData.width * 4) + x * 4 + 1] = prevColor[1];
    imageData.data[y * (imageData.width * 4) + x * 4 + 2] = prevColor[2];
  }
}

function getColor(imageData, x, y) {
  return [
    imageData.data[y * (imageData.width * 4) + x * 4 + 0],
    imageData.data[y * (imageData.width * 4) + x * 4 + 1],
    imageData.data[y * (imageData.width * 4) + x * 4 + 2],
  ];
}
