<%-- 
    Document   : FacReports
    Created on : Apr 5, 2013, 1:39:31 AM
    Author     : Anji
--%>


<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style type="text/css">
            button{
                padding: 1px 0px 2px;
                height:30px;
                width:80px;
                background-color: #4343eb;
                color: white;
                border-width: 0;
                border-radius: 6px;;
                font-weight:bolder;
                font-size: 16px;
                font-family: verdana,arial,sans-serif;
            }
            button:hover{
                cursor:pointer;
                color:#eeeeee;
                background-color: #435fff;
                text-decoration: underline;
                /*font-size: 18px;*/
            }
        </style>
        <title>::GRIET</title>
    </head>
    <body onload="">
        <%if(session.getAttribute("FACAID")!=null){%>
        <center><h2><u>Reports</u>:</h2>
        <table align="center" width="800"  class="edit" >
            <tr>
                <td height="250"  align="center"  >
                    <h1><u>Individual</u> <u>Report</u></h1>
                    <b>
                        <form action="FacReportLinks.jsp" method="post">
                            Year:<select name="year">
                                <option>IT</option><option>BT</option><option>BME</option><option>CIVIL</option>
                                <option>CSE</option><option>ECE</option><option>EEE</option><option>MECH</option></select>
                            <br/><br />
                            <button type="submit">Submit</button>
                        </form>
                    </b>
                </td>
                <td align="center">
                    <h1><u>Question-wise</u> <u>Report</u></h1>
                    <b>
                        <form action="FacQReport.jsp" method="post" target="_blank">
                            Question:<select name="question">
                                <option>1</option><option>2</option><option>3</option><option>4</option>
                                <option>5</option><option>6</option><option>7</option><option>8</option>
                                <option>9</option><option>10</option><option>11</option><option>12</option>
                            </select>
                            <br/><br />
                            <button type="submit">Submit</button>
                        </form>
                    </b>
                </td>
                <td align="center">
                    <h1><u>Overall</u> <u>Report</u></h1>
                    <b>
                        <form action="FacOverallReportLinks.jsp" method="post" target="_blank">
                            <button type="submit">Submit</button>
                        </form>
                    </b>
                </td>
            </tr>
        </table>
<%}else{%>
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
                <button type="submit" >LogIn</button>
            </form>
            </h2>
        </center>
    </noscript>
<%}%>
   </body>
</html>

