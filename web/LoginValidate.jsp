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
if(session.getAttribute("UID")==null && session.getAttribute("UYEAR")==null && session.getAttribute("USECTION")==null && session.getAttribute("SDEPT")==null){
    String userID=request.getParameter("uname");
    String password=request.getParameter("upwd");
    String studdept=request.getParameter("dept");
    if(userID!="" && password!="" && (studdept!=null && studdept!="")){
    try{
        Class.forName("com.mysql.jdbc.Driver");
        String uri="jdbc:mysql://localhost:3306/feedback_"+studdept;
        Connection con=DriverManager.getConnection(uri, "root", "GRIETITOLFF1202");
        Statement st=con.createStatement();
        ResultSet rs;
        String sql="select UID,PASSWORD,YEAR,SECTION from students where UID='"+userID+"'";
        rs=st.executeQuery(sql);
        if(rs.next()){
            if(rs.getString("UID").equals(userID)&&rs.getString("PASSWORD").equals(password)){
                session.setAttribute("UID", userID);
                session.setAttribute("UYEAR", rs.getString("YEAR"));
                session.setAttribute("USECTION", rs.getString("SECTION"));
                session.setAttribute("SDEPT", studdept);%>
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