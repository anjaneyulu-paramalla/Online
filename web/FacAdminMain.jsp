<%-- 
    Document   : FacAdminMain
    Created on : Mar 27, 2013, 8:35:43 PM
    Author     : Anji
--%>

<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Error.jsp"%>
<!DOCTYPE html>
<%
if(session.getAttribute("FACAID")!=null ){%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="CSS/Admin.css" /> 
        <title>::GRIET</title>
    </head>
    <body style="background-image: url(IMAGES/back.jpg);background-size: 100% 160%;background-repeat: no-repeat;background-color:#00a9e7 ">
    <center ><img src="IMAGES/logo.jpg" height="150" width="1000"/></center>
        <table width="1000"  align="center" style="margin-top: -20px;margin-bottom: 10px;">
            <tr>
                <td width="150"></td>
                <td width="700" align="center"><marquee behavior="alternate" scrollamount="2"><font face="algerian" size="4" color="#E62E00"><b>GOKARAJU RANGARAJU INSTITUTE OF ENGINEERING & TECHNOLOGY</b></font></marquee ></td>
                 <td align="center" valign="top"> 
                    <form action="FacAdminLogout.jsp" method="post">
                        <button class="decide" type="submit" ><b><u>Logout</u></b>?</button>
                    </form>
                </td>
            </tr>
        </table>
        <table  width="1000"  align="center" class="ref" border="1" cellspacing="0" class="tab">
            <tr  align="center" style="border-width: 0;">
                <td style="border-top-left-radius: 10px ;">
                    <form  action="FacManual.jsp" target="Mbottom">
                        <button type="submit"  class="links" >Manual</button>
                    </form> 
                </td>
                <td>
                    <form action="FacSettings.jsp" target="Mbottom" >
                        <button type="submit" class="links">Settings</button>
                    </form>
                </td>
                <td>
                    <form action="FacReports.jsp" target="Mbottom" >
                        <button type="submit" class="links">Reports</button>
                    </form>
                </td>
                <td>
                    <form action="FacAMessageBox.jsp" target="Mbottom">
                        <button type="submit" class="links">Message Box</button>
                    </form>
                </td>
                <td style="border-top-right-radius: 10px ;">
                    <form action="FacAdminAccount.jsp" target="Mbottom" >
                        <button type="submit" class="links" >Account</button>
                    </form>
                </td>
            </tr>
            <tr cellspacing="0" style="padding:0px">
                <td bgcolor="white" colspan="5" style="background-color:#eeeeff " >
                    <iframe name="Mbottom" src="FacSettings.jsp" height="430" width="1000" frameborder="0" ></iframe>
                </td>
            </tr>
            <%  
             Calendar calendar=Calendar.getInstance();
             int CYear=calendar.get(Calendar.YEAR);
            %> 
            <tr class="ref"><td colspan="5" class="cap" style="cursor:default"><b>Copyright &copy; <%=CYear%> This site content is licensed under a <a href="license.jsp" target="_blank">MIT License</a>.Best viewed with a resolution 
        of 1024x768 or above.</b></td></tr>
        </table>
    </body>
</html>
<%}
else{%>
    <jsp:forward page="./" >
        <jsp:param name="invalid" value="Wrong UserID"/>
        <jsp:param name="account" value="Administrator-2" />
    </jsp:forward>
<%}%>    