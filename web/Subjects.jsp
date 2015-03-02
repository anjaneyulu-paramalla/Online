<%-- 
    Document   : Subjects
    Created on : Jun 27, 2012, 1:25:31 AM
    Author     : Anjaneyulu
--%>

<%@page import="org.data.connection.Connector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
if(session.getAttribute("UID")!=null && session.getAttribute("UYEAR")!=null && session.getAttribute("USECTION")!=null && session.getAttribute("SDEPT")!=null){
            String sdept=(String)session.getAttribute("SDEPT");
            try{
                Connection con=new Connector(sdept).getConnection();
                Statement st=con.createStatement();
                String year=""+session.getAttribute("UYEAR");
                String section=""+session.getAttribute("USECTION");
                String sq="select CURRENT_SEM from semester where YEAR="+year;
                ResultSet rs=st.executeQuery(sq); 
                String sem="";
                if(rs.next())
                    sem=rs.getString("CURRENT_SEM");
                String sql="select SID,SNAME,SCODE,Subjects_"+year+"_"+sem+section+".FID,FNAME from faculty,Subjects_"+year+"_"+sem+section+" where subjects_"+year+"_"+sem+section+".FID=faculty.FID order by SID";
                rs=st.executeQuery(sql);%>
                <h3 ><center><u>Subjects for <%=sdept%> <%=year%>-<%=sem%> <%=section%> Section:</u></center></h3>
                <%if(rs.next()){%>
                    <table width="700" border="5" cellspacing="0" align="center">
                        <tr height="40" bgcolor= "#9999ff" align="left">
                            <th align="center">SID</th>
                            <th align="center">SUBJECT</th>
                            <th align="center">CODE</th>
                            <th align="center">FACULTY</th>
                        </tr>
                        <tr height="30" style="font-weight: bold">
                            <td align="center"><%=rs.getInt("SID")%></td>
                            <td><%=rs.getString("SNAME") %></td>
                            <td><%=rs.getString("SCODE")%></td>
                            <td><%=rs.getString("FNAME") %></td>
                        </tr>
                        <%while(rs.next()){%>
                            <tr height="30" style="font-weight: bold">
                                <td align="center"><%=rs.getInt("SID")%></td>
                                <td><%=rs.getString("SNAME") %></td>
                                <td><%=rs.getString("SCODE")%></td>
                                <td><%=rs.getString("FNAME") %></td>
                            </tr>
                        <%}%>
                    </table>
                <%}
                else{
                    out.println("<center><b>No Subjects Found!</b></center>");
                }
                con.close();
                st.close(); 
            }
            catch(Exception e){
                out.print("<center>"+e+"</center>");
            }
        }
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
        <center><h2>
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