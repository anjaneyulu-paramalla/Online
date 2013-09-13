<%-- 
    Document   : Manual
    Created on : Jul 8, 2012, 5:06:20 PM
    Author     : Anjaneyulu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
        <link rel="stylesheet" href="CSS/redun.css" />
    </head>
    <body>
        <%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){%>
        <h1 style="display: inline">Manual!</h1>
    <center>
           <video width="600" height="350" controls="controls" style="background-color: black">
               <source src="Videos/h.mp4" type="video/mp4" />
            <source src="h.ogg" type="video/ogg" />
            <source src="h.webm" type="video/webm" />
            <object data="Videos/h.mp4" width="320" height="240">
                <embed src="h.swf" width="320" height="240" />
            </object> 
          </video>
        
        <!--iframe width="560" height="315" src="http://www.youtube.com/embed/mu1JgJARHO8" frameborder="0" allowfullscreen></iframe-->
    </center>
<%}
else{%>
    <%--<jsp:forward page="./" />--%>
    <form action="./" target="_top" id="autosubmit"  method="post" onload="myfunc()">
        <input type="hidden" name="uaccount" value="Administrator" />
    </form>
    <script type="text/javascript">
        function myfunc () {
            var frm = document.getElementById("autosubmit");
            frm.submit();
        }
        window.document.getElementById("autosubmit").onload = myfunc();
    </script>
    <noscript>
        <center>
            <h2>You are not Logged In.
            Please Login to continue!
            <form action="./" target="_top" method="post" >
                <input type="hidden" name="uaccount" value="Administrator" />
                <button type="submit" class="redbutton" >LogIn</button>
            </form>
            </h2>
        </center>
    </noscript>
<%}%>
    </body>
</html>