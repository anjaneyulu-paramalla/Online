<%-- 
    Document   : newjsp1
    Created on : Apr 20, 2013, 11:49:14 PM
    Author     : Anji
--%>

<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            @media all {
	.page-break	{ display: none; }
}

@media print {
	.page-break	{ display: block; page-break-before: always; }
}
        </style>
    </head>
    <body>
        <h1>Hello World!</h1>
        <h1>Page Title</h1>
        <form method="POST" action="test.jsp" enctype="multipart/form-data" >
            File:
            <input type="file" name="file" id="file" /> <br/>
          <!--  <input type="file" name="file1" id="figle" /> <br/>
            Destination:
            <input type="text" value="jeffa" name="destination"/>
            <input type="text" value="jeffa" name="destination"/>
            <!--input type="text" value="hbbntmp" name="destinathjhion"/-->
            </br>
            <input type="submit" value="Upload" id="upload" />
        </form>
        <%
        File[] f=new File("../../../../../../../../").listFiles();
       for(File k:f)
           out.print(""+k);
        %>
<!-- content block -->
<!-- content block -->
<div class="page-break"></div>
<!-- content block -->
<!-- content block -->
<div class="page-break"></div>
<!-- content block -->
<!-- content -->
    </body>
</html>
