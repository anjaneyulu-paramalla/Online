<%--
    Document   : FacUpdateFeedback
    Created on : Apr 3, 2013, 8:05:30 PM
    Author     : Anji
--%>


<%@page import="com.sun.mail.util.QDecoderStream" errorPage="Error.jsp"%>
<%@page import="org.data.connection.FacConnector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%
if(session.getAttribute("FACID")!=null && session.getAttribute("FACDEPT")!=null){
    try{
        String fid=(String)session.getAttribute("FACID");
        String fdept=(String)session.getAttribute("FACDEPT");
        Connection con=new FacConnector().getConnection(); 
        Statement st=con.createStatement();
        String sql="select c.FID from Count c,faculty f where c.FID=f.FID AND f.FID='"+fid+"'"; 
        ResultSet rs=st.executeQuery(sql);
        if(rs.next()){
            String ss=""+"<center><h1 style='color: blue'>You are already submitted the Feedback Form</h1></center>";%>
            <jsp:forward page="FacMain.jsp" >
                <jsp:param name="outInFrame" value="<%=ss%>"/>
            </jsp:forward>
        <%}
        else{
            int row;
            if(session.getAttribute("row")==null){
                String cnt="select count(*) as count from Questions";
                rs=st.executeQuery(cnt);
                rs.next();
                row=rs.getInt("count"); 
            }
            else
                row=Integer.parseInt(""+session.getAttribute("row"));
            if(row==0){
                String err=new String();
                err=""+"<center><h3>No questions found to give feedback!</h3></center>";%>
                <jsp:forward page="FacMain.jsp" >
                    <jsp:param name="outInFrame" value="<%=err%>"/>
               </jsp:forward>
            <%}
            else{
                String q[]=new String[20];
                String rating[]=new String[row+1]; 
                int rcount=0,qlen=0;
                String tsql="select QID,QUESTION from questions order by QID";
                ResultSet g=st.executeQuery(tsql);
                boolean gfirst=true; 
                tsql="";
                while(g.next()){
                    if(gfirst){ 
                        q[qlen]="Q"+g.getString("QID");
                        tsql+="`"+q[qlen]+"`"; 
                        qlen++;
                        gfirst=false;
                    }
                    else{
                        q[qlen]="Q"+g.getString("QID");
                        tsql+=",`"+q[qlen]+"`"; 
                        qlen++;
                    }   
                }
                int qno=0;
                String csql="create table if not exists feedback_"+fdept+" (";
                while(qno<qlen){
                    if(qno==0)
                        csql+="`"+q[qno]+"` TEXT NOT NULL";
                    else
                        csql+=",`"+q[qno]+"` TEXT NOT NULL";
                    qno++;
                }
                csql+=")";
                //out.print(csql);
                st.execute(csql);
                String usql="select count(*) as Count from count c,faculty f where f.FID=c.FID AND f.DEPT='"+fdept+"'";
                ResultSet urs=st.executeQuery(usql);
                boolean first=true;
                int nu=0;
                if(urs.next()){
                    nu=urs.getInt("Count");
                    if(nu!=0)
                        first=false;
                }
                if(first){
                    String fs="select * from feedback_"+fdept;
                    ResultSet f=st.executeQuery(fs);
                    if(f.next()){
                        String del="delete from feedBack_"+fdept;
                        st.execute(del);
                    }
                }
                String sqs="insert into feedback_"+fdept+" ("+tsql+") values";
                while(rcount<row){
                    rcount++;
                    String rate="rate"+rcount;
                    rating[rcount]=request.getParameter(rate).trim();
                    out.print(rate+":"+rating[rcount]+"<br />");
                    if(rating[rcount].trim().equals(""))
                        throw new ArithmeticException("inavlid rating!"); 
                }
                String insUser="insert into count (`FID`) values('"+fid+"')";
                st.addBatch(insUser);
                String sval="";
                rcount=0;
                while(rcount<row){
                    rcount++;
                    rating[rcount]=rating[rcount].replace("\\", "\\\\");
                    rating[rcount]=rating[rcount].replace("'", "\\'");
                    if(rcount==1){
                        sval="'"+rating[rcount]+"'";
                    }
                    else
                        sval+=",'"+rating[rcount]+"'";
                                               
                }
                sqs=sqs+"("+sval+")";
                st.addBatch(sqs);
                //out.print(insUser+"<br />"+sqs);
                st.executeBatch();
                String ss=""+"<center><h3 style='color: blue'>Thank You For Your Feedback<br></h3></center>";%>
                <jsp:forward page="Main.jsp" >
                    <jsp:param name="outInFrame" value="<%=ss%>"/>
                </jsp:forward>
            <%}
        }
        con.close();
        st.close();
    }
    catch(Exception e){%>  
        <jsp:forward page="FacMain.jsp" >
            <jsp:param name="outInFrame" value="<%=e %>"/> 
        </jsp:forward>
    <%}
}
else{%>
    <jsp:forward page="./" >
        <jsp:param name="uaccount" value="Faculty" />
    </jsp:forward>
<%}%>
