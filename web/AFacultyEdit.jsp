<%-- 
    Document   : AFacultyEdit
    Created on : Feb 26, 2013, 4:16:41 AM
    Author     : Anji
--%>

<%@page import="DataConnection.Connector"%>
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
        String edit=request.getParameter("edit");
        int count=Integer.parseInt(request.getParameter("count"));%>
        <center><h3><u><%=edit.substring(0,1).toUpperCase()+edit.substring(1, edit.length()) %> faculty details</u>:</h3></center>
        <%if(request.getParameter("editstatus")==null){
            if(edit.equals("update")){%>
                <form action="#" method="post">
                    <input type="hidden" name="editstatus" value="step" />
                    <input type="hidden" name="edit" value="<%=edit%>" />
                    <%int i=1,flen=0;
                    String fid[]=new String[count];
                    while(i<=count){
                        if(request.getParameter("check"+i)!=null){
                            fid[flen++]=request.getParameter("check"+i);
                        }
                        i++;
                    }
                    if(flen==0){%>
                        <h4><center>sorry,you didn't select any faculty to update!</center></h4>
                        <h4><center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></center></h4>
                    <%}
                    else{
                        Connection con=new Connector(dept).getConnection();
                        Statement st=con.createStatement();
                        i=0;%>
                        <table border="3" cellspacing="0" align="center">
                        <%while(i<flen){
                            String sql="select FID,FNAME,EMAILID,MOBILE from faculty where FID="+fid[i];
                            ResultSet rs=st.executeQuery(sql);
                            if(rs.next()){
                                if(i==0){%>
                                    <tr style="background-color: #9999ff">
                                        <th>Sno</th>
                                        <th>Name</th>
                                        <th>FID</th>
                                        <th>EmailId</th>
                                        <th>MobileNo</th>
                                    </tr>  
                                <%}%>
                                <tr>
                                   <td align="center"><%=i+1%></td>
                                   <td><input type="text" name="fname<%=i+1%>" value="<%=rs.getString("FNAME")%>" size="30"/></td>
                                   <td align="center"><%=fid[i]%></td>
                                   <td><input type="text" name="femail<%=i+1%>" value="<%=rs.getString("EMAILID")%>" size="30"/></td>
                                   <td><input type="text" name="fmobile<%=i+1%>" value="<%=rs.getString("MOBILE")%>" size="15"/></td>
                                </tr>
                                <input type="hidden" name="fid<%=i+1%>" value="<%=fid[i]%>" />
                            <%}
                            i++;
                        }%>
                        </table>
                        <center>
                            <b><span style="color: red">Note:</span>if email id is not in proper format it will be updated as blank field!</b>
                            <h3><input type="hidden" name="count" value="<%=flen%>" />
                            <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                            <input type="submit" value="Update" class="redbutton" style="width: 120px;margin-left: 10px;" /></h3>
                        </center>
                        <%st.close();
                        con.close();
                    }%>
                </form>  
            <%}
            else{%>
                <form action="#" method="post">
                <input type="hidden" name="editstatus" value="step" />
                <input type="hidden" name="edit" value="<%=edit%>" />
                <%int i=1,flen=0;;
                String findsemsql="",knock="";
                boolean fchecked=false;
                while(i<=count){
                    if(request.getParameter("check"+i)!=null){
                        flen++;
                        knock=request.getParameter("check"+i);%>
                        <input type="hidden" name="fid<%=flen%>" value="<%=knock%>"  />
                        <%if(!fchecked){
                            findsemsql=" FID="+knock;
                            fchecked=true;
                        }
                        else{
                            findsemsql+=" OR FID="+knock;
                        }
                    }
                    i++;
                }%>
                <input type="hidden" name="count" value="<%=flen%>" />
                <%if(flen==0){%>
                    <h4><center>sorry,you didn't select any faculty to delete!</center></h4>
                    <h4><center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></center></h4>
                <%}
                else{
                    Connection con=new Connector(dept).getConnection();;
                    Statement st=con.createStatement();
                    boolean foundsem=false;
                    String sql="";
                    String fyear[]=new String[4]; 
                    String fsem[]=new String[4];
                    String fsec[]=new String[4];
                    i=1;
                    int j=1,k=1,fnlen=0;
                    while(i<=4){
                        //4 years
                        j=1; 
                        while(j<=2){
                            //2 semesters
                            k=1;
                            String smt="";
                            while(k<=4){
                                //4 sections
                                char c=(char)(64+k);
                                try{
                                    sql="select count(*) as count from subjects_"+i+"_"+j+c+" where "+findsemsql; 
                                    //out.print("<br />"+sql); 
                                    ResultSet rs=st.executeQuery(sql);
                                    if(rs.next()){
                                        int cnt=rs.getInt("count");
                                        //out.print("---"+cnt); 
                                        if(cnt>0){
                                            if(smt.equals(""))
                                                smt=""+c;
                                            else
                                                smt+=","+c;
                                        }
                                    }
                                }
                                catch(Exception e){
                                    //out.print("<br />"+e+"<br />");
                                }
                                k++;
                            }
                            //out.print("<br />smt:"+smt);
                            if(!smt.equals("")){
                                if(i==1)   
                                    fyear[fnlen]="I";
                                else if(i==2)
                                    fyear[fnlen]="II";
                                else if(i==3)
                                    fyear[fnlen]="III";
                                else if(i==4)
                                    fyear[fnlen]="IV";
                                if(j==1)
                                    fsem[fnlen]="I";
                                else if(j==2)
                                    fsem[fnlen]="II";
                                fsec[fnlen]=smt;
                                fnlen++;
                            }
                            j++;
                        }
                        i++;
                    }
                    if(fnlen==0){%>
                        <center>
                            <h4 style="display: inline">
                                Deleting <%=flen%> faculty details.<br />
                                Are you sure?<br /><br />
                                <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                                <input type="submit" value="Yes" class="redbutton" style="margin-left: 10px;" />
                            </h4>
                        </center>
                    <%}
                    else{%>
                        <center>
                            <h4 style="display: inline">
                                On deleting the selected <%=flen%> faculty ,the subjects being taught by the faculty also gets deleted!<br />
                                Following are the section wise details which contain the subjects being taught by the selected faculty.
                                <table align="center" border="3" cellspacing="0">
                                    <tr style="background-color: #9999ff">
                                        <th width="100px">
                                            Year
                                        </th>
                                        <th width="100px">
                                            Semester
                                        </th>
                                        <th width="100px">
                                            Section(s)
                                        </th>
                                    </tr>
                                    <%i=0;
                                    while(i<fnlen){%>
                                        <tr>
                                            <td align="center"><%=fyear[i]%></td>
                                            <td align="center"><%=fsem[i]%></td>
                                            <td align="center"><%=fsec[i]%></td>
                                        </tr>
                                        <%i++;
                                    }%>
                                </table>
                                Do you wish to continue?<br /><br />
                                <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                                <input type="submit" value="Yes" class="redbutton" style="margin-left: 10px;" />
                            </h4>
                        </center>
                   <%}
                }%>
                </form>
            <%}
        }
        else{
            if(edit.equals("update")){
                int i=1,ucount=0;
                Connection con=new Connector(dept).getConnection();
                Statement st=con.createStatement();
                String sql=new String(), fid=new String(),fname=new String(),femail=new String(),fmobile=new String();
                while(i<=count){
                    fid=request.getParameter("fid"+i);
                    fname=request.getParameter("fname"+i).trim();
                    femail=request.getParameter("femail"+i).trim();
                    fmobile=request.getParameter("fmobile"+i).trim();
                    if(fname.equals("")){
                        i++;
                        continue;
                    }
                    if(!femail.equals("")){
                        if(femail.contains("@")){
                            int mlen=femail.length();
                            int alen=femail.lastIndexOf("@")+1;
                            String domain=femail.substring(alen,mlen);
                            int dlen=mlen-alen; 
                            int ulen=mlen-(dlen+1);
                            if(dlen<6 || ulen<4)
                                femail="";
                        }
                        else{
                            femail="";
                        }
                    }
                    sql="update faculty set FNAME='"+fname+"',EMAILID='"+femail+"',MOBILE='"+fmobile+"' where FID="+fid;
                    ucount++;
                    st.addBatch(sql);
                    i++;
                }
                if(sql.equals("")){%>
                     <center><h4 style="display: inline">No records to update! </h4><br /><br />
                        <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                     </center>  
                <%}
                else{
                    st.executeBatch();
                    st.close();
                    con.close();%>
                    <center>
                    <h4>
                        <%=ucount%> record(s) updated successfully!
                    </h4>
                    <form action="Settings.jsp">
                        <button type="submit" class="redbutton" style="width: 200px">Go to Home Page</button>
                    </form>
                    </center>
                <%}
            }
            else{
                int i=1;
                String delsql="";
                boolean first=true;
                while(i<=count){
                    if(request.getParameter("fid"+i)!=null){
                        if(first){
                            first=false;
                            delsql="delete from faculty where FID="+Integer.parseInt(request.getParameter("fid"+i));
                        }
                        else{
                            delsql+=" OR FID="+Integer.parseInt(request.getParameter("fid"+i));
                        }
                    }
                    i++;
                }
                //out.print(delsql);
                Connection con=new Connector(dept).getConnection();
                Statement statement=con.createStatement(); 
                int del=statement.executeUpdate(delsql);
                statement.close();
                con.close();%>
                <center>
                <h4>
                    <%=del%> record(s) updated successfully!
                </h4>
                <form action="Settings.jsp">
                    <button type="submit" class="redbutton" style="width: 200px">Go to Home Page</button>
                </form>
                </center>
            <%}
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
