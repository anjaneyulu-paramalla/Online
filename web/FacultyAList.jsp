<%-- 
    Document   : FacultyAList
    Created on : Apr 7, 2013, 2:25:48 PM
    Author     : Anji
--%>


<%@page import="DataConnection.FacConnector"%>
<%@page import="com.sun.crypto.provider.RSACipher"%>
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
        <script type="text/javascript" src="JS/Faccheck.js"></script>
    </head>
    <body>
        <%if(session.getAttribute("FACAID")!=null){
             try{
                 Connection con=new FacConnector().getConnection();
                 Statement st=con.createStatement();
                 if(request.getParameter("status")==null){%>
                    <center><h3><u>Faculty data </u>:</h3>
                        <form action="#" method="post" style="display: inline">
                            <h3>Department :<select name="dept">
                            <option>IT</option>
                            <option>BT</option>
                            <option>BME</option>
                            <option>CSE</option>
                            <option>CIVIL</option>
                            <option>ECE</option>
                            <option>EEE</option>
                            <option>MECH</option>
                            <option>BS</option>
                            <option>MBA</option>
                            <option>MCA</option>
                            </select></h3>
                        <input type="hidden" name="status" value="step2"/>
                        <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                        <input class="redbutton" type="submit" name="submit" value="Next" style="margin-left: 10px"/>
                        </form>
                    </center> 
                 <%}
                 else{
                     String dept=request.getParameter("dept");%>  
                     <center><h3><u>Faculty data of <%=dept%> Department</u>:</h3>
                     <%String sp;
                     String sql="select * from faculty where DEPT='"+dept+"' order by FID";
                     ResultSet rs=st.executeQuery(sql);
                     if(rs.next()){%>
                        <center> 
                        <form action="FacAFacultyEdit.jsp" method="post" onsubmit="return check(this,'<%=dept%>')">
                            <%sql="select FID,FNAME,EMAILID,MOBILE from faculty where DEPT='"+dept+"' order by FID ";
                            rs=st.executeQuery(sql);%>
                            <table align="center">
                            <tr><td>
                            <table  border="3" cellspacing="0" >
                            <%boolean first=false;
                            int sno=1;
                            while(rs.next()){
                                String fid=rs.getString("FID");
                                if(!first){%>
                                    <tr style="background-color: #9999ff">
                                        <th></th>
                                        <th>Sno</th>
                                        <th>FID</th>
                                        <th>Name</th>
                                        <th>EmailId</th>
                                        <th>MobileNo</th>
                                    </tr>
                                    <%first=true;    
                                }%>
                                <tr>
                                    <td><input type="checkbox" id="check<%=dept%><%=sno%>" name="check<%=dept%><%=sno%>" value="<%=fid%>" /></td>
                                    <td align="center"><%=sno++%></td>
                                    <td >&nbsp;<%=fid %>&nbsp;</td>
                                    <td width="200px">&nbsp;<%=rs.getString("FNAME") %>&nbsp;</td>
                                    <td width="200px">&nbsp;<%=rs.getString("EMAILID") %>&nbsp;</td>
                                    <td width="100px">&nbsp;<%=rs.getString("MOBILE") %>&nbsp;</td>
                                </tr>
                            <%}%>
                            </table>
                            </td></tr>
                            <tr><td>
                            <input type="hidden" id="count<%=dept%>" name="count" value="<%=sno-1%>" />
                            <span style="color: #0033cc;">
                                &nbsp;&nbsp;<img src="IMAGES/arrow_ltr.png" />
                                <input style="display: none" id="checkall<%=dept%>" type="radio" name="check<%=dept%>"  onclick="checkall(this,'<%=dept%>')"/>
                                <label for="checkall<%=dept%>" >
                                    <a >check All</a>
                                </label> / 
                                <input style="display: none" id="uncheckall<%=dept%>" type="radio" name="check<%=dept%>" onclick="uncheckall(this,'<%=dept%>')" />
                                <label for="uncheckall<%=dept%>">
                                    <a>Uncheck All</a>
                                </label>
                            </span>&nbsp;&nbsp;&nbsp;&nbsp;
                            <span style="color: #0033cc;">
                                <b>with selected:
                                <input   id="uedit<%=dept%>" type="radio" name="edit<%=dept%>" value="update" checked />
                                <label for="uedit<%=dept%>">
                                update
                                </label>
                                <input id="dedit<%=dept%>" type="radio" name="edit<%=dept%>" value="delete" />
                                <label for="dedit<%=dept%>">
                                delete
                                </label>
                                </b>
                                &nbsp;&nbsp;<button type="submit"  class="link" ><b>Go</b></button>
                            </span>
                            </td></tr></table>
                        </form>
                        </center> 
                        <form action="FacAFacultyEditAll.jsp" method="post">
                            <input type="hidden" name="year" value="" />
                            <h3><center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                            <input type="submit" name="option" value="Delete All" class="redbutton" style="width: 120px;margin-left: 10px;margin-right: 10px"/>
                            </center></h3>
                        </form>
                     <%}
                    else{%>
                        <h4><center>No data found with <%=dept%> Department!</center></h4>
                        <h3><center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></center></h3>
                    <%}
                     rs.close();
                 }
                 st.close();
                 con.close();
             }
             catch(Exception e){
                 out.println("<center>"+e+"</center>");%>
                 <center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></center>
             <%}
        }else{%>
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
