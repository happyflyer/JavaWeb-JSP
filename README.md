# [JavaWeb-JSP](https://github.com/happyflyer/JavaWeb-JSP)

## 1. JSP 生命周期

- JSP 和 Servlet 是一体两面
- 基本上 Servlet 能实现的功能，使用 JSP 也都能做到
- 因为 JSP 最后还是会被容器
  - 转译为 Servlet 源代码
  - 自动编译为 `.class` 文件
  - 载入 `.class` 文件
  - 然后生成 Servlet 对象

```java
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Hello</title>
</head>
<body>
<h1>Hello JSP!</h1>
</body>
</html>
```

转译后的 Servlet 有三个重要方法

- `_jspInit()`
- `_jspService(request, response)`
- `_jspDestroy()`

```java
package org.apache.jsp;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
public final class hello_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {
  public void _jspInit() {}
  public void _jspDestroy() {}
  public void _jspService(final javax.servlet.http.HttpServletRequest request,
      final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException { ... }
}
```

- 三个方法名称上都有一个下划线
- 表示这些方法是由容器转译时维护，不应该重新定义这些方法
- 如果想要做 JSP 初始化或收尾工作，则应定义 `jspInit()` 或 `jspDestroy()` 方法

```java
package org.apache.jasper.runtime;
import java.io.*;
import javax.servlet.*;
import org.apache.jasper.*;
public abstract class HttpJspBase extends HttpServlet implements HttpJspPage {
    protected HttpJspBase() {}
    @Override
    public final void init(ServletConfig config) throws ServletException { ... }
    @Override
    public String getServletInfo() { ... }
    @Override
    public final void destroy() { ... }
    @Override
    public final void service(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException { ... }
    @Override
    public void jspInit() {}
    public void _jspInit() {}
    @Override
    public void jspDestroy() {}
    protected void _jspDestroy() {}
    @Override
    public abstract void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException;
}
```

## 2. JSP 语法元素

### 2.1. 指示元素

- `page`
- `include`
- `taglib`

#### 2.1.1. page

```java
<%@ page import="java.util.Date"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
```

- `import`
  - 页面导入的 `Java` 包
- `contentType`
  - 告知容器转译 JSP 时必须使用 `HttpServletRequest` 的 `setContentType()`
  - 调用方法时传递的参数的就是 `contentType` 的属性值
- `pageEncoding`
  - 告知容器这个 JSP 网页的文字编码
  - 以及内容类型附加的 `charset` 设置
  - 如果网页中包括非 `ASCII` 编码范围的字符（如中文）
  - 就要指定正确的编码格式，才不会出现乱码
- `info`
  - 设置 JSP 页面的基本信息
  - 转换为 Servlet 的后的 `getServletInfo()` 返回值
- `autoFlush`
  - 设置输出串流是否要自动清除，默认为 `true`
  - 若设置为 `false`，而缓冲区满了却还没有调用 `flush()` 将数据送出到客户端
  - 则会产生异常
- `buffer`
  - 设置至客户端的输出串流缓冲区大小 默认 `8kb`
  - 设置需要指定单位，`buffer="16kb"`
- `errorPage`
  - 设置当 JSP 执行错误而产生异常时
  - 该转发到哪一个页面处理这个异常
- `extends`
  - 设置转译为 Servlet 后该继承哪一个类，默认继承 `HttpJspBase`
  - `HttpJspBase` 类又继承自 `HttpServlet`
  - 这个属性几乎不用
- `isErrorPage`
  - 设置当前 JSP 页面是否为处理异常的页面
  - 与 `errorPage` 属性配合使用
- `language`
  - 指定容器使用哪种语言的语法来转译 JSP 网页
  - 不过目前使用使用 java ，默认为 `java`
- `session`
  - 设置是否在转移后的 Servlet 源代码中具有创建 `HttpSession` 对象的语句，默认为 `true`
  - 有些页面不需要做进程跟踪，设置为 `false` 可以增加效能
- `isELIgnored`
  - 设置 JSP 页面中是否忽略表达式语言 (Expression Language)，默认为 `false`
  - 如果为 `true`，则不转译表达式语言
  - 这个设置会覆盖 `web.xml` 中的 `<el-ignore>` 设置
- `isThreadSafe`
  - 告知容器编写 JSP 时是否注意到线程安全，默认为 `true`
  - 如果设置为 `false` ，则转译后的 Servlet 会实现 `SimpleThreadModel` 接口
  - 每次请求时会创建一个 Servlet 实例来服务请求
  - 虽然可以避免线程安全问题，这会引擎性能问题，极度不建议设置为 `false`

```xml
<web-app>
  <jsp-config>
    <jsp-property-group>
      <url-pattern>*.jsp</url-pattern>
      <page-encoding>UTF-8</page-encoding>
      <default-content-type>text/html</default-content-type>
      <buffer>16kb</buffer>
    </jsp-property-group>
  </jsp-config>
</web-app>
```

#### 2.1.2. include

```java
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<h1>include 示范本体</h1>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
```

```java
<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>header</title>
</head>
<body>
```

```java
<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" %>
</body>
</html>
```

```xml
<web-app>
  <jsp-config>
    <jsp-property-group>
      <url-pattern>*.jsp</url-pattern>
      <include-prelude>/WEB-INF/jspf/pre.jspf</include-prelude>
      <include-coda>/WEB-INF/jspf/coda.jspf</include-coda>
    </jsp-property-group>
    <jsp-property-group>
      <url-pattern>*.jsp</url-pattern>
      <trim-directive-whitespaces>true</trim-directive-whitespaces>
    </jsp-property-group>
  </jsp-config>
</web-app>
```

### 2.2. 声明元素

```java
<%! 类成员声明或方法声明 %>
```

- 使用声明元素时，必须小心数据共享和线程安全的问题
- 容器默认会使用一个 Servlet 实例来服务不同用户的请求
- 每个请求是一个线程，而声明元素声明的变量对应至类变量成员
- 因此会有线程共享访问的问题

```java
<%!
    public void jspInit() {
        // 初始化动作
    }
    public void jspDeatroy() {
        // 销毁动作
    }
%>
```

### 2.3. 脚本元素

```java
<% java 代码 %>
```

```java
<%
  out.println("&lt;%与%\>被用来作为JSP中Java语法的部分。");
%>
```

```xml
<web-app>
  <jsp-config>
    <jsp-property-group>
      <url-pattern>*.jsp</url-pattern>
      <scripting-invalid>true</scripting-invalid>
    </jsp-property-group>
  </jsp-config>
</web-app>
```

### 2.4. 表达式元素

```java
<%= java 表达式 %>
```

### 2.5. 注释元素

```java
<%
    // 单行注释
    /*
        多行注释
    */
%>
```

```java
<!-- 网页注释 -->
```

```java
<%-- JSP 注释 --%>
```

### 2.6. 隐式对象

| 隐式对象      | 说明                                                           |
| ------------- | -------------------------------------------------------------- |
| `out`         | 转译后对应 `JspWriter` 对象，其内部关联一个 `PrintWriter` 对象 |
| `request`     | 转译后对应 `HttpServletRequest` 对象                           |
| `response`    | 转译后对应 `HttpServletResponse` 对象                          |
| `config`      | 转译后对应 `ServletConfig` 对象                                |
| `application` | 转译后对应 `ServletContext` 对象                               |
| `session`     | 转译后对应 `HttpSession` 对象                                  |
| `pageContext` | 转译后对应 `PageContext` 对象，                                |
| `exception`   | 转译后对应 `Throwable` 对象，`isErrorPage="true"`              |
| `page`        | 转译后对应 `this`                                              |

```java
application = pageContext.getServletContext();
config = pageContext.getServletConfig();
session = pageContext.getSession();
out = pageContext.getOut();
```

使用 `pageContext` 管理属性的范围

- `getAttribute(String name, int scope)`
- `setAttribute(String name, Object value, int scope)`
- `removeAttribute(String name, int scope)`

scope

