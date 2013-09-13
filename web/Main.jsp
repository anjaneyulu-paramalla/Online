<%-- 
    Document   : Main
    Created on : Jun 29, 2012, 6:21:51 PM
    Author     : Anjaneyulu
--%>

<%@page import="java.util.Calendar" errorPage="Error.jsp"%>
<%
if((session.getAttribute("UID")!=null && session.getAttribute("UYEAR")!=null && session.getAttribute("USECTION")!=null && session.getAttribute("SDEPT")!=null)){%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <META HTTP-EQUIV="Pragma" CONTENT="no-cache" />
        <title>::GRIET</title>
        <link rel="stylesheet" href="CSS/login.css" />
        <script type="text/javascript" src="JS/Validate.js"></script>
    </head>
     <body style="background-image: url(IMAGES/back.jpg);background-size: 100% 160%;background-repeat: no-repeat;background-color:#00a9e7 ">
        <center ><img src="IMAGES/logo.jpg" height="150" width="1000"/></center>
        <table width="1000"  align="center" style="margin-top: -10px;margin-bottom: 0px">
            <tr>
                <td width="150"></td>
                <td width="700" ><marquee behavior="alternate" scrollamount="2"><font face="algerian" size="4" color="#E62E00"><b>GOKARAJU RANGARAJU INSTITUTE OF ENGINEERING & TECHNOLOGY</b></font></marquee ></td>
                <td align="center" valign="top"> 
                    <form action="Logout.jsp" method="post">
                        <button class="decide" type="submit" ><b><u>Logout</u></b>?</button>
                    </form>
                </td>
            </tr>
        </table>
        <table width="1000" border="2" align="center" cellspacing="0" class="Main" >
            <tr>
                <td  align="center" colspan="3" class="Ftitle">ONLINE FEEDBACK SYSTEM</td>
            </tr>
             <tr>
                <td width="800" height="400" valign="top" class="desc">
                    <%if(request.getParameter("outInFrame")!=null){%>
                        <iframe src="outputFrame.jsp?<%=request.getQueryString()%>" name="bottom" height="400" width="800" ></iframe>
                    <%}
                    else{%>
                        <iframe src="Home.jsp" name="bottom" height="400" width="800" ></iframe>
                    <%}%>
                </td>
                <td width="1" class="vline"></td> 
                <td valign="top" align="center" class="login"  >
                    <table >
                        <tr><td>
                                <form  action="Home.jsp" target="bottom">
                                    <button type="submit" name="home" value="home" class="links" >Home</button>
                                </form> 
                            </td>
                        </tr>
                        <tr /><tr />
                        <tr><td>
                                <form action="Details.jsp" target="bottom" >
                                    <button type="submit" class="links">Details</button>
                                </form>
                            </td>
                        </tr>
                        <tr /><tr />
                         <tr><td>
                                 <form action="Subjects.jsp" target="bottom" >
                                    <button type="submit" class="links">Subjects</button>
                                 </form>
                             </td>
                         </tr>
                         <tr /><tr />
                         <tr><td>
                                 <form action="FeedBack.jsp" target="_top">
                                    <button type="submit" class="links">Feedback</button>
                                 </form>
                             </td>
                         </tr>
                         <tr /><tr />
                         <tr><td>
                                 <form action="StudentAccount.jsp" target="bottom" >
                                    <button type="submit" class="links">Account</button>
                                 </form>
                             </td>
                         </tr>
                         <tr /><tr />
                         <tr><td>
                                 <form action="ContactAdmin.jsp" target="bottom" >
                                    <button type="submit" class="links">Contact Admin</button>
                                 </form>
                             </td>
                         </tr>
                         <tr /><tr />
                    </table>
                </td>
            </tr>
            <%  
             Calendar calendar=Calendar.getInstance();
             int CYear=calendar.get(Calendar.YEAR);
            %> 
            <tr class="ref"><td colspan="5" class="cap"><b>Copyright &copy; <%=CYear%> This site content is licensed under a <a href="license.jsp" target="_blank">MIT License</a>.Best viewed with a resolution 
        of 1024x768 or above.</b></td></tr>
        </table>
    </body>
</html>
<%}
else{%>
    <jsp:forward page="./" />
<%}%>