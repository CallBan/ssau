alert(
  "Совершенным называется число, равное сумме всех своих собственных делителей"
);

let x = Number(prompt("Введите число"));

if (isPerfectNumber(x)) {
  alert(x + "- совершенное число");
} else {
  alert(x + "- несовершенное число");
}

function isPerfectNumber(x) {
  let sum = 0;
  for (let i = 1; i < x; i++) {
    if (x % i === 0) {
      sum += i;
    }
  }
  return x === sum;
}
