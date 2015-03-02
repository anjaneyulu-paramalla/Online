<%-- 
    Document   : ExcelGen
    Created on : Jul 16, 2012, 3:16:52 PM
    Author     : Anjaneyulu
--%>
<%@page import="org.data.connection.Connector"%>
<%@page import="java.text.SimpleDateFormat" errorPage="Error.jsp"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){ 
    try{
        response.setContentType("application/vnd.ms-excel");
        //response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        String dept=(String)session.getAttribute("DEPT"); 
        String year=request.getParameter("year");
        String sem=request.getParameter("sem");
        String scode=request.getParameter("scode");
        int fid=Integer.parseInt(request.getParameter("fid"));
        Connection con=new Connector(dept).getConnection();
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
            sql="Select s.SNAME ,f.FNAME from Subjects_"+year+"_"+sem+section[0]+" s,Faculty f where s.fid=f.fid and (s.scode='"+scode+"' and f.fid="+fid+")";
            rs=st.executeQuery(sql);
            rs.next();
            String fname=""+rs.getString("FNAME");
            String filename=""+year+"-"+sem+"_"+scode+"-"+fname;
            String sb=rs.getString("SNAME");
            int l=0,res=0,tot=0;
            String sect=new String();
            while(l<cnt){
                sql="select Count(*) as res from count c,students s where s.UID=c.UID AND s.YEAR=c.YEAR AND c.SEMESTER="+sem+" AND c.YEAR="+year+" AND s.SECTION='"+section[l]+"'";
                rs=st.executeQuery(sql);
                rs.next();
                res+=rs.getInt("res");
                sql="select count(*) as strength from students where YEAR="+year+" AND SECTION='"+section[l]+"'"; 
                rs=st.executeQuery(sql);
                rs.next();
                tot+=rs.getInt("strength");
                if(l==0)
                    sect=section[l];
                else
                    sect+=","+section[l];
                l++;
            }
            sql="select count(*) as qu from Questions";
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
                        int c1=rs.getInt(scode+"_C1");
                        int c2=rs.getInt(scode+"_C2");
                        int c3=rs.getInt(scode+"_C3");
                        int c4=rs.getInt(scode+"_C4");
                        int r1=c1;
                        int r2=2*c2;
                        int r3=3*c3;
                        int r4=4*c4;
                        //tcount+=c1+c2+c3+c4;
                        //rate[qloop]+=r1+r2+r3+r4;
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
            String result=new String();
            /*if(tavg>=1&&tavg<1.5)
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
            response.setHeader("Content-Disposition","attachment;filename="+filename +".xls"); 
            PrintWriter pw=response.getWriter();
            pw.println("Faculty Name:  "+fname); 
            pw.println("Suject:   "+sb+"\t\t\t\t   Section(s):   "+sect);
            pw.println("Year:   "+y+"\t\t\tDate: "+dt);
            pw.println("Semester:   "+sm+"\t\t\tAcademic Year:  "+academicYear);
            pw.println("No. of Response:   "+res);
            pw.println("Total Strength:    "+tot);
            pw.println("");
            pw.println("Q.No"+"\tQuestion"+"\t\t\t\t\t\t\t"+"Avg");
            int loop=1;
            while(loop<=tq){
                sql="select QID,Question from Questions where QID="+loop;
                rs=st.executeQuery(sql);
                if(rs.next()){
                    int intfrec=(int)(rate[loop]*100);
                    double doublefrec=(double)intfrec/100;%>
                    <%if(doublefrec!=0){
                        pw.println(rs.getInt("QID")+"\t"+rs.getString("Question")+"\t\t\t\t\t\t\t"+doublefrec); 
                    }
                    else
                        pw.println(rs.getInt("QID")+"\t"+rs.getString("Question"));
                }
                loop++;
            }
            pw.println();
            if((int)tavg!=0){ 
                //pw.println("Total Average :"+(double)((int)(tavg*1000))/1000);
                pw.println("Total Average :"+(double)((int)(totavg*10000))/1000);
            }
            else{
                pw.println("Total Average :");
            }
            if((int)percent!=0){ 
                pw.println("Percentage :"+percent+" %");
            }
            else
                pw.println("Percentage :  %");
            pw.println("Result :"+result);
        } 
        con.close();
  }
  catch(Exception e){
        out.println(e);
  }
}
 else{%>
    <%--<jsp:forward page="./" />--%>
    <!DOCTYPE html>
    <html>
    <head>
        <title>::GRIET</title>
        <!--link rel="stylesheet" href="CSS/redun.css" /-->
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
                <button type="submit" >LogIn</button>
            </form>
            </h2>
        </center>
    </noscript>  
    </body>
    </html>
 <%}%>
