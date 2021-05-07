<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>el-list</title>
</head>
<body>
<%
    String[] names = {"zhangsan", "lisi", "wangwu"};
    request.setAttribute("array", names);
%>
${array[0]}<br>
${array[1]}<br>
${array[2]}<br>
</body>
</html>
