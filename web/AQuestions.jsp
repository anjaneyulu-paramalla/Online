<%-- 
    Document   : Questions
    Created on : Jul 24, 2012, 12:13:57 AM
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
        <%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){
  String dept=(String)session.getAttribute("DEPT");
    try{
        Connection con=new Connector(dept).getConnection();
        Statement st=con.createStatement();
        String sql="select * from Questions order by QID";
        ResultSet rs=st.executeQuery(sql);%>
        <h3 ><center><u>Questions for Feedback of<%=dept%> Department</u>:</center></h3>
        <%if(rs.next()){%>
        <table border="5" cellspacing="0" align="center">
            <tr style="height: 12px;background-color: #9999ff">
                <th>
                    QID
                </th>
                <th>
                    Question
                </th>
            </tr>
            <tr style="height: 9px;font-weight: bold">
                <td align="center">
                    <%=rs.getString("QID")%>
                </td>
                <td>
                    <%=rs.getString("Question")%>
                </td>
            </tr>
            <%while(rs.next()){%>
            <tr style="height: 9px;font-weight: bold">
                <td align="center">
                    <%=rs.getString("QID")%>
                </td>
                <td>
                    <%=rs.getString("Question")%>
                </td>
            </tr>
            <%}%>
        </table>
        <!--<table align="center" style="margin-top: 10px">
        <tr style="height: 10mm">
                <td colspan="2">
                    <form action="#" method="post">
                        <button type="submit">Edit</button>
                        <input type="hidden" name="status" value="Edit" />
                    </form>
                </td>
        </tr>
        </table>-->
        <%}
        else{
            out.println("<center>No Questions Found!</center>");%>
            <!--<table align="center" style="margin-top: 10px">
                <tr style="height: 10mm">
                    <td colspan="2">
                        <form action="#" method="post">
                            <button type="submit">Add</button>
                            <input type="hidden" name="status" value="Add" />
                        </form>
                    </td>
                </tr>
            </table>-->
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
    <%--<jsp:forward page="./" />--%>
    <form action="./" target="_top" id="autosubmit"  method="post" onload="myfunc()">
        <input type="hidden" name="uaccount" value="Administrator" />
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
                <input type="hidden" name="uaccount" value="Administrator" />
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