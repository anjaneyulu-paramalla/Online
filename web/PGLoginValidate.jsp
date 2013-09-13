<%-- 
    Document   : PGLoginValidate
    Created on : Apr 13, 2013, 11:52:35 AM
    Author     : Anji
--%>

<%@page import="DataConnection.MCAConnector" errorPage="Error.jsp"%>
<%@page import="DataConnection.MBAConnector"%>
<%@page import="DataConnection.MTechConnector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%if(session.getAttribute("PID")==null && session.getAttribute("PYEAR")==null && session.getAttribute("PSECTION")==null && session.getAttribute("PCOURSE")==null){
    String userID=request.getParameter("uname");
    String password=request.getParameter("upwd");
    String studentcourse=request.getParameter("ucourse");
    if(userID!="" && password!="" && (studentcourse!=null && studentcourse!="")){
        if(studentcourse.equals("M.Tech")){
            studentcourse="mtech";
            try{
                Connection con=new MTechConnector().getConnection();
                Statement st=con.createStatement();
                ResultSet rs;
                String sql="select UID,PASSWORD,YEAR,SECTION,SPECIALIZATION from `"+studentcourse+"_students` where UID='"+userID+"'";
                rs=st.executeQuery(sql);
                if(rs.next()){
                    if(rs.getString("UID").equals(userID)&&rs.getString("PASSWORD").equals(password)){
                        session.setAttribute("PID", userID);
                        session.setAttribute("PYEAR", rs.getString("YEAR"));
                        session.setAttribute("PSECTION", rs.getString("SECTION"));
                        session.setAttribute("PCOURSE", studentcourse);
                        session.setAttribute("PSPECIALIZATION", rs.getString("SPECIALIZATION")); %>
                        <jsp:forward page="PGMain.jsp" />
                    <%}
                    else{%>
                        <jsp:forward page="./" >
                            <jsp:param name="invalid" value="Wrong Password"/>
                            <jsp:param name="course" value='<%=studentcourse %>' /> 
                        </jsp:forward>
                    <%}    
                }
                else{%>
                    <jsp:forward page="./" >
                        <jsp:param name="invalid" value="Wrong UserID"/>
                        <jsp:param name="course" value='<%=studentcourse%>' />
                    </jsp:forward>
                <%}
            }
            catch(Exception e){
                out.print("<center>"+e+"</center>");
            }
        }
        else if(studentcourse.equals("MBA")){
            studentcourse="mba";
            try{
                Connection con=new MBAConnector().getConnection();
                Statement st=con.createStatement();
                ResultSet rs;
                String sql="select UID,PASSWORD,YEAR,SECTION,SPECIALIZATION from `"+studentcourse+"_students` where UID='"+userID+"'";
                rs=st.executeQuery(sql);
                if(rs.next()){
                    if(rs.getString("UID").equals(userID)&&rs.getString("PASSWORD").equals(password)){
                        session.setAttribute("PID", userID);
                        session.setAttribute("PYEAR", rs.getString("YEAR"));
                        session.setAttribute("PSECTION", rs.getString("SECTION"));
                        session.setAttribute("PCOURSE", studentcourse);
                        session.setAttribute("PSPECIALIZATION", rs.getString("SPECIALIZATION"));%>
                        <jsp:forward page="PGMain.jsp" />
                    <%}
                    else{%>
                        <jsp:forward page="./" >
                            <jsp:param name="invalid" value="Wrong Password"/>
                            <jsp:param name="course" value='<%=studentcourse %>' /> 
                        </jsp:forward>
                    <%}    
                }
                else{%>
                    <jsp:forward page="./" >
                        <jsp:param name="invalid" value="Wrong UserID"/>
                        <jsp:param name="course" value='<%=studentcourse%>' />
                    </jsp:forward>
                <%}
            }
            catch(Exception e){
                out.print("<center>"+e+"</center>");
            }
        }
        else{
            studentcourse="mca";
            try{
                Connection con=new MCAConnector().getConnection();
                Statement st=con.createStatement();
                ResultSet rs;
                String sql="select UID,PASSWORD,YEAR,SECTION from `"+studentcourse+"_students` where UID='"+userID+"'";
                rs=st.executeQuery(sql);
                if(rs.next()){
                    if(rs.getString("UID").equals(userID)&&rs.getString("PASSWORD").equals(password)){
                        session.setAttribute("PID", userID);
                        session.setAttribute("PYEAR", rs.getString("YEAR"));
                        session.setAttribute("PSECTION", rs.getString("SECTION"));
                        session.setAttribute("PCOURSE", studentcourse);%>
                        <jsp:forward page="PGMain.jsp" />
                    <%}
                    else{%>
                        <jsp:forward page="./" >
                            <jsp:param name="invalid" value="Wrong Password"/>
                            <jsp:param name="course" value='<%=studentcourse %>' /> 
                        </jsp:forward>
                    <%}    
                }
                else{%>
                    <jsp:forward page="./" >
                        <jsp:param name="invalid" value="Wrong UserID"/>
                        <jsp:param name="course" value='<%=studentcourse%>' />
                    </jsp:forward>
                <%}
            }
            catch(Exception e){
                out.print("<center>"+e+"</center>");
            }
        }
   }
   else{%>
        <jsp:forward page="./" >
            <jsp:param name="invalid" value="Empty UserID/Paswword"/>
        </jsp:forward>
   <%}
}
else{%>
    <jsp:forward page="./" />
<%}%>