<%-- 
    Document   : FacLoginValidate
    Created on : Mar 27, 2013, 2:50:10 PM
    Author     : Anji
--%>

<%@page import="DataConnection.FacConnector" errorPage="Error.jsp"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%
if((session.getAttribute("FACID")!=null && session.getAttribute("FACDEPT")!=null) ||session.getAttribute("FACAID")!=null){%>
    <jsp:forward page="./" />
<%}
else{
    String account=request.getParameter("uaccount");
    try{
    if(account.equals("Faculty")){
        String facid=request.getParameter("uname");
        String facpass=request.getParameter("upwd");
        try{
            Connection con=new FacConnector().getConnection(); 
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery("select FID,DESIGNATION,PASSWORD,DEPT from faculty where FID='"+facid+"'");
            if(rs.next()){
                if(rs.getString("FID").equals(facid)&&rs.getString("PASSWORD").equals(facpass)){
                    session.setAttribute("FACID", facid);
                    session.setAttribute("FACDEPT",rs.getString("DEPT") );%>
                    <jsp:forward page="FacMain.jsp" />
                <%}
                else{%>
                    <jsp:forward page="./" >
                        <jsp:param name="invalid" value="Wrong Password"/>
                        <jsp:param name="uaccount" value="<%=account%>" />
                    </jsp:forward>
                <%}  
            }
            else{%>
                <jsp:forward page="./" >
                    <jsp:param name="invalid" value="Wrong UserID"/>
                    <jsp:param name="uaccount" value="<%=account%>" /> 
                </jsp:forward>
            <%} 
        }
        catch(Exception e){
            out.print("<center>"+e+"</center>");
        }
    }
    else{
        String adminid=request.getParameter("uname");
        String adminpass=request.getParameter("upwd");
        try{
            Connection con=new FacConnector().getConnection(); 
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery("select AID,PASSWORD from admin where AID='"+adminid+"'");
            if(rs.next()){
                if(rs.getString("AID").equals(adminid)&&rs.getString("PASSWORD").equals(adminpass)){
                    session.setAttribute("FACAID",adminid );%>
                    <jsp:forward page="FacAdminMain.jsp" />
                <%}
                else{%>
                    <jsp:forward page="./" >
                        <jsp:param name="invalid" value="Wrong Password"/>
                        <jsp:param name="uaccount" value="<%=account%>" />
                    </jsp:forward>
                <%}  
            }
            else{%>
                <jsp:forward page="./" >
                    <jsp:param name="invalid" value="Wrong UserID"/>
                    <jsp:param name="uaccount" value="<%=account%>" /> 
                </jsp:forward>
            <%} 
        }
        catch(Exception e){
            out.print("<center>"+e+"</center>");
        }
    }
    }
    catch(Exception e){
        out.print("<center>"+e+"</center>");
    }
}%>