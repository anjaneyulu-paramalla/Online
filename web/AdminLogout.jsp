<%-- 
    Document   : AdminLogout
    Created on : Jul 8, 2012, 4:22:01 PM
    Author     : Anjaneyulu
--%>
<%@page errorPage="Error.jsp" %>
<%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){
    String dept=(String)session.getAttribute("DEPT");
    session.setAttribute("AID", null);
    session.setAttribute("DEPT", null);
    session.removeAttribute("AID");  
    session.removeAttribute("DEPT");
    session.invalidate();%>
    <jsp:forward page="./" >
        <jsp:param name="uaccount" value="Administrator"/>
        <jsp:param name="department" value='<%=dept%>' /> 
    </jsp:forward>
  <%}
  else{%>
  <jsp:forward page="./" >
    <jsp:param name="uaccount" value="Administrator"/>
  </jsp:forward>
<%}%>
