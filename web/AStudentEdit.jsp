<%-- 
    Document   : AStudentEdit
    Created on : Feb 26, 2013, 6:35:59 AM
    Author     : Anji
--%>

<%@page import="javax.swing.text.AbstractDocument.BranchElement" errorPage="Error.jsp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
            String section=request.getParameter("section");
            String option=request.getParameter("edit"+section);%>
            <h3><center><u><%=option.substring(0, 1).toUpperCase()+option.substring(1,option.length()).toLowerCase() %> <%=Ryear%> year <%=section%> section student data</u>:</center></h3>
            <%if(request.getParameter("status")==null){
                 if(option.toLowerCase().equals("update")){
                     int count=Integer.parseInt(request.getParameter("count"));%>
                     <form action="#" method="post">
                         <input type="hidden" name="status" value="step" />
                         <%int i=1,ns=0;
                         String stid[]=new String[count]; 
                         while(i<=count){
                             if(request.getParameter("check"+i)!=null){
                                 stid[ns]=request.getParameter("check"+i);
                                 ns++;
                             }
                             i++;
                         }
                         if(ns==0){%>
                            <form>
                            <center>
                                <h4>Sorry,you didn't select any student to update!</h4>
                                <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /> 
                            </center>
                            </form>
                         <%}
                         else{
                             Class.forName("com.mysql.jdbc.Driver");
                             String url="jdbc:mysql://localhost:3306/feedback_"+dept;
                             Connection con=DriverManager.getConnection(url,"root","GRIETITOLFF1202");
                             Statement st=con.createStatement();
                             String sql="select UID,UNAME,SECTION,EMAILID,MOBILE from students where ";
                             i=0;
                             while(i<ns){
                                 if(i==0)
                                    sql+="UID='"+stid[i]+"'";
                                 else
                                     sql+="OR UID='"+stid[i]+"'";
                                 if(i==ns-1)
                                     sql+=" order by UID";
                                 i++;
                             }
                             ResultSet rs=st.executeQuery(sql);
                             if(rs.next()){
                                 int sno=1;
                                 String sid=rs.getString("UID");
                                 String sname=rs.getString("UNAME");
                                 String sect=rs.getString("SECTION");
                                 String semail=rs.getString("EMAILID");
                                 String smobile=rs.getString("MOBILE");%>
                                 <table align="center" border="3" cellspacing="0" >
                                     <tr style="background-color: #9999ff">
                                        <th>Sno</th>
                                        <th>SID</th>
                                        <th>Name</th>
                                        <th>Section</th>
                                        <th>EmailId</th>
                                        <th>MobileNo</th>
                                    </tr>
                                    <tr>
                                        <input type="hidden" name="uid<%=sno%>" value="<%=sid%>" />
                                        <td align="center"><%=sno%></td> 
                                        <td><input type="text" name="sid<%=sno%>" value="<%=sid%>" size="15"/></td>
                                        <td><input type="text" name="sname<%=sno%>" value="<%=sname%>" size="30" /></td>
                                        <td><input type="text" name="sect<%=sno%>" value="<%=sect%>" size="2" /></td>
                                        <td><input type="text" name="semail<%=sno%>" value="<%=semail%>" size="30"/></td>
                                        <td><input type="text" name="smobile<%=sno++%>" value="<%=smobile%>" size="15"/></td>
                                    </tr>
                                    <%
                                    while(rs.next()){
                                        sid=rs.getString("UID");
                                        sname=rs.getString("UNAME");
                                        sect=rs.getString("SECTION");
                                        semail=rs.getString("EMAILID");
                                        smobile=rs.getString("MOBILE");%>
                                        <tr>
                                            <input type="hidden" name="uid<%=sno%>" value="<%=sid%>" />
                                            <td align="center"><%=sno%></td> 
                                            <td><input type="text" name="sid<%=sno%>" value="<%=sid%>" size="15"/></td>
                                            <td><input type="text" name="sname<%=sno%>" value="<%=sname%>" size="30" /></td>
                                            <td><input type="text" name="sect<%=sno%>" value="<%=sect%>" size="2" /></td>
                                            <td><input type="text" name="semail<%=sno%>" value="<%=semail%>" size="30"/></td>
                                            <td><input type="text" name="smobile<%=sno++%>" value="<%=smobile%>" size="15"/></td>
                                        </tr>
                                    <%}%>
                                 </table>
                                 <center>
                                   <b><table>
                                        <tr>
                                            <td><span style="color: red" rowspan="2">Note:</span></td>
                                            <td>1.SID,Name,Section,EmailId are mandatory fields.</td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>2.if email id is not in proper format then the corresponding student details will not be updated!</td>
                                        </tr>
                                   </table></b><br />
                                   <input type="hidden" name="count" value="<%=sno-1%>" />
                                   <input type="hidden" name="edit<%=section%>" value="<%=option%>" />
                                   <input type="hidden" name="year" value="<%=year%>" />
                                   <input type="hidden" name="section" value="<%=section%>" />
                                   <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                   <input type="submit" value="Update"  class="redbutton" style="width: 120px;margin-left: 10px" />
                                </center>
                             <%}
                             else{%>
                                <form>
                                    <center>
                                    <h4>Details not found!</h4>
                                    <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /> 
                                    </center>
                                </form>
                             <%}
                             st.close();
                             con.close();
                         }%>
                     </form>
                 <%}
                 else if(option.toLowerCase().equals("delete")){%>
                     <form action="#" method="post">
                         <input type="hidden" name="status" value="step" />
                         <input type="hidden" name="year" value="<%=year%>" />
                         <input type="hidden" name="section" value="<%=section%>" />
                         <input type="hidden" name="edit<%=section%>" value="<%=option%>" />
                     <%int count=Integer.parseInt(request.getParameter("count"));
                     int i=1,ns=0;
                     String stud[]=new String[count];
                     while(i<=count){
                         if(request.getParameter("check"+i)!=null){
                             stud[ns]=request.getParameter("check"+i);
                             ns++;
                         }
                         i++;
                     }
                     if(ns==0){%>
                         <form>
                         <center>
                            <h4>Sorry,you didn't select any student to delete!</h4>
                            <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /> 
                         </center>
                         </form>
                     <%}
                     else{
                         Class.forName("com.mysql.jdbc.Driver");
                         String url="jdbc:mysql://localhost:3306/feedback_"+dept;
                         Connection con=DriverManager.getConnection(url,"root","GRIETITOLFF1202");
                         Statement st=con.createStatement();
                         i=0;
                         String dsql="";
                         while(i<ns){%>
                            <input type="hidden" name="sid<%=i+1%>" value="<%=stud[i]%>" />
                             <%if(i==0)
                                 dsql="select YEAR,SEMESTER from count where UID='"+stud[i]+"'";
                             else
                                 dsql+=" OR UID='"+stud[i]+"'";
                             if(i==ns-1)
                                 dsql+=" group by YEAR,SEMESTER order by YEAR,SEMESTER";
                             i++;
                         }
                         i=1;
                         ResultSet rs=st.executeQuery(dsql);
                         if(rs.next()){
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
                                     On deleting the selected <%=ns%> student(s), feedback for the following semesters of <%=section%> section will be restarted freshly.
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
                                     would you like to continue?<br /><br />
                                     <input type="hidden" name="fycount" value="<%=i-1%>" />
                                     <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                 <input type="submit" value="Yes"  class="redbutton" style="margin-left: 10px" />
                                </h4>
                             </center>
                         <%}
                         else{%>
                            <center><h4>Deleting <%=ns%> student(s).<br />Are you sure?<br /><br />
                                 <input type="hidden" name="found" value="false" />
                                 <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                 <input type="submit" value="Yes"  class="redbutton" style="margin-left: 10px" />
                            </h4></center>
                         <%}
                         //out.print(dsql);
                     }%>
                     <input type="hidden" name="count" value="<%=ns%>" />
                     </form>
                 <%}
                 else if(option.toLowerCase().equals("move")){
                    int count=Integer.parseInt(request.getParameter("count"));%>
                    <form action="#" method="post">
                    <%int i=1,ns=0;
                    boolean selected=false;
                    while(i<=count){
                        String s=request.getParameter("check"+i);
                        if(s!=null){
                            ns++;
                            if(!selected){
                                selected=true;
                            }%>
                            <input type="hidden" name="check<%=i%>" value="<%=s%>" />
                        <%}
                        i++;
                    }
                    if(selected){%>
                        <center><h4>Move <%=ns%> selected students to year:
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
                            <input type="hidden" name="count" value="<%=count%>" />
                            <input type="hidden" name="status" value="step" />
                            <input type="hidden" name="edit<%=section%>" value="<%=option%>" />
                            <input type="hidden" name="year" value="<%=year%>" />
                            <input type="hidden" name="section" value="<%=section%>" />
                            <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                            <input type="submit" value="Continue" class="redbutton" style="width: 120px;margin-left: 10px" />
                        </center></h3>
                    <%}
                    else{%>
                        <form>
                            <center>
                                <h4>No student selected!</h4>
                                <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /> 
                            </center>
                        </form>
                    <%}%>
                    </form>
                <%}  
            }
            else if(request.getParameter("status").equals("step")){
                if(option.toLowerCase().equals("update")){
                     //update
                    Class.forName("com.mysql.jdbc.Driver");
                    String url="jdbc:mysql://localhost:3306/feedback_"+dept;
                    Connection con=DriverManager.getConnection(url,"root","GRIETITOLFF1202");
                    Statement st=con.createStatement();
                    if(request.getParameter("ustat")==null){%>
                        <form action="#" method="post">
                            <input type="hidden" name="status" value="step" />
                            <input type="hidden" name="ustat" value="step2" />
                        <%int rows=Integer.parseInt(request.getParameter("count"));
                        int i=1,uscount=1; 
                        boolean flag=false,csn=false; 
                        String sql="",chsql="";
                        while(i<=rows){
                            String uid=request.getParameter("uid"+i);
                            String sid=request.getParameter("sid"+i).trim();
                            String sname=request.getParameter("sname"+i).trim();
                            String sect=request.getParameter("sect"+i).toUpperCase().trim();
                            String semail=request.getParameter("semail"+i).trim();
                            String smobile=request.getParameter("smobile"+i).trim();
                            if(sid.equals("")||sname.equals("")||sect.equals("")||semail.equals("")){
                                i++;
                                continue;
                            } 
                            if(semail.contains("@")){
                                int mlen=semail.length();
                                int alen=semail.lastIndexOf("@")+1;
                                String domain=semail.substring(alen,mlen);
                                int dlen=mlen-alen; 
                                int ulen=mlen-(dlen+1);
                                if(dlen<6 || ulen<4){
                                    i++;
                                    continue;
                                }
                            }
                            else{
                                i++;
                                continue;
                            }%>
                            <input type="hidden" name="uid<%=uscount%>" value="<%=uid%>" />
                            <input type="hidden" name="sid<%=uscount%>" value="<%=sid%>" />
                            <input type="hidden" name="sname<%=uscount%>" value="<%=sname%>" />
                            <input type="hidden" name="sect<%=uscount%>" value="<%=sect%>" />
                            <input type="hidden" name="semail<%=uscount%>" value="<%=semail%>" />
                            <input type="hidden" name="smobile<%=uscount++%>" value="<%=smobile%>" />
                            <%
                            if(!section.toLowerCase().equals(sect.toLowerCase())){
                                if(!csn){
                                    chsql="select YEAR,SEMESTER from count where UID='"+uid+"'";
                                    csn=true;
                                }
                                else{
                                    chsql+=" OR UID='"+uid+"'"; 
                                }
                            }
                            sql="update students set UID='"+sid+"',UNAME='"+sname+"',SECTION='"+sect+"',EMAILID='"+semail+"',MOBILE='"+smobile+"' where UID='"+uid+"'";
                            st.addBatch(sql);
                            i++;
                        }
                        if(!csn){
                            if(sql.equals("")){%>
                                <center>
                                    <h3 style="display: inline">No records to update! </h3><br /><br /> 
                                    <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                </center>
                                </form>
                            <%}
                            else{
                                int rs[]=st.executeBatch(); 
                                int j=0,rslen=0; 
                                while(j<rs.length){
                                    rslen+=rs[j]; 
                                    j++;
                                }%>
                                <center>
                                    <h3><%=rslen%> record(s) updated successfully!</h3>
                                </center>
                                </form>
                                <center>
                                    <form action="Settings.jsp">
                                        <button type="submit" class="redbutton" style="width: 200px">Go to Home Page</button>
                                    </form>
                                </center>
                            <%}
                        }
                        else{
                            chsql+=" group by YEAR,SEMESTER order by YEAR,SEMESTER";
                            //out.print(chsql);
                            ResultSet rs=st.executeQuery(chsql);
                            i=1;
                            if(rs.next()){
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
                                        On updating the selected <%=rows%> student(s), feedback for the following semesters of <%=section%> section will be restarted freshly.
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
                                        would you like to continue?<br /><br />
                                        <input type="hidden" name="fycount" value="<%=i-1%>" />
                                        <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                        <input type="submit" value="Yes"  class="redbutton" style="margin-left: 10px" />
                                    </h4>
                                </center>
                                <input type="hidden" name="count" value="<%=uscount-1%>" />
                                <input type="hidden" name="edit<%=section%>" value="<%=option%>" />
                                <input type="hidden" name="year" value="<%=year%>" />
                                <input type="hidden" name="section" value="<%=section%>" />
                                </form> 
                            <%}
                            else{
                                if(sql.equals("")){%>
                                    <center>
                                        <h3 style="display: inline">No records to update! </h3><br /><br /> 
                                        <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                    </center>
                                    </form>
                                <%}
                                else{
                                    int rl[]=st.executeBatch(); 
                                    int j=0,rslen=0; 
                                    while(j<rl.length){
                                        rslen+=rl[j]; 
                                        j++;
                                    }%>
                                    <center>
                                        <h3><%=rslen%> record(s) updated successfully!</h3>
                                    </center>
                                    </form>
                                    <center>
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
                    else if(request.getParameter("ustat").equals("step2")){
                        if(request.getParameter("found")!=null){
                            int rows=Integer.parseInt(request.getParameter("count"));
                            int fyc=Integer.parseInt(request.getParameter("fycount"));  
                            int i=1;
                            boolean came=false;
                            int delfeedyear[]=new int[fyc], delfeedsem[]=new int[fyc];
                            String cdel=""; 
                            while(i<=fyc){
                                if(request.getParameter("fyear"+i)!=null && request.getParameter("fsem"+i)!=null){
                                    delfeedyear[i-1]=Integer.parseInt(request.getParameter("fyear"+i));
                                    delfeedsem[i-1]=Integer.parseInt(request.getParameter("fsem"+i));
                                    if(i==1)
                                        cdel="delete from count where UID IN (select UID from students where SECTION='"+section+"' AND (YEAR="+request.getParameter("fyear"+i)+"";
                                    else
                                        cdel+=" OR YEAR="+request.getParameter("fyear"+i)+"";
                                    if(!came){
                                        came=true;
                                    }
                                    /*if(i==1)
                                        cdel="delete from count where (YEAR="+request.getParameter("fyear"+i)+" AND SEMESTER="+request.getParameter("fsem"+i)+")";
                                    else
                                        cdel+=" OR (YEAR="+request.getParameter("fyear"+i)+" AND SEMESTER="+request.getParameter("fsem"+i)+")";*/
                                }
                                i++;
                            }
                            if(came){
                                cdel+="))";
                                st.addBatch(cdel);
                                //out.print(cdel);
                            }
                            String sql="";
                            i=1;
                            while(i<=rows){
                                String uid=request.getParameter("uid"+i);
                                String sid=request.getParameter("sid"+i).trim();
                                String sname=request.getParameter("sname"+i).trim();
                                String sect=request.getParameter("sect"+i).toUpperCase().trim();
                                String semail=request.getParameter("semail"+i).trim();
                                String smobile=request.getParameter("smobile"+i).trim();
                                if(sid.equals("")||sname.equals("")||sect.equals("")||semail.equals("")){
                                    i++;
                                    continue;
                                } 
                                if(semail.contains("@")){
                                    int mlen=semail.length();
                                    int alen=semail.lastIndexOf("@")+1;
                                    String domain=semail.substring(alen,mlen);
                                    int dlen=mlen-alen; 
                                    int ulen=mlen-(dlen+1);
                                    if(dlen<6 || ulen<4){
                                        i++;
                                        continue;
                                    }
                                }
                                else{
                                    i++;
                                    continue;
                                }
                                sql="update students set UID='"+sid+"',UNAME='"+sname+"',SECTION='"+sect+"',EMAILID='"+semail+"',MOBILE='"+smobile+"' where UID='"+uid+"'";
                                //out.print(sql);
                                st.addBatch(sql);
                                i++;
                                //out.print("came"); 
                            }
                            if(sql.equals("")){%>
                                <center>
                                    <h3 style="display: inline">No records to update! </h3><br /><br /> 
                                    <form>
                                    <input type="button" value="Back" class="redbutton" onclick="history.go(-2)" />
                                    </form>
                                </center>
                            <%}
                            else{
                                int rs[]=st.executeBatch(); 
                                int j=1,rslen=0; 
                                while(j<rs.length){ 
                                    rslen+=rs[j]; 
                                    j++;
                                }
                                i=1;
                                while(i<=fyc){
                                    try{
                                        st.executeUpdate("delete from feedback_"+dept+"_"+delfeedyear[i-1]+"_"+delfeedsem[i-1]+section);
                                    } 
                                    catch(Exception e){
                                        //do not print
                                    }
                                    i++;
                                }%>
                                <center>
                                    <h3><%=rslen%> record(s) updated successfully!</h3>
                                </center>
                                <center>
                                    <form action="Settings.jsp">
                                        <button type="submit" class="redbutton" style="width: 200px">Go to Home Page</button>
                                    </form>
                                </center>
                            <%}
                        }
                    }
                 }
                 else if(option.toLowerCase().equals("delete")){
                     //delete
                     if(request.getParameter("status")!=null){
                        int count=Integer.parseInt(request.getParameter("count"));
                        if(request.getParameter("found")!=null){
                            Class.forName("com.mysql.jdbc.Driver");
                            String url="jdbc:mysql://localhost:3306/feedback_"+dept;
                            Connection con=DriverManager.getConnection(url,"root","GRIETITOLFF1202");
                            Statement st=con.createStatement();
                            Statement cl=con.createStatement();
                            String sql="";
                            int i=1;
                            while(i<=count){
                                if(request.getParameter("sid"+i)!=null){
                                    if(i==1){
                                        sql="delete from students where UID='"+request.getParameter("sid"+i)+"'";
                                    }
                                    else{
                                        sql+=" OR UID='"+request.getParameter("sid"+i)+"'";
                                    }
                                }
                                i++;
                            }
                            if(request.getParameter("found").equals("true")){
                                int fyc=Integer.parseInt(request.getParameter("fycount"));
                                i=1;
                                int delfeedyear[]=new int[fyc], delfeedsem[]=new int[fyc];
                                String cdel=""; 
                                boolean came=false;
                                while(i<=fyc){
                                    if(request.getParameter("fyear"+i)!=null && request.getParameter("fsem"+i)!=null){
                                        delfeedyear[i-1]=Integer.parseInt(request.getParameter("fyear"+i));
                                        delfeedsem[i-1]=Integer.parseInt(request.getParameter("fsem"+i));
                                        if(i==1)
                                            cdel="delete from count where UID IN (select UID from students where SECTION='"+section+"' AND (YEAR="+request.getParameter("fyear"+i)+"";
                                        else
                                            cdel+=" OR YEAR="+request.getParameter("fyear"+i)+"";
                                        if(!came){
                                            came=true;
                                        }
                                        /*if(i==1)
                                            cdel="delete from count where (YEAR="+request.getParameter("fyear"+i)+" AND SEMESTER="+request.getParameter("fsem"+i)+")";
                                        else
                                            cdel+=" OR (YEAR="+request.getParameter("fyear"+i)+" AND SEMESTER="+request.getParameter("fsem"+i)+")";*/
                                    }
                                    i++;
                                }
                                if(came){
                                    cdel+="))"; 
                                }
                                st.addBatch(cdel);
                                st.addBatch(sql);
                                i=1;
                                while(i<=fyc){
                                    try{
                                        cl.executeUpdate("delete from feedback_"+dept+"_"+delfeedyear[i-1]+"_"+delfeedsem[i-1]+section);
                                    } 
                                    catch(Exception e){
                                        //do not print
                                    }
                                    /*int j=1;
                                    while(j<=4){
                                        char c=(char)(64+j);
                                        try{
                                            cl.executeUpdate("delete from feedback_"+dept+"_"+delfeedyear[i-1]+"_"+delfeedsem[i-1]+c);
                                        }
                                        catch(Exception e){
                                            //do not print
                                        }
                                        j++; 
                                    }*/
                                    i++;
                                }
                                int rdel[]=st.executeBatch();%>
                                <center>
                                    <h3><%=rdel[1]%> record(s) deleted successfully!</h3>
                                    <form action="Settings.jsp">
                                        <button type="submit" class="redbutton" style="width: 200px">Go to Home Page</button>
                                    </form>
                                </center>
                            <%}
                            else{
                                int rdel=st.executeUpdate(sql);%>
                                <center>
                                    <h3><%=rdel%> record(s) deleted successfully!</h3>
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
                else if(option.toLowerCase().equals("move")){
                    Class.forName("com.mysql.jdbc.Driver");
                    String url="jdbc:mysql://localhost:3306/feedback_"+dept;
                    Connection con=DriverManager.getConnection(url,"root","GRIETITOLFF1202");
                    Statement st=con.createStatement();
                    if(request.getParameter("mstatus")==null){
                        String my=request.getParameter("myear");
                        int count=Integer.parseInt(request.getParameter("count"));
                        int myear;
                        String cdel=""; 
                        if(my.equals("I"))
                            myear=1;
                        else if(my.equals("II"))
                            myear=2;
                        else if(my.equals("III"))
                            myear=3;
                        else
                            myear=4;%>
                        <center>
                        <form action="#" method="post">
                            <%int i=1,ns=0;
                            while(i<=count){
                                String s=request.getParameter("check"+i);
                                if(s!=null){
                                    ns++;
                                    if(ns==1){
                                        cdel="select YEAR,SEMESTER from count where UID='"+s+"'"; 
                                    }
                                    else{
                                        cdel+=" OR UID='"+s+"'";
                                    }%>
                                    <input type="hidden" name="check<%=ns%>" value="<%=s%>" />
                                <%}
                                i++;
                            }
                            if(!cdel.equals("")){
                                ResultSet rs=st.executeQuery(cdel);
                                if(rs.next()){
                                    i=1;
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
                                    <input type="hidden" name="status" value="step" />
                                    <input type="hidden" name="edit<%=section%>" value="<%=option%>" />
                                    <input type="hidden" name="year" value="<%=year%>" />
                                    <input type="hidden" name="section" value="<%=section%>" />
                                    <input type="hidden" name="myear" value="<%=myear%>" />
                                    <input type="hidden" name="mstatus" value="step" />
                                    <input type="hidden" name="found" value="true" />
                                    <input type="hidden" name="fyear<%=i%>" value="<%=roy%>" />
                                    <input type="hidden" name="fsem<%=i++%>" value="<%=ros%>" />
                                    <center><h4>
                                            On moving <%=Ryear%> year students to <%=my%> year ,feedback for the following semester(s) of <%=section%> section  will be restarted freshly.
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
                                        <input type="hidden" name="count" value="<%=ns%>" />
                                        <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                        <input type="submit" value="Yes"  class="redbutton" style="margin-left: 10px" />
                                    </h4></center>
                                    </form>
                                <%}
                                else{%>
                                    <h4>
                                        Moving <%=ns%> <%=Ryear%> year student data to <%=my%> year!<br />
                                        Are you sure?
                                    </h4>
                                    <input type="hidden" name="found" value="false" />
                                    <input type="hidden" name="status" value="step" />
                                    <input type="hidden" name="mstatus" value="step" />
                                    <input type="hidden" name="count" value="<%=ns%>" />
                                    <input type="hidden" name="edit<%=section%>" value="<%=option%>" />
                                    <input type="hidden" name="year" value="<%=year%>" />
                                    <input type="hidden" name="myear" value="<%=myear%>" />
                                    <input type="hidden" name="section" value="<%=section%>" />
                                    <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                                    <input type="submit" value="Yes" class="redbutton" style="margin-left: 10px" />
                                </form>
                                </center>
                                <%}
                            } 
                            else{%>
                                <h4>
                                    Moving <%=ns%> <%=Ryear%> year student data to <%=my%> year!<br />  
                                    Are you sure?
                                </h4>
                                <input type="hidden" name="found" value="false" />
                                <input type="hidden" name="status" value="step" />
                                <input type="hidden" name="mstatus" value="step" />
                                <input type="hidden" name="count" value="<%=ns%>" />
                                <input type="hidden" name="edit<%=section%>" value="<%=option%>" />
                                <input type="hidden" name="year" value="<%=year%>" />
                                <input type="hidden" name="myear" value="<%=myear%>" />
                                <input type="hidden" name="section" value="<%=section%>" />
                                <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                                <input type="submit" value="Yes" class="redbutton" style="margin-left: 10px" />
                            </form>
                            </center>
                           <%}
                            st.close();
                            con.close();
                    }
                    else{
                        if(request.getParameter("found").equals("true")){
                            int count=Integer.parseInt(request.getParameter("count"));
                            int fycount=Integer.parseInt(request.getParameter("fycount"));
                            int myear=Integer.parseInt(request.getParameter("myear"));
                            int i=1,fyc=0;
                            boolean came=false;
                            String sql="";
                            int fyear[]=new int[fycount],fsem[]=new int[fycount];
                            while(i<=fycount){
                                if(request.getParameter("fyear"+i)!=null && request.getParameter("fsem"+i)!=null){
                                    came=true;
                                    fyear[fyc]=Integer.parseInt(request.getParameter("fyear"+i));
                                    fsem[fyc]=Integer.parseInt(request.getParameter("fsem"+i));
                                    if(fyc==0) 
                                        sql="delete from count where UID IN (select UID from students where SECTION='"+section+"') AND ((YEAR="+fyear[fyc]+" AND SEMESTER="+fsem[fyc]+")";
                                    else
                                        sql+=" OR (YEAR="+fyear[fyc]+" AND SEMESTER="+fsem[fyc]+")";
                                    fyc++;
                                }
                                i++;
                            }
                            if(came)
                                sql+=")";
                            st.addBatch(sql);
                            i=1;
                            while(i<=count){
                                if(request.getParameter("check"+i)!=null){
                                    sql="update students set YEAR="+myear+" where UID='"+request.getParameter("check"+i)+"'";
                                    st.addBatch(sql);
                                    //out.print(sql);
                                }
                                i++;
                            }
                            int rs[]=st.executeBatch(); 
                            int j=1,rslen=0; 
                            while(j<rs.length){ 
                                rslen+=rs[j]; 
                                j++;
                            }
                            i=0;
                            while(i<fyc){
                                try{
                                    st.executeUpdate("delete from feedback_"+dept+"_"+fyear[i]+"_"+fsem[i]+section);
                                }
                                catch(Exception e){
                                    //do not print
                                }
                                i++;
                            }%>
                            <center>
                                <h3><%=rslen%> record(s) moved successfully!</h3>
                            </center>
                            <center>
                                <form action="Settings.jsp">
                                    <button type="submit" class="redbutton" style="width: 200px">Go to Home Page</button>
                                </form>
                            </center>
                        <%}
                        else{
                            int myear=Integer.parseInt(request.getParameter("myear"));
                            int count=Integer.parseInt(request.getParameter("count"));
                            String MYEAR;
                            if(myear==1)
                                MYEAR="I";
                            else if(myear==2)
                                MYEAR="II";
                            else if(myear==3)
                                MYEAR="III";
                            else
                                MYEAR="IV";
                            String sql="";
                            int i=1;
                            boolean first=false;
                            while(i<=count){
                                String s=request.getParameter("check"+i);
                                if(s!=null){
                                    if(!first){
                                        sql="update students set year="+myear+" where UID='"+s+"'";
                                        first=true;
                                    }
                                    else
                                        sql+="OR uid='"+s+"'";
                                }
                                i++;
                            }
                            if(sql.equals("")){%>
                                <center>
                                    <h4>No student selected!</h4>
                                    <form action="AStudentList.jsp" method="post">
                                        <input type="hidden" name="year" value="<%=year%>" />
                                        <input type="hidden" name="status" value="step2" />
                                        <input type="submit" value="Back" class="redbutton" />
                                    </form>
                                </center>
                            <%}
                            else{
                                int rs=st.executeUpdate(sql);
                                /* int j=0,rslen=0; 
                                while(j<rs.length){
                                    rslen+=rs[j]; 
                                    j++;
                                }*/%>
                                <center>
                                    <h4>Successfully moved  <%=rs%> <%=Ryear%> year student(s) to <%=MYEAR%> year!</h4>
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
