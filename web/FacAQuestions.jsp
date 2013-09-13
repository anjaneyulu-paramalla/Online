<%-- 
    Document   : FacAQuestions
    Created on : Apr 7, 2013, 2:26:57 PM
    Author     : Anji
--%>

<%@page import="DataConnection.FacConnector" errorPage="Error.jsp"%>
<%-- 
    Document   : Questions
    Created on : Jul 24, 2012, 12:13:57 AM
    Author     : Anjaneyulu
--%>

<%@page import="java.sql.ResultSet"%>
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
    <%if(session.getAttribute("FACAID")!=null){
    try{
        Connection con=new FacConnector().getConnection();
        Statement st=con.createStatement();
        String sql="select * from questions order by QID";
        ResultSet rs=st.executeQuery(sql);%>
        <h3 ><center><u>Feedback questions for faculty of all Departments</u>:</center></h3>
        <%if(rs.next()){%>
        <table border="5" width="80%" cellspacing="0" align="center">
            <tr style="height: 12px;background-color: #9999ff">
                <th>
                    QID
                </th>
                <th>
                    Question
                </th>
            </tr>
            <tr style="height: 9px;">
                <td align="center" valign="top">
                    <%=rs.getString("QID")%>
                </td>
                <td>
                    <%=rs.getString("Question")%>
                </td>
            </tr>
            <%while(rs.next()){%>
            <tr style="height: 9px;">
                <td align="center" valign="top">
                    <%=rs.getString("QID")%>
                </td>
                <td>
                    <%=rs.getString("Question")%>
                </td>
            </tr>
            <%}%>
        </table>
        <%}
        else{
            out.println("<center>No Questions Found!</center>");%>
        <%}
        st.close();
        con.close();
    }
    catch(Exception e){
        out.println(e);
    }%>
    <h3 ><center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></center></h3>
<%}
else{%>
    <form action="./" target="_top" id="autosubmit"  method="post" onload="myfunc()">
        <input type="hidden" name="uaccount" value="Administrator-2" />
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
            <h2>You are not Logged In.
            Please Login to continue!
            <form action="./" target="_top" method="post" >
                <input type="hidden" name="uaccount" value="Administrator-2" />
                <button type="submit" class="redbutton" >LogIn</button>
            </form>
            </h2>
        </center>
    </noscript>
<%}%>
    <noscript>
        <center><h4 style="color:red;"> JavaScript is not enabled on your Browser<br />Please enable JavaScript to make the page Interactive</h4></center>
    </noscript>
    </body>
</html>
