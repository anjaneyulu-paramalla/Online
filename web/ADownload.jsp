<%-- 
    Document   : ADownload
    Created on : Feb 19, 2013, 2:20:32 PM
    Author     : Anji
--%>

<%@page import="DataConnection.Connector"%>
<%@page import="java.io.PrintWriter" errorPage="Error.jsp"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
    <%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){
       String dept=(String)session.getAttribute("DEPT");%>
       <%if(request.getParameter("downloadstatus")==null){%>
        <!DOCTYPE html>
        <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>::GRIET</title>
            <link rel="stylesheet" href="CSS/redun.css" />
            <script type="text/javascript" >
               /* function hidefaculty(){
                    document.getElementById("fbody").style.display=none;  
                }
                function hidestudent(){
                    document.getElementById("sbody").style.display=none;
                }
                function hide(){
                    document.getElementById("student").style.display=none;
                    document.getElementById("fbody").style.display=none;
                }
                window.document.getElementById("view").onload = hide();*/
            </script>
        </head>
        <body>
            <center><h2><u>Data download</u>:</h2></center>
            <form id="view" action="#" method="post" >
                <input type="hidden" name="downloadstatus" value="step" />
                <table align="center">
                    <tr><td colspan="2">
                        <h3 style="display: inline">
                            <input type="radio" id="student" name="designation" value="student" checked onchange="hidefaculty()"/>
                            <label for="student">
                                Student
                            </label>
                        </h3
                    </td></tr>
                    <tbody id="sbody">
                    <tr>
                        <td width="40px"></td>
                        <td>
                            <h4 style="display: inline"> &nbsp;&nbsp;&nbsp;&nbsp;Year: &nbsp;<select name="year"><option>I</option><option>II</option><option>III</option><option>IV</option></select></h4>   
                        </td>
                    </tr>
                    <tr>
                        <td width="40px"></td>
                        <td>
                            <h4 style="display: inline">Format: &nbsp;<select name="sformat"><option>CSV</option><option>XLS</option></select></h4>   
                        </td>
                    </tr>
                    </tbody>
                    <tr>
                        <td colspan="2">
                            <h3 style="display: inline"><input type="radio" id="faculty" name="designation" value="faculty" onchange="hidestudent()"/>
                            <label for="faculty">
                                Faculty
                            </label></h3>
                        </td>
                    </tr>
                    <tbody id="fbody" >
                    <tr>
                        <td width="40px"></td>
                        <td>
                            <h4 style="display: inline">Format: &nbsp;<select name="fformat"><option>CSV</option><option>XLS</option></select></h4>   
                        </td>
                    </tr>
                    </tbody>
                </table>
                <center><br />
                    <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                    <input class="redbutton" type="submit"  value="Continue" style="width: 120px;margin-left: 10px"/>
                </center>
            </form>
        </body>
        </html>
       <%}
       else if(request.getParameter("downloadstatus").equals("step")){%>
        <!DOCTYPE html>
        <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>::GRIET</title>
            <link rel="stylesheet" href="CSS/redun.css" />
        </head>
        <body>
           <%try{
               if(request.getParameter("designation").equals("student")){%>
                   <center><h2><u>Student data download</u>:</h2></center>
                   <%String Ryear=request.getParameter("year");
                    int year;
                    if(Ryear.equals("I"))
                        year=1;
                    else if(Ryear.equals("II"))
                        year=2;
                    else if(Ryear.equals("III"))
                        year=3;
                    else
                        year=4;
                    String format=request.getParameter("sformat");                            
                    Connection con=new Connector(dept).getConnection();
                    Statement st=con.createStatement();
                    String sql="select distinct(SECTION) from students where year="+year+" order by SECTION";
                    ResultSet rs=st.executeQuery(sql);
                    if(rs.next()){
                        String sec=rs.getString("SECTION"); %>
                        <center>
                        <h4><a href="ADownload.jsp?downloadstatus=step2&designation=student&year=<%=year%>&section=<%=sec%>&sformat=<%=format%>">student data of  <%=dept%> <%=Ryear%> <%=sec %> section</a></h4>
                       <%while(rs.next()){
                           sec=rs.getString("SECTION");%>
                           <h4><a href="ADownload.jsp?downloadstatus=step2&designation=student&year=<%=year%>&section=<%=sec%>&sformat=<%=format%>">student data of  <%=dept%> <%=Ryear%> <%=sec%> section</a></h4>                      
                       <%}%>
                        </center>
                    <%}
                    else{%>
                        <center>
                            <h4>No data found with <%=Ryear%> year!</h4>
                        </center>
                    <%}%>
                    <center><h3><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></h3></center>
               <%} 
               else{%>
                   <center><h2><u>Faculty data download</u>:</h2></center>
                   <%String format=request.getParameter("fformat");                            
                   Connection con=new Connector(dept).getConnection();
                   Statement st=con.createStatement();
                   String sql="select count(*) from faculty";
                   ResultSet rs=st.executeQuery(sql);
                   if(rs.next()){%>
                       <center>
                        <h4><a href="ADownload.jsp?downloadstatus=step2&designation=faculty&fformat=<%=format%>">Faculty data of  <%=dept%> Department </a></h4>
                       </center>
                   <%}
                   else{%>
                       <center>
                            <h4>No data found!</h4>
                       </center>
                   <%}%>
                   <center><h3><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></h3></center>
               <%}
           }
           catch(Exception e){%>
               <center><%=e%>
                   <h3><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></h3>
               </center>
           <%}%>
        </body>
        </html>
       <%}
       else{
         try{  
           /*Enumeration e=request.getParameterNames();
           while(e.hasMoreElements()){
               String g=(String)e.nextElement();
               out.print(g+": "+request.getParameter(g)); 
           }*/ 
           if(request.getParameter("designation").equals("student")){
               int year=Integer.parseInt(request.getParameter("year"));
               String section=request.getParameter("section");
               String format=request.getParameter("sformat").trim().toLowerCase();
               Connection con=new Connector(dept).getConnection();
               Statement st=con.createStatement();
               String sql="select UID,UNAME,EMAILID,MOBILE from students where year="+year+" AND SECTION='"+section+"' order by UID";
               ResultSet rs=st.executeQuery(sql);
               if(rs.next()){
                   response.setContentType("application/vnd.ms-excel"); 
                   response.setHeader("Content-Disposition","inline;filename="+dept+"_"+year+"_"+section+"."+format);
                   String sid=rs.getString("UID");
                   String sname=rs.getString("UNAME");
                   String semail=rs.getString("EMAILID");
                   String smobile=rs.getString("MOBILE");
                   if(format.equals("csv")){
                       PrintWriter pw=response.getWriter();
                       pw.println("SID,SNAME,EMAILID,MOBILENO");
                       pw.println(sid+","+sname+","+semail+","+smobile);
                       while(rs.next()){
                           sid=rs.getString("UID");
                           sname=rs.getString("UNAME");
                           semail=rs.getString("EMAILID");
                           smobile=rs.getString("MOBILE");
                           pw.println(sid+","+sname+","+semail+","+smobile);
                       }
                       pw.close();
                   }
                   else{%>
                        <table >
                            <tr>
                                <th style="background-color: #9999ff">SID</th>
                                <th style="background-color: #9999ff">SNAME</th>
                                <th style="background-color: #9999ff">EMAILID</th>
                                <th style="background-color: #9999ff">MOBILENO</th>
                            </tr>
                            <tr>
                                <td><%=sid%></td>
                                <td><%=sname%></td>
                                <td><%=semail%></td>
                                <td><%=smobile%></td>
                            </tr>
                            <%while(rs.next()){
                                sid=rs.getString("UID");
                                sname=rs.getString("UNAME");
                                semail=rs.getString("EMAILID");
                                smobile=rs.getString("MOBILE");%>
                                 <tr>
                                <td><%=sid%></td>
                                <td><%=sname%></td>
                                <td><%=semail%></td>
                                <td><%=smobile%></td>
                            </tr>
                            <%}%>
                        </table>
                   <%}
               }
           }
           else{
               String format=request.getParameter("fformat").trim().toLowerCase();
               Connection con=new Connector(dept).getConnection();
               Statement st=con.createStatement();
               String sql="select FNAME,EMAILID,MOBILE from faculty order by FNAME";
               ResultSet rs=st.executeQuery(sql);
               if(rs.next()){
                   response.setContentType("application/vnd.ms-excel"); 
                   response.setHeader("Content-Disposition","inline;filename="+dept+"_faculty."+format);
                   String fname=rs.getString("FNAME");
                   String femail=rs.getString("EMAILID");
                   String fmobile=rs.getString("MOBILE");
                   if(format.equals("csv")){
                        PrintWriter pw=response.getWriter();
                        pw.println("FNAME,EMAILID,MOBILENO");
                        pw.println(fname+","+femail+","+fmobile);
                       while(rs.next()){
                           fname=rs.getString("FNAME");
                           femail=rs.getString("EMAILID");
                           fmobile=rs.getString("MOBILE");
                           pw.println(fname+","+femail+","+fmobile);
                       }
                       pw.close(); 
                   }
                   else{%>
                       <table>
                            <tr>
                                <th style="background-color: #9999ff">FNAME</th>
                                <th style="background-color: #9999ff">EMAILID</th>
                                <th style="background-color: #9999ff">MOBILENO</th>
                            </tr>
                            <tr>
                                <td><%=fname%></td>
                                <td><%=femail%></td>
                                <td><%=fmobile%></td>
                            </tr>
                            <%while(rs.next()){
                                fname=rs.getString("FNAME");
                                femail=rs.getString("EMAILID");
                                fmobile=rs.getString("MOBILE");%> 
                                <tr>
                                <td><%=fname%></td>
                                <td><%=femail%></td>
                                <td><%=fmobile%></td>
                            </tr>
                            <%}%>
                        </table>
                   <%}                                             
               }
               else{%>
                    <!DOCTYPE html>
                    <html>
                    <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                    <title>::GRIET</title>
                    <link rel="stylesheet" href="CSS/redun.css" />
                    </head>
                    <body>
                    <center><h2><u><%=format.trim().substring(0, 1).toUpperCase()+format.trim().substring(1) %> data Download</u>:</h2>
                    <h3>No data found! section.<br />
                        <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></h3>
                    </center>
                    </body>
                    </html>  
               <%}
           }
        }
        catch(Exception e){%>
            <!DOCTYPE html>
            <html>
            <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>::GRIET</title>
            <link rel="stylesheet" href="CSS/redun.css" />
            </head>
            <body>
            <center><h2><u><%=request.getParameter("designation").trim().substring(0, 1).toUpperCase()+request.getParameter("designation").trim().substring(1) %> data Download</u>:</h2></center>
            <center><%=e%>
                <h3><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></h3>
            </center>
            </body>
            </html>
        <%}
       }%>
    <%} 
    else{%>
    <%--<jsp:forward page="./" />--%>
     <!DOCTYPE html>
     <html>
     <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
        <link rel="stylesheet" href="CSS/redun.css" />
    </head>
    <body>
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
    </html>
    <%}%> 
