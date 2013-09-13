<%-- 
    Document   : Error
    Created on : Sep 13, 2013, 2:22:25 AM
    Author     : Anji
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
 

<% exception.printStackTrace(response.getWriter()); %>
        <%=exception%>
    </body>
</html>
