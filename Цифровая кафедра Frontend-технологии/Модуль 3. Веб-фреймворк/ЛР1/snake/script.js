const boardSize = 10;
const gameBoard = document.getElementById("game-board");
const cells = [];

let snake = [{ x: 0, y: 0 }];
let food = { x: 5, y: 5 };
/**
 *  отвечает за направление движения змейки
 */
let direction = "right";
/**
 * отвечает за скорость движения змейки
 */
let speed = 800;

function initializeGameBoard() {
    for (let row = 0; row < boardSize; row++) {
        for (let col = 0; col < boardSize; col++) {
            const cell = document.createElement("div");
            cell.className = "cell";
            cells.push(cell);
            gameBoard.appendChild(cell);
        }
    }
}

function render() {
    cells.forEach((cell) => cell.classList.remove("snake", "food"));

    snake.forEach((segment) => {
        const index = segment.x + segment.y * boardSize;
        cells[index].classList.add("snake");
    });

    const foodIndex = food.x + food.y * boardSize;
    cells[foodIndex].classList.add("food");
}

function update() {
    const head = Object.assign({}, snake[0]);

    switch (direction) {
        case "up":
            head.y -= 1;
            break;
        case "down":
            head.y += 1;
            break;
        case "left":
            head.x -= 1;
            break;
        case "right":
            head.x += 1;
            break;
    }

    if (
        head.x < 0 ||
        head.x >= boardSize ||
        head.y < 0 ||
        head.y >= boardSize
    ) {
        resetGame();
        return;
    }

    if (isCollisionWithSelf(head)) {
        resetGame();
        return;
    }

    if (head.x === food.x && head.y === food.y) {
        snake.unshift(head);
        generateFood();
    } else {
        snake.pop();
        snake.unshift(head);
    }
}

function isCollisionWithSelf(head) {
    return snake
        .slice(1)
        .some((segment) => segment.x === head.x && segment.y === head.y);
}

function generateFood() {
    food = {
        x: Math.floor(Math.random() * boardSize),
        y: Math.floor(Math.random() * boardSize),
    };
}

function resetGame() {
    snake = [{ x: 0, y: 0 }];
    direction = "right";
    generateFood();
    updateScore(snake.length);
}

initializeGameBoard();

function gameLoop() {
    update();
    render();
    updateScore(snake.length);
    setTimeout(gameLoop, speed);
}

// TODO: добавить обработчик нажатия на клавиши, добавить обработчик нажатия клавиши R (сброс игры)
document.addEventListener("keydown", function (event) {
    switch (event.key) {
        case "ArrowLeft":
            direction = "left";
            break;
        case "ArrowRight":
            direction = "right";
            break;
        case "ArrowUp":
            direction = "up";
            break;
        case "ArrowDown":
            direction = "down";
            break;
        case "r":
            resetGame();
            break;
        case "R":
            resetGame();
            break;
    }
});

// TODO: добавить обработчики нажатия кнопок
const buttons = document.querySelectorAll("button");
buttons.forEach((button) => {
    button.addEventListener("click", function () {
        const id = this.id;
        switch (id) {
            case "left":
                direction = "left";
                break;
            case "right":
                direction = "right";
                break;
            case "up":
                direction = "up";
                break;
            case "down":
                direction = "down";
                break;
        }
    });
});

// TODO: добавить возможность изменения скорости змейки
const snakeSpeed = document.getElementById("speedInput");
snakeSpeed.addEventListener("change", function (event) {
    speed = parseInt(event.target.value);
});

updateScore(snake.length);
gameLoop();

function updateScore(score) {
    const currentScore = document.querySelector("span");
    currentScore.textContent = score;
}
