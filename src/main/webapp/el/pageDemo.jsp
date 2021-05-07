<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>el-page</title>
</head>
<body>
<%= ((HttpServletRequest)pageContext.getRequest()).getMethod() %><br>
<%= ((HttpServletRequest)pageContext.getRequest()).getQueryString() %><br>
<%= ((HttpServletRequest)pageContext.getRequest()).getRemoteAddr() %><br>
${pageContext.request.method}<br>
${pageContext.request.queryString}<br>
${pageContext.request.remoteAddr}<br>
</body>
</html>
