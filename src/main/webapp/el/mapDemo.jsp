<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<html>
<head>
    <title>el-map</title>
</head>
<body>
    <%
    Map<String, String> map = new HashMap<>();
    map.put("user", "zhangsan");
    map.put("role", "admin");
    request.setAttribute("login", map);
%>
${login.user}<br>
${login.role}<br>
${login["user"]}<br>
${login["role"]}<br>
</body>
</html>
