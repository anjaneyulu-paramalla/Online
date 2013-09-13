<%-- 
    Document   : Change
    Created on : Jul 8, 2012, 5:06:40 PM
    Author     : Anjaneyulu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>::GRIET</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="CSS/ChangeButton.css" />
        <script type="text/javascript" >
            function checkPass(f){
                var err="";
                err+=checkCurrent(f.currentPass);
                if(err==""){
                    err+=checkMatch(f.newPass,f.confirm_newPass);
                    if(err=="")
                        return true;
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
                    return "Enter the Current Password\n";
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
<%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){%> 
    <center><h2><u>Change Password</u>:</h2>
        <form action="ChangePassword.jsp" method="post" onsubmit="return checkPass(this)">
            <table>
                <tr>
                    <th align="right">
                       Current Password: 
                    </th>
                    <td>
                        <input type="password" name="currentPass"/>
                    </td>
                </tr>
                <tr height="5mm"/>
                <tr>
                    <th align="right">
                       New Password: 
                    </th>
                    <td>
                        <input type="password" name="newPass" />
                    </td>
                </tr>
                <tr height="5mm"/>
                <tr>
                    <th align="right">
                       Confirn New Password: 
                    </th>
                    <td>
                        <input type="password" name="confirm_newPass" />
                    </td>
                </tr>
                <tr height="10mm"/>
                <tr>
                    <td colspan="2"align="center">
                        <button type="submit">Change Password</button>
                    </td>
                </tr>
            </table>
        </form>
    </center>
<%}
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
            <h2>You are not Logged In.
            Please Login to continue!
            <form action="./" target="_top" method="post" >
                <input type="hidden" name="uaccount" value="Student" /><br />
                <button type="submit" >LogIn</button>
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