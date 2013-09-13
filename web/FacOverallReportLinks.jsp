<%-- 
    Document   : FacOverallReportLinks
    Created on : Apr 6, 2013, 1:16:59 AM
    Author     : Anji
--%>

<%@page import="java.sql.ResultSet" errorPage="Error.jsp"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DataConnection.FacConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
    </head>
    <body onload="window.print()">
    <%if(session.getAttribute("FACAID")!=null){
        try{
            String check[]=new String[12],found[]=new String[12],question[]=new String[20];
            String sql=new String();
            int deptcount=0,foundcount=0,qlen=0,i=0,temp,cnt=0;
            boolean flag=false;
            Connection con=new FacConnector().getConnection();
            Statement st=con.createStatement();
            sql="select distinct(DEPT) from faculty";
            ResultSet rs=st.executeQuery(sql);
            if(rs.next()){
                check[cnt]=rs.getString("DEPT");
                cnt++;
                while(rs.next()){
                    check[cnt]=rs.getString("DEPT");
                    cnt++;
                }
                sql="select QUESTION from questions order by QID";
                rs=st.executeQuery(sql);
                while(rs.next()){
                    if(!flag)
                        flag=true; 
                    question[qlen]=rs.getString("QUESTION");
                    qlen++;
                }
                if(flag){
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
                    boolean gotFlag=false;
                    while(i<deptcount){
                        sql="select * from feedback_"+found[i];
                        rs=st.executeQuery(sql);
                        int k=0;
                        while(rs.next()){
                            if(!gotFlag)
                                gotFlag=true;
                            temp++;k=0;
                            if(temp==1){%>
                                <center><h3>Report No:<%=temp%> of <%=foundcount%></h3></center>
                            <%}
                            else{%>
                                <center style="page-break-before: always"><h3>Report No:<%=temp%> of <%=foundcount%></h3></center>
                           <%}%>
                            <table align="center" border="1" width="100%" cellspacing="0">
                              <%while(k<qlen){%>
                                <tr >
                                    <td style="border-width: 0px"></td>
                                    <td style="border-width: 0px"></td>
                                </tr>
                                <tr>
                                    <td valign="top" style="border-width: 0px"><b><%=k+1%>.</b></td>
                                    <td valign="top" style="border-width: 0px"><b><%=question[k]%></b></td>
                                </tr>
                                <tr>
                                    <td valign="top" style="border-width: 0px">A.</td>
                                    <td valign="top" style="border-width: 0px"><%=rs.getString("Q"+(k+1))%></td>
                                </tr>
                                <%k++;
                              }%>
                            </table>
                        <%}
                        i++;
                    }
                    if(!gotFlag){%>
                        <center>No Data found!</center>
                    <%}
                }
                else{%>
                    <center>No Questions found!</center>
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
    </body>
</html>
