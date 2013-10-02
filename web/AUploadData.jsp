<%-- 
    Document   : AUploadData
    Created on : Jan 31, 2013, 11:17:01 PM
    Author     : Anji
--%>

<%@page import="java.util.Enumeration" errorPage="Error.jsp"%>
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
    try{
        if(request.getParameter("status")!=null){
            if(request.getParameter("status").equals("step3")){
                String dtype=request.getParameter("dtype");
                String utype=request.getParameter("utype");
                String dept=(String)session.getAttribute("DEPT");
                if(dtype.equals("Student")){%>
                    <%int year=Integer.parseInt(request.getParameter("year"));
                    int sections=Integer.parseInt(request.getParameter("sections"));
                    session.setAttribute("ADMINYEAR", ""+year);
                    String RYear=new String();
                    if(year==1)
                        RYear="I";
                    else if(year==2)
                        RYear="II";
                    else if(year==3)
                        RYear="III";
                    else
                        RYear="IV";
                    if(utype.equals("Import")){%>
                        <center><h2 style="display: inline"><u><%=dtype%> data <%=utype.toLowerCase()%></u>:</h2></center>
                        <%int i=0,seclength=0;
                        String se[]=new String[4];
                        boolean flag=false;
                        while(i<sections){
                            char ch=(char)(65+i);
                            if(request.getParameter("sec"+ch)!=null){
                                se[seclength]=request.getParameter("sec"+ch);
                                seclength++;
                            }
                            i++; 
                        }
                        //out.print(seclength);
                        %>
                        <form method="post" action="AUploadImport.jsp" enctype="multipart/form-data">
                        <center>
                        <%
                        if(seclength>=2){%>
                            <table cellspacing="15" align="center">
                        <%}
                        i=0;
                        int rowcount=0,colcount=0;
                        while(i<sections){
                            char c=(char)(65+i); 
                            String check=request.getParameter("sec"+c);
                            //out.print("["+check+"]"); 
                            if(check!=null){
                                colcount++;
                                boolean tdflag=false;
                                flag=true;%>
                                <input type="hidden" name="sec<%=c%>" value=<%=c%> />
                                <%if(seclength>=2){
                                    if(rowcount==0){%>
                                        <tr>
                                        <%if(seclength-(colcount-1)==1){%>
                                            <td colspan="2" align="center">
                                            <%tdflag=true;
                                        }    
                                    }
                                    if(!tdflag){%>
                                        <td align="center">
                                    <%}
                                }
                                if(seclength<2){%>
                                <br />
                                <%}%>
                                <table border="3" style="border-radius:10px;background-color: #ccffcc" >
                                    <tr>
                                        <th colspan="2" style="border-width: 0"><u>Import for <%=dept%> <%=RYear%> <%=c%> section</u>:</th>
                                    </tr>
                                    <tr>
                                        <th align="right" style="border-width: 0">Format:</th>
                                        <th align="left" style="border-width: 0"><select name="sec<%=c%>format"><option>CSV</option><!--option>Other Excel Format</option--></select></th>
                                    </tr>
                                    <tr>
                                        <th align="right"  style="border-width: 0">File:</th>
                                        <th align="left" style="border-width: 0"><input type="file" name="sec<%=c%>file"/></th>
                                    </tr>
                                    <tr>
                                        <th valign="top" align="right" style="border-width: 0">No. of rows to skip:</th>
                                        <th valign="top" align="left" style="border-width: 0"><input type="number" name="sec<%=c%>skip" min="0" max="10" value="1"/></th>
                                    </tr>
                                    <tr>
                                        <!--th style="border-width: 0"-->
                                        <th colspan="2" align="center" valign="top" style="border-width: 0">
                                            <%--<input id="clear" type="checkbox" name="sec<%=c%>clear" value="clear" checked/>
                                            <label for="clear">
                                                clear previous Data
                                            </label><br />--%> 
                                            <%--input id="pass" type="checkbox" name="sec<%=c%>pass" value="use" checked/--%>
                                            <input id="pas1<%=c%>" type="radio" name="sec<%=c%>pass" value="student"/>
                                            <label for="pas1<%=c%>">
                                                use student ID as Password
                                            </label><br />
                                            <!--input id="pass" type="checkbox" name="sec<%=c%>pass" value="use" checked/-->
                                            &nbsp;&nbsp;<input id="pas2<%=c%>" type="radio" name="sec<%=c%>pass" value="random" checked/>
                                            <label for="pas2<%=c%>">
                                                randomly generate password 
                                            </label>
                                        </th>
                                    </tr>
                                </table>
                            <%if(seclength<2){%>
                                <br />
                            <%}
                            if(seclength>=2){%>
                                </td>
                                <%rowcount++;
                                if(rowcount==2){
                                    rowcount=0;%>
                                    </tr>
                                <%}
                            }
                            }
                            i++;
                        }
                        if(seclength>=2){%>
                            </table>
                        <%}
                        if(flag){%>
                            <input type="hidden" name="dtype" value=<%=dtype%> />
                            <input type="hidden" name="utype" value=<%=utype%> />
                            <input type="hidden" name="year" value=<%=year%> />
                            <input type="hidden" name="sections" value=<%=sections%> />
                            <a href="ASSETS/Student_template.csv">click here to download the template of the file to be uploaded!</a><br />
                            <table align="center" cellspacing="0">
                                <tr height="10 px"/>
                                <tr><td>
                                        <b style="color:red">Note:</b>
                                    </td>
                                    <td>
                                        <b>1.SID ,SNAME ,EMAILID fields in the file are mandatory.</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <b>2.if they are not given then the corresponding student details will not be imported.</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <b>3.Email id's must be unique ,if they are not you will get an error!</b>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <%
                            int sel=0;
                            while(sel<seclength){%>
                                <input type="hidden" name="sec<%=se[sel]%>" value="<%=se[sel]%>" /> 
                                <%sel++;
                            }
                            %>
                            <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                            <input class="redbutton" type="submit"  value="Import" style="margin-left: 10px"/>
                        <%}
                        else{%>
                            <h2>No sections selected!</h2>
                            <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                        <%}%>
                        </center>
                        </form>
                    <%}
                    else{
                      String section=request.getParameter("section");%>
                      <center><h2><u><%=dtype%> data <%=utype.toLowerCase()%></u>:</h2></center>
                      <form method="post" action="AUploadInsert.jsp">
                        <input type="hidden" name="dtype" value="<%=dtype%>" />
                        <input type="hidden" name="utype" value="<%=utype%>" />
                        <center>
                            <table border="3" width="350px" style="border-radius:10px;background-color: #ccffcc" cellspacing="0"  >
                                <tr>
                                   <th colspan="2" style="border-width: 0"><u>Insert data for <%=dept%> <%=RYear%>  <%=section%> section</u>:</th>
                                </tr>
                                <tr>
                                    <td align="center"style="border-width: 0">
                                        <table>
                                            <tr height="10"/>
                                            <tr>
                                                <th style="border-width: 0">No of  students to be added:<input type="number" name="sturows" min="1" max="60" value="1" /></th>
                                            </tr>
                                            <tr>
                                                <td><b>
                                                &nbsp;&nbsp;<input id="pas1" type="radio" name="sec<%=section%>pass" value="student"/>
                                                <label for="pas1">
                                                    use student ID as Password
                                                </label><br />
                                                <%--input id="pass" type="checkbox" name="sec<%=section%>pass" value="use" checked/--%>
                                                &nbsp;&nbsp;<input id="pas2" type="radio" name="sec<%=section%>pass" value="random" checked/>
                                                <label for="pas2">
                                                    randomly generate passwords 
                                                </label></b>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                                <table align="center" cellspacing="0">
                                <tr height="10 px"/>
                                <tr><td>
                                        <b style="color:red">Note:</b>
                                    </td>
                                    <td>
                                        <b>1.SID ,SNAME ,EMAILID fields are mandatory.</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <b>2.if they are not given then the corresponding student details will not be imported.</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <b>3.Email id's must be unique ,if they are not you will get an error!</b>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <input type="hidden" name="year" value=<%=year%> />
                            <input type="hidden" name="section" value="<%=section%>" /> 
                            <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                            <input type="submit" value="Insert"  class="redbutton" style="width: 100px;margin-left: 10px" />   
                        </center>
                        </form>
                    <%} 
                }
                else{
                    if(utype.equals("Import")){%>
                        <center><h2><u><%=dtype%> data <%=utype.toLowerCase()%></u>:</h2></center>
                        <form method="post" action="AUploadImport.jsp" enctype="multipart/form-data">
                        <center>
                        <table border="3" style="border-radius:10px;background-color: #ccffcc" >
                            <tr>
                                <th colspan="2" style="border-width: 0"><u>Import faculty teaching for <%=dept%> Students</u>:</th>
                            </tr>
                            <tr>
                                <th align="right"align="left" style="border-width: 0">Format:</th>
                                <th align="left" style="border-width: 0"><select name="facformat">format"><option>CSV</option><!--option>Other Excel Format</option--></select></th>
                            </tr>
                            <tr>
                                <th align="right"align="left" style="border-width: 0">File:</th>
                                <th align="left" style="border-width: 0"><input type="file" name="facfile"/></th>
                            </tr>
                            <tr>
                                <th valign="top" align="right" style="border-width: 0">No. of rows to skip:</th>
                                <th valign="top" align="left" style="border-width: 0"><input type="number" name="facskip" min="0" max="10" value="1"/></th>
                            </tr>
                            <tr>
                                <th style="border-width: 0">
                                <th align="left" valign="top" style="border-width: 0">
                                <input id="clear" type="checkbox" name="facclear" value="clear" checked/>
                                <label for="clear">
                                    clear previous faculty data
                                </label>
                                </th>
                            </tr>
                        </table><br />
                        <input type="hidden" name="dtype" value=<%=dtype%> />
                        <input type="hidden" name="utype" value=<%=utype%> />
                        <a href="ASSETS/Faculty_template.csv">click here to download the template of the file to be uploaded!</a><br />
                        <table align="center" cellspacing="0">
                                <tr height="10 px"/>
                                <tr><td>
                                        <b style="color:red">Note:</b>
                                    </td>
                                    <td>
                                        <b>1.FNAME field in the file is mandatory.</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <b>2.if Email Id and mobile number are not known leave them blank.</b>
                                    </td>
                                </tr>
                            </table>
                        <br />
                        <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                        <input class="redbutton" type="submit" name="submit" value="Import" style="margin-left: 10px"/>
                        </center>
                        </form>
                    <%}
                    else{%>
                      <center><h2><u><%=dtype%> data <%=utype.toLowerCase()%></u>:</h2></center>
                      <form method="post" action="AUploadInsert.jsp">
                        <input type="hidden" name="dtype" value="<%=dtype%>" />
                        <input type="hidden" name="utype" value="<%=utype%>" />
                        <center>
                            <table border="3" width="350px" style="border-radius:10px;background-color: #ccffcc" cellspacing="0"  >
                                <tr>
                                   <th colspan="2" style="border-width: 0"><u>Insert faculty teaching for <%=dept%> Students</u>:</th>
                                </tr>
                                <tr>
                                    <td align="center"style="border-width: 0">
                                        <table >
                                            <tr height="10"/>
                                            <tr>
                                                <th style="border-width: 0">No of faculty to be added:<input type="number" name="facrows" min="1" max="60" value="1" /></th>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <br /> 
                            <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                            <input type="submit" value="Insert"  class="redbutton" style="width: 100px;margin-left: 10px" />   
                        </center>
                        </form>
                    <%}
                }
            }
        }
   }
   catch(Exception e){
        out.println("<center>"+e+"</center>");
    }
}
else{%>
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
                    <input type="hidden" name="uaccount" value="Administrator" /><br />
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