- `pageContext.PAGE_SCOPE`
- `pageContext.REQUEST_SCOPE`
- `pageContext.SESSION_SCOPE`
- `pageContext.APPLICATION_SCOPE`

```java
Object attr = pageContext.findAttribute(String name);
```

### 2.7. 错误处理

- JSP 转译为 Servlet 源代码时错误
- Servlet 源代码进行编译时错误
- Servlet 载入容器进行服务但运行时错误

```xml
<web-app>
  <error-page>
    <exception-type>java.lang.Exception</exception-type>
    <location>/errorPage.jsp</location>
  </error-page>
</web-app>
```

```xml
<web-app>
  <error-page>
    <error-code>404</error-code>
    <location>/404.jsp</location>
  </error-page>
</web-app>
```

## 3. 标准标签

### 3.1. include

`include` 指示元素，

- 可以在 JSP 转译为 Servlet 时
- 将另一个 JSP 包括进来进行转译的动作
- 这是静态地进行转译的动作
- 也就是被包括的 JSP 与 原 JSP 合并在一起，转译为一个 Servlet 类
- 无法在运行时依据条件动态地调整想要包括地 JSP 页面

`<jsp:include>` 标签

- 可以依据条件动态地调整想要包括地 JSP 页面
- 这种情况下，原 JSP 页面会单独生成一个 Servlet 类
- 而被包括的 `add.jsp` 也会独立生成一个 Servlet 类
- 事实上，目前转译而成的 Servlet 中
- 会取得 `RequestDispatcher` 对象，并执行 `include()` 方法

```java
<jsp:include page="add.jsp">
    <jsp:param name="a" value="1" />
    <jsp:param name="b" value="2" />
</jsp:include>
```

### 3.2. forward

```java
<jsp:forward page="add.jsp">
    <jsp:param name="a" value="1" />
    <jsp:param name="b" value="2" />
</jsp:forward>
```

### 3.3. useBean

- `<jsp:useBean>` 标签是用来搭配 `useBean` 元件的标签元素
- 这里的 `JavaBean` 并非桌面系统或者 `EJB`（Enterprise JavaBeans）中的 `JavaBean` 元件
- 而是只要满足以下条件的纯粹的 `Java` 对象
  - 必须实现 `java.io.Serializable` 接口
  - 没有公开（`public`）的类变量
  - 具有无参数的构造器
  - 具有公开的设值方法（`Setter`）和取值方法（`Getter`）
- 有 Body 的这种写法
  - 如果在属性范围内找不到 `user`
  - 则会新创建一个对象那个并设置其属性值
  - 如果可以找到对象，就直接使用

```java
<jsp:useBean id="user"
        class="org.example.java_web.jsp.bean.User"
        type="org.example.java_web.jsp.bean.User"
        scope="session">
    <jsp:setProperty name="user" property="*"/>
</jsp:useBean>
```

```java
org.example.java_web.jsp.bean.User user = null;
synchronized (session) {
    user = (org.example.java_web.jsp.bean.User) _jspx_page_context.getAttribute(
        "user", javax.servlet.jsp.PageContext.SESSION_SCOPE);
    if (user == null){
        user = new org.example.java_web.jsp.bean.User();
        _jspx_page_context.setAttribute(
            "user", user, javax.servlet.jsp.PageContext.SESSION_SCOPE);
        org.apache.jasper.runtime.JspRuntimeLibrary.introspect(
            _jspx_page_context.findAttribute("user"), request);
    }
}
```

- 没有 Body 的这种写法
- 无论是找到还是新创建 `JavaBean` 对象
- 都一定会使用内省机制来设置

```java
<jsp:useBean id="user"
        class="org.example.java_web.jsp.bean.User"
        type="org.example.java_web.jsp.bean.User"
        scope="session"/>
<jsp:setProperty name="user" property="*"/>
```

```java
org.example.java_web.jsp.bean.User user = null;
synchronized (session) {
    user = (org.example.java_web.jsp.bean.User) _jspx_page_context.getAttribute(
        "user", javax.servlet.jsp.PageContext.SESSION_SCOPE);
    if (user == null){
        user = new org.example.java_web.jsp.bean.User();
        _jspx_page_context.setAttribute(
            "user", user, javax.servlet.jsp.PageContext.SESSION_SCOPE);
    }
}
org.apache.jasper.runtime.JspRuntimeLibrary.introspect(
    _jspx_page_context.findAttribute("user"), request);
```

```java
<jsp:getProperty name="user" property="name"/>
```

```java
out.write(org.apache.jasper.runtime.JspRuntimeLibrary.toString((((
    org.example.java_web.jsp.bean.User)_jspx_page_context.findAttribute("user")).getName())));
```

### 3.4. Model 1 和 Model 2

在 Model 1 中

- `JavaBean` 为模型，JSP 负责视图和逻辑
- 显然在这种框架下
- JSP 中会不可避免地使用 `Scriptlet` 代码
- 这样不仅使得代码编写起来困难，而且后期难以维护
- 由此产生了 Model 2

Model 2 是典型的 MVC 模型，

- 这样做的好处不仅是代码解耦，分工明确
- 而且再 JSP 页面中不用再 使用 `HTML` 和 `Java` 代码混杂
- 只要 JSP 中可使用的标签足够强大

### 3.5. XML 格式标签

| JSP 语法                          | XML 格式标签                                        |
| --------------------------------- | --------------------------------------------------- |
| `<%@ page import="java.util.*"%>` | `<jsp:directive.page import="java.util.*" />`       |
| `<%! String name; %>`             | `<jsp:declaration>String name;</jsp:declaration>`   |
| `<% name="zhangsan"; %>`          | `<jsp:scriptlet>name = "zhangsan";</jsp:scriptlet>` |
| `<%=name %>`                      | `<jsp:expression>name</jsp:expression>`             |
| 网页文字                          | `<jsp:text>网页文字</jsp:text>`                     |

## 4. EL 表达式

### 4.1. EL 用法

- `EL` 优雅地处理了 `null` 值的情况
- 对于 `null` 值用空字符串显示，而不是直接显示 `"null"`
- 在进行运算时，也不会因此发生错误而抛出异常

```java
${param.a} + ${param.b} = ${param.a + param.b}
```

- 使用 `EL` 之前

```java
<%= ((HttpServletRequest)pageContext.getRequest()).getMethod() %><br>
<%= ((HttpServletRequest)pageContext.getRequest()).getQueryString() %><br>
<%= ((HttpServletRequest)pageContext.getRequest()).getRemoteAddr() %><br>
```

- 使用 `EL` 之后

```java
${pageContext.request.method}<br>
${pageContext.request.queryString}<br>
${pageContext.request.remoteAddr}<br>
```

- 可以使用 `page` 指示元素的 `isELIgnored` 属性（默认为 `false`）
- 来设置网页是否使用 `EL`
- 禁用 `EL` 的原因可能是网页中已包含与 `EL` 类似的 `${}` 语法功能
- 例如 `jQuery`
- 也可以在 `web.xml` 中设置

```xml
<web-app>
  <jsp-config>
    <jsp-property-group>
      <url-pattern>*.jsp</url-pattern>
      <el-ignored>true</el-ignored>
    </jsp-property-group>
  </jsp-config>
<web-app>
```

- 如果在 `web.xml` 和 JSP 页面的 `page` 指令都没有设置 `EL`
- 如果 `web.xml` 是 2.3 或以下版本，则默认不会执行 `EL`
- 如果是 2.4 或以上版本，则默认会执行 `EL`
- JSP 中 `page` 指令的 `EL` 设置会覆盖 `web.xml` 的设置

### 4.2. 使用 EL 取得属性

- 可以在 JSP 中将对象设置到
  - `page`
  - `request`
  - `session`
  - `application`
- 范围中作为属性
- 基本上通过 `setAttribute(name, value)` 设置属性
- 使用 `getAttribute(name)` 取得属性
- 但是这些方法必须在 `ScriptLet` 中进行
- 如果不想写 `Scriptlet`
- 可以使用 标准标签
  - `<jsp:useBean>`
  - `<jsp:setProperty>`
  - `<jsp:getAttribute>`
