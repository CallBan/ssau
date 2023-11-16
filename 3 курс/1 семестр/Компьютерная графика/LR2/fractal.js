// const width = 400;
// const height = 400;
// const minX = -2.2; //*
// const maxX = 1; //*
// const minY = -1.2; //*
// const maxY = 1.2; //*
// const maxN = 200; //* должен вводить пользователь
// const maxZ = 2;

var width = 400;
var height = 400;
var minX = -2.2; //*
var maxX = 1; //*
var minY = -1.2; //*
var maxY = 1.2; //*
var maxN = 200; //* должен вводить пользователь
var maxZ = 2;
var scale = 100;

var canvas = document.getElementById("canvas");
canvas.width = width;
canvas.height = height;
var ctx = canvas.getContext("2d");

function Submit() {
  minX = parseFloat(document.getElementById("minX").value);
  maxX = parseFloat(document.getElementById("maxX").value);
  minY = parseFloat(document.getElementById("minY").value);
  maxY = parseFloat(document.getElementById("maxY").value);
  scale = parseFloat(document.getElementById("M").value) / 100;
  maxN = parseFloat(document.getElementById("N").value);
  setPixels();
}

function setPixels() {
  minX *= scale;
  maxX *= scale;
  minY *= scale;
  maxY *= scale;
  var dx = (maxX - minX) / width;
  var dy = (maxY - minY) / height;
  var n, x, y;
  for (var i = 0; i < width; i++) {
    for (var j = 0; j < height; j++) {
      n = 0;
      x = i * dx + minX;
      y = j * dy + minY;
      while ((n < maxN) && (Math.sqrt(x * x + y * y) <= maxZ)) {
        new_x = x ** 5 - 10 * x ** 3 * y * y + 5 * x * y ** 4 + x;
        new_y = 5 * x ** 4 * y - 10 * x * x * y * y * y + y ** 5 + y;
        x = new_x;
        y = new_y;
        n++;
      }
      ctx.fillStyle = getColor(n);
      ctx.fillRect(i, j, 1, 1);
    }
  }
}

function getColor(n) {
  var c = (n / maxN) * 255;
  var r = 0,
    g = 0,
    b = 0;
  if (c < 1) {
    r = 123;
    g = 104;
    b = 238;
  } else if (c < 2) {
    r = 0;
    g = 255;
    b = 0;
  } else if (c < 3) {
    r = 255;
    g = 255;
    b = 0;
  } else if (c < 4) {
    r = 255;
    g = 0;
    b = 255;
  } else if (c < 210) {
    r = 255;
    g = 255;
    b = 255;
  } else {
    r = 128;
    g = 128;
    b = 128;
  }
  return "rgb(" + r + ", " + g + ", " + b + ")";
}
