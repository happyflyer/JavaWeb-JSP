<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>jsp-include</title>
</head>
<body>
<jsp:include page="../addDemo.jsp">
    <jsp:param name="a" value="1" />
    <jsp:param name="b" value="2" />
</jsp:include>
</body>
</html>