- 代替

但是，这样依然代码很冗长

- 使用 `EL` 之前

```java
<h1><jsp:getProperty name="user" property="name"/>登录成功</h1>
```

- 使用 `EL` 之后

```java
<h1>${user.name}登录成功</h1>
```

- 使用 `.` 运算符，左边可以是
  - `JavaBean`
  - `Map` 对象
- 使用 `[]` 运算符，左边可以是
  - `JavaBean`
  - `Map`
  - 数组
  - `List`

```java
<%
    String[] names = {"zhangsan", "lisi", "wangwu"};
    request.setAttribute("array", names);
%>
${array[0]}<br>
${array[1]}<br>
${array[2]}<br>
```

```java
<%
    Map<String, String> map = new HashMap<>();
    map.put("user", "zhangsan");
    map.put("role", "admin");
    request.setAttribute("login", map);
%>
${login.user}
${login.role}
${login["user"]}
${login["role"]}
```

### 4.3. EL 隐式对象

- `pageContext`
- `request`
- `session`
- `application`
- `pageScope`
- `requestScope`
- `sessionScope`
- `applicationScope`
- `param`

```java
<%= request.getParameter("user") %>
${param.user}
```

- `paramValues`

```java
<%= request.getParameterValues("favorites")[0] %>
${paramValues.favorites[0]}
```

- `header`

```java
<%= request.getHeader("User-Agent") %>
${header["User-Agent"]}
```

- `headerValues`

```java
<%= request.getHeaderNames() %>
${headerValues}
```

- `cookie`

```java
${cookie.username}
```

- `initParam`

```java
<%= application.getInitParameter("initCount") %>
${initParam.initCount}
```

### 4.4. EL 运算符

```java
${1}
${1 + 2}
${1.2 + 2.3}
${1.2E4 + 1.4}
${-4 - 2}
${21 * 4}
${3/4}
${3 div 4}
${1/0}  // Infinity
${10 % 4}
${10 mod 4}
${(1 == 2) ? 3 : 4}
```

```java
${true and false}
${true or false}
${not true}
```

```java
${1 < 2}
${1 lt 2}
${2 > 1}
${2 gt 1}
${4 <= 3}
${4 le 3}
${4.0 >= 3}
${4.0 ge 3}
${100.0 == 100}
${100.0 eq 100}
${(10 * 10) == 100}
${(10 * 10) eq 100}
${(10 * 10) != 100}
${(10 * 10) ne 100}
${'a' < 'b'}
${"hit" > "hip"}
${'4' > 3}  // 4 > 3
```

## 5. 自定义 EL 函数

设计一个 `Util` 类，其中有个 `length()` 静态方法可以将传入的 `Collection` 的长度返回。

```java
<% Util.length(request.getAttribute("someList")) %>
```

想使用 EL 后的效果如下：

```java
${util:length(requestScope.someList)}
```

1. 编写函数
   1. 自定义的 `EL` 函数
   2. 必须是公开（`public`）类
   3. 调用的方法必须是静态（`static`）而且公开（`public`）的
2. 编写标签程序库描述（Tag Library Descriptor, TLD）
   1. 一个 `XML` 文件，后缀名为 `.tld`
   2. 将 LTD 文件直接放在 `WEB-INF` 文件夹下
3. 使用 EL 函数

```java
package org.example.java_web.jsp.el;
import java.util.Collection;
public class Util {
    public static int length(Collection collection) {
        return collection.size();
    }
}
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<taglib version="2.1" xmlns="http://java.sun.com/xml/ns/javaee"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
        http://java.sun.com/xml/ns/javaee/web-jsptaglibrary_2_1.xsd">
  <tlib-version>1.0</tlib-version>
  <short-name>util</short-name>
  <uri>http://127.0.0.1:8080/JavaWeb_JSP_war/util</uri>
  <function>
    <description>Collection Length</description>
    <name>length</name>
    <function-class>org.example.java_web.jsp.el.Util</function-class>
    <function-signature>int length(java.util.Collection)</function-signature>
  </function>
</taglib>
```

```java
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
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
```
