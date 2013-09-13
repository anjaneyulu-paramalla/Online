<%-- 
    Document   : Logout
    Created on : Jun 27, 2012, 2:07:53 AM
    Author     : Anjaneyulu
--%>

<%@page errorPage="Error.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <title>::GRIET</title>
    </head>
<body>
<%
if(session.getAttribute("UID")!=null && session.getAttribute("UYEAR")!=null && session.getAttribute("USECTION")!=null && session.getAttribute("SDEPT")!=null){
    String dept=(String)session.getAttribute("SDEPT");
    session.setAttribute("UID", null);
    session.setAttribute("UYEAR", null);
    session.setAttribute("USECTION", null);
    session.setAttribute("SDEPT", null);
    session.removeAttribute("UID");    
    session.removeAttribute("UYEAR");
    session.removeAttribute("USECTION"); 
    session.removeAttribute("SDEPT"); 
    session.invalidate();%>
    <jsp:forward page="./" >
        <jsp:param name="department" value="<%=dept%>" />
    </jsp:forward>
  <%}
  else{%>
    <jsp:forward page="./" />
<%}%>
</body>
</html>
