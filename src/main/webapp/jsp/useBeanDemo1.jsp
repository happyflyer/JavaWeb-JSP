<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.java_web.jsp.bean.User" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        user = new User();
        request.setAttribute("user", user);
    }
    user.setName(request.getParameter("name"));
    user.setPassword(request.getParameter("password"));
%>
<html>
<head>
    <title>jsp-useBean</title>
</head>
<body>
<%
    if (user.isValid()) {
%>
<h1><%= user.getName() %>登录成功</h1>
<%
} else {
%>
<h1>登录失败</h1>
<%
    }
%>
</body>
</html>
