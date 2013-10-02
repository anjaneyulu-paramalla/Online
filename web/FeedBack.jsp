<%-- 
    Document   : FeedBack
    Created on : Jun 27, 2012, 3:12:55 AM
    Author     : Anjaneyulu
--%>
<%@page import="DataConnection.Connector"%>
<%-- 
    Document   : Feedback
    Created on : May 22, 2012, 3:32:05 AM
    Author     : Anjaneyulu
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Error.jsp"%>
<!DOCTYPE html>
<%
if(session.getAttribute("UID")!=null && session.getAttribute("UYEAR")!=null && session.getAttribute("USECTION")!=null && session.getAttribute("SDEPT")!=null){
    String sdept=(String)session.getAttribute("SDEPT");
    try{
    Connection con=new Connector(sdept).getConnection();
    Statement st=con.createStatement();
    String uid=""+session.getAttribute("UID");
    String year=""+session.getAttribute("UYEAR");
    String section=""+session.getAttribute("USECTION");
    String sqlsem="select CURRENT_SEM from semester where YEAR="+year;
    String semester=new String();
    ResultSet rs=st.executeQuery(sqlsem);
    if(rs.next())
        semester=rs.getString("CURRENT_SEM");
    String sql="select c.UID from Count c,students s where c.UID=s.UID AND c.YEAR=s.YEAR AND c.YEAR="+year+" AND c.SEMESTER="+semester+" AND s.SECTION='"+section+"' AND c.UID='"+uid+"'";
    rs=st.executeQuery(sql);
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
        <%int   qcount=0,scount=0;%>
    <center>
        <form id="feed" action="UpdateFeedback.jsp" method="post" target="_top">
        <table border="4" cellspacing="0" width="70%">
            <caption><h1 style="color:#003333"><u>Feedback form for <%=sdept%> <%=year%>-<%=semester%> <%=section%> section:</u></h1></caption>
            <%Statement qst=con.createStatement();
            Statement qc=con.createStatement();
            Statement sst=con.createStatement();
            Statement subst=con.createStatement();
            String q="select * from Questions order by QID";
            String qcnt="select count(*) as count from Questions";
            String s="select * from Subjects_"+year+"_"+semester+section+" order by SID"; 
            String subCnt="select count(*) as Count from Subjects_"+year+"_"+semester+section;
            ResultSet qr=qst.executeQuery(q);
            ResultSet sr=sst.executeQuery(s);
            ResultSet sub=subst.executeQuery(subCnt);
            ResultSet quo=qc.executeQuery(qcnt);
            scount=0;qcount=0;
            if(sub.next())
                scount=sub.getInt("Count");
            if(quo.next())
                qcount=quo.getInt("Count");  
            session.setAttribute("col", scount);
            session.setAttribute("row", qcount);
            session.setAttribute("sem", semester);
            if(scount==0||qcount==0){
                String err=new String();
                if(scount==0&&qcount==0)
                    err=""+"<center ><h3>No questions & Subjects to give Feedback!</h3></center>";
                else if(qcount==0)
                     err=""+"<center><h3>No questions  to give Feedback!</h3></center>";
                else
                     err=""+"<center><h3>No Subjects to give Feedback!</h3></center>";%>
                <jsp:forward page="Main.jsp" >
                    <jsp:param name="outInFrame" value="<%=err%>"/>
               </jsp:forward>
            <%}
            else{%>
        <input type="hidden" name="col" value="<%=scount%>" />
        <input type="hidden" name="row" value="<%=qcount%>" />
        <input type="hidden" name="sem" value="<%=semester%>" />
            <thead bgcolor="#9999ff">
            <tr style="height:14mm">
                <th width="2%"><h2  style="display: inline">S.No</h2></th>
            <th ><h2 style="display: inline">Question</h2></th>
            <%while(sr.next()){%>
        <th><h2 style="display: inline"><%=sr.getString("SCODE")%></h2></th>
            <%} %>   
            </tr>
            </thead>
            <tbody>
            <%String rating;int rowcnt=0;
            while(qr.next()){
            int colcnt=0;%>
            <tr >
                <%rowcnt++;%>                 
                <th style="height: 13mm"><%=qr.getString("QID") %></th>
                <th align="left"  width="35%" style="font-size:4mm"><%=qr.getString("Question") %></th>
                <%int n=scount;
                while(n!=0){%>
                <th >
                    <%colcnt++;
                    rating="rate"+rowcnt+colcnt;%> 
                    <select name="<%=rating%>">
                        <option value="null">select</option>
                        <option>1</option>
                        <option>2</option>
                        <option>3</option>
                        <option>4</option>
                    </select>
                </th> 
                <%n--;}%>
            </tr>
            <%}%>
            </tbody>
            <h3>
                <table align="center"><tr ><th  rowspan="5" valign="top">*NOTE:</th><th align="left">1 indicates UNSATISFACTORY</th></tr>
                    <tr><th align="left">2 indicates SATISFACTORY</th></tr>
                    <tr><th align="left">3 indicates GOOD</th></tr>
                    <tr><th align="left">4 indicates EXCELLENT</th></tr>
                </table>
            </h3>
        </table>
        <input class="redbutton" type="button" value="Back" onclick="goBack()" />   
        <input class="redbutton" type="button" value="Reset" style="margin-left: 3mm;margin-right: 3mm" onclick="goFresh()"/>
        <input class="redbutton" type="button"  value="Submit" onclick="check()" /> 
        </form>
    </center>
    <script type="text/javascript">
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
        function check(){
            var t=document.getElementById("feed");
            var err="",errorCount=0;
            <% int nq=qcount,ns=scount;
                int  rcount=0,ccount=0;
                while(rcount!=nq){
                rcount++;
                ccount=0;%>
                var flag=false;
                <%while(ccount!=ns){
                    ccount++;
                    String c="rate"+rcount+ccount;
                    %>
                    var cell=t.<%=c%>;
                    if(!flag)
                        if((cell[0].checked==false&&cell[1].checked==false&&cell[2].checked==false&&cell[3].checked==false)||cell.value=="null"){
                            //cell[] is for radio buttons
                            flag=true;
                            errorCount++;
                        }
                <%} %> 
                if(flag){
                    err+="Q"+<%=rcount%>+",";
                }
            <%} %>
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
    </script> 
    </body>
</html>
    <%qst.close();
    qc.close();
    sst.close();
    subst.close();
        }
    }
    else{
        String ss=""+"<center><h1 style='color: blue'>You have already given the feedback!</h1></center>";%>
        <jsp:forward page="Main.jsp" >
            <jsp:param name="outInFrame" value="<%=ss%>"/>
        </jsp:forward>
    <%}
    }
    catch(Exception e){%>
        <jsp:forward page="Main.jsp" >
            <jsp:param name="outInFrame" value="<%=e%>"/>
        </jsp:forward>
    <%}
}
else{%>
    <jsp:forward page="./" /> 
<%}%>