<%-- 
    Document   : ACourse
    Created on : Jul 24, 2012, 1:24:04 AM
    Author     : Anjaneyulu
--%>

<%@page import="java.sql.ResultSet" errorPage="Error.jsp"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
        Class.forName("com.mysql.jdbc.Driver");
        String uri="jdbc:mysql://localhost:3306/feedback_"+dept; 
        Connection con=DriverManager.getConnection(uri,"root","GRIETITOLFF1202");
        Statement st=con.createStatement();
        String sql="select * from semester order by year";
        ResultSet rs=st.executeQuery(sql);
        if(rs.next()){%>
        <form>
            <h3><center><u>Semester details of <%=dept%></u>:</center></h3>
            <table border="5" cellspacing="0" align="center">
            <tr style="height: 10mm;background-color: #9999ff">
                <th>
                    YEAR
                </th>
                <th>
                    CURRENT_SEMESTER
                </th>
                <th>
                    TOTAL_SECTIONS
                </th>
            </tr>
            <tr style="height: 10mm;font-weight: bold">
                <td align="center">
                    <%=rs.getString("YEAR")%>
                </td>
                <td align="center">
                    <%=rs.getString("CURRENT_SEM")%>
                </td>
                <td align="center">
                    <%=rs.getString("SECTIONS")%>
                </td>
            </tr>
            <%while(rs.next()){%>
            <tr style="height: 10mm;font-weight: bold">
               <td align="center">
                    <%=rs.getString("YEAR")%>
                </td>
                <td align="center">
                    <%=rs.getString("CURRENT_SEM")%>
                </td>
                <td align="center">
                    <%=rs.getString("SECTIONS")%>
                </td>
            </tr>
            <%}%>
            </table>
            <!--<table align="center" style="margin-top: 10px"><tr><td><button type="submit" >Update</button></td></tr></table>-->
        </form>
        <%}
        else{
            out.println("No Data Found!");%>
        <%}
        con.close();
    }
    catch(Exception e){
        out.println(e);
    }%>
    <h3><center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></center></h3>
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
                <input type="hidden" name="uaccount" value="Administrator" />>
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
