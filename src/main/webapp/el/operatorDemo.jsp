<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>el-object</title>
</head>
<body>
${1}<br>
${1 + 2}<br>
${1.2 + 2.3}<br>
${1.2E4 + 1.4}<br>
${-4 - 2}<br>
${21 * 4}<br>
${3/4}<br>
${3 div 4}<br>
${1/0}<br>
${10 % 4}<br>
${10 mod 4}<br>
${(1 == 2) ? 3 : 4}<br>

${true and false}<br>
${true or false}<br>
${not true}<br>

${1 < 2}<br>
${1 lt 2}<br>
${2 > 1}<br>
${2 gt 1}<br>
${4 <= 3}<br>
${4 le 3}<br>
${4.0 >= 3}<br>
${4.0 ge 3}<br>
${100.0 == 100}<br>
${100.0 eq 100}<br>
${(10 * 10) == 100}<br>
${(10 * 10) eq 100}<br>
${(10 * 10) != 100}<br>
${(10 * 10) ne 100}<br>
${'a' < 'b'}<br>
${"hit" > "hip"}<br>
${'4' > 3}<br>
</body>
</html>
