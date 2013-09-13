<%-- 
    Document   : verify
    Created on : Mar 29, 2013, 9:46:44 PM
    Author     : Anji
--%>
<%@page errorPage="Error.jsp" %>
<%if((session.getAttribute("UID")==null || session.getAttribute("UYEAR")==null || session.getAttribute("USECTION")==null || session.getAttribute("SDEPT")==null) && (session.getAttribute("AID")==null ||session.getAttribute("DEPT")==null) &&(session.getAttribute("PID")==null || session.getAttribute("PYEAR")==null || session.getAttribute("PSECTION")==null || session.getAttribute("PCOURSE")==null) && (session.getAttribute("PAID")==null ||session.getAttribute("PACOURSE")==null)  && (session.getAttribute("FACID")==null ||session.getAttribute("FACDEPT")==null) && (session.getAttribute("FACAID")==null )){
    try{
    String uaccount=request.getParameter("uaccount");
    if(uaccount!=null && uaccount.toLowerCase().equals("student")){
        String course=request.getParameter("ucourse");
        String uname=request.getParameter("uname");
        String upwd=request.getParameter("upwd");
        if(course.equals("B.Tech")){
            String udept=request.getParameter("udept");%>
            <jsp:forward page="LoginValidate.jsp">
                <jsp:param name="dept" value="<%=udept%>" />
                <jsp:param name="uname" value="<%=uname%>" />
                <jsp:param name="upwd" value="<%=upwd%>" /> 
            </jsp:forward>
        <%}
        else{
            String specvalue="";
            if(course.equals("M.Tech")){
                specvalue=request.getParameter("mtechudept");%>
                <jsp:forward page="PGLoginValidate.jsp"> 
                    <jsp:param name="ucourse" value="<%=course%>" />
                    <jsp:param name="udept" value="<%=specvalue%>" />
                    <jsp:param name="uname" value="<%=uname%>" />
                    <jsp:param name="upwd" value="<%=upwd%>" /> 
                </jsp:forward>
            <%}
            else if(course.equals("MBA")){
                specvalue=request.getParameter("mbaudept");%>
                <jsp:forward page="PGLoginValidate.jsp"> 
                    <jsp:param name="ucourse" value="<%=course%>" />
                    <jsp:param name="udept" value="<%=specvalue%>" />
                    <jsp:param name="uname" value="<%=uname%>" />
                    <jsp:param name="upwd" value="<%=upwd%>" /> 
                </jsp:forward>
            <%}
            else{%>
                <jsp:forward page="PGLoginValidate.jsp"> 
                    <jsp:param name="ucourse" value="<%=course%>" />
                    <jsp:param name="uname" value="<%=uname%>" />
                    <jsp:param name="upwd" value="<%=upwd%>" /> 
                </jsp:forward>
            <%}
        }
    }
    else if(uaccount!=null && uaccount.toLowerCase().equals("faculty")){
        String uname=request.getParameter("uname");
        String upwd=request.getParameter("upwd");%>
        <jsp:forward page="FacLoginValidate.jsp">
            <jsp:param name="uname" value="<%=uname%>" />
            <jsp:param name="upwd" value="<%=upwd%>" /> 
        </jsp:forward>
    <%}
    else if(uaccount!=null && uaccount.toLowerCase().equals("administrator")){
        String course=request.getParameter("ucourse");
        String uname=request.getParameter("uname");
        String upwd=request.getParameter("upwd");
        if(course.equals("B.Tech")){
            String udept=request.getParameter("udept");%>
            <jsp:forward page="AdminLoginValidate.jsp">
                <jsp:param name="dept" value="<%=udept%>" />
                <jsp:param name="aname" value="<%=uname%>" />
                <jsp:param name="apwd" value="<%=upwd%>" /> 
            </jsp:forward>
        <%}
        else{
            String specvalue="";
            if(course.equals("M.Tech")){
                specvalue=request.getParameter("mtechudept");%>
                <jsp:forward page="PGAdminLoginValidate.jsp"> 
                    <jsp:param name="ucourse" value="<%=course%>" />
                    <jsp:param name="mtechudept" value="<%=specvalue%>" />
                    <jsp:param name="uname" value="<%=uname%>" />
                    <jsp:param name="upwd" value="<%=upwd%>" /> 
                </jsp:forward>
            <%}
            else if(course.equals("MBA")){
                specvalue=request.getParameter("mbaudept");%>
                <jsp:forward page="PGAdminLoginValidate.jsp"> 
                    <jsp:param name="ucourse" value="<%=course%>" />
                    <jsp:param name="mbaudept" value="<%=specvalue%>" />
                    <jsp:param name="uname" value="<%=uname%>" />
                    <jsp:param name="upwd" value="<%=upwd%>" /> 
                </jsp:forward>
            <%}
            else{%>
                <jsp:forward page="PGAdminLoginValidate.jsp"> 
                    <jsp:param name="ucourse" value="<%=course%>" />
                    <jsp:param name="uname" value="<%=uname%>" />
                    <jsp:param name="upwd" value="<%=upwd%>" /> 
                </jsp:forward>
            <%}
        }
    } 
    else if(uaccount!=null && uaccount.toLowerCase().equals("administrator-2")){
        String uname=request.getParameter("uname");
        String upwd=request.getParameter("upwd");%>
        <jsp:forward page="FacLoginValidate.jsp">
            <jsp:param name="uname" value="<%=uname%>" />
            <jsp:param name="upwd" value="<%=upwd%>" /> 
        </jsp:forward>
    <%}
    else{%>
        <jsp:forward page="./" />
    <%}
    }
    catch(Exception e){%>
        <jsp:forward page="./" />
    <%}
}
else{%>
    <jsp:forward page="./" />   
<%}%>