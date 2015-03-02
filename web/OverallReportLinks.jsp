<%-- 
    Document   : OverallReportLinks
    Created on : Jul 28, 2012, 7:34:22 PM
    Author     : Anjaneyulu
--%>

<%@page import="org.data.connection.Connector"%>
<%@page import="java.sql.ResultSet" errorPage="Error.jsp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
    String year=request.getParameter("year");
    String sem=request.getParameter("sem");
    String dept=(String)session.getAttribute("DEPT");
    try{
        Connection con=new Connector(dept).getConnection();
        Statement st=con.createStatement();
        Statement ff=con.createStatement();
        String sql="select SECTIONS from semester where YEAR="+year; 
        String ins="insert into Z_intCalc_"+dept+"_"+year+"_"+sem+" values(?,?,?)";
        PreparedStatement pst=con.prepareStatement(ins);
        ResultSet rs=st.executeQuery(sql),irs;
        int sec;
        if(rs.next()){
            sec=rs.getInt("SECTIONS");
            int i=1;
            String sf=new String();
            while(i<=sec){
                char c=(char)(i+64);
                sf="select * from Subjects_"+year+"_"+sem+c;
                rs=st.executeQuery(sf);
                while(rs.next()){
                    pst.setString(1, rs.getString("SCODE"));
                    pst.setString(2, rs.getString("SNAME"));
                    pst.setInt(3, rs.getInt("FID"));
                    pst.addBatch();
                }
                i++;
            }
            try{
                sql="delete from Z_intCalc_"+dept+"_"+year+"_"+sem;
                st.execute(sql);
            }
            catch(Exception r){
                sql="create table Z_intCalc_"+dept+"_"+year+"_"+sem+" (SCODE varchar(20),SNAME text,FID INT)";
                int cr=st.executeUpdate(sql);
            }
            pst.executeBatch();
            sql="select distinct * from Z_intCalc_"+dept+"_"+year+"_"+sem;
            rs=st.executeQuery(sql);
            boolean found=false;
            if(rs.next()){
                    found=true;%>
                        <head>
                            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                            <link href="CSS/settings.css" rel="stylesheet" />
                        </head>
                        <table align="center"width="600"  class="edit">
                        <tr>
                            <td height="300"  align="center">
                                <form action="OverallReportGen.jsp" method="post" target="_blank">
                                    <input type="hidden" name="year" value="<%=year%>" />
                                    <input type="hidden" name="sem" value="<%=sem%>" />
                                    <button type="submit" style="width: 200px" >PrintOut</button>
                                </form>
                            </td>
                            <td align="center">
                                <form action="OverallExcelGen.jsp" method="post">
                                    <input type="hidden" name="year" value="<%=year%>" />
                                    <input type="hidden" name="sem" value="<%=sem%>" />
                                    <button type="submit" style="width: 200px" >Excel</button>
                                </form>
                            </td>
                        </tr>
                        </table>
            <%}
            if(!found){%>
                <center><h2>No Subjects Found!</h2></center> 
            <%}
        }
        else{%>
            <center><h2>No data found with the given year!</h2></center>  
        <%}
        con.close();
    }
    catch(Exception e){
        out.println("<center>"+e+"</center>"); 
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
                <input type="hidden" name="uaccount" value="Administrator" />
                <button type="submit" class="redbutton">LogIn</button>
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
