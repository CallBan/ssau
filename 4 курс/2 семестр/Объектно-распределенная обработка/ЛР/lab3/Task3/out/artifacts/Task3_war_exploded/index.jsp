<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
    <title>Calculator</title>
</head>
<body>
<h1>Простой калькулятор</h1>
<form action="index.jsp" method="post">
    <p>Первое число</p><input type="number" name="first" size="3" value="<%=request.getParameter("first")%>" step="1">
    <p>Второе число</p><input type="number" name="second" size="3" value="<%=request.getParameter("second")%>" step="1">
    <br><br>
    <input type="submit" name="button" value="+"/>
    <input type="submit" name="button" value="-"/>
    <input type="submit" name="button" value="*"/>
    <input type="submit" name="button" value="/"/>
</form>
<p>Результат:
    <%
        String firstStr = request.getParameter("first");
        String secondStr = request.getParameter("second");
        if ((firstStr!=null)&&(secondStr!=null)) {
            String button = request.getParameter("button");
            int first = Integer.parseInt(request.getParameter("first"));
            int second = Integer.parseInt(request.getParameter("second"));
            int res = 0;
            String result = "";
            if ("+".equals(button)) {
                res = first + second;
            } else if ("-".equals(button)) {
                res = first - second;
            } else if ("*".equals(button)) {
                res = first * second;
            } else if ("/".equals(button)) {
                if (second == 0) {
                    throw new IllegalArgumentException();
                } else {
                    res = first / second;
                }
            }
            result = Integer.toString(res);
            out.println(result);
        }
    %></p>
</body>
</html>
