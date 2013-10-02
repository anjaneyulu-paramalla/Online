<%-- 
    Document   : PGAdminLoginValidate
    Created on : Apr 13, 2013, 11:53:47 AM
    Author     : Anji
--%>

<%@page import="java.sql.ResultSet" errorPage="Error.jsp"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
if(session.getAttribute("PID")==null && session.getAttribute("PYEAR")==null && session.getAttribute("PSECTION")==null && session.getAttribute("PCOURSE")==null){
    String userID=request.getParameter("uname");
    String password=request.getParameter("upwd");
    String specialization=request.getParameter("ucourse");
    if(userID!="" && password!="" && (specialization!=null && specialization!="")){
    try{
        Class.forName("com.mysql.jdbc.Driver"); 
        String uri="jdbc:mysql://localhost:3306/feedback_"+specialization;
        Connection con=DriverManager.getConnection(uri, "root", "GRIETITOLFF1202");
        Statement st=con.createStatement();
        ResultSet rs;
        String sql="select UID,PASSWORD,YEAR,SECTION from students where UID='"+userID+"'";
        rs=st.executeQuery(sql);
        if(rs.next()){
            if(rs.getString("UID").equals(userID)&&rs.getString("PASSWORD").equals(password)){
                session.setAttribute("PID", userID);
                session.setAttribute("PYEAR", rs.getString("YEAR"));
                session.setAttribute("PSECTION", rs.getString("SECTION"));
                session.setAttribute("PCOURSE", specialization);%>
                <jsp:forward page="Main.jsp" />
            <%}
            else{%>
                <jsp:forward page="index.jsp" >
                    <jsp:param name="invalid" value="Wrong Password"/>
                    <jsp:param name="department" value='<%=request.getParameter("dept")%>' />
                </jsp:forward>
            <%}    
        }
        else{%>
            <jsp:forward page="./" >
                <jsp:param name="invalid" value="Wrong UserID"/>
                <jsp:param name="department" value='<%=request.getParameter("dept")%>' />
            </jsp:forward>
       <%}
    }
    catch(Exception e){
        out.print("<center>"+e+"</center>");
    }
   }
   else{%>
        <jsp:forward page="./" >
            <jsp:param name="invalid" value="Empty UserID/Paswword"/>
            <jsp:param name="department" value='<%=request.getParameter("dept")%>' />
        </jsp:forward>
   <%}
}
else{%>
    <jsp:forward page="./" />
<%}%>
