<%-- 
    Document   : FacFeedback
    Created on : Mar 28, 2013, 1:33:03 AM
    Author     : Anji
--%>

<%@page import="DataConnection.FacConnector" errorPage="Error.jsp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
if(session.getAttribute("FACID")!=null && session.getAttribute("FACDEPT")!=null ){
    String fid=""+session.getAttribute("FACID");
    String fdept=(String)session.getAttribute("FACDEPT");
    try{
    Connection con=new FacConnector().getConnection();
    Statement st=con.createStatement();
    String sql="select FID from count where fid='"+fid+"'";
    ResultSet rs=st.executeQuery(sql);
    if(!rs.next()){%> 
    <html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
        <noscript>
            <p><h3 style="color:red;text-align: center"> JavaScript is not enabled on your Browser<br />Please enable JavaScript to make the page Interactive</h3></p>
        </noscript>
        <link rel="stylesheet" href="CSS/redun.css" />
    </head>
    <body  bgcolor="#dddddd">
        <%int qcount=0;%>
    <center>
        <form name="feed" id="feed" action="FacUpdateFeedback.jsp" method="post" target="_top">
        <table border="4" cellspacing="0" width="80%">
            <caption><h1 style="color:#003333"><u>Faculty Feedback Form:</u></h1></caption>
            <%Statement qst=con.createStatement();
            Statement qc=con.createStatement();
            String q="select * from Questions order by QID";
            String qcnt="select count(*) as count from Questions"; 
            ResultSet qr=qst.executeQuery(q);
            ResultSet quo=qc.executeQuery(qcnt);
            qcount=0;
            if(quo.next())
                qcount=quo.getInt("Count");  
            session.setAttribute("row", qcount);
            if(qcount==0){
                String err=new String();
                if(qcount==0)
                     err=""+"<center><h3>No questions  to give Feedback!</h3></center>";%>
                <jsp:forward page="FacMain.jsp" >
                    <jsp:param name="outInFrame" value="<%=err%>"/>
               </jsp:forward>
            <%}
            else{%>
            <input type="hidden" name="row" value="<%=qcount%>" />
                <thead bgcolor="#9999ff">
                <tr>
                    <th width="2%"><h3  style="display: inline">Sno</h3></th>
                    <th><h3 style="display: inline">Question</h3></th>
                    <th><h3 style="display: inline">Your response</h3></th>
                </tr>
                </thead>
                <tbody>
                <%boolean entryfirst=true;
                while(qr.next()){%>
                <tr>                 
                    <th style="height: 13mm"><%=qr.getString("QID") %></th>
                    <td align="left"  style="font-size:4mm"><b><%=qr.getString("Question") %></b></td>
                    <th>
                        <%if(entryfirst){%>
                            <textarea autofocus name="rate<%=qr.getString("QID")%>" maxlength="200" rows="3" cols="35"></textarea>
                        <%entryfirst=false;
                        }
                        else{%>
                            <textarea name="rate<%=qr.getString("QID")%>" maxlength="200" rows="3" cols="35"></textarea>
                        <%}%>
                    </th> 
                </tr> 
                <%}%>
                </tbody>
            </table>
            <br />
            <input class="redbutton" type="button" value="Back" onclick="goBack()" />   
            <input class="redbutton" type="button" value="Reset" style="margin-left: 3mm;margin-right: 3mm" onclick="goFresh()" />
            <input class="redbutton" type="button"  value="Submit" onclick="return check(feed)"/>
            </form>
        </center>
        <script type="text/javascript">
            function check(t){
                var err="",errorCount=0;
                <%int nq=qcount;
                int  rcount=0;
                while(rcount!=nq){
                    rcount++;%>
                    var flag=false;
                    <%String c="rate"+rcount;%>
                    var cell=t.<%=c%>;
                    cell=cell.value.replace(/^\s+|\s+$/g,'');
                    if(!flag)
                        if(cell==""){
                            flag=true;
                            errorCount++;
                        } 
                    if(flag){
                        err+="Q"+<%=rcount%>+",";
                    }
                <%}%>
                if(err==""){
                    giveEntry();
                    return true;
                } 
                else{
                    var l=err.lastIndexOf(',');
                    if(errorCount>1)
                        err=err.substring(0,l)+" are not answered completely";
                    else
                        err=err.substring(0,l)+" is not answered completely";
                    alert(err);
                    return false;
                }
            }
            function giveEntry(){
                var confirm=window.confirm("Note: You cannot change the feedback once submitted!\nAre you sure?\nDo you want to submit the form!");
                if(confirm){
                    document.getElementById("feed").submit();
                }
            }
            function goFresh(){
                var confirm=window.confirm("Are you sure?\nDo you want to reset!");
                if(confirm){
                    document.getElementById("feed").reset();
                }
            }
            function goBack(){
                var confirm=window.confirm("Are you sure?\nDo you want to go back!");
                if(confirm){
                    history.go(-1);
                }
            }
        </script> 
        </body>
    </html>
        <%qst.close();
        qc.close();
        }
    }
    else{
        String ss=""+"<center><h1 style='color: blue'>You have already given the feedback!</h1></center>";%>
        <jsp:forward page="FacMain.jsp" >
            <jsp:param name="outInFrame" value="<%=ss%>"/> 
        </jsp:forward> 
    <%}
    }
    catch(Exception e){%>
        <jsp:forward page="FacMain.jsp" >
            <jsp:param name="outInFrame" value="<%=e%>"/>
        </jsp:forward>
    <%}
}
else{%>
    <jsp:forward page="./" >
        <jsp:param name="uaccount" value="Faculty" />
    </jsp:forward>
<%}%>
