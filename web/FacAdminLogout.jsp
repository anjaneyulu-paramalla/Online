<%-- 
    Document   : FacAdminLogout
    Created on : Apr 4, 2013, 9:13:00 AM
    Author     : Anji
--%>
<%@page errorPage="Error.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <title>::GRIET</title>
    </head>
<body>
<%if(session.getAttribute("FACAID")!=null){
    session.setAttribute("FACAID", null);
    session.removeAttribute("FACAID"); 
    session.invalidate();%>
    <jsp:forward page="./" >
        <jsp:param name="uaccount" value="Administrator-2" />
    </jsp:forward>
  <%}
  else{%>
    <jsp:forward page="./" >
        <jsp:param name="uaccount" value="Administrator-2" />
    </jsp:forward>
<%}%>
</body>
</html>

