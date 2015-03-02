<%-- 
    Document   : ANewFeed
    Created on : Jul 25, 2012, 3:54:04 PM
    Author     : Anjaneyulu
--%>

<%@page import="org.data.connection.Connector"%>
<%@page import="javax.print.attribute.standard.MediaSize.Other" errorPage="Error.jsp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
        <link rel="stylesheet" href="CSS/redun.css" /> 
        <link rel="stylesheet" href="CSS/ChangeButton.css" /> 
    </head>
    <body>
<%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){
    String dept=(String)session.getAttribute("DEPT");
    String status=request.getParameter("status");
    out.println("<br />");
    if(status==null){%>
    <center><h3>
        <form  method="post">
            Year:<select name="year"><option>1</option><option>2</option><option>3</option><option>4</option></select>
            Semester:<select name="sem"><option>1</option><option>2</option></select><br/><br />
            Number of sections:<select name="sec" ><option>1</option><option>2</option><option>3</option><option>4</option></select><br /><br />
            Number of subjects:<select name="sub" ><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option><option>10</option><option>11</option><option>12</option></select><br /><br />
            <input type="hidden" name="status" value="step2" />
            <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
            <input type="submit" value="Next" class="redbutton" style="margin-left: 10px"/>
        </form></h3>
    </center>
    <%}
    else if(status.equals("step2")){
        try{
            int year=Integer.parseInt(request.getParameter("year"));
            int sem=Integer.parseInt(request.getParameter("sem"));
            int sections=Integer.parseInt(request.getParameter("sec"));
            int scount=Integer.parseInt(request.getParameter("sub"));
            int b,bcount;
            if(request.getParameter("b")!=null){
                b=Integer.parseInt(request.getParameter("b"));
            }
            else
                b=1;
            if(request.getParameter("bcount")!=null){
                bcount=Integer.parseInt(request.getParameter("bcount"));
            }
            else
                bcount=0;%> 
            <form action="#" method="post" onsubmit="return validateSubjects(this)">  
            <%
            Connection con=new Connector(dept).getConnection();
            Statement st=con.createStatement();
            Statement pst=con.createStatement();
            ResultSet rs,r;
            int csec;
            if(request.getParameter("csec")==null)
                csec=0;
            else{
                csec=Integer.parseInt(request.getParameter("csec"));
                int prevcsec=csec-1;
                char prevsect=(char)(65+prevcsec);
                String insSql=""+"delete from Subjects_"+year+"_"+sem+prevsect; 
                st.execute(insSql);
                int j=0;
                while(j<scount){
                    j++;
                    String sname=request.getParameter(""+j+"s").trim();
                    String code=request.getParameter(""+j+"c").trim();
                    String fname=request.getParameter(""+j+"f");
                    int index=fname.indexOf('|');
                    int sfid=Integer.parseInt(fname.substring(0, index));
                    //String fetchSql=""+"select fid from faculty where fname='"+fname+"'";
                   // r=pst.executeQuery(fetchSql);
                    //int fid=0;
                    //if(r.next())
                    insSql=""+"insert into Subjects_"+year+"_"+sem+prevsect+" (SID,SNAME,SCODE,FID) values("+j+",'"+sname+"','"+code+"',"+sfid+")"; 
                    st.addBatch(insSql);
                }
                if(j!=0)
                    st.executeBatch();
            }
            char c=(char)(65+csec);
            String sql=""+"select count(*) from Subjects_"+year+"_"+sem+c; 
            String fsql=""+"select FID,FNAME from Faculty order by FNAME";
            r=pst.executeQuery(fsql);
            String[] fac=new String[100];
            int[] fid=new int[100];
            int facCount=0;
            while(r.next()){
                fac[facCount]=r.getString("FNAME");
                fid[facCount]=r.getInt("FID");
                facCount++;
            }
            try{ 
                rs=st.executeQuery(sql);
                if(rs.next()){
                    char fill;
                    if(csec==0)
                        fill=c;
                    else
                        fill=(char)(65+csec-1);
                    sql=""+"select * from Subjects_"+year+"_"+sem+fill;
                    rs=st.executeQuery(sql); 
                    int loop=0;%>
                    <center><h3>Subjects for <%=dept%> <%=year%>-<%=sem%> <%=c%> Section:</h3></center>
                    <table align="center" >
                        <tr>
                            <th>SID</th><th>Subject</th><th>Code</th><th>Faculty</th>
                        </tr>
                    <%while(loop<scount){
                        if(rs.next()){%>
                            <tr>
                                <td><%=loop+1%>.</td>
                                <td><input type="text" id="t<%=(loop+1)%>s" name="<%=(loop+1)%>s" value="<%=rs.getString("SNAME")%>" /></td>
                                <td><input type="text" id="t<%=(loop+1)%>c" name="<%=(loop+1)%>c" value="<%=rs.getString("SCODE")%>" /></td>
                                <td><select id="<%=(loop+1)%>f" name="<%=(loop+1)%>f">
                                        <option>Select</option>
                                    <%int j=0;
                                      int sfid=rs.getInt("FID");
                                      //fsql=""+"select FID,FNAME from Faculty where FID="+rs.getInt("FID")+"";
                                      //r=pst.executeQuery(fsql);
                                      //String fcomp=new String();
                                      //if(r.next())
                                          //fcomp=""+r.getString("FNAME");
                                      while(j<facCount){
                                        if(sfid==(fid[j])){%>
                                            <option selected="selected">
                                                <%if(fid[j]<10){%>0<%}%><%=fid[j]%>| <%=fac[j]%>
                                            </option>
                                        <%}
                                        else{%>
                                            <option>
                                                <%if(fid[j]<10){%>0<%}%><%=fid[j]%>| <%=fac[j]%>
                                            </option>
                                        <%}    
                                        j++;
                                     }%>
                                    </select>
                                </td>
                            </tr>
                        <%}
                        else{%>
                            <tr>
                                <td><%=loop+1%>.</td>
                                <td><input type="text" name="<%=(loop+1)%>s"   /></td>
                                <td><input type="text" name="<%=(loop+1)%>c"  /></td>
                                <td><select name="<%=(loop+1)%>f">
                                    <option>Select</option>
                                    <%int j=0;
                                      while(j<facCount){%>
                                            <option>
                                                <%if(fid[j]<10){%>0<%}%><%=fid[j]%>| <%=fac[j]%>
                                            </option>    
                                        <%j++;
                                    }%>
                                    </select>
                                </td>
                            </tr>
                        <%}
                        loop++;
                    }%>
                    </table>
                <%}
            }
            catch(Exception e){
                try{
                    String csql="create table Subjects_"+year+"_"+sem+c+" (SID TINYINT primary key,SNAME text,SCODE varchar(20),FID INT,FOREIGN KEY(FID) references Faculty(FID) ON DELETE CASCADE  ON UPDATE CASCADE )";
                    st.execute(csql);
                    if(csec==0){
                        int loop=0;%>
                        <center><h3>Subjects for <%=dept%> <%=year%>-<%=sem%> <%=c%> Section:</h3></center>
                        <table align="center" >
                        <tr>
                            <th>SID</th><th>Subject</th><th>Code</th><th>Faculty</th>
                        </tr>
                        <%while(loop<scount){%>
                            <tr>
                                <td><%=loop+1%>.</td>
                                <td><input type="text" name="<%=(loop+1)%>s"  /></td>
                                <td><input type="text" name="<%=(loop+1)%>c"  /></td>
                                <td><select name="<%=(loop+1)%>f">
                                    <option>Select</option>
                                    <%int j=0;
                                      while(j<facCount){%>
                                            <option>
                                                <%if(fid[j]<10){%>0<%}%><%=fid[j]%>| <%=fac[j]%>
                                            </option>    
                                      <%j++;
                                    }%>
                                    </select>
                                </td>
                            </tr>
                            <%loop++;
                        }%>
                        </table>
                    <%}
                    else{
                        char fill=(char)(65+csec-1);
                        sql=""+"select * from Subjects_"+year+"_"+sem+fill;
                        rs=st.executeQuery(sql); 
                        int loop=0;%>
                        <center><h3>Subjects for <%=dept%> <%=year%>-<%=sem%> <%=c%> Section:</h3></center>
                        <table align="center" >
                            <tr>
                                <th>SID</th><th>Subject</th><th>Code</th><th>Faculty</th>
                            </tr>
                            <%while(loop<scount){
                                if(rs.next()){%>
                                    <tr>
                                    <td><%=loop+1%>.</td>
                                    <td><input type="text" name="<%=(loop+1)%>s" value="<%=rs.getString("SNAME")%>" /></td>
                                    <td><input type="text" name="<%=(loop+1)%>c" value="<%=rs.getString("SCODE")%>" /></td>
                                    <td><select name="<%=(loop+1)%>f">
                                        <option>Select</option>
                                        <%int j=0;
                                        int fd=rs.getInt("FID");
                                        while(j<facCount){
                                            if(fd==(fid[j])){%>
                                                <option selected="selected">
                                                    <%if(fid[j]<10){%>0<%}%><%=fid[j]%>| <%=fac[j]%>
                                                </option>
                                            <%}
                                            else{%>
                                                <option>
                                                    <%if(fid[j]<10){%>0<%}%><%=fid[j]%>| <%=fac[j]%>
                                                </option>
                                            <%}    
                                            j++;
                                        }%>
                                        </select>
                                    </td>
                                    </tr>
                                <%}
                                else{%>
                                    <tr>
                                    <td><%=loop+1%>.</td>
                                    <td><input type="text" name="<%=(loop+1)%>s"  /></td>
                                    <td><input type="text" name="<%=(loop+1)%>c"  /></td>
                                    <td><select name="<%=(loop+1)%>f">
                                        <option>Select</option>
                                        <%int j=0;
                                        while(j<facCount){%>
                                            <option>
                                                <%if(fid[j]<10){%>0<%}%><%=fid[j]%>| <%=fac[j]%>
                                            </option>    
                                            <%j++;
                                        }%>
                                        </select>
                                    </td>
                                    </tr>
                                <%}
                                loop++;
                            }%>
                    </table>
                    <%}
                }
                catch(Exception ex){
                    out.print("<center>"+ex+"</center>");%><br />
                    <center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                <%}
            }%>
            <input type="hidden" name="year" value="<%=year%>" />
            <input type="hidden" name="sem" value="<%=sem%>" />
            <input type="hidden" name="sec" value="<%=sections%>" />
            <input type="hidden" name="sub" value="<%=scount%>" />
            <%csec++;
            if(csec<sections){%>
                <input type="hidden" name="status" value="step2" />
            <%}
            else{%>
                <input type="hidden" name="status" value="step3" />  
            <%}%>
            <input type="hidden" name="csec" value="<%=csec%>" />
            <br />
            <%
            bcount++; 
            if(bcount>2){
                b++;
            }
            int backc=-b;
            //out.print("b:"+b+"bcount:"+bcount+"backc:"+backc);%>
            <input type="hidden" name="b" value="<%=b%>" />
            <input type="hidden" name="bcount" value="<%=bcount%>" />
            <center><input style="margin-right: 3mm"type="button" value="Back" class="redbutton" onclick="history.go(<%=backc%>);" />
                <input type="submit" value="Next" class="redbutton"/></center>
        </form> 
        <%
        st.close();
        pst.close();
        con.close();
        }
        catch(Exception e){
            out.print("<center>"+e+"</center>");%><br />
            <center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /> 
        <%}
    }
    else if(status.equals("step3")){
        try{
            int year=Integer.parseInt(request.getParameter("year"));
            int sem=Integer.parseInt(request.getParameter("sem"));
            int sections=Integer.parseInt(request.getParameter("sec"));
            int scount=Integer.parseInt(request.getParameter("sub"));
            int csec=Integer.parseInt(request.getParameter("csec"));
            int prevcsec=csec-1;
            char prevsect=(char)(65+prevcsec);
            Connection con=new Connector(dept).getConnection();
            Statement st=con.createStatement();
            Statement pst=con.createStatement();
            ResultSet rs,r;
            String insSql=""+"delete from subjects_"+year+"_"+sem+prevsect;
            st.execute(insSql);
            int j=0;
            while(j<scount){
                j++;
                String sname=request.getParameter(""+j+"s").trim();
                String code=request.getParameter(""+j+"c").trim();
                String fname=request.getParameter(""+j+"f");
                int index=fname.indexOf('|');
                int sfid=Integer.parseInt(fname.substring(0, index));
                //String fetchSql=""+"select fid from faculty where fname='"+fname+"'";
                //r=pst.executeQuery(fetchSql);
                //int fid=0;
                //if(r.next())
                //    fid=r.getInt("FID");
                insSql=""+"insert into subjects_"+year+"_"+sem+prevsect+" (SID,SNAME,SCODE,FID) values("+j+",'"+sname+"','"+code+"',"+sfid+")"; 
                st.addBatch(insSql);
            }
            if(j!=0)
                st.executeBatch();
            %>
            <jsp:forward page="ANewFeed.jsp">
                <jsp:param name="status" value="step4"/>
                <jsp:param name="year" value="<%=year%>"/>
                <jsp:param name="sem" value="<%=sem%>"/>
                <jsp:param name="sections" value="<%=sections%>"/>
            </jsp:forward>
            <%
            st.close();
            con.close();
        }
        catch(Exception e){
            out.print("<center>"+e+"</center>");%><br />
            <center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
        <%}   
    }
    else if(status.equals("step4")){
         try{
            int year=Integer.parseInt(request.getParameter("year"));
            int sem=Integer.parseInt(request.getParameter("sem"));
            int sections=Integer.parseInt(request.getParameter("sec"));
            Connection con=new Connector(dept).getConnection();
            Statement st=con.createStatement();
            Statement pst=con.createStatement();
            String sql=new String();
            ResultSet rs; 
            //Z_intCalc Table
            sql=""+"create table if not exists Z_intCalc_"+dept+"_"+year+"_"+sem+" (SCODE varchar(20),SNAME Text,FID TINYINT)";
            pst.addBatch(sql); 
            //Count,
            sql=""+"delete from Count where YEAR="+year+" AND SEMESTER="+sem; 
            pst.addBatch(sql);
            //Feedback
            int j=0;
            while(j<sections){
                char c=(char)(65+j);
                sql=""+"drop table if exists FeedBack_"+dept+"_"+year+"_"+sem+c; 
                /*try{
                    sql=""+"select count(*) from FeedBack_"+dept+"_"+year+"_"+sem+c; 
                    st.executeQuery(sql);
                    sql=""+"drop table FeedBack_"+dept+"_"+year+"_"+sem+c; */
                    pst.addBatch(sql);
                    //st.executeUpdate(sql);
                //}
               // catch(Exception e){
                //}
                sql="create table FeedBack_"+dept+"_"+year+"_"+sem+c+"(QID TINYINT primary key,Question text"; 
                String s="select SCODE from Subjects_"+year+"_"+sem+c+" order by SID"; 
                rs=st.executeQuery(s);
                while(rs.next()){
                    //sql+=","+r.getString("SCODE")+" Number";
                    String sub=rs.getString("SCODE");
                    int l=1;
                    while(l<=4){
                        sql+=",`"+sub+"_C"+l+"` SMALLINT ";
                        l++;
                    }
                }
                sql+=")";
                pst.addBatch(sql);
                //st.execute(sql); 
                j++; 
            }
            //Semester
            try{
                sql=""+"select * from semester where year="+year;
                rs=st.executeQuery(sql);
                if(rs.next()){
                    sql=""+"update semester set CURRENT_SEM="+sem+",SECTIONS="+sections+" where YEAR="+year;
                    pst.addBatch(sql);
                }
                else{
                    sql=""+"insert into semester (YEAR,CURRENT_SEM,SECTIONS) values("+year+","+sem+","+sections+")";
                    pst.addBatch(sql);
                }
            }
            catch(Exception e){
                sql="create table semester (YEAR TINYINT Primary Key,CURRENT_SEM TINYINT,SECTIONS TINYINT)";
                pst.addBatch(sql);
                sql=""+"insert into semester (YEAR,CURRENT_SEM,SECTIONS) values("+year+","+sem+","+sections+")";
                pst.addBatch(sql);
            }
            pst.executeBatch();
            pst.clearBatch();
            //Clean Database by deleting tables which are not needed(subjects,feedback)
            try{
                Statement fst=con.createStatement();
                Statement sst=con.createStatement();
                j=sections;
                while(j<4){
                    char c=(char)(65+j);
                    //Subjects
                    sql=""+"drop table if exists Subjects_"+year+"_"+sem+c;  
                   /* try{
                        sql=""+"select count(*) from Subjects_"+year+"_"+sem+c;
                        st.executeQuery(sql);
                        sql=""+"drop table Subjects_"+year+"_"+sem+c;  */ 
                        sst.addBatch(sql);
                    /*}
                    catch(Exception e){
                    }*/
                    //Feedback  
                    sql=""+"drop table if exists FeedBack_"+dept+"_"+year+"_"+sem+c;
                    fst.addBatch(sql);
                    /*try{
                        sql=""+"select count(*) from FeedBack_"+dept+"_"+year+"_"+sem+c;
                        st.executeQuery(sql);
                        sql=""+"drop table FeedBack_"+dept+"_"+year+"_"+sem+c; 
                        fst.addBatch(sql);
                    }
                    catch(Exception e){
                    }*/
                    j++;
                }
                pst.executeBatch();
                try{
                    sst.executeBatch();
                }
                catch(Exception e){
                    out.print("<center>"+e+"</center>");%><br />
                    <center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                <%}
                try{
                    fst.executeBatch();
                }
                catch(Exception e){
                    out.print("<center>"+e+"</center>");%><br />
                    <center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                <%}
                fst.close();
            }
            catch(Exception e){
                out.print("<center>"+e+"</center>");%><br />
                <center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
            <%}
            st.close();
            pst.close();
            con.close();
            out.print("<center><h2>This system is now ready to take the FeedBack </h2></center>");%>
            <center>
                <form action="Settings.jsp">
                    <button type="submit" >Go to Home Page</button>
                </form>
            </center>
         <%}
         catch(Exception e){
             out.print("<center>"+e+"</center>");%><br />
             <center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
         <%}
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
                <button type="submit" class="redbutton" >LogIn</button>
            </form>
            </h2>
        </center>
    </noscript>
<%}%>
        <noscript>
            <center><h4 style="color:red;"> JavaScript is not enabled on your Browser<br />Please enable JavaScript to make the page Interactive</h4></center>
        </noscript>
    </body>
</html>