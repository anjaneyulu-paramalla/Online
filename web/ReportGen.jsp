<%-- 
    Document   : ReportGenerator
    Created on : Jul 9, 2012, 3:06:16 AM
    Author     : Anjaneyulu
--%>
<%@page import="com.sun.xml.internal.fastinfoset.tools.StAX2SAXReader"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="sun.util.calendar.BaseCalendar"%>
<%@page import="sun.util.calendar.BaseCalendar.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
        <link rel="stylesheet" href="CSS/redun.css" />
    </head>
    <body>
<% if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){
    String year=request.getParameter("year");
    String sem=request.getParameter("sem");
    String scode=request.getParameter("scode");
    String dept=(String)session.getAttribute("DEPT");
    int fid=Integer.parseInt(request.getParameter("fid"));
    try{
        Class.forName("com.mysql.jdbc.Driver");
        String uri="jdbc:mysql://localhost:3306/feedback_"+dept;
        Connection con=DriverManager.getConnection(uri,"root","GRIETITOLFF1202");
        Statement st=con.createStatement();
        String sql="select SECTIONS from semester where YEAR="+year;
        ResultSet rs=st.executeQuery(sql);
        int sec;
        if(rs.next()){
            sec=rs.getInt("SECTIONS");
            int i=1,cnt=0;
            String section[]=new String[5];
            while(i<=sec){
                char c=(char)(i+64);
                sql="select SCODE from Subjects_"+year+"_"+sem+c+" where SCODE='"+scode+"' and FID="+fid ;
                rs=st.executeQuery(sql);
                while(rs.next()){
                    section[cnt]=""+c;
                    cnt++;
                }
                i++;
            }
            String y="",sm="";
            int ey=Integer.parseInt(year),es=Integer.parseInt(sem),sy=1,ss=1;
            while(sy<=ey){
                if(sy<=3)
                    y+=""+"I";
                else{
                    if(sy==4)
                        y="IV";
                    else if(sy==5)
                        y="V";
                    else if(sy==6)
                        y="VI";
                }
                sy++;                       
            }
            while(ss<=es){
                sm+="I";
                ss++;
            }    
            %>
            <html>
            <head>
                <style type="text/css">
                    td{
                        height:13mm;
                        border-width: 0px;
                    }
                    .que tr td{
                        border-width: 1px;
                    }
                </style>
            </head>
            <body onload="window.print()">
            <div  style="text-align: center">
                <img src="IMAGES/logo-new_small.jpg" width="60" height="30"/><br />
                <h4 style="display:inline">Gokaraju Rangaraju Institute Of Engineering & Technology<br />
                Summation of Teacher Appraisal by Student<br />
                </h4>
            </div>
            <table align="center"  width="700" style="font-size: 16;font-family: 'Times New Roman'">
                <tr align="left">
                    <%
                    sql="Select s.SNAME ,f.FNAME from Subjects_"+year+"_"+sem+section[0]+" s,Faculty f where s.fid=f.fid and (s.scode='"+scode+"' and f.fid="+fid+")";
                    rs=st.executeQuery(sql);
                    rs.next();
                    DateFormat dateFormat=new SimpleDateFormat("dd-MM-yyyy");
                    Calendar calendar=Calendar.getInstance();
                    String dt=""+dateFormat.format(calendar.getTime());
                    int cYear=calendar.get(Calendar.YEAR);
                    int mon=calendar.get(Calendar.MONTH)+1;
                    String academicYear="";
                    if(mon>=6 && mon<=12){
                        int nYear=cYear+1;
                        String ny=""+nYear;
                        int alength=ny.length();
                        int shortAYear=Integer.parseInt(ny.substring((alength-2)));
                        academicYear=""+cYear+"-"+shortAYear;
                    }
                    else{
                        int pYear=cYear-1;
                        String cy=""+cYear;
                        int alength=cy.length();
                        int shortAYear=Integer.parseInt(cy.substring((alength-2)));
                        academicYear=""+pYear+"-"+shortAYear;    
                    }
                    /*if(es==1){
                        if(mon>=8&&mon<=12){
                            int nYear=cYear+1;
                            String ny=""+nYear;
                            int alength=ny.length();
                            int shortAYear=Integer.parseInt(ny.substring((alength-2)));
                            academicYear=""+cYear+"-"+shortAYear;
                            //out.print(academicYear);
                        }
                        else{
                            int pYear=cYear-1;
                            String cy=""+cYear;
                            int alength=cy.length();
                            int shortAYear=Integer.parseInt(cy.substring((alength-2)));
                            academicYear=""+pYear+"-"+shortAYear;
                          //  out.print(academicYear);
                        } 
                    }
                    else{
                        int pYear=cYear-1;
                        String cy=""+cYear;
                        int alength=cy.length();
                        int shortAYear=Integer.parseInt(cy.substring((alength-2)));
                        academicYear=""+pYear+"-"+shortAYear;
                        //out.print(academicYear);
                    }*/
                    %>
                    <td width="200">1.&nbsp;Name of Instructor</td><td colspan="3">:&nbsp;<b><%=rs.getString("FNAME")%></b></td>
                </tr>
                <tr align="left">
                    <%int sl=0;
                    String sect=new String();
                    while(sl<cnt){
                        if(sl==0){
                            sect=section[sl];
                        }
                        else{
                            sect+=","+section[sl];
                        }
                        sl++;
                    }%>
                    <td width="200">2.&nbsp;Subject</td>
                    <td colspan="3">:&nbsp;<b><%=rs.getString("SNAME") %></b></td>
                    <!--<td>&nbsp;<b>Section(s)</b></td>
                    <td>:&nbsp;<b><%=sect%></b></td>-->
                </tr>
                <tr>
                    <td width="200">3.&nbsp;Course&nbsp;:&nbsp;<b>B.Tech -<%=dept%></b></td>
                    <td width="150">&nbsp;Year&nbsp;:&nbsp;<b><%=y%></b></td>
                    <td width="150" >&nbsp;Semester&nbsp;:&nbsp;<b><%=sm%></b></td>
                    <td width="300">Academic Year&nbsp;:&nbsp;<b><%=academicYear%></b></td>
                </tr>
                <tr>
                    <%
                    int l=0,res=0,tot=0;
                    while(l<cnt){
                        sql="select Count(*) as res from Count c,students s where s.UID=c.UID AND s.YEAR=c.YEAR AND c.SEMESTER="+sem+" AND c.YEAR="+year+" AND s.SECTION='"+section[l]+"'";
                        rs=st.executeQuery(sql);
                        if(rs.next())
                            res+=rs.getInt("res");
                        sql="select count(*) as strength from students where YEAR="+year+" AND SECTION='"+section[l]+"'";
                        rs=st.executeQuery(sql);
                        if(rs.next())
                            tot+=rs.getInt("strength");
                        l++;
                    }
                    %>
                    <td colspan="2">4.&nbsp;Total Number of responses/Class Strength &nbsp;:&nbsp;<b><%=res%>/<%=tot %></b></td>
                    <td>&nbsp;Section(s):&nbsp;<b><%=sect%></b></td>
                    <td >Date &nbsp;:&nbsp;<b><%=dt%></b></td>
                </tr> 
                <!--tr>
                    <td colspan="4" >
                        <pre style="font-family: 'Times New Roman'">5.&nbsp;Responses Considered        :&nbsp;<b><%=res%></b></pre>
                    </td>
                </tr-->
                <tr>
                    <td colspan="4">
                        5.&nbsp;Average rating on a scale of 4 for the responses considered:
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <table width="800" border="1" cellspacing="0" class="que">
                            <%sql="select count(*) as qu from Questions";
                              rs=st.executeQuery(sql);
                              rs.next();
                              int tq=rs.getInt("qu");
                              float rate[]=new float[tq+1],trate=0,tavg=0,totrate=0,totcount=0,totavg=0;  
                              int dest=4*tq,qloop=1;                              
                              while(qloop<=tq){
                                  int j=0,tcount=0;
                                  while(j<cnt){
                                      sql="select `"+scode+"_C1`,`"+scode+"_C2`,`"+scode+"_C3`,`"+scode+"_C4` from FeedBack_"+dept+"_"+year+"_"+sem+section[j]+" where QID="+qloop; 
                                      rs=st.executeQuery(sql);
                                      if(rs.next()){
                                        int c1=rs.getInt(1);
                                        int c2=rs.getInt(2);
                                        int c3=rs.getInt(3);
                                        int c4=rs.getInt(4);
                                        int r1=c1;
                                        int r2=2*c2;
                                        int r3=3*c3;
                                        int r4=4*c4;
                                        tcount+=c1+c2+c3+c4;
                                        rate[qloop]+=r1+r2+r3+r4;
                                        totrate+=r1+r2+r3+r4;
                                        totcount+=c1+c2+c3+c4;
                                      }
                                      j++;
                                  }
                                  rate[qloop]=(rate[qloop]/tcount);
                                  trate+=rate[qloop];
                                  qloop++;
                              }
                              tavg=trate/tq;
                              totavg=totrate/totcount;
                              //float percent=Math.round((trate/dest)*10000);
                              float percent=Math.round(((totavg*10)/dest)*10000); 
                              percent=percent/100;
                            %>
                            <tr style="background-color: #cccccc" align="center" > 
                                <th>Q.No</th>
                                <th>Question</th>
                                <th>Avg</th>
                                <%if(tq>5){%>
                                    <th>Q.No</th>
                                    <th>Question</th>
                                    <th>Avg</th>
                                <%}%>
                            </b>
                            </tr>
                          <%int loop=1;
                          int sep=(int)Math.ceil((float)tq/2);
                          while(loop<=sep){
                            sql="select QID,Question from Questions where QID="+loop;
                            rs=st.executeQuery(sql);
                            rs.next();
                            %><tr >
                                <td align="center"><%=rs.getInt("QID") %></td>
                                <td ><%=rs.getString("Question") %></td>
                                <td align="left"><!--<b><%--=rate[loop+sep]--%></b-->
                                    <b>
                                        <%int intfrec=(int)(rate[loop]*100);
                                          double doublefrec=(double)intfrec/100;%>
                                        <%if(doublefrec!=0){%>
                                           <%=doublefrec%> 
                                        <%}%>
                                    </b>
                                </td>
                                <%if(tq>5 && tq>=loop+sep){
                                    sql="select QID,Question from Questions where QID="+(loop+sep);
                                    rs=st.executeQuery(sql);
                                    rs.next();
                                %><td align="center"><%=rs.getInt("QID") %></td>
                                <td><%=rs.getString("Question") %></td>
                                <td><!--<b><%=rate[loop+sep]%></b-->
                                    <b>
                                        <%intfrec=(int)(rate[loop+sep]*100); 
                                          doublefrec=(double)intfrec/100;%>
                                          <%if(doublefrec!=0){%>
                                            <%=doublefrec%>
                                          <%}%>
                                    </b>
                                </td>
                                <%}%>
                            </tr>
                            <%loop++;}%>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" valign="bottom">
                        Sum of Average ratings of <b><%=tq%></b> Questions:&nbsp;
                        <b><%if((int)totrate!=0){%>
                                <%=(double)((int)(totavg*10000))/1000%>&nbsp; 
                           <%}
                           else{%>
                              &nbsp;&nbsp;
                           <%}%>
                           /<%=dest%>
                        </b>  =&nbsp;&nbsp;
                                <%if((int)percent!=0){%> 
                                    <b>
                                        <u><%=percent%></u>
                                    </b>
                                <%}%>
                                &nbsp;%
                        <%String result=new String();
                        /*if(tavg<1.5)
                            result="Unsatisfactory";
                        else if(tavg>=1.5 && tavg<2)
                            result="Average";
                        else if(tavg>=2 && tavg<2.5)
                            result="Above Average";
                        else if(tavg>=2.5 && tavg<3)
                            result="Good";
                        else if(tavg>=3 && tavg<3.5)
                            result="Very Good";
                        else if(tavg>=3.5 && tavg<=4)
                            result="Excellent";*/
                        if(totavg<2) 
                            result="Unsatisfactory";
                        else if(totavg>=2 && totavg<3)
                            result="Average/Satisfactory";
                        else if(totavg>=3 && totavg<3.5)
                            result="Good";
                        else if(totavg>=3.5 && totavg<3.9)
                            result="Very Good";
                        else if(totavg>=3.9 && totavg<=4)
                            result="Excellent";
                        %>
                    </td>
                    <td valign="bottom"> 
                      Result:&nbsp;<b><%=result%></b>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center" valign="bottom"><hr style="border-style: dashed" /><!--................................................................................................................................................................--></td>
                </tr>
                <tr>
                    <td colspan="4" align="center" valign="top">
                        <h2 style="display: inline">FOR OFFICE USE ONLY</h2>
                    </td>
                </tr>
                <tr >
                    <td valign="top">
                    Suggestions for improvement:
                    </td>
                    <td colspan="3" valign="middle" style="padding-bottom: 20px">
                        <hr color="black" size="1"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" valign="top" >
                        <hr color="black" size="1"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" valign="top" >
                        <hr color="black" size="1"/>
                    </td>
                </tr>
                <!--<tr>
                    <td colspan="4" valign="top">
                        Suggestions for improvement:_______________________________________________________
                    </td>
                </tr>
                  <tr>
                    <td colspan="4" valign="top">
                        _______________________________________________________________________________
                    </td>
                </tr>
                  <tr>
                    <td colspan="4" valign="top">
                        _______________________________________________________________________________
                    </td>
                </tr>-->
               <!--tr valign="bottom"-->
                <tr valign="top">
                    <td  >HOD</td>
                    <td colspan="2" align="center" >PRINCIPAL</td>
                    <td align="right">DIRECTOR</td>
                </tr>
                <!--tr valign="bottom"-->
                <tr valign="top">
                    <td colspan="3">Signature of Instructor</td>
                    <td  align="center">Date:</td>
                </tr>
            </table>
            </body>
            </html>
        <%}%>          
    <%
    con.close();}
    catch(Exception e){
        out.print("<center>"+e+"</center>");
    }
}
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
                <input type="hidden" name="uaccount" value="Administrator" />
                <button type="submit" class="redbutton">LogIn</button>
            </form>
            </h2>
        </center>
    </noscript>  
<%}%>
    </body>
</html>