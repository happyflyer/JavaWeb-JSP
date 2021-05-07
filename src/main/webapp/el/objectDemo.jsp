<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>el-object</title>
</head>
<body>
<%= request.getParameter("user") %><br>
${param.user}<br>

<%= request.getParameterValues("favorites")[0] %><br>
${paramValues.favorites[0]}<br>

<%= request.getHeader("User-Agent") %><br>
${header["User-Agent"]}<br>

<%= request.getHeaderNames() %><br>
${headerValues}<br>

${cookie.username}<br>

<%= application.getInitParameter("initCount") %><br>
${initParam.initCount}<br>
</body>
</html>
