<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Угадываем число</title>
</head>
<body>
<%
    Integer guess = (Integer) session.getAttribute("guess");
    if (guess == null) {
%>
<p>Ошибка: число не определено.</p>
<a href="index.jsp">Вернуться на главную</a>
<%
} else {
%>
<h1>Моя догадка: <%= guess %>
</h1>
<p>Ваше число больше, меньше или равно <%= guess %>?</p>
<form action="game" method="post">
    <input type="radio" id="bigger" name="answer" value="bigger" required>
    <label for="bigger">Загаданное число больше</label><br><br>

    <input type="radio" id="smaller" name="answer" value="smaller">
    <label for="smaller">Загаданное число меньше</label><br><br>

    <input type="radio" id="correct" name="answer" value="correct">
    <label for="correct">Вы угадали!</label><br><br>

    <input type="submit" value="Отправить ответ">
</form>
<%
    }
%>
</body>
</html>
