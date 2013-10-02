<%-- 
    Document   : AStudentList
    Created on : Dec 25, 2012, 8:26:46 PM
    Author     : Anjaneyulu
--%>

<%@page import="DataConnection.Connector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
        <link rel="stylesheet" href="CSS/redun.css" />
        <style type="text/css">
            button.link{
                border:none;
                background-color:#4343eb;
                width:30px;
                border-radius: 30px;
                height:20px;
                font-family: "times new roman",sans-serif;
                font-size: 15px;
                color: whitesmoke;
                padding:0px;
                cursor:pointer;
            }
            button.link:hover{
                /*text-decoration:underline;*/
                background-color:#435fff;
                cursor:pointer;
            }
            a:hover{
                text-decoration: underline;
                cursor: pointer;
            }
            span:hover{
                /*text-decoration: underline;*/
                color: blue;
                cursor: pointer;
            }
        </style>
        <script type="text/javascript" src="JS/check.js"></script>
        <script type="text/javascript">
            function openDialoge(d){
                var s="div"+d,im="img"+d,qu="quo"+d;
                var f=document.getElementById(s).style.display;
                if(f=="none"){
                    document.getElementById(im).innerHTML="<img src='IMAGES/down.png ' height='14' width='14'></img>";
                    document.getElementById(qu).innerHTML=":";
                    document.getElementById(s).style.display="block";
                }
                else{
                    document.getElementById(im).innerHTML="<img src='IMAGES/left.png ' height='14' width='14'></img>";
                    document.getElementById(qu).innerHTML="?";
                    document.getElementById(s).style.display="none";
                }  
            }
        </script>
    </head>
    <body>
        <%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){
             String dept=(String)session.getAttribute("DEPT");
             try{
                 Connection con=new Connector(dept).getConnection();
                 Statement st=con.createStatement();
                 if(request.getParameter("status")==null){%>
                    <center><h3><u>Student data of <%=dept%> Department</u>:</h3>
                        <form action="#" method="post" style="display: inline">
                            <h3>Year :<select name="year">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            </select></h3>
                        <input type="hidden" name="status" value="step2"/>
                        <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                        <input class="redbutton" type="submit" name="submit" value="Next" style="margin-left: 10px"/>
                        </form>
                    </center> 
                 <%}
                 else{%>  
                     <center><h3><u>Student data of <%=dept%> Department</u>:</h3>
                     <%int year=Integer.parseInt(request.getParameter("year"));
                     String sp;
                     if(year==1)
                         sp="st year";
                     else if(year==2)
                         sp="nd year";
                     else if(year==3)
                         sp="rd year";
                     else
                         sp="th year";
                     String sql="select distinct(SECTION) as section from students where year="+year+" order by SECTION";
                     ResultSet rs=st.executeQuery(sql);
                     if(rs.next()){
                         int seclength=0;
                         String sec[]=new String[4];
                         sec[seclength++]=rs.getString("section");
                         while(rs.next()){
                             sec[seclength++]=rs.getString("section");
                         }
                         int i=0;
                         while(i<seclength){%>
                             <h3><center><span id="img<%=sec[i]%>"><img src="IMAGES/left.png " height="14" width="14" /></span><span style="color:blue"><span  id="<%=sec[i]%>" onclick="openDialoge('<%=sec[i]%>')"><u  >Student list of <%=dept%> <%=year+sp%> <%=sec[i]%> section</u></span><span id="quo<%=sec[i]%>">?</span></span></center></h3>
                             <div id="div<%=sec[i]%>" style="display: none">
                                 <center>
                                     <form action="AStudentEdit.jsp" method="post" onsubmit="return check(this,'<%=sec[i]%>')">
                                     <input type="hidden" name="year" value="<%=year%>" />
                                     <input type="hidden" name="section" value="<%=sec[i]%>" />
                                     <%sql="select UID,UNAME,EMAILID,MOBILE from students where year="+year+" AND SECTION='"+sec[i]+"' order by UID";
                                       rs=st.executeQuery(sql);%>
                                       <table align="center">
                                       <tr><td>
                                       <table  border="3" cellspacing="0" >
                                       <%boolean first=false;
                                       int sno=1;
                                       while(rs.next()){
                                           String stid=rs.getString("UID");
                                           if(!first){%>
                                               <tr style="background-color: #9999ff">
                                                   <th></th>
                                                   <th>Sno</th>
                                                   <th>SID</th>
                                                   <th>Name</th>
                                                   <th>EmailId</th>
                                                   <th>MobileNo</th>
                                               </tr>
                                               <%first=true;    
                                           }%>
                                           <tr>
                                               <td><input type="checkbox" id="check<%=sec[i]%><%=sno%>" name="check<%=sno%>" value="<%=stid%>" /></td>
                                               <td align="center"><%=sno++%></td>
                                               <td >&nbsp;<%=stid %>&nbsp;</td>
                                               <td width="200px">&nbsp;<%=rs.getString("UNAME") %>&nbsp;</td>
                                               <td width="200px">&nbsp;<%=rs.getString("EMAILID") %>&nbsp;</td>
                                               <td width="100px">&nbsp;<%=rs.getString("MOBILE") %>&nbsp;</td>
                                           </tr>
                                       <%}%>
                                       </table>
                                    </td></tr>
                                    <tr><td>
                                    <input type="hidden" id="count<%=sec[i]%>" name="count" value="<%=sno-1%>" />
                                    <span style="color: #0033cc;">
                                        &nbsp;&nbsp;<img src="IMAGES/arrow_ltr.png" />
                                        <input style="display: none" id="checkall<%=sec[i]%>" type="radio" name="check<%=sec[i]%>"  onclick="checkall(this,'<%=sec[i]%>')"/>
                                        <label for="checkall<%=sec[i]%>" >
                                            <a >check All</a>
                                        </label> / 
                                        <input style="display: none" id="uncheckall<%=sec[i]%>" type="radio" name="check<%=sec[i]%>" onclick="uncheckall(this,'<%=sec[i]%>')" />
                                        <label for="uncheckall<%=sec[i]%>">
                                            <a>Uncheck All</a>
                                        </label>
                                    </span>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <span style="color: #0033cc;">
                                        <b>with selected:
                                        <input   id="uedit<%=sec[i]%>" type="radio" name="edit<%=sec[i]%>" value="update" checked />
                                        <label for="uedit<%=sec[i]%>">
                                        update
                                        </label>
                                        <input id="dedit<%=sec[i]%>" type="radio" name="edit<%=sec[i]%>" value="delete" />
                                        <label for="dedit<%=sec[i]%>">
                                        delete
                                        </label>
                                        <input id="medit<%=sec[i]%>" type="radio" name="edit<%=sec[i]%>" value="move" />
                                        <label for="medit<%=sec[i]%>">
                                        move
                                        </label></b>
                                        &nbsp;&nbsp;<button type="submit"  class="link" ><b>Go</b></button>
                                    </span>
                                    </td></tr></table>
                                 </form>
                                 </center>
                             </div>
                             <%i++;
                         }%>
                     <form action="AStudentEditAll.jsp" method="post">
                         <input type="hidden" name="year" value="<%=year%>" />
                         <h3><center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                         <input type="submit" name="option" value="Delete All" class="redbutton" style="width: 120px;margin-left: 10px;margin-right: 10px"/>
                         <input type="submit" name="option" value="Move All" class="redbutton" style="width: 120px"/></center></h3>
                     </form>
                     <%}
                    else{%>
                        <h4><center>No data found with <%=dept%> <%=year+sp%>!</center></h4>
                        <h3><center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></center></h3>
                    <%}
                     rs.close();%>
                     <%--String sql="select sections from semester where year="+year; 
                     ResultSet rs=st.executeQuery(sql);
                     if(rs.next()){
                         int scount=rs.getInt("sections");
                         int count=0;
                         while(count<scount){
                              char c=(char)(65+count);%>
                              <h3><center><span id="img<%=c%>"><img src="IMAGES/left.png " height="14" width="14" /></span><span style="color:blue"><span  id="<%=c%>" onclick="openDialoge('<%=c%>')"><u  >Student List of <%=dept%> <%=year+sp%> <%=c%> Section</u></span><span id="quo<%=c%>">?</span></span></center></h3>
                              <div id="div<%=c%>" style="display: none"><center>
                             <%sql="select count(*) as strength from students where year="+year+" AND section='"+c+"'"; 
                             rs=st.executeQuery(sql);
                               int strength=0;
                               if(rs.next())
                                   strength=rs.getInt("strength");
                               if(strength<=15){
                                    sql="select * from students where year="+year+" AND section='"+c+"'";
                                    rs=st.executeQuery(sql);
                                    if(rs.next()){
                                        int sno=1;%>
                                        <table border="5" cellspacing="0" align="center" >
                                            <tr height="40" bgcolor= "#9999ff" align="center">
                                                <th>S.NO</th>
                                                <th>ID</th>
                                                <th>Name</th>
                                            </tr>
                                            <tr>
                                                <td align="center"><%=sno++%></td>
                                                <td><%=rs.getString("UID")%></td>
                                                <td><%=rs.getString("UNAME")%></td>
                                            </tr>
                                        <%while(rs.next()){%>
                                            <tr>
                                                <td align="center"><%=sno++%></td>
                                                <td><%=rs.getString("UID")%></td>
                                                <td><%=rs.getString("UNAME")%></td>
                                            </tr>
                                        <%}%>
                                        </table>
                                    <%}
                                    else{%>
                                        <h3><center>No data found!</center></h3>
                                    <%}
                               }
                               else{
                                   int stcount=0;
                                   String[] uid=new String[strength],uname=new String[strength];
                                   sql="select * from students where year="+year+" AND section='"+c+"'";
                                   rs=st.executeQuery(sql);
                                   while(rs.next()){
                                       uid[stcount]=rs.getString("UID");
                                       uname[stcount]=rs.getString("UNAME");
                                       stcount++;
                                   }%>
                                   <table cellspacing="0" border="5" align="center">
                                            <tr height="40" bgcolor= "#9999ff" align="center">
                                                <th>S.NO</th>
                                                <th>ID</th>
                                                <th>Name</th>
                                                <th width="1" style="border:0;background-color:#9999ff " ></th>
                                                <th>S.NO</th>
                                                <th>ID</th>
                                                <th>Name</th>
                                            </tr>
                                            <%int len=0;
                                            int sep=(int)Math.ceil((float)strength/2);
                                            while(len<sep){%>
                                                <tr>
                                                    <td align="center"><%=len+1%></td>
                                                    <td><%=uid[len]%></td>
                                                    <td><%=uname[len]%></td>
                                                    <td width="1" style="border-width:0;background-color:#9999ff" ></td>
                                                    <%if(len<strength/2){%>
                                                    <td align="center" ><%=len+1+sep%></td>
                                                    <td><%=uid[len+sep]%></td>
                                                    <td><%=uname[len+sep]%></td>
                                                    <%}%>
                                                </tr>  
                                            <%len++;
                                            }%>
                                   </table>
                               <%}%>
                               </center></div>
                             <%count++;
                         }%>
                     <%}
                     else{%>
                         <h3><center>No data Found with <%=dept%> <%=year+sp%>!</center></h3>
                     <%}
                     rs.close();%>
                     <h3><center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></center></h3>--%>
                 <%}
                 st.close();
                 con.close();
             }
             catch(Exception e){
                 out.println("<center>"+e+"</center>");%>
                 <center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></center>
             <%}
        }else{%>
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
