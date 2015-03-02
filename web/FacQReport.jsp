<%-- 
    Document   : FacQReport
    Created on : Apr 10, 2013, 12:26:15 AM
    Author     : Anji
--%>
<%@page import="java.sql.ResultSet" errorPage="Error.jsp"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.data.connection.FacConnector"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
    </head>
    <body onload="window.print()">
<%if(session.getAttribute("FACAID")!=null){
    try{
        int qno=Integer.parseInt(request.getParameter("question"));
        String check[]=new String[12],found[]=new String[12];
        int deptcount=0,foundcount=0,qlen=0,i=0,temp,cnt=0;
        Connection con=new FacConnector().getConnection();
        Statement st=con.createStatement();
        String sql="select distinct(DEPT) from faculty";
        ResultSet rs=st.executeQuery(sql);
        if(rs.next()){
            check[cnt]=rs.getString("DEPT");
            cnt++;
            while(rs.next()){
                check[cnt]=rs.getString("DEPT");
                cnt++;
            }
            sql="select QUESTION from questions where QID="+qno;
            rs=st.executeQuery(sql);
            if(rs.next()){
                String quest=rs.getString("QUESTION");
                rs=st.executeQuery("select max(QID) as max from questions");
                rs.next();
                int qcount=rs.getInt("max");
                while(i<cnt){
                    sql="select count(*) as count from feedback_"+check[i];
                    try{
                        rs=st.executeQuery(sql);
                        if(rs.next()){
                            temp=rs.getInt("count");
                            if(temp!=0){
                                found[deptcount]=check[i];
                                deptcount++;
                                foundcount+=temp; 
                            }
                        }
                    }
                    catch(Exception e){
                        //Nothing to do
                    }
                    i++;
                }
                i=0;temp=0;
                if(i<deptcount){%>
                    <center><h3 style="display: inline">Faculty feedback for Question No:<%=qno%> of <%=qcount%></h3></center>
                    <table align="center" border="1" width="100%" cellspacing="0">
                    <tr>
                        <td valign="top" style="border-width: 0px" align="right"><b>Q<%=qno%>. </b></td>
                        <td valign="top" style="border-width: 0px"><b>&nbsp;<%=quest%></b></td>
                    </tr>
                    <%while(i<deptcount){
                        sql="select Q"+qno+" from feedback_"+found[i];
                        rs=st.executeQuery(sql);
                        while(rs.next()){
                            temp++;%>
                            <tr>
                                <td valign="top" style="border-width: 0px" align="right">A<%=temp%>. </td>
                                <td valign="top" style="border-width: 0px">&nbsp;<%=rs.getString("Q"+qno)%></td> 
                            </tr>
                        <%}
                        i++;
                    }%>
                    </table>
                <%}
                else{%>
                    <center>No Data found!</center>
                <%} 
            }
            else{%>
                <center>Question not found!</center>
            <%}
            
        }
        else{%>
            <center>No Data found!</center>
        <%}  
    }
    catch(Exception e){
        out.print("<center>"+e+"</center>");
    }
}
else{%>
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
