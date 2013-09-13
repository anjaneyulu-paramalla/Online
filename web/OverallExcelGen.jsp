<%-- 
    Document   : OverallExcelGen
    Created on : Jul 27, 2012, 10:18:48 PM
    Author     : Anjaneyulu
--%>

<%-- 
    Document   : OverallReportGen
    Created on : Jul 27, 2012, 10:18:29 PM
    Author     : Anjaneyulu
--%>
<%@page import="java.sql.PreparedStatement" errorPage="Error.jsp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="sun.util.calendar.BaseCalendar"%>
<%@page import="sun.util.calendar.BaseCalendar.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){
    String year=request.getParameter("year");
    String sem=request.getParameter("sem");
    String dept=(String)session.getAttribute("DEPT");
    try{
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition","inline;filename="+year+"-"+sem+"_Overall.xls");
        Class.forName("com.mysql.jdbc.Driver");
        String uri="jdbc:mysql://localhost:3306/feedback_"+dept; 
        Connection con=DriverManager.getConnection(uri,"root","GRIETITOLFF1202");
        Statement st=con.createStatement();
        Statement ff=con.createStatement();
        String sql="select SECTIONS from semester where YEAR="+year;
        String ins="insert into Z_intCalc_"+dept+"_"+year+"_"+sem+" values(?,?,?)";
        PreparedStatement pst=con.prepareStatement(ins);
        ResultSet rs=st.executeQuery(sql),irs;
        int sec;
        if(rs.next()){
            sec=rs.getInt("SECTIONS");
            int i=1;
            String sf=new String();
            while(i<=sec){
                char c=(char)(i+64);
                sf="select * from Subjects_"+year+"_"+sem+c;
                rs=st.executeQuery(sf);
                while(rs.next()){
                    pst.setString(1, rs.getString("SCODE"));
                    pst.setString(2, rs.getString("SNAME"));
                    pst.setInt(3, rs.getInt("FID"));
                    pst.addBatch();
                }
                i++;
            }
            try{
                sql="delete from Z_intCalc_"+dept+"_"+year+"_"+sem;
                st.execute(sql);
            }
            catch(Exception r){
                sql="create table Z_intCalc_"+dept+"_"+year+"_"+sem+" (SCODE varchar(20),SNAME text,FID INT)";
                int cr=st.executeUpdate(sql);
            }
            pst.executeBatch();
            sql="select distinct * from Z_intCalc_"+dept+"_"+year+"_"+sem;
            rs=st.executeQuery(sql);
            boolean found=false;
            int count=0,sno=0;
            while(rs.next()){
                if(count==0){
                    found=true; 
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
                    }*/%>
                <table align="center"  cellspacing="0" width="70%" >
                    <tr rowspan="2">
                        <th colspan="5" style="font-size: 20;font-family: 'Times New Roman'">
                            Gokaraju Rangaraju Institute Of Engineering & Technology<br />
                            Summation of Teacher Appraisal by Student
                        </th>
                    </tr>
                    <tr>
                        <td colspan="5" >Course: <b>B.Tech</b></td>
                    </tr>
                    <tr>
                        <td colspan="5" >Branch: <b><%=dept%></b></td>
                    </tr>
                    <tr >
                        <td colspan="2" >Year: <b><%=y%></b></td>
                        <td colspan="3">Date:  <b><%=dt%></b></td>
                    </tr>
                    <tr>
                        <td colspan="2" >Semester: <b><%=sm%></b></td>
                        <td colspan="3">Academic Year:  <b><%=academicYear%></b></td>
                    </tr>
                    <tr />
                    <tr>
                        <th style="background-color: #cccccc">S.No</th>
                        <th style="background-color: #cccccc">Name of the Instructor</th>
                        <th style="background-color: #cccccc">Subject</th>
                        <th style="background-color: #cccccc">Rating</th>
                        <th style="background-color: #cccccc">Result</th>
                    </tr>
                    <%count++;
                }
                String section[]=new String[5]; 
                int cnt=0,fid=rs.getInt("FID");
                i=1;
                String scode=rs.getString("SCODE"),sname=rs.getString("SNAME"),fname="";
                while(i<=sec){
                    char c=(char)(i+64);
                    sql="select SCODE from Subjects_"+year+"_"+sem+c+" where SCODE='"+scode+"' and FID="+fid ;
                    irs=ff.executeQuery(sql);
                    while(irs.next()){
                        section[cnt]=""+c;
                        cnt++;
                    }
                    i++;
                }
                i=0;
                float trate=0,tcount=0,tavg=0;
                while(i<cnt){
                    sql=""+"select sum(`"+scode+"_C1`) as c1,sum(`"+scode+"_C2`) as c2,sum(`"+scode+"_C3`) as c3,sum(`"+scode+"_C4`) as c4 from FeedBack_"+dept+"_"+year+"_"+sem+section[i]; 
                    irs=ff.executeQuery(sql);
                    if(irs.next()){
                        int c1=irs.getInt("c1");
                        int c2=irs.getInt("c2");
                        int c3=irs.getInt("c3");
                        int c4=irs.getInt("c4");
                        trate+=c1+2*c2+3*c3+4*c4;
                        tcount+=c1+c2+c3+c4;                              
                    }
                    i++;
                }
                tavg=trate/tcount; 
                sql=""+"select FNAME from Faculty where FID="+fid;
                irs=ff.executeQuery(sql);
                if(irs.next())
                    fname=irs.getString("FNAME");
                %> 
                <tr>
                    <td align="center">
                        <%=++sno%> 
                    </td>
                    <td>
                        <%=fname%>
                    </td>
                    <td>
                        <%=sname%>
                    </td>
                    <td>
                        <b><!--<%=tavg%>-->
                            <%int intfrec=(int)(tavg*100);
                            double doublefrec=(double)intfrec/100;%>
                            <%if(doublefrec!=0){%>
                                <%=doublefrec%>
                            <%}%>
                        </b>
                    </td>
                    <td>
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
                        /*if(tavg<2) 
                            result="Unsatisfactory";
                        else if(tavg>=2 && tavg<3)
                            result="Average";
                        else if(tavg>=3 && tavg<3.5)
                            result="Good";
                        else if(tavg>=3.5 && tavg<=4)
                            result="Excellent";*/
                        if(tavg<2) 
                            result="Unsatisfactory";
                        else if(tavg>=2 && tavg<3)
                            result="Average/Satisfactory";
                        else if(tavg>=3 && tavg<3.5)
                            result="Good";
                        else if(tavg>=3.5 && tavg<3.9)
                            result="Very Good";
                        else if(tavg>=3.9 && tavg<=4)
                            result="Excellent";
                        %>
                        <%=result%>
                    </td>
                </tr>
            <%}
            if(found){%>
                    <tr style="height: 8mm" />
                    <tr />
                    <tr style="font-size: 20">
                        <td colspan="2" align="center">
                            HOD
                        </td>
                        <td  align="left">
                            PRINCIPAL
                        </td>
                        <td colspan="2" align="center">
                            DIRECTOR
                        </td>
                    </tr>
                </table>
            <%}
            else{%>
                <center><h2>No Subjects Found!</h2></center> 
            <%}
        }
        else{%>
            <center><h2>No data found with the given year!</h2></center>  
        <%}
        con.close();
    }
    catch(Exception e){
        out.println(e);
    }
}
else{%>
    <%--<jsp:forward page="./" />--%>
    <!DOCTYPE Excel>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
        <link rel="stylesheet" href="CSS/redun.css" />
    </head>
    <body>
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
    </body>
</html>
<%}%>