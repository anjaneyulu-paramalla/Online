<%-- 
    Document   : LoginValidate
    Created on : Jun 23, 2012, 6:24:31 PM
    Author     : Anjaneyulu
--%>
<%@page import="java.sql.ResultSet" errorPage="Error.jsp"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%
if(session.getAttribute("AID")==null && session.getAttribute("DEPT")==null){
    String AdminID=request.getParameter("aname");
    String password=request.getParameter("apwd");
    String dept=request.getParameter("dept");
    if(AdminID!="" && password!="" && (dept!=null && dept!="")){
    try{
        Class.forName("com.mysql.jdbc.Driver");
        String uri="jdbc:mysql://localhost:3306/feedback_"+dept;
        Connection con=DriverManager.getConnection(uri,"root","GRIETITOLFF1202"); 
        Statement st=con.createStatement();
        ResultSet rs;
        String sql="select AID,PASSWORD from Admin where AID='"+AdminID+"'";
        rs=st.executeQuery(sql);
        if(rs.next()){
             if(rs.getString("AID").equals(AdminID)&& rs.getString("PASSWORD").equals(password)){
                    session.setAttribute("AID", AdminID);
                    session.setAttribute("DEPT", dept); %>
                    <jsp:forward page="AdminMain.jsp"/>
             <%}
             else{%>
                    <jsp:forward page="./" >
                        <jsp:param name="uaccount" value="Administrator"/>
                        <jsp:param name="invalid" value="Wrong Password"/>
                        <jsp:param name="department" value='<%=dept%>' />
                    </jsp:forward>
             <%}
        }
        else{%>
            <jsp:forward page="./" >
                <jsp:param name="uaccount" value="Administrator"/>
                <jsp:param name="invalid" value="Wrong Password"/>
                <jsp:param name="department" value='<%=dept%>' />
            </jsp:forward>
        <%}
    }
    catch(Exception e){
        out.print("<center>"+e+"</center>");
    }
   }
   else{%>
        <jsp:forward page="./" >
            <jsp:param name="uaccount" value="Administrator"/>
            <jsp:param name="invalid" value="Wrong Password"/>
            <jsp:param name="department" value='<%=dept%>' />
        </jsp:forward>
   <%}
   }
  else{%>
    <jsp:forward page="./" >
        <jsp:param name="uaccount" value="Administrator" />
    </jsp:forward>
  <%}%>