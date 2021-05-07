<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="user" class="org.example.java_web.jsp.bean.User" type="org.example.java_web.jsp.bean.User" scope="session"/>
<jsp:setProperty name="user" property="*"/>
<html>
<head>
    <title>el-login</title>
</head>
<body>
<%
    if (user.isValid()) {
%>
<h1>${user.name}登录成功</h1>
<%
} else {
%>
<h1>登录失败</h1>
<%
    }
%>
</body>
</html>
