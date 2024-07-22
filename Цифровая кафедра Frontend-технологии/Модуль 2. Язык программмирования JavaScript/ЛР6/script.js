// Реализуйте функцию для поиска в двух заданных массивах элементов,
// которые присутствуют в обоих массивах. Используйте Set.

let arr1 = [1, 2, 3, 4, 5];
let arr2 = [3, 4, 5, 6, 7];

function findCommonElements(arr1, arr2) {
    const result = new Set();

    for (item of arr1) {
        if (arr2.includes(item)) {
            result.add(item);
        }
    }

    return result;
}

console.log(findCommonElements(arr1, arr2));
