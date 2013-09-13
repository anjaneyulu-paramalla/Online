<%-- 
    Document   : FacoutputFrame
    Created on : Mar 28, 2013, 2:02:44 AM
    Author     : Anji
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
<%
if(session.getAttribute("FACID")!=null && session.getAttribute("FACDEPT")!=null){ 
    out.print(request.getParameter("outInFrame"));
}
else{%>
    <form action="./" target="_top" id="autosubmit"  method="post" onload="myfunc()">
        <input type="hidden" name="uaccount" value="Faculty" />
    </form>
    <script type="text/javascript">
        function myfunc () {
            var frm = document.getElementById("autosubmit");
            frm.submit();
        }
        window.document.getElementById("autosubmit").onload = myfunc();
    </script>
    <noscript>
        <center><h2>
            You are not Logged In.
            Please Login to continue!
            <form action="./" target="_top" method="post" >
                <input type="hidden" name="uaccount" value="Faculty" />
                <button type="submit" class="redbutton">LogIn</button>
            </form>
            </h2>
        </center>
    </noscript>
<%}%>
    </body>
</html>