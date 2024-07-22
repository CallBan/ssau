// Напишите функцию, производящую бинарный поиск студентов в
// массиве по фамилии и имени. Сортировку массива произвести при
// помощи метода sort().

const students = [
    { name: "Александр", surname: "Иванов" },
    { name: "Екатерина", surname: "Петрова" },
    { name: "Дмитрий", surname: "Сидоров" },
    { name: "Ольга", surname: "Михайлова" },
    { name: "Иван", surname: "Сидоров" },
];

students.sort((a, b) => {
    if (a.surname === b.surname) {
        return a.name.localeCompare(b.name);
    } else {
        return a.surname.localeCompare(b.surname);
    }
});

console.log(students);

const student = { name: "Екатерина", surname: "Петрова" };

function binarySearchStudent(students, student, start, end) {
    let middle = Math.floor((start + end) / 2);

    if (student.surname === students[middle].surname) {
        if (student.name === students[middle].name) {
            return middle;
        }

        if (start >= end) {
            return -1;
        }

        if (student.name.localeCompare(students[middle].name) < 0) {
            return binarySearchStudent(students, student, start, middle - 1);
        } else {
            return binarySearchStudent(students, student, middle + 1, end);
        }
    }

    if (student.surname.localeCompare(students[middle].surname) < 0) {
        return binarySearchStudent(students, student, start, middle - 1);
    } else {
        return binarySearchStudent(students, student, middle + 1, end);
    }
}

console.log(binarySearchStudent(students, student, 0, students.length - 1));


