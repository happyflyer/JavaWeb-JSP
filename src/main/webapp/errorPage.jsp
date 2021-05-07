<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ page import="java.io.PrintWriter" %>
<html>
<head>
    <title>error</title>
</head>
<body>
<h1>网页发生异常</h1><%= exception %>
<h2>显示异常堆栈跟踪：</h2>
<%
    exception.printStackTrace(new PrintWriter(out));
%>
</body>
</html>
