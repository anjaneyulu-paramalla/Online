<%-- 
    Document   : FacDetails
    Created on : Mar 27, 2013, 9:33:57 PM
    Author     : Anji
--%>

<%@page import="org.data.connection.FacConnector"%>
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
if(session.getAttribute("FACID")!=null && session.getAttribute("FACDEPT")!=null){
    String fid=""+session.getAttribute("FACID");
    String fdept=(String)session.getAttribute("FACDEPT");
    try{
        Connection con=new FacConnector().getConnection();
        Statement st=con.createStatement();; 
        String sql="select FID,FNAME,DESIGNATION from faculty where FID='"+fid+"'";
        ResultSet rs=st.executeQuery(sql);
        if(rs.next()){%>
            <center><h2 style="display: inline"><u>Details</u>:</h2></center><br />
            <table align="center" border="3"  width="400" style="border-radius:10px;background-color: #ccffcc;padding: 10px">
                <tr>
                    <th align="right">Name:</th>
                    <td align="left"><%=rs.getString("FNAME") %></td>
                </tr>
                <tr>
                    <th align="right">ID:</th>
                    <td align="left"><%=fid%></td>
                </tr>
                <tr>
                    <th align="right">Department:</th>
                    <td align="left"><%=fdept %></td>
                </tr>
                <tr>
                    <th align="right">Designation:</th>
                    <td align="left"><%=rs.getString("DESIGNATION")%></td>
                </tr>
                <tr /><tr />
                <tr /><tr />
            </table>
        <%}   
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
            <h2>
            You are not Logged In.
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
