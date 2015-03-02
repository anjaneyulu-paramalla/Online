<%-- 
    Document   : Update
    Created on : May 23, 2012, 3:13:51 AM
    Author     : Anjaneyulu
--%>

<%@page import="org.data.connection.Connector"%>
<%@page import="java.sql.ResultSet" errorPage="Error.jsp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
if(session.getAttribute("UID")!=null && session.getAttribute("UYEAR")!=null && session.getAttribute("USECTION")!=null && session.getAttribute("SDEPT")!=null){
    try{
        String uid=(String)session.getAttribute("UID");
        String year=""+session.getAttribute("UYEAR");
        String section=""+session.getAttribute("USECTION");
        String sdept=(String)session.getAttribute("SDEPT");
        Connection con=new Connector(sdept).getConnection();
        Statement st=con.createStatement();
        String sem=new String();
        if(session.getAttribute("sem")==null){
            String sqlsem="select CURRENT_SEM from semester where YEAR="+year;
            ResultSet rs=st.executeQuery(sqlsem);
            if(rs.next())
                sem=""+rs.getInt("CURRENT_SEM");  
        }
        else
            sem=""+session.getAttribute("sem"); 
        String sql="select c.UID from Count c,students s where c.UID=s.UID AND c.YEAR=s.YEAR AND c.YEAR="+year+" AND c.SEMESTER="+sem+" AND s.SECTION='"+section+"' AND c.UID='"+uid+"'"; 
        ResultSet rs=st.executeQuery(sql);
        if(rs.next()){
            String ss=""+"<center><h1 style='color: blue'>You are already submitted the Feedback Form</h1></center>";%>
            <jsp:forward page="Main.jsp" >
                <jsp:param name="outInFrame" value="<%=ss%>"/>
            </jsp:forward>
        <%}
        else{
            //int row=Integer.parseInt(request.getParameter("row"));
            //int col=Integer.parseInt(request.getParameter("col"));
            int row,col;
            if(session.getAttribute("col")==null||session.getAttribute("row")==null){
                String cnt="(select count(*) as count from Questions)union (select count(*) as count from Subjects_"+year+"_"+sem+section+")";
                rs=st.executeQuery(cnt);
                rs.next();
                row=rs.getInt("count"); 
                rs.next();
                col=rs.getInt("count");
            }
            else{ 
                row=Integer.parseInt(""+session.getAttribute("row"));
                col=Integer.parseInt(""+session.getAttribute("col"));
            }
            if(row==0||col==0){
                String err=new String();
                if(row==0&&col==0)
                    err=""+"<center><h3>No questions & Subjects found to give feedback!</h3></center>";
                else if(row==0)
                     err=""+"<center><h3>No questions found  to give feedback!</h3></center>";
                else
                     err=""+"<center><h3>No Subjects found to give feedback!</h3></center>";%>
                <jsp:forward page="Main.jsp" >
                    <jsp:param name="outInFrame" value="<%=err%>"/>
               </jsp:forward>
            <%}
            else{
                int rating[][]=new int[row+1][col+1];
                int rcount=0,ccount=0;
                String tsql="select SCODE from subjects_"+year+"_"+sem+section+" order by SID";
                ResultSet g=st.executeQuery(tsql);
                boolean gfirst=true; 
                while(g.next()){
                    int gg=1;
                    if(gfirst){
                        tsql="`QID`,`QUESTION`";
                        while(gg<=4){
                            tsql+=",`"+g.getString("SCODE")+"_C"+gg+"`";
                            gg++;
                        }
                        gfirst=false;
                    }
                    else{
                        while(gg<=4){
                            tsql+=",`"+g.getString("SCODE")+"_C"+gg+"`";
                            gg++;
                        }
                    }
                }
                g.close();
                String isql="insert into Feedback_"+sdept+"_"+year+"_"+sem+section+" ("+tsql+") values(?,?,";
                String sqs="insert into Feedback_"+sdept+"_"+year+"_"+sem+section+" ("+tsql+") values";
                //out.print(isql);
                while(rcount<row){
                    rcount++;ccount=0;
                    while(ccount<col){
                        ccount++;
                        String rate="rate"+rcount+ccount;
                        rating[rcount][ccount]=Integer.parseInt(request.getParameter(rate));
                        if(rating[rcount][ccount]<1 ||rating[rcount][ccount]>4)
                            throw new ArithmeticException("inavlid rating!"); 
                        if(rcount==1){
                            if(ccount<col)
                                isql+="?,?,?,?,";
                            else
                                isql+="?,?,?,?)";
                        }
                    }
                }
                //PreparedStatement pst=con.prepareStatement(isql);
                Statement pst=con.createStatement();
                Statement sst=con.createStatement();
                Statement qst=con.createStatement();
                Statement ust=con.createStatement();
                Statement fst=con.createStatement();
                Statement ufst=con.createStatement();
                String usql="select count(*) as Count from Count c,students s where s.UID=c.UID AND c.YEAR=s.YEAR AND c.SEMESTER="+sem+" AND c.YEAR="+year+" AND s.SECTION='"+section+"'";
                String qsql="select * from Questions order by QID";
                ResultSet qrs=qst.executeQuery(qsql);
                ResultSet urs=ust.executeQuery(usql);
                boolean first=true;int nu=0;
                if(urs.next()){
                    nu=urs.getInt("Count");
                    if(nu!=0)
                        first=false;
                }
                if(first){
                    String fs="select * from Feedback_"+sdept+"_"+year+"_"+sem+section;
                    ResultSet f=fst.executeQuery(fs);
                    if(f.next()){
                        String del="delete from FeedBack_"+sdept+"_"+year+"_"+sem+section;
                        fst.execute(del);
                    }
                }
                if(!first){
                    rcount=0;
                    String insUser="insert into count (UID,YEAR,SEMESTER) values('"+uid+"',"+year+","+sem+")";
                    ufst.addBatch(insUser);
                    while(rcount<row){
                        rcount++;
                        ccount=0;
                        String fsql="select * from Feedback_"+sdept+"_"+year+"_"+sem+section+" where QID="+rcount;
                        ResultSet frs=fst.executeQuery(fsql);
                        if(frs.next()){
                            String ssql="select * from Subjects_"+year+"_"+sem+section+" order by SID"; 
                            ResultSet srs=sst.executeQuery(ssql);
                            if(col>0){
                                String ufsql=""+"update Feedback_"+sdept+"_"+year+"_"+sem+section+" set ";
                                while(srs.next()){
                                    ccount++;
                                    int i=rating[rcount][ccount];
                                    String subject=srs.getString("SCODE");
                                    ufsql+=" `"+subject+"_C"+i+"`=`"+subject+"_C"+i+"`+1 "; 
                                    if(ccount!=col)
                                        ufsql+=", ";
                                }
                                ufsql+=" where QID="+rcount;
                                out.println(ufsql+"<br/>");
                                ufst.addBatch(ufsql);
                            }
                        }
                    }
                }
                if(first){
                    rcount=0; 
                    String impsql="",impq="";
                    boolean impflag=false;
                    while(qrs.next()){
                        rcount++;
                        int qno=qrs.getInt("QID");
                        String ques=qrs.getString("Question");
                        //out.print(ques.replace("'", "\\'"));
                        ques=ques.replace("'", "\\'");
                       // out.print(ques);
                        //pst.setInt(1,qno);pst.setString(2,ques);
                        impq=""+qno+",'"+ques+"'";
                        int i=1;
                        while(i<=col){
                            int rate=rating[rcount][i],k=1,j=4*(i-1);
                            while(k<=4){
                                if(k==rate){
                                    //pst.setInt(j+k+2,1);
                                    impq+=",1";
                                }
                                else
                                    //pst.setInt(j+k+2,0);
                                    impq+=",0"; 
                                k++;
                            }
                            i++;
                        }
                        //pst.addBatch();
                        if(!impflag){
                            impsql=sqs+"("+impq+")";
                            impflag=true;
                        }
                        else
                            impsql+=",("+impq+")";
                    }
                    //out.print(impsql);
                    if(impflag){
                        //out.print(impsql);
                        impsql=impsql;
                        pst.addBatch(impsql);
                    }
                    //out.print(impsql);
                }
                /*c/else{
                    String isql1="insert into Feedback_"+sdept+"_"+year+"_"+sem+section+" (QID,Question";
                    String isql2=" values ("+qno+",'"+ques+"'";
                    while(srs.next()){
                       ccount++;
                       String subject=srs.getString("SCODE");
                       int i=1;
                       int j=rating[rcount][ccount];
                       while(i<=4){
                           isql1+=","+subject+"_C"+i;
                           if(i==j)
                               isql2+=",1";
                           else
                               isql2+=",0";
                           i++;
                       }
                    }
                    String isql=isql1+")"+isql2+")";
                    pst.addBatch(isql);
 *              }*/
                if(true){
                    if(first){
                        String insUser="insert into count (UID,YEAR,SEMESTER) values('"+uid+"',"+year+","+sem+")";
                        pst.addBatch(insUser);
                        pst.executeBatch();
                        //st.executeUpdate(insUser);
                    }
                    else{
                        //ufst.addBatch(insUser);
                        ufst.executeBatch();
                    }
                    String ss=""+"<center><h3 style='color: blue'>Thank You For Your Feedback<br></h3></center>";%>
                    <jsp:forward page="Main.jsp" >
                        <jsp:param name="outInFrame" value="<%=ss%>"/>
                    </jsp:forward>
                <%}
            }
        }
        con.close();
        st.close();
    }
    catch(Exception e){%>
    <%=e%>
        <jsp:forward page="Main.jsp" >
            <jsp:param name="outInFrame" value="<%=e %>"/> 
        </jsp:forward>
    <%}
}
else{%>
    <jsp:forward page="./" >
        <jsp:param name="uaccount" value="Student" />
    </jsp:forward>
<%}%>