<%-- 
    Document   : Home
    Created on : Jun 24, 2012, 1:48:39 AM
    Author     : Anjaneyulu
--%>
<%@page import="DataConnection.Connector"%>
<%@page import="java.sql.ResultSet" errorPage="Error.jsp"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
        <link rel="stylesheet" href="CSS/redun.css" />  
    </head>
    <body>
<% 
if(session.getAttribute("UID")!=null && session.getAttribute("UYEAR")!=null && session.getAttribute("USECTION")!=null && session.getAttribute("SDEPT")!=null){
            String sdept=(String)session.getAttribute("SDEPT");
            try{
                Connection con=new Connector(sdept).getConnection();
                Statement st=con.createStatement();
                String uid=""+session.getAttribute("UID");
                String inf=""+session.getAttribute("UYEAR")+session.getAttribute("USECTION");
                String sql="select UNAME from students where UID='"+uid+"'";
                ResultSet rs=st.executeQuery(sql);
                if(rs.next()){%>
                <h3 style="text-align: center">Hello <%=rs.getString("UNAME")%>,<br />Welcome to the Online FeedBack System</h3>
                <h3><u style="color: red">Note</u>:Please give your feedback honestly. <br />
                    <center>We do not store your Feedback.We store only the average rating given by all students!</center>
                </h3>
               <% } 
               con.close();
               st.close();
            }
            catch(Exception e){
                out.print("<center>"+e+"</center>");
            }      
}
else{%>
    <form action="./" target="_top" id="autosubmit"  method="post" onload="myfunc()"></form>
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
                <button type="submit" class="redbutton">LogIn</button>
            </form>
            </h2>
        </center>
    </noscript>
<%}%>
    </body>
</html>