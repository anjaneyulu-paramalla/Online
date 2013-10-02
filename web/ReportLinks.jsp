<%-- 
    Document   : ReportLinks
    Created on : Jul 10, 2012, 1:52:59 AM
    Author     : Anjaneyulu
--%>
<%@page import="DataConnection.Connector"%>
<%@page import="java.sql.PreparedStatement" errorPage="Error.jsp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
 <html>
<%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){%>
    <head>
        <style type="text/css">
            button.link{
                border:none;
                background:none;
                text-decoration: underline;
                font-family: "times new roman",sans-serif;
                font-size: 20px;
                color:blue;
                padding:0px;
                cursor:pointer;
            }
            button.link:visited{
                text-decoration:underline;
                cursor:pointer;
                color:#6633ff;
            }
            button.link:hover{
                text-decoration:underline;
                cursor:pointer;
            }
        </style>
    </head>
    <%String year=request.getParameter("year");
    String sem=request.getParameter("sem");
    String dept=(String)session.getAttribute("DEPT");
    try{
        Connection con=new Connector(dept).getConnection();
        Statement st=con.createStatement();
        Statement ff=con.createStatement();
        String sql="select SECTIONS from semester where YEAR="+year;
        String ins="insert into Z_intCalc_"+dept+"_"+year+"_"+sem+" values(?,?,?)";
        PreparedStatement pst=con.prepareStatement(ins);
        ResultSet rs=st.executeQuery(sql);
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
                sql="create table Z_intCalc_"+dept+"_"+year+"_"+sem+" (SCODE VARCHAR(20),SNAME text,FID INT)";
                int cr=st.executeUpdate(sql);
            }
            pst.executeBatch();
            sql="select distinct * from Z_intCalc_"+dept+"_"+year+"_"+sem; 
            rs=st.executeQuery(sql);
            if(rs.next()){%>        
            <table align="center" border="1" cellspacing="0">
                <tr style="background-color: #9999ff">
                    <td ><center style="font-size:8 mm;font-color:blue;">PrintOut</center></td>
                    <td ><center style="font-size:8 mm;font-color:blue;">ExcelSheet</center></td>
                </tr>
                <tr><td><h3><dl>
            <%rs=st.executeQuery(sql);
            while(rs.next()){
                   String scode=rs.getString("SCODE");
                   int fid=rs.getInt("FID");;
                   ResultSet fac=ff.executeQuery(""+"Select * from Faculty where FID="+fid);
                   fac.next();%>
                   <dt>
                   <form action="ReportGen.jsp" method="post" target="_blank" style="display:inline">
                       <input type="hidden" name="year" value="<%=year%>" /> 
                       <input type="hidden" name="sem" value="<%=sem%>" />
                       <input type="hidden" name="scode" value="<%=scode%>" />
                       <input type="hidden" name="fid" value="<%=fid%>" />
                       <button type="submit" class="link"><h3 align="left">&nbsp;<% out.print(rs.getString("SNAME"));%></h3></button>
                   <%--<a href="ReportGen.jsp?year=<%=year%>&sem=<%=sem%>&scode=<%=scode%>&fid=<%=fid%>" target="_blank"  ><% out.print(rs.getString("SNAME"));%></a>--%>
                   </form>
                   </dt>
                   <dd>
                       by <%out.print(fac.getString("FNAME"));%>
                   </dd>
            <%}%>
            </dl></h3></td>
            <td><h3><dl>
            <%sql="select distinct * from Z_intCalc_"+dept+"_"+year+"_"+sem;
            rs=st.executeQuery(sql);
            while(rs.next()){
                   String scode=rs.getString("SCODE");
                   int fid=rs.getInt("FID");;
                   ResultSet fac=ff.executeQuery(""+"Select * from Faculty where FID="+fid);
                   fac.next();%>
                   <dt>
                   <form action="ExcelGen.jsp"  method="post" style="display:inline">
                       <input type="hidden" name="year" value="<%=year%>" /> 
                       <input type="hidden" name="sem" value="<%=sem%>" />
                       <input type="hidden" name="scode" value="<%=scode%>" />
                       <input type="hidden" name="fid" value="<%=fid%>" />
                       <button type="submit" class="link"><h3 align="left">&nbsp;<% out.print(rs.getString("SNAME"));%></h3></button>
                   <%--<a href="ReportGen.jsp?year=<%=year%>&sem=<%=sem%>&scode=<%=scode%>&fid=<%=fid%>" target="_blank"  ><% out.print(rs.getString("SNAME"));%></a>--%>
                   </form>
                   </dt>
                   <dd>
                       by <%out.print(fac.getString("FNAME"));%>
                   </dd>
            <%}%>
            </dl></h3></td>
                </tr></table>
            <%}
            else{
                out.println("<center><h2>No Subjects Found!</h2></center>");
            }%>
            </body>
            </html>
        <%}
        else{
            out.println("<center><h2>No data found with the given year and Semester!</h2></center>");
        }
        con.close();
    }
    catch(Exception e){
        out.print("<center>"+e+"</center>");
    }%>
    <center><button  class="link" onclick="history.go(-1);">Back</button></center>
    <noscript>
            <center><h4 style="color:red;"> JavaScript is not enabled on your Browser<br />Please enable JavaScript to make the page Interactive</h4></center>
    </noscript>
<%}
else{%>
 <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>::GRIET</title>
    <link rel="stylesheet" href="CSS/redun.css" />
 </head>
 <body>
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
 </body>
<%}%>
 <html>