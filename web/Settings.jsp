<%-- 
    Document   : database
    Created on : Jul 20, 2012, 2:17:27 PM
    Author     : Anjaneyulu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="CSS/settings.css" rel="stylesheet" />
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
                font-size: 18px;
            }
        </style>
        <title>::GRIET</title>
    </head>
    <body>
        <%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){%>    
        <table align="center" class="edit" cellspacing="10">
            <tr />
            <tr />
            <tr height="20mm"/>
            <tr>
                <td colspan="3" align="center" >
                    <form action="AStudentList.jsp" >
                        <button type="submit" style="width: 300px">Student Data </button>
                    </form>
                </td>
            </tr>
            <tr />
            <tr>
                <td align="center">
                    <form action="AQuestions.jsp" >
                        <button type="submit" style="width: 200px">Questions </button>
                    </form>
                </td>
                <td align="center">
                    <form action="AFaculty.jsp">
                        <button type="submit" style="width: 200px">Faculty </button>
                    </form>
                </td>
                <td align="center">
                    <form action="ASubjects.jsp" >
                        <button type="submit"style="width: 200px">Subjects </button>
                    </form>
                </td>
            </tr>
            <tr />
            <tr>
                <td align="center">
                    <form action="AUpload.jsp" >
                        <button type="submit"style="width: 200px">Upload</button>
                    </form>
                </td>
                <td align="center">
                    <form action="AInitial.jsp" >
                        <button type="submit" style="width: 200px">Semesters </button>
                    </form>
                </td>
                <td align="center">
                    <form action="ADownload.jsp" >
                        <button type="submit" style="width: 200px">Download</button>
                    </form>
                </td>
            </tr>
            <tr />
            <tr>
                <td colspan="3" align="center" >
                    <form action="ANewFeed.jsp"  >
                        <button type="submit" style="width: 300px">Start New Feedback </button>
                    </form>
                </td>
            </tr>
            <tr />
            <tr>
                <td colspan="3" >
                    <b>
                        <span style="color: red">Note:</span>Please make sure that required faculty of the department are available before starting new Feedback.<br />
                        Insert/Import the data if the required faculty names does not exist using the above upload option!
                    </b>
                </td>
            </tr>
        </table>
        <%}
        else{%>
            <%--<jsp:forward page="./" />--%>
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
                        <button type="submit" >LogIn</button>
                    </form>
                    </h2>
                </center>
            </noscript>
        <%}%>
        <noscript>
        <center> <h4 style="color:red;display: inline"> JavaScript is not enabled on your Browser<br />Please enable JavaScript to make the page Interactive</h4></center>
        </noscript>
    </body>
</html>