alert('Факториал — это произведение всех натуральных чисел от 1 до данного числа');

let x = Number(prompt('Введите число'));

alert(x + '! = ' + Factorial(x))

function Factorial(x, y = 5)
{
    if (x == 1)
    {
        return 1;
    }
    return x * Factorial(x - 1);
}
