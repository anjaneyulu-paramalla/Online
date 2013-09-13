<%-- 
    Document   : AUpload
    Created on : Jan 26, 2013, 1:25:46 AM
    Author     : Anji
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
            if(request.getParameter("status")==null){%>
                <center><h2><u>Data upload</u>:</h2>
                <h3 style="inline"><form method="post" action="#">
                <table align="center">
                <tr>
                    <th align="right">
                        Data Type:
                    </th>
                    <td>
                        <select name="dtype">
                            <option>Student</option>
                            <option>Faculty</option>
                        </select>
                    </td>
                </tr>
                <tr /><tr /><tr /><tr /><tr />
                <tr>
                    <th align="right">
                        Upload Type:
                    </th>
                    <td>
                        <select name="utype">
                            <option>Import</option>
                            <option>Insert</option>
                        </select>
                    </td>
                </tr>
                <tr /><tr /><tr /><tr /><tr /><tr />
                </table>
                <input type="hidden" name="status" value="step2" />
                <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                <input type="submit" value="Next" class="redbutton" style="margin-left: 10px"/>
                </form></h3>
                </center>    
            <%}
            else if(request.getParameter("status").equals("step2")){
                String dtype=request.getParameter("dtype");
                String utype=request.getParameter("utype");
                String dept=(String)session.getAttribute("DEPT");
                //out.print(dtype+"  "+utype);
                %>
                <%if(dtype.equals("Student")){
                    if(request.getParameter("studentstatus")==null){%>
                        <center><h2><u><%=dtype%> data <%=utype.toLowerCase()%></u>:</h2>
                        <form action="#" method="post" >
                            <input type="hidden" name="dtype" value="<%=dtype%>" />
                            <input type="hidden" name="utype" value="<%=utype%>" />
                            <input type="hidden" name="status" value="step2"/>
                            <input type="hidden" name="studentstatus" value="step" />
                            <h3>Year :<select name="year">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            </select></h3>
                            <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                            <input class="redbutton" type="submit" name="submit" value="Next" style="margin-left: 10px"/>
                        </form></center>
                    <%}
                    else{
                        int year=Integer.parseInt(request.getParameter("year"));
                        String RYear=new String();
                        if(year==1)
                            RYear="I";
                        else if(year==2)
                            RYear="II";
                        else if(year==3)
                            RYear="III";
                        else
                            RYear="IV";
                        int sections=4;
                        if(utype.equals("Import")){%>
                                <center><h2 ><u><%=dtype%> data <%=utype.toLowerCase()%></u>:</h2>
                                    <form action="AUploadData1.jsp" method="post">
                                    <input type="hidden" name="dtype" value="<%=dtype%>" />
                                    <input type="hidden" name="utype" value="<%=utype%>" />
                                    <input type="hidden" name="status" value="step3" />
                                    <input type="hidden" name="year" value="<%=year%>" />
                                    <input type="hidden" name="sections" value="<%=sections%>"/>
                                    <table align="center">
                                        <tr>
                                            <th>
                                                Import data for <%=dept%> <%=RYear%> Year:
                                            </th>
                                        </tr>
                                        <%int i=0;
                                          while(i<sections){
                                              char c=(char)(65+i);%>
                                              <tr><th>
                                              <input type="checkbox" name="sec<%=c%>" id="<%=c%>" value="<%=c%>"/>
                                              <label for="<%=c%>"><%=c%> section</label>
                                              </th></tr>
                                          <%i++;
                                          }%>
                                        <tr /><tr /><tr /><tr /><tr />
                                    </table>
                                    <input type="button" value="Back" class="redbutton" onclick="history.go(-2);" />
                                    <input class="redbutton" type="submit" name="submit" value="Next" style="margin-left: 10px"/>
                                </form></center>
                        <%}
                        else{%>
                                <center><h2><u><%=dtype%> data <%=utype.toLowerCase()%></u>:</h2>
                                <form action="AUploadData.jsp" method="post">
                                    <input type="hidden" name="dtype" value="<%=dtype%>" />
                                    <input type="hidden" name="utype" value="<%=utype%>" />
                                    <input type="hidden" name="status" value="step3" />
                                    <input type="hidden" name="year" value="<%=year%>" />
                                    <input type="hidden" name="sections" value="<%=sections%>"/>
                                    <table align="center">
                                        <tr>
                                            <th>
                                                Insert data for <%=dept%> <%=RYear%> Year:
                                            </th>
                                        </tr>
                                        <%int i=0;
                                          while(i<sections){
                                              char c=(char)(65+i);%>
                                              <tr><th>
                                              <%if(i==0){%>
                                                <input type="radio" name="section" id="<%=c%>" value="<%=c%>" checked>
                                              <%}else{%>
                                                <input type="radio" name="section" id="<%=c%>" value="<%=c%>">
                                              <%}%>
                                              <label for="<%=c%>"><%=c%> section</label>
                                              </th></tr>
                                          <%i++;
                                          }%>
                                        <tr /><tr /><tr /><tr /><tr />
                                    </table>
                                    <input type="button" value="Back" class="redbutton" onclick="history.go(-2);" />
                                    <input class="redbutton" type="submit" name="submit" value="Next" style="margin-left: 10px"/>
                                </form></center>
                        <%}
                    }
                }
                else{%>
                    <jsp:forward page="AUploadData.jsp" >
                        <jsp:param name="dtype" value="<%=dtype%>" />
                        <jsp:param name="utype" value="<%=utype%>" />
                        <jsp:param name="status" value="step3" />
                    </jsp:forward>
                <%}%> 
            <%}
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
