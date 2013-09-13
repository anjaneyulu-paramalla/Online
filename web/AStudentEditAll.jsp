<%-- 
    Document   : AStudentEditAll
    Created on : Feb 26, 2013, 6:08:05 PM
    Author     : Anji
--%>

<%@page import="java.sql.ResultSet" errorPage="Error.jsp"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
        <link rel="stylesheet" href="CSS/redun.css" />
    </head>
    <body>
 <%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){
    String dept=(String)session.getAttribute("DEPT");
    try{
        int year=Integer.parseInt(request.getParameter("year"));
        String Ryear="";
        if(year==1)
            Ryear="I";
        else if(year==2)
            Ryear="II";
        else if(year==3)
            Ryear="III";
        else
            Ryear="IV";
        String option=request.getParameter("option");%>
        <h3><center><u><%=option.substring(0, 1).toUpperCase()+option.substring(1,option.length()).toLowerCase() %> <%=Ryear%> year student data</u>:</center></h3>
        <%if(request.getParameter("status")==null){
            if(option.toLowerCase().equals("move all")){%>           
                <form action="#" method="post">
                    <center><h4>Move to year:
                        <select name="myear">
                            <%if(year!=1){%>
                                <option>I</option>
                            <%}
                            if(year!=2){%>
                                <option>II</option>
                            <%}
                            if(year!=3){%>
                                <option>III</option>
                            <%}
                            if(year!=4){%>
                                <option>IV</option>
                            <%}%>
                        </select>
                    </h4></center>
                    <h3><center>
                        <input type="hidden" name="status" value="step" />
                        <input type="hidden" name="option" value="<%=option%>" />
                        <input type="hidden" name="year" value="<%=year%>" />
                        <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                        <input type="submit" value="Continue" class="redbutton" style="width: 120px;margin-left: 10px" />
                    </center></h3>
                </form>
            <%}
            else if(option.toLowerCase().equals("delete all")){%>
                <form action="#" method="post" >
                    <input type="hidden" name="status" value="step" />
                    <input type="hidden" name="year" value="<%=year%>" />
                    <input type="hidden" name="option" value="<%=option%>" />
                    <%Class.forName("com.mysql.jdbc.Driver");
                    String url="jdbc:mysql://localhost:3306/feedback_"+dept;
                    Connection con=DriverManager.getConnection(url,"root","GRIETITOLFF1202");
                    Statement st=con.createStatement();
                    String sql="select c.YEAR,c.SEMESTER from count c,students s where c.UID=s.UID AND s.YEAR="+year+" group by YEAR,SEMESTER order by YEAR,SEMESTER";
                    ResultSet rs=st.executeQuery(sql);
                    if(rs.next()){
                        int i=1;
                        String romyear="",romsem="";
                        int roy=rs.getInt("YEAR"); 
                        int ros=rs.getInt("SEMESTER");
                        if(roy==1)
                            romyear="I";
                        else if(roy==2)
                            romyear="II";
                        else if(roy==3)
                            romyear="III";
                        else
                            romyear="IV";
                        if(ros==1)
                            romsem="I";
                        else if(ros==2)
                            romsem="II";
                        else if(ros==3)
                            romsem="III";
                        else
                            romsem="IV";%>
                        <input type="hidden" name="found" value="true" />
                        <input type="hidden" name="fyear<%=i%>" value="<%=roy%>" />
                        <input type="hidden" name="fsem<%=i++%>" value="<%=ros%>" />
                        <center>
                            <h4>
                                On deleting <%=Ryear%> year students, feedback for the following semesters will be restarted freshly.
                                <table width="300px" align="center" cellspacing="0" border="3">
                                    <tr style="background-color: #9999ff">
                                        <th>Year</th>
                                        <th>Semester</th>
                                    </tr>
                                    <tr>
                                        <td align="center"><%=romyear%></td>
                                        <td align="center"><%=romsem%></td>
                                    </tr>
                                    <%while(rs.next()){
                                    roy=rs.getInt("YEAR"); 
                                    ros=rs.getInt("SEMESTER");
                                    if(roy==1)
                                        romyear="I";
                                    else if(roy==2)
                                        romyear="II";
                                    else if(roy==3)
                                        romyear="III";
                                    else
                                        romyear="IV";
                                    if(ros==1)
                                        romsem="I";
                                    else if(ros==2)
                                        romsem="II";
                                    else if(ros==3)
                                        romsem="III";
                                    else
                                        romsem="IV";%>
                                    <input type="hidden" name="fyear<%=i%>" value="<%=roy%>" />
                                    <input type="hidden" name="fsem<%=i++%>" value="<%=ros%>" />
                                    <tr>
                                        <td align="center"><%=romyear%></td>
                                        <td align="center"><%=romsem%></td>
                                    </tr>
                                    <%}%>
                                </table>
                                would you like  to continue?<br /><br />
                                <input type="hidden" name="fycount" value="<%=i-1%>" />
                                <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                <input type="submit" value="Yes"  class="redbutton" style="margin-left: 10px" />
                        </h4>
                        </center>
                    <%}
                    else{%>
                        <center><h4>Deleting <%=Ryear%> year students data.<br />Are you sure?<br /><br />
                            <input type="hidden" name="found" value="false" />
                            <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                            <input type="submit" value="Yes"  class="redbutton" style="margin-left: 10px" />
                        </h4></center>
                    <%}%>
                </form>
            <%}
        }
        else if(request.getParameter("status").equals("step")){
            if(option.toLowerCase().equals("move all")){
                Class.forName("com.mysql.jdbc.Driver");
                String url="jdbc:mysql://localhost:3306/feedback_"+dept;
                Connection con=DriverManager.getConnection(url,"root","GRIETITOLFF1202");
                Statement st=con.createStatement();
                if(request.getParameter("mstatus")==null){
                    String my=request.getParameter("myear");
                    int myear;
                    if(my.equals("I"))
                        myear=1;
                    else if(my.equals("II"))
                        myear=2;
                    else if(my.equals("III"))
                        myear=3;
                    else
                        myear=4;
                    if(year!=myear){
                        String fsql="select YEAR,SEMESTER from count where UID IN (select UID from students where YEAR="+year+") group by YEAR,SEMESTER order by YEAR,SEMESTER";
                        ResultSet rs=st.executeQuery(fsql);
                        if(rs.next()){
                            int i=1;
                            String romyear="",romsem="";
                            int roy=rs.getInt("YEAR"); 
                            int ros=rs.getInt("SEMESTER");
                            if(roy==1)
                                romyear="I";
                            else if(roy==2)
                                romyear="II";
                            else if(roy==3)
                                romyear="III";
                            else
                                romyear="IV";
                            if(ros==1)
                                romsem="I";
                            else if(ros==2)
                                romsem="II";
                            else if(ros==3)
                                romsem="III";
                            else
                                romsem="IV";%>
                            <form action="#"method="post">
                            <input type="hidden" name="status" value="step" />
                            <input type="hidden" name="option" value="<%=option%>" />
                            <input type="hidden" name="year" value="<%=year%>" />
                            <input type="hidden" name="myear" value="<%=myear%>" />
                            <input type="hidden" name="mstatus" value="step" />
                            <input type="hidden" name="found" value="true" />
                            <input type="hidden" name="fyear<%=i%>" value="<%=roy%>" />
                            <input type="hidden" name="fsem<%=i++%>" value="<%=ros%>" />
                            <center><h4>
                                    On moving <%=Ryear%> year students to <%=my%> year ,feedback for the following semester(s) will be restarted freshly.
                                    <table width="300px" align="center" cellspacing="0" border="3">
                                    <tr style="background-color: #9999ff">
                                        <th>Year</th>
                                        <th>Semester</th>
                                    </tr>
                                    <tr>
                                        <td align="center"><%=romyear%></td>
                                        <td align="center"><%=romsem%></td>
                                    </tr>
                                    <%while(rs.next()){
                                        roy=rs.getInt("YEAR"); 
                                        ros=rs.getInt("SEMESTER");
                                        if(roy==1)
                                            romyear="I";
                                        else if(roy==2)
                                            romyear="II";
                                        else if(roy==3)
                                            romyear="III";
                                        else
                                            romyear="IV";
                                        if(ros==1)
                                            romsem="I";
                                        else if(ros==2)
                                            romsem="II";
                                        else if(ros==3)
                                            romsem="III";
                                        else
                                            romsem="IV";%>
                                        <input type="hidden" name="fyear<%=i%>" value="<%=roy%>" />
                                        <input type="hidden" name="fsem<%=i++%>" value="<%=ros%>" />
                                        <tr>
                                            <td align="center"><%=romyear%></td>
                                            <td align="center"><%=romsem%></td>
                                        </tr>
                                    <%}%>
                                </table>
                                would you like  to continue?<br /><br />
                                <input type="hidden" name="fycount" value="<%=i-1%>" />
                                <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                <input type="submit" value="Yes"  class="redbutton" style="margin-left: 10px" />
                            </h4></center>
                            </form>
                        <%}
                        else{%>
                            <center>
                            <h4>
                            Moving <%=Ryear%> year student data to <%=my%> year!<br />
                            Are you sure?
                            </h4>
                            <form action="#" method="post">
                                <input type="hidden" name="found" value="false" />
                                <input type="hidden" name="status" value="step" />
                                <input type="hidden" name="mstatus" value="step" />
                                <input type="hidden" name="option" value="<%=option%>" />
                                <input type="hidden" name="year" value="<%=year%>" />
                                <input type="hidden" name="myear" value="<%=myear%>" />
                                <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                                <input type="submit" value="Yes" class="redbutton" style="margin-left: 10px" />
                            </form>
                            </center>
                       <%}
                    }%>
                <%}
                else{
                    int myear=Integer.parseInt(request.getParameter("myear"));
                    if(year!=myear){
                        if(request.getParameter("found").equals("true")){
                            int i=1;
                            int count =Integer.parseInt(request.getParameter("fycount"));
                            int sye[]=new int[count],sse[]=new int[count];
                            String cdel="delete from count where UID IN (select UID from students where YEAR="+year+")";
                            st.executeUpdate(cdel);
                            String MYEAR;
                            if(myear==1)
                                MYEAR="I";
                            else if(myear==2)
                                MYEAR="II";
                            else if(myear==3)
                                MYEAR="III";
                            else
                                MYEAR="IV";
                            String sql="update students set year="+myear+" where year="+year;
                            int rs=st.executeUpdate(sql);%>
                            <center>
                                <h4>Successfully moved <%=rs%> <%=Ryear%> year students to <%=MYEAR%> year!</h4>
                                <form action="Settings.jsp">
                                    <button type="submit" class="redbutton" style="width: 200px">Go to Home Page</button>
                                </form>
                            </center>
                            <%while(i<=count){
                                if(request.getParameter("fyear"+i)!=null && request.getParameter("fsem"+i)!=null){
                                    int fyy=Integer.parseInt(request.getParameter("fyear"+i));
                                    int fss=Integer.parseInt(request.getParameter("fsem"+i));
                                    int j=1;
                                    while(j<=4){
                                        char c=(char)(64+j);
                                        try{
                                            String fdel="delete from feedback_"+dept+"_"+fyy+"_"+fss+c; 
                                            st.executeUpdate(fdel);
                                        }
                                        catch(Exception e){
                                            //do not print
                                        }
                                        j++;
                                    }
                                }
                                i++;
                            }
                            st.close();
                            con.close();
                        }
                        else{
                            String MYEAR;
                            if(myear==1)
                                MYEAR="I";
                            else if(myear==2)
                                MYEAR="II";
                            else if(myear==3)
                                MYEAR="III";
                            else
                                MYEAR="IV";
                            String sql="update students set year="+myear+" where year="+year;
                            int rs=st.executeUpdate(sql);
                            st.close();
                            con.close();%>
                            <center>
                                <h4>Successfully moved <%=rs%> <%=Ryear%> year students to <%=MYEAR%> year!</h4>
                                <form action="Settings.jsp">
                                    <button type="submit" class="redbutton" style="width: 200px">Go to Home Page</button>
                                </form>
                            </center>
                        <%}
                    }
                }
                st.close();
                con.close();
            }
            else if(option.toLowerCase().equals("delete all")){
                if(request.getParameter("found")!=null){
                    Class.forName("com.mysql.jdbc.Driver");
                    String url="jdbc:mysql://localhost:3306/feedback_"+dept;
                    Connection con=DriverManager.getConnection(url,"root","GRIETITOLFF1202");
                    Statement st=con.createStatement();
                    String dsql="delete from students where year="+year;
                    if(request.getParameter("found").equals("true")){
                        int fyc=Integer.parseInt(request.getParameter("fycount"));
                        int i=1;
                        int delfeedyear[]=new int[fyc], delfeedsem[]=new int[fyc];
                        String cdel="delete from count where UID IN (select UID from students where year="+year+")";
                        out.print(cdel);
                        while(i<=fyc){ 
                            if(request.getParameter("fyear"+i)!=null && request.getParameter("fsem"+i)!=null){
                                delfeedyear[i-1]=Integer.parseInt(request.getParameter("fyear"+i));
                                delfeedsem[i-1]=Integer.parseInt(request.getParameter("fsem"+i));
                            }
                            i++;
                        }
                        st.addBatch(cdel);
                        st.addBatch(dsql);
                        int rdel[]=st.executeBatch();
                        i=1;
                        while(i<=fyc){
                            int j=1;
                            while(j<=4){
                                char c=(char)(64+j);
                                try{
                                    st.executeUpdate("delete from feedback_"+dept+"_"+delfeedyear[i-1]+"_"+delfeedsem[i-1]+c);
                                }
                                catch(Exception e){
                                    //do not print
                                }
                                j++; 
                            }
                            i++;
                        }%>
                        <center>
                            <h3><%=rdel[1]%> <%=Ryear%> year record(s) deleted successfully!</h3>
                            <form action="Settings.jsp">
                                <button type="submit" class="redbutton" style="width: 200px">Go to Home Page</button>
                            </form>
                        </center>
                    <%}
                    else{
                        int rdel=st.executeUpdate(dsql);%>
                        <center>
                            <h3><%=rdel%> <%=Ryear%> year record(s) deleted successfully!</h3>
                            <form action="Settings.jsp">
                                <button type="submit" class="redbutton" style="width: 200px">Go to Home Page</button>
                            </form>
                        </center>
                    <%}
                    st.close();
                    con.close();
                } 
            }
        }
    }
    catch(Exception e){
        out.println("<center>"+e+"</center>");%>
        <h3><center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></center></h3>    
    <%}
}
else{%>
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
                <input type="hidden" name="uaccount" value="Administrator" />
                <button type="submit" class="redbutton">LogIn</button>
            </form>
        </h2>
        </center>
    </noscript>        
<%}%>
    </body>
</html>
