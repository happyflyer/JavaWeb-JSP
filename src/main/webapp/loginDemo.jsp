<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    String name = "zhangsan";
    String password = "123456";

    boolean checkUser(String name, String password) {
        return this.name.equals(name) && this.password.equals(password);
    }
%>
<html>
<head>
    <title>login</title>
</head>
<body>
<%
    String name = request.getParameter("name");
    String password = request.getParameter("password");
    if (checkUser(name, password)) {
%>
<h1><%= name %>登录成功</h1>
<%
} else {
%>
<h1>登录失败</h1>
<%
    }
%>
</body>
</html>
