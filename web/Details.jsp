<%-- 
    Document   : Details
    Created on : Jun 27, 2012, 1:01:27 AM
    Author     : Anjaneyulu
--%>

<%@page import="org.data.connection.Connector"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
        <link rel="stylesheet" href="CSS/redun.css" />
        <style type="text/css">
            th,td{
                border-width: 0px;
            } 
        </style>
    </head>
    <body>
<%
if(session.getAttribute("UID")!=null && session.getAttribute("UYEAR")!=null && session.getAttribute("USECTION")!=null && session.getAttribute("SDEPT")!=null){
            String sdept=(String)session.getAttribute("SDEPT");
            try{
                Connection con=new Connector(sdept).getConnection(); 
                Statement st=con.createStatement();
                String uid=""+session.getAttribute("UID");
                String year=""+session.getAttribute("UYEAR");
                String section=""+session.getAttribute("USECTION"); 
                String sql="select UNAME,YEAR,SECTION from students where UID='"+uid+"'";
                ResultSet rs=st.executeQuery(sql);
                if(rs.next()){%>
                    <center><h2 style="display: inline"><u>Details</u>:</h2></center><br />
                    <table align="center" border="3"  width="400" style="border-radius:10px;background-color: #ccffcc;padding: 10px">
                        <tr>
                            <th align="right">Name:</th>
                            <td align="left"><%=rs.getString("UNAME") %></td>
                        </tr>
                        <tr>
                            <th align="right">ID:</th>
                            <td align="left"><%=uid%></td>
                        </tr>
                        <tr>
                            <th align="right">Course:</th>
                            <td align="left">B.Tech</td>
                        </tr>
                        <tr>
                            <th align="right">Branch:</th>
                            <td align="left"><%=sdept %></td>
                        </tr>
                        <tr>
                            <th align="right">Year:</th>
                            <td align="left"><%=rs.getString("YEAR")%></td>
                        </tr>
                        <%String stsec=""+rs.getString("SECTION");
                        String sq="select CURRENT_SEM from semester where YEAR="+year;
                        rs=st.executeQuery(sq); 
                        if(rs.next()){%>
                        <tr>
                            <th align="right">Semester:</th>
                            <td align="left"><%=rs.getString("CURRENT_SEM")%></td>
                        </tr>
                        <%}%>
                        <tr>
                            <th align="right">Section:</th>
                            <td align="left"><%=stsec%></td>
                        </tr>
                        <tr /><tr />
                        <tr /><tr />
                    </table>
               <% }   
               con.close();
               st.close();
            }
            catch(Exception e){
                out.print("<center>"+e+"</center>");
            }
        %>
<%}
else{%>
    <form action="./" target="_top" id="autosubmit"  method="post" onload="myfunc()">
        <input type="hidden" name="uaccount" value="Student" />
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
            <h2>
            You are not Logged In.
            Please Login to continue!
            <form action="./" target="_top" method="post" >
                <input type="hidden" name="uaccount" value="Student" />
                <button type="submit" class="redbutton">LogIn</button>
            </form>
            </h2>
        </center>
    </noscript>
<%}%>
    </body>
</html>