<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Загадай число</title>
</head>
<body>
<h1>Введите диапазон чисел</h1>
<form action="game" method="post">
    <label for="min">Минимальное значение:</label>
    <input type="number" id="min" name="min" required><br><br>
    <label for="max">Максимальное значение:</label>
    <input type="number" id="max" name="max" required><br><br>
    <input type="submit" value="Начать игру">
</form>
</body>
</html>
