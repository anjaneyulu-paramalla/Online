<%-- 
    Document   : FacLogout
    Created on : Mar 27, 2013, 9:21:16 PM
    Author     : Anji
--%>
<%@page errorPage="Error.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <title>::GRIET</title>
    </head>
<body>
<%if(session.getAttribute("FACID")!=null && session.getAttribute("FACDEPT")!=null){
    String fdept=(String)session.getAttribute("FACDEPT");
    session.setAttribute("FACID", null);
    session.setAttribute("FACDEPT", null);
    session.removeAttribute("FACID");    
    session.removeAttribute("FACDEPT"); 
    session.invalidate();%>
    <jsp:forward page="./" >
        <jsp:param name="uaccount" value="Faculty" />
    </jsp:forward>
  <%}
  else{%>
    <jsp:forward page="./" >
         <jsp:param name="uaccount" value="Faculty" />
    </jsp:forward>
<%}%>
</body>
</html>

