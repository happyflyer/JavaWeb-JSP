<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="util" uri="http://127.0.0.1:8080/JavaWeb_JSP_war/util" %>
<html>
<head>
    <title>el-custom</title>
</head>
<body>
<%
    List<String> names = new ArrayList<>();
    names.add("zhansan");
    names.add("lisi");
    names.add("wangwu");
    request.setAttribute("array", names);
%>
${util:length(array)}
</body>
</html>
