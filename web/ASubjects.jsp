<%-- 
    Document   : ASubjects
    Created on : Jul 24, 2012, 1:23:42 AM
    Author     : Anjaneyulu
--%>

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
<%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){
    String dept=(String)session.getAttribute("DEPT");
    String status=request.getParameter("status");
    if(status==null){%>
    <h3><center><u>Subject details of <%=dept%> Department</u>:</center></h3>
    <center><h3>
        <form  method="post">
            Year:<select name="year"><option>1</option><option>2</option><option>3</option><option>4</option></select>
            Semester:<select name="sem"><option>1</option><option>2</option></select><br/><br />
            <input type="hidden" name="status" value="step2" />
            <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
            <input type="submit" value="Next" class="redbutton" style="margin-left: 10px" />
        </form></h3>
    </center>     
    <%}
    else{
        boolean b=false;
        try{
                Class.forName("com.mysql.jdbc.Driver");
                String uri="jdbc:mysql://localhost:3306/feedback_"+dept; 
                Connection con=DriverManager.getConnection(uri,"root","GRIETITOLFF1202");
                Statement st=con.createStatement();
                String year=""+request.getParameter("year");
                String sem=""+request.getParameter("sem");
                String sq="select Sections from semester where YEAR="+year;
                ResultSet rs=st.executeQuery(sq); 
                if(rs.next()){
                    int count=rs.getInt("Sections");
                    int loop=0;
                    while(loop<count){
                        char c=(char)(65+loop);
                        String sql="select SID,SNAME,SCODE,Subjects_"+year+"_"+sem+c+".FID,FNAME from faculty,Subjects_"+year+"_"+sem+c+" where subjects_"+year+"_"+sem+c+".FID=faculty.FID order by SID";
                        rs=st.executeQuery(sql);%>
                        <h3><center><u>Subjects for <%=dept%> <%=year%>-<%=sem%> <%=c%> section</u>:</center></h3>
                        <%if(!b){
                            b=true;
                        }
                        if(rs.next()){%>
                            <table width="70%" cellspacing="0" border="5" align="center">
                                <tr height="40"  bgcolor= "#9999ff" align="left">
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
                            out.println("<center><b>No subjects found!</b></center>");
                        }
                        loop++; 
                    }
                }
                else{
                    if(!b)
                        b=true;%>
                    <h3><center><u>Subject details of <%=dept%> Department</u>:</center></h3>                    
                    <%String Ryear="";
                    if(year.equals("1")) 
                        Ryear="I";
                    else if(year.equals("2"))
                        Ryear="II";
                    else if(year.equals("3"))
                        Ryear="III";
                    else
                        Ryear="IV";
                    out.println("<center><b>No data found with "+Ryear+" year</b></center>");
                }
        }
        catch(Exception e){
            if(!b){%>
                <h3><center><u>Subject Details of <%=dept%> Department</u>:</center></h3>
                <center><b>No data found with this year</b></center>
            <%}%>
            <%//out.print("<center><b>"+e+"</b></center>");
        }%>
        <h3><center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></center></h3>
    <%}
}
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
