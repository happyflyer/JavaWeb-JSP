<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>jsp-forward</title>
</head>
<body>
<jsp:forward page="../addDemo.jsp">
    <jsp:param name="a" value="1" />
    <jsp:param name="b" value="2" />
</jsp:forward>
</body>
</html>
