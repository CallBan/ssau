// Напишите функцию, принимающую на вход массив вещественных
// чисел и возвращающую сумму элементов, расположенных после
// последнего элемента равного нулю.
let numbers = [3, 0, 9, 4, 0, 5, 1, 0, 8, 2];

function sumAfterLastNull(array) {
    let sum = 0;
    for (let i = array.length - 1; i >= 0; i--) {
        if (array[i] === 0) {
            return sum;
        }
        sum += array[i];
    }
    return 0;
}

console.log(sumAfterLastNull(numbers));

// Напишите функцию, принимающую на вход вещественную
// прямоугольную матрицу и возвращающую сумму элементов в тех
// строках, которые содержат хотя бы один отрицательный элемент.
let matrix = [
    [2, 5, 8, -1],
    [1, 2, 3, 4],
    [7, -3, 2, -4],
];

function sumRowHaveNegElement(array) {
    let result = [];
    for (let row of array) {
        if (row.find((number) => number < 0) === undefined) {
            result.push(0);
        } else {
            let sum = 0;
            for (let number of row) {
                sum += number;
            }
            result.push(sum);
        }
    }
    return result;
}

console.log(sumRowHaveNegElement(matrix));
