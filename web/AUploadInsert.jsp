<%-- 
    Document   : AUploadInsert
    Created on : Feb 18, 2013, 8:16:49 PM
    Author     : Anji
--%>

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
    <%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){
        try{
            String dtype=request.getParameter("dtype");
            String utype=request.getParameter("utype");
            String dept=(String)session.getAttribute("DEPT");%>
            <center><br /><h2 style="display:inline"><u><%=dtype%> data insert</u>:</h2></center>
            <%if(dtype.equals("Student")){
                if(utype.equals("Insert")){
                    if(request.getParameter("insertstatus")==null){
                        String section=request.getParameter("section");
                        int year=Integer.parseInt(request.getParameter("year"));%>
                        <center><h3><%=dept%> 
                                <%if(year==1)
                                    out.print("I");
                                else if(year==2)
                                    out.print("II"); 
                                else if(year==3)
                                    out.print("III");
                                else
                                    out.print("IV");
                                %>
                                <%=section%> Section:
                                </h3>
                        </center>
                        <form action="#" method="post">
                            <input type="hidden" name="dtype" value="<%=dtype%>" />
                            <input type="hidden" name="utype" value="<%=utype%>" />
                            <input type="hidden" name="insertstatus" value="step" />
                            <%
                            //year=Integer.parseInt(request.getParameter("year"));
                            int rows=Integer.parseInt(request.getParameter("sturows"));
                            String pass=request.getParameter("sec"+section+"pass");
                            int i=1;
                            while(i<=rows){
                                if(i==1){%>
                                <table align="center" border="3" cellspacing="0">
                                    <tr style="background-color: #9999ff">
                                        <th>Sno.</th><th>SID</th><th>Name</th><th>EmailId</th><th>MobileNo</th>
                                    </tr>
                                <%}%>
                                <tr>
                                    <td align="center"><%=i%></td>
                                    <td><input type="text" name="sid<%=i%>" size="15"/></td>
                                    <td><input type="text" name="sname<%=i%>" size="30"/></td>
                                    <td><input type="text" name="semail<%=i%>" size="30"/></td>
                                    <td><input type="text" name="smobile<%=i%>" size="15"/></td>
                                </tr>
                                <%if(i==rows){%>
                                    </table>
                                    <center>
                                        <b><span style="color: red">Note:</span>if email id is not in proper format then the corresponding student details will not be imported!</b>
                                        <br /><br />
                                        <input type="hidden" name="year" value="<%=year%>" />
                                        <input type="hidden" name="section" value="<%=section%>" />
                                        <input type="hidden" name="sturows" value="<%=rows %>" />
                                        <input type="hidden" name="sec<%=section%>pass" value="<%=pass%>" />
                                        <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                        <input type="submit" value="Continue"  class="redbutton" style="width: 120px;margin-left: 10px" />
                                    </center>
                                <%}
                                i++;
                            }%>
                        </form>
                    <%}
                    else{
                        String section=request.getParameter("section");
                        int year=Integer.parseInt(request.getParameter("year"));%>
                        <center><h3><%=dept%> 
                                <%if(year==1)
                                    out.print("I");
                                else if(year==2)
                                    out.print("II"); 
                                else if(year==3)
                                    out.print("III");
                                else
                                    out.print("IV");
                                %>
                                <%=section%> Section:
                                </h3>
                        </center> 
                        <%int rows=Integer.parseInt(request.getParameter("sturows"));
                        String pass=request.getParameter("sec"+section+"pass");     
                        int j=1; 
                        boolean flag=false;  
                        String sql=""; 
                        String rand[]=new String[62];
                        int rk=0;
                        while(rk<62){
                            if(rk<10){
                                rand[rk]=""+rk; 
                            }
                            else if(rk<36){
                                char c=(char)(55+rk);
                                rand[rk]=""+c; 
                            }
                            else{
                                char c=(char)(61+rk);
                                rand[rk]=""+c;
                            } 
                            rk++;
                        }
                        while(j<=rows){
                            String sid=request.getParameter("sid"+j).trim();
                            String sname=request.getParameter("sname"+j).trim();
                            String semail=request.getParameter("semail"+j).trim();
                            String smobile=request.getParameter("smobile"+j).trim();
                            if(sid.equals("")||sname.equals("")||semail.equals("")){
                                j++;
                                continue;
                            } 
                            if(semail.contains("@")){
                                int mlen=semail.length();
                                int alen=semail.lastIndexOf("@")+1;
                                String domain=semail.substring(alen,mlen);
                                int dlen=mlen-alen; 
                                int ulen=mlen-(dlen+1);
                                if(dlen<6 || ulen<4){
                                    j++;
                                    continue;
                                }
                            }
                            else{
                                j++;
                                continue;
                            }
                            String spass=sid;
                            if(pass.equals("random")){
                                //random password generation
                                int len=5;
                                len=(int)(len+4*Math.random());
                                String kpass="";
                                int jk=1;
                                while(jk<=len){
                                    kpass+=""+rand[(int)(Math.random()*62)]; 
                                    jk++;
                                }
                                spass=kpass;
                            }
                            if(!flag){
                                sql+="('"+sid+"','"+sname+"','"+spass+"',"+year+",'"+section+"','"+semail+"','"+smobile+"','')";
                                flag=true; 
                            }
                            else
                                sql+=",('"+sid+"','"+sname+"','"+spass+"',"+year+",'"+section+"','"+semail+"','"+smobile+"','')";
                            j++;
                        }
                        if(!sql.equals("")){
                            sql="insert into students (UID,UNAME,PASSWORD,YEAR,SECTION,EMAILID,MOBILE,STATUS) values"+sql;
                            Class.forName("com.mysql.jdbc.Driver");
                            String uri="jdbc:mysql://localhost:3306/feedback_"+dept;
                            Connection con=DriverManager.getConnection(uri,"root","GRIETITOLFF1202");
                            Statement st=con.createStatement();
                            int rs=st.executeUpdate(sql);%>
                            <center>
                                <h3><%=rs%> new record(s) got imported successfully!</h3>
                                <form action="Settings.jsp">
                                    <button type="submit" class="redbutton" style="width: 200px">Go to Home Page</button>
                                </form>
                            </center>
                        <%}
                        else{%>
                            <center>
                                <h3 style="display: inline">No records to import! </h3><br /><br /> 
                                <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                            </center>
                        <%}
                    }
                }
            }
            else{
                if(utype.equals("Insert")){
                    if(request.getParameter("insertstate")==null){%>
                        <form action="#" method="post">
                            <input type="hidden" name="dtype" value="<%=dtype%>" />
                            <input type="hidden" name="utype" value="<%=utype%>" />
                            <input type="hidden" name="insertstate" value="step" />
                            <%int facrows=Integer.parseInt(request.getParameter("facrows"));
                              try{
                                  Class.forName("com.mysql.jdbc.Driver");
                                  String url="jdbc:mysql://localhost:3306/feedback_"+dept; 
                                  Connection con=DriverManager.getConnection(url,"root","GRIETITOLFF1202");
                                  Statement st=con.createStatement();
                                  ResultSet rs=st.executeQuery("select max(FID) as max from faculty");
                                  if(rs.next()){
                                      int startfid=rs.getInt("max")+1;
                                      int i=0,fid=startfid;%>
                                      <table align="center" border="3" cellspacing="0" padding="0">
                                      <%while(i<facrows){
                                          if(i==0){%>
                                            <tr style="background-color: #9999ff">
                                                <th>Fid</th><th>Name</th><th>EmailId</th><th>MobileNo</th>
                                            </tr>
                                          <%}%>
                                          <tr>
                                              <td align="center"><%=fid%></td>
                                              <td><input type="text" name="fname<%=fid%>" size="30"/></td>
                                              <td><input type="text" name="femail<%=fid%>" size="30"/></td>
                                              <td><input type="text" name="fmobile<%=fid%>" size="15"/></td>
                                          </tr>
                                          <%fid++;
                                          i++;
                                      }%>
                                      </table>
                                      <input type="hidden" name="facrows" value="<%=facrows%>" />
                                      <input type="hidden" name="startfid" value="<%=startfid%>" />
                                      <center>
                                        <b><span style="color: red">Note:</span>if email id is not in proper format it will be imported as blank field!</b><br /><br />
                                        <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                        <input type="submit" value="Continue"  class="redbutton" style="width: 120px;margin-left: 10px" />
                                      </center>
                                <%}
                              }
                              catch(Exception e){%>
                                    <center>
                                        <br /><%=e%><br /><br />
                                        <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                                    </center>
                              <%}
                            %>
                        </form>
                    <%}
                    else{
                        int startfid=Integer.parseInt(request.getParameter("startfid"));
                        int facrows=Integer.parseInt(request.getParameter("facrows"));
                        int is=startfid,dups=startfid,es=startfid+facrows;
                        String fname=new String(),femail=new String(),fmobile=new String(),sql=new String();
                        while(is<es){
                            fname=request.getParameter("fname"+is);
                            if(fname.trim().equals("")){
                                if(is==es-1){
                                    if(!sql.equals("")){
                                        int slen=sql.length()-1;
                                        sql=sql.substring(0, slen); 
                                    }
                                }
                                is++;
                                continue;
                            }
                            femail=request.getParameter("femail"+is);
                            fmobile=request.getParameter("fmobile"+is);
                            if(is<es-1)
                                sql+="('"+dups+"','"+fname+"','"+femail+"','"+fmobile+"'),";
                            else
                                sql+="('"+dups+"','"+fname+"','"+femail+"','"+fmobile+"')";
                            is++; 
                            dups++;
                        }
                        if(!sql.equals("")){
                            sql="insert into faculty (`FID`,`FNAME`,`EMAILID`,`MOBILE`) values"+sql;
                            //out.print(sql);
                            Class.forName("com.mysql.jdbc.Driver");
                            String uri="jdbc:mysql://localhost:3306/feedback_"+dept;
                            Connection con=DriverManager.getConnection(uri,"root","GRIETITOLFF1202");
                            Statement st=con.createStatement();
                            int rs=st.executeUpdate(sql);%>
                            <h3><table align="center" cellspacing="0">
                                    <tr><th align="left"><%=rs%> new record(s) inserted successfully!</th></tr>
                            </table></h3>
                            <center>
                                <form action="Settings.jsp">
                                    <button type="submit" class="redbutton" style="width: 200px">Go to Home Page</button>
                                </form>
                            </center>
                        <%}
                        else{%>
                            <center><h3 style="display: inline">No records to import! </h3><br /><br />
                                <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
                            </center>  
                        <%}
                    }
                }
            }
        }
        catch(Exception e){%>
            <center>
                <span style="color:red">Error:</span><br />
                <%=e%><br /><br />
                <input type="button" value="Back" class="redbutton" onclick="history.go(-1)" />
            </center> 
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
                        <input type="hidden" name="uaccount" value="Administrator" /><br />
                        <button type="submit" class="redbutton">LogIn</button>
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
