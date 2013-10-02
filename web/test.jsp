<%-- 
    Document   : test
    Created on : Sep 30, 2013, 2:28:07 AM
    Author     : Anji
--%>

<%@page import="java.util.Enumeration"%>
<%@page import="Custom.CustomRequest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <% 
        CustomRequest
            cr=new CustomRequest(request,"fd","fds");
         out.print(cr.getParameterNames());
         CustomRequest
            cr1=new CustomRequest(request,"fd","fds");
         out.print(cr1.getParameterNames());
         Enumeration e=cr.getParameterNames(request);
         out.print(e.hasMoreElements());
         while(e.hasMoreElements()){
             out.print(e.nextElement());
         };
         
        
        
        
        %>
    </body>
</html>
