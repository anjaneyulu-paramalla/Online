<%-- 
    Document   : Edit
    Created on : Mar 12, 2013, 4:16:32 AM
    Author     : Anjaneyulu
--%>

<%@page import="org.data.connection.Connector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
        <link rel="stylesheet" href="CSS/redun.css" />
        <script type="text/javascript">
            function frmSubmit(){
                document.getElementById("frm").submit();
            }
            function checkPass(){
                var err="";
                err+=checkCurrent(document.getElementById("currentPass"));
                if(err==""){
                    err+=checkMatch(document.getElementById("newPass"),document.getElementById("confirm_newPass"));
                    if(err==""){
                        document.getElementById("frm").submit();
                        //return true;
                    }
                    else{
                        alert(err);
                        return false;
                    }
                }
                else{
                    alert(err);
                    return false;
                }
            }
            function checkCurrent(l){
                if(l.value=="")
                    return "Enter Current Password\n";
                else
                    return "";
            }
            function checkMatch(x,y){
                if(x.value=="")
                    return "New Password Field Cannot be Empty\n";
                else{
                    if(x.value==y.value){
                        return ""; 
                    }
                    else
                        return "Passwords did not Match";
                }
            }
        </script>
    </head>
    <body>
    <%if(session.getAttribute("UID")!=null && session.getAttribute("UYEAR")!=null && session.getAttribute("USECTION")!=null && session.getAttribute("SDEPT")!=null){
        String uid=(String)session.getAttribute("UID");
        String sdept=(String)session.getAttribute("SDEPT");
        try{
            Connection con=new Connector(sdept).getConnection();;
            Statement st=con.createStatement();
            ResultSet rs;
            if(request.getParameter("status")==null){
                rs=st.executeQuery("select UNAME,EMAILID,MOBILE from students where UID='"+uid+"'");
                if(request.getParameter("option")!=null){%>
                    <form id="frm" action="#" method="post">
                        <input type="hidden" name="status" value="step" />
                    <%--if(request.getParameter("option").equals("cname")){
                        String on="";
                        if(rs.next()){
                            on=rs.getString("UNAME");
                        }
                        %>
                        <center><h2><u>Change Name</u>:</h2></center>
                        <input type="hidden" name="option" value="cname" />
                        <center>
                            <h3>
                                New Name:<input type="text" name="cname" value="<%=on%>" size="30" /><br /><br />
                                <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                <input type="button" value="Continue"  class="redbutton" onclick="frmSubmit()" style="width: 120px;margin-left: 10px" />
                            </h3>
                        </center>
                    <%}--%>
                    <%if(request.getParameter("option").equals("cemail")){
                        String oe="";
                        if(rs.next()){
                            oe=rs.getString("EMAILID");
                        }%>
                        <center><h2><u>Change Email Id</u>:</h2></center>
                        <input type="hidden" name="option" value="cemail" />
                        <center>
                            <h3>
                                New Email Id:<input type="text" name="cemail" value="<%=oe%>" size="30" /><br /><br />
                                <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                <input type="button" value="Continue"  class="redbutton" onclick="frmSubmit()" style="width: 120px;margin-left: 10px" />
                            </h3>
                        </center>
                    <%}
                    else if(request.getParameter("option").equals("cmobile")){
                    String om="";
                        if(rs.next()){
                            om=rs.getString("MOBILE");
                            if(om==null)
                                om=""; 
                        }%>
                        <center><h2><u>Change Mobile Number</u>:</h2></center>
                        <input type="hidden" name="option" value="cmobile" />
                        <center>
                            <h3>
                                New Mobile:<input type="text" name="cmobile" value="<%=om%>" size="15" /><br /><br />
                                <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                <input type="button" value="Continue"  class="redbutton" onclick="frmSubmit()" style="width: 120px;margin-left: 10px" />
                            </h3>
                        </center>
                   <%}
                    else if(request.getParameter("option").equals("cpass")){%>
                        <center><h2><u>Change Password</u>:</h2></center>
                            <input type="hidden" name="option" value="cpass" />
                            <table align="center">
                                <tr>
                                    <th align="right">
                                    Current Password: 
                                    </th>
                                    <td>
                                        <input type="password" id="currentPass"/>
                                    </td>
                                </tr>
                                <tr height="5mm"/>
                                <tr>
                                    <th align="right">
                                    New Password: 
                                    </th>
                                    <td>
                                        <input type="password" id="newPass" />
                                    </td>
                                </tr>
                                <tr height="5mm"/>
                                <tr>
                                    <th align="right">
                                    Confirm New Password: 
                                    </th>
                                    <td>
                                        <input type="password" id="confirm_newPass" />
                                    </td>
                                </tr>
                                <tr height="10mm"/>
                                <tr>
                                    <td colspan="2" align="center">
                                        <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                        <input type="button" value="Continue"  class="redbutton" onclick="return checkPass()" style="width: 120px;margin-left: 10px" />
                                    </td>
                                </tr>
                            </table>
                    <%}%>
                    </form>
                <%}
                st.close();
                con.close();
            }
            else{
                if(request.getParameter("option")!=null){
                    
                }
                Enumeration e=request.getParameterNames();
                while(e.hasMoreElements()){
                    String str=(String)e.nextElement();
                    out.print(str+"-"+request.getParameter(str)+"<br />");
                }
            }
        }
        catch(Exception e){
            out.print("<center>"+e+"</center>");
        }
    }
    else{%>
        <form action="./" target="_top" id="autosubmit"  method="post" onload="myfunc()">
            <input type="hidden" name="uaccount" value="Student" />
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
                <h2>
                You are not Logged In.
                Please Login to continue!
                <form action="./" target="_top" method="post" >
                    <input type="hidden" name="uaccount" value="Student" />
                    <button type="submit" class="redbutton">LogIn</button>
                </form>
                </h2>
            </center>
        </noscript>
    <%}%>
    </body>
</html>
