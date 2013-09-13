<%-- 
    Document   : FacHome
    Created on : Mar 27, 2013, 9:12:23 PM
    Author     : Anji
--%>

<%@page import="DataConnection.FacConnector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
        <link rel="stylesheet" href="CSS/redun.css" />  
    </head>
    <body>
<% 
if(session.getAttribute("FACID")!=null && session.getAttribute("FACDEPT")!=null){
    String fid=""+session.getAttribute("FACID");
    String fdept=(String)session.getAttribute("FACDEPT");
    try{
        Connection con=new FacConnector().getConnection(); 
        Statement st=con.createStatement();
        String sql="select FNAME from faculty where FID='"+fid+"'";
        ResultSet rs=st.executeQuery(sql);
        if(rs.next()){%>
        <h3 style="text-align: center">Hello <%=rs.getString("FNAME")%>,<br />Welcome to the Online FeedBack System</h3>
        <center>
            <b><u style="color: red">Note</u>:Please give your feedback honestly. <br />
                Your feedback is Anonymous!</b>
        </center>
        <% } 
        con.close();
        st.close();
    }
    catch(Exception e){
        out.print("<center>"+e+"</center>");
    }      
}
else{%>
    <form action="./" target="_top" id="autosubmit"  method="post" onload="myfunc()">
        <input type="hidden" name="uaccount" value="Faculty" />
    </form>
    <script type="text/javascript">
        function myfunc () {
            var frm = document.getElementById("autosubmit");
            frm.submit();
        }
        window.document.getElementById("autosubmit").onload = myfunc();
    </script>
    <noscript>
        <center>
            <h2> You are not Logged In.
            Please Login to continue!
            <form action="./" target="_top" method="post" >
                <input type="hidden" name="uaccount" value="Faculty" />
                <button type="submit" class="redbutton">LogIn</button>
            </form>
            </h2>
        </center>
    </noscript>
<%}%>
    </body>
</html>