<%-- 
    Document   : recovery
    Created on : Apr 2, 2013, 11:04:36 PM
    Author     : Anji
--%>

<%@page import="DataConnection.FacConnector" errorPage="Error.jsp"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DataConnection.Connector"%>
<%@page import="java.util.Enumeration"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="CSS/redun.css" />
        <title>::GRIET</title>
        <script type="text/javascript" src="JS/recValidate.js" ></script>
    </head>
    <body onload="change()">
        <div style="background-color:#9999ff;margin: -5px;height:80px" width="100%" ><h1 style="display: inline;"><center style="font-family:algerian;color: #236875;padding:20px">Online Feedback System</center></h1></div>
        <br />
        <%if(request.getParameter("recoverystatus")==null){%>
            <form id="log" action="#" method="post" >
                <div align="center">
                    <table align="center" cellspacing="0">
                        <tr>
                            <td align="right">
                                Account :
                            </td>
                            <td align="left">
                                <select name="accounttype" id="uaccount" onchange="changeBehaviour()">
                                    <%if(request.getParameter("type")==null || request.getParameter("type").toLowerCase().equals("student")){%>
                                         <option>Student</option>
                                         <option>Faculty</option>
                                         <option>Administrator</option>
                                         <option>Administrator-2</option>
                                    <%}
                                    else{
                                        if(request.getParameter("type").toLowerCase().equals("faculty")){%>
                                            <option>Student</option>
                                            <option selected>Faculty</option>
                                            <option>Administrator</option>
                                            <option>Administrator-2</option>
                                        <%}
                                        else if(request.getParameter("type").toLowerCase().equals("administrator")){%>
                                            <option>Student</option>
                                            <option>Faculty</option>
                                            <option selected>Administrator</option>
                                            <option>Administrator-2</option>
                                        <%} 
                                        else if(request.getParameter("type").toLowerCase().equals("administrator-2")){%>
                                            <option>Student</option>
                                            <option>Faculty</option>
                                            <option>Administrator</option>
                                            <option selected>Administrator-2</option>
                                        <%} 
                                    }%>
                                </select>
                            </td>
                        </tr>
                        <tr height="10px" />
                        <tr>
                            <td align="right">
                                Dept :
                            </td>
                            <td align="left">
                                <select id="department" name="dept" >
                                    <%if(request.getParameter("branch")==null){%>
                                        <option>IT</option>
                                        <option>BT</option>
                                        <option>BME</option>
                                        <option>CIVIL</option>
                                        <option>CSE</option>
                                        <option>ECE</option>
                                        <option>EEE</option>
                                        <option>MECH</option>
                                    <%}
                                    else if(request.getParameter("branch").equals("BT")){%>
                                        <option>IT</option>
                                        <option selected>BT</option>
                                        <option>BME</option>
                                        <option>CIVIL</option>
                                        <option>CSE</option>
                                        <option>ECE</option>
                                        <option>EEE</option>
                                        <option>MECH</option>    
                                    <%}
                                    else if(request.getParameter("branch").equals("BME")){%>
                                        <option>IT</option>
                                        <option>BT</option>
                                        <option selected>BME</option>
                                        <option>CIVIL</option>
                                        <option>CSE</option>
                                        <option>ECE</option>
                                        <option>EEE</option>
                                        <option>MECH</option>    
                                    <%}
                                    else if(request.getParameter("branch").equals("CIVIL")){%>
                                        <option>IT</option>
                                        <option>BT</option>
                                        <option>BME</option>
                                        <option selected>CIVIL</option>
                                        <option>CSE</option>
                                        <option>ECE</option>
                                        <option>EEE</option>
                                        <option>MECH</option>    
                                    <%}
                                    else if(request.getParameter("branch").equals("CSE")){%>
                                        <option>IT</option>
                                        <option>BT</option>
                                        <option>BME</option>
                                        <option>CIVIL</option>
                                        <option selected>CSE</option>
                                        <option>ECE</option>
                                        <option>EEE</option>
                                        <option>MECH</option>    
                                    <%}
                                    else if(request.getParameter("branch").equals("ECE")){%>
                                        <option>IT</option>
                                        <option>BT</option>
                                        <option>BME</option>
                                        <option>CIVIL</option>
                                        <option>CSE</option>
                                        <option selected>ECE</option>
                                        <option>EEE</option>
                                        <option>MECH</option>    
                                    <%}
                                    else if(request.getParameter("branch").equals("EEE")){%>
                                        <option>IT</option>
                                        <option>BT</option>
                                        <option>BME</option>
                                        <option>CIVIL</option>
                                        <option>CSE</option>
                                        <option>ECE</option>
                                        <option selected>EEE</option>
                                        <option>MECH</option>    
                                    <%}
                                    else if(request.getParameter("branch").equals("MECH")){%>
                                        <option>IT</option>
                                        <option>BT</option>
                                        <option>BME</option>
                                        <option>CIVIL</option>
                                        <option>CSE</option>
                                        <option>ECE</option>
                                        <option>EEE</option>
                                        <option selected>MECH</option>    
                                    <%}
                                    else{%>
                                        <option selected>IT</option>
                                        <option>BT</option>
                                        <option>BME</option>
                                        <option>CIVIL</option>
                                        <option>CSE</option>
                                        <option>ECE</option>
                                        <option>EEE</option>
                                        <option>MECH</option>    
                                    <%}%>
                                </select>
                            </td>
                        </tr>
                        <tr height="10px" />
                        <tr>
                            <td align="right">
                                User ID :
                            </td>
                            <td align="left">
                                <input type="text" name="id" id="uname" size="15" />
                            </td>
                        </tr>
                        <tr height="10px" >
                        <tr>
                            <td/>
                            <td>
                                <input type="hidden" name="recoverystatus" value="sendingstep" />
                                <input type="button" value="continue" onclick="return validateLog()" />
                            </td>
                        </tr>
                    </table>
                </div>
            </form>
        <%}
        else if(request.getParameter("recoverystatus").equals("sendingstep")){
            String accounttype=request.getParameter("accounttype");
            if(accounttype!=null){
                if(accounttype.toLowerCase().equals("student")){
                    try{
                        String id=request.getParameter("id");
                        String dept=request.getParameter("dept");
                        /*Class.forName("com.mysql.jdbc.Driver");
                        String url="jdbc:mysql://localhost:3306/feedback_"+dept;
                        Connection con=DriverManager.getConnection(url,"root","GRIETITOLFF1202");*/
                        Connection con=new Connector(dept).getConnection();
                        Statement st=con.createStatement();
                        String sql="select UNAME,PASSWORD,EMAILID from students where UID='"+id+"'";
                        ResultSet rs=st.executeQuery(sql);
                        if(rs.next()){
                            String name=rs.getString("UNAME");
                            String to=rs.getString("EMAILID");
                            String cred=rs.getString("PASSWORD");
                            String dupto="";
                            if(to!=null)
                                dupto=to;
                            dupto=dupto.trim();
                            if(to!=null && !dupto.equals("")){
                                to=to.trim();
                                int tlen=to.length();
                                int slen=to.lastIndexOf('@')+1;
                                String domain=to.substring(slen,tlen);
                                int dlen=tlen-slen;
                                int ulen=tlen-(dlen+1);
                                if(to.contains("@")&& dlen >5 && ulen>=4){
                                    Properties props=new Properties();
                                    props.put("mail.smtp.host", "smtp.gmail.com");
                                    props.put("mail.smtp.socketFactory.port", "465");
                                    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                                    props.put("mail.smtp.auth", "true");
                                    props.put("mail.smtp.port", "465");
                                    String user="@gmail.com";
                                    Session session1=Session.getInstance(props,
                                        new javax.mail.Authenticator() {
                                            protected PasswordAuthentication getPasswordAuthentication(){
                                                String use="";
                                                return new PasswordAuthentication("grietolfs@gmail.com",use); 
                                            }
                                        }   
                                    );    
                                    Message message=new MimeMessage(session1);
                                    message.setFrom(new InternetAddress(user));
                                    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
                                    message.setSubject("Griet OLFS: Student Login Credentials!");
                                    message.setText("Hello "+name+", \nYour account credentials are:\n    User ID: "+id+"\nPassword: "+cred );
                                    try{
                                        Transport.send(message); 
                                    %>
                                    <center>
                                        <h3>Your Login credentials have been sent to your Email Id!</h3>
                                        <a href="http://www.<%=domain%>">click here to check your mail!</a>
                                    </center>
                                    <%}
                                    catch(Exception e){%>
                                            <center>
                                                <h3>Oops! <br />  Server failed to send your credentials due to network problem!</h3>
                                                <form action="recovery.jsp">
                                                    <input type="hidden" name="type" value="<%=accounttype%>" />
                                                    <input type="hidden" name="branch" value="<%=dept%>" />
                                                    <input type="submit" value="tryAgain" /> 
                                                </form>
                                            </center>
                                    <%}
                                }
                            }
                        }
                        else{%>
                            <center>
                                <h3>Error: Invalid Details!</h3>
                                <form action="recovery.jsp">
                                    <input type="hidden" name="type" value="<%=accounttype%>" />
                                    <input type="hidden" name="branch" value="<%=dept%>" />
                                    <input type="submit" value="tryAgain" /> 
                                </form>
                            </center>
                        <%}
                    }
                    catch(Exception e){%>
                        <center>
                            <h3><%=e%></h3>
                            <form action="recovery.jsp">
                                <input type="hidden" name="type" value="<%=accounttype%>" />
                                <input type="submit" value="tryAgain" /> 
                            </form>
                        </center>
                    <%}
                }
                else if(accounttype.toLowerCase().equals("faculty")){
                    try{
                        String id=request.getParameter("id");
                        /*Class.forName("com.mysql.jdbc.Driver");
                        String url="jdbc:mysql://localhost:3306/feedback_"+dept;
                        Connection con=DriverManager.getConnection(url,"root","GRIETITOLFF1202");*/
                        Connection con=new FacConnector().getConnection();
                        Statement st=con.createStatement();
                        String sql="select FID,FNAME,PASSWORD,EMAILID from faculty where FID='"+id+"'";
                            ResultSet rs=st.executeQuery(sql);
                            if(rs.next()){
                                String name=rs.getString("FNAME");
                                String to=rs.getString("EMAILID");
                                String cred=rs.getString("PASSWORD");
                                String dupto="";
                                if(to!=null)
                                    dupto=to;
                                dupto=dupto.trim();
                                if(to!=null && !dupto.equals("")){
                                    to=to.trim();
                                    int tlen=to.length();
                                    int slen=to.lastIndexOf('@')+1;
                                    String domain=to.substring(slen,tlen);
                                    int dlen=tlen-slen;
                                    int ulen=tlen-(dlen+1);
                                    if(to.contains("@")&& dlen >5 && ulen>=4){
                                        Properties props=new Properties();
                                        props.put("mail.smtp.host", "smtp.gmail.com");
                                        props.put("mail.smtp.socketFactory.port", "465");
                                        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                                        props.put("mail.smtp.auth", "true");
                                        props.put("mail.smtp.port", "465");
                                        String user="@gmail.com";
                                        Session session1=Session.getInstance(props,
                                            new javax.mail.Authenticator() {
                                                protected PasswordAuthentication getPasswordAuthentication(){
                                                    String use="";
                                                    return new PasswordAuthentication("grietolfs@gmail.com",use); 
                                                }
                                            }   
                                        );    
                                        Message message=new MimeMessage(session1);
                                        message.setFrom(new InternetAddress(user));
                                        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
                                        message.setSubject("Griet OLFS: Faculty Login Credentials!");
                                        message.setText("Hello "+name+", \nYour login credentials are:\n    User ID: "+id+"\n Password: "+cred );
                                    try{
                                        Transport.send(message); 
                                    %>
                                    <center>
                                        <h3>Your Login credentials have been sent to your Email Id!</h3>
                                        <a href="http://www.<%=domain%>">click here to check your mail!</a>
                                    </center>
                                    <%}
                                    catch(Exception e){%>
                                            <center>
                                                <h3>Oops! <br />  Server failed to send your credentials due to network problem!</h3>
                                                <form action="recovery.jsp">
                                                    <input type="hidden" name="type" value="<%=accounttype%>" />
                                                    <input type="submit" value="tryAgain" /> 
                                                </form>
                                            </center>
                                    <%}
                                }
                            }
                        }
                        else{%>
                            <center>
                                <h3>Error: Invalid Details!</h3>
                                <form action="recovery.jsp">
                                    <input type="hidden" name="type" value="<%=accounttype%>" />
                                    <input type="submit" value="tryAgain" /> 
                                </form>
                            </center>
                        <%}
                    }
                    catch(Exception e){%>
                        <center>
                            <h3><%=e%></h3>
                            <form action="recovery.jsp">
                                <input type="hidden" name="type" value="<%=accounttype%>" />
                                <input type="submit" value="tryAgain" /> 
                            </form>
                        </center>
                    <%}
                }
                else if(accounttype.toLowerCase().equals("administrator")){
                    try{
                        String id=request.getParameter("id");
                        String dept=request.getParameter("dept");
                        /*Class.forName("com.mysql.jdbc.Driver");
                        String url="jdbc:mysql://localhost:3306/feedback_"+dept;
                        Connection con=DriverManager.getConnection(url,"root","GRIETITOLFF1202");*/
                        Connection con=new Connector(dept).getConnection();
                        Statement st=con.createStatement();
                        String sql="select AID,ANAME,PASSWORD,EMAILID from admin where AID='"+id+"'";
                            ResultSet rs=st.executeQuery(sql);
                            if(rs.next()){
                                String name=rs.getString("ANAME");
                                String to=rs.getString("EMAILID");
                                String cred=rs.getString("PASSWORD");
                                String dupto="";
                                if(to!=null)
                                    dupto=to;
                                dupto=dupto.trim();
                                if(to!=null && !dupto.equals("")){
                                    to=to.trim();
                                    int tlen=to.length();
                                    int slen=to.lastIndexOf('@')+1;
                                    String domain=to.substring(slen,tlen);
                                    int dlen=tlen-slen;
                                    int ulen=tlen-(dlen+1);
                                    if(to.contains("@")&& dlen >5 && ulen>=4){
                                        Properties props=new Properties();
                                        props.put("mail.smtp.host", "smtp.gmail.com");
                                        props.put("mail.smtp.socketFactory.port", "465");
                                        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                                        props.put("mail.smtp.auth", "true");
                                        props.put("mail.smtp.port", "465");
                                        String user="@gmail.com";
                                        Session session1=Session.getInstance(props,
                                            new javax.mail.Authenticator() {
                                                protected PasswordAuthentication getPasswordAuthentication(){
                                                    String use="";
                                                    return new PasswordAuthentication("grietolfs@gmail.com",use); 
                                                }
                                            }   
                                        );    
                                        Message message=new MimeMessage(session1);
                                        message.setFrom(new InternetAddress(user));
                                        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
                                        message.setSubject("Griet OLFS:"+dept+" Admin Login Credentials!");
                                        message.setText("Hello "+name+", \nYour login credentials are:\n Department: "+dept+"\n       User ID: "+id+"\n   Password: "+cred );
                                    try{
                                        Transport.send(message); 
                                    %>
                                    <center>
                                        <h3>Your Login credentials have been sent to your Email Id!</h3>
                                        <a href="http://www.<%=domain%>">click here to check your mail!</a>
                                    </center>
                                    <%}
                                    catch(Exception e){%>
                                            <center>
                                                <h3>Oops! <br />  Server failed to send your credentials due to network problem!</h3>
                                                <form action="recovery.jsp">
                                                    <input type="hidden" name="type" value="<%=accounttype%>" />
                                                    <input type="hidden" name="branch" value="<%=dept%>" />
                                                    <input type="submit" value="tryAgain" /> 
                                                </form>
                                            </center>
                                    <%}
                                }
                            }
                        }
                        else{%>
                            <center>
                                <h3>Error: Invalid Details!</h3>
                                <form action="recovery.jsp">
                                    <input type="hidden" name="type" value="<%=accounttype%>" />
                                    <input type="hidden" name="branch" value="<%=dept%>" />
                                    <input type="submit" value="tryAgain" /> 
                                </form>
                            </center>
                        <%}
                    }
                    catch(Exception e){%>
                        <center>
                            <h3><%=e%></h3>
                            <form action="recovery.jsp">
                                <input type="hidden" name="type" value="<%=accounttype%>" />
                                <input type="submit" value="tryAgain" /> 
                            </form>
                        </center>
                    <%}
                }
                else if(accounttype.toLowerCase().equals("administrator-2")){
                    try{
                        String id=request.getParameter("id");
                        /*Class.forName("com.mysql.jdbc.Driver");
                        String url="jdbc:mysql://localhost:3306/feedback_"+dept;
                        Connection con=DriverManager.getConnection(url,"root","GRIETITOLFF1202");*/
                        Connection con=new FacConnector().getConnection();
                        Statement st=con.createStatement();
                        String sql="select AID,ANAME,PASSWORD,EMAILID from admin where AID='"+id+"'";
                            ResultSet rs=st.executeQuery(sql);
                            if(rs.next()){
                                String name=rs.getString("ANAME");
                                String to=rs.getString("EMAILID");
                                String cred=rs.getString("PASSWORD");
                                String dupto="";
                                if(to!=null)
                                    dupto=to;
                                dupto=dupto.trim();
                                if(to!=null && !dupto.equals("")){
                                    to=to.trim();
                                    int tlen=to.length();
                                    int slen=to.lastIndexOf('@')+1;
                                    String domain=to.substring(slen,tlen);
                                    int dlen=tlen-slen;
                                    int ulen=tlen-(dlen+1);
                                    if(to.contains("@")&& dlen >5 && ulen>=4){
                                        Properties props=new Properties();
                                        props.put("mail.smtp.host", "smtp.gmail.com");
                                        props.put("mail.smtp.socketFactory.port", "465");
                                        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                                        props.put("mail.smtp.auth", "true");
                                        props.put("mail.smtp.port", "465");
                                        String user="@gmail.com";
                                        Session session1=Session.getInstance(props,
                                            new javax.mail.Authenticator() {
                                                protected PasswordAuthentication getPasswordAuthentication(){
                                                    String use="";
                                                    return new PasswordAuthentication("grietolfs@gmail.com",use); 
                                                }
                                            }   
                                        );    
                                        Message message=new MimeMessage(session1);
                                        message.setFrom(new InternetAddress(user));
                                        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
                                        message.setSubject("Griet OLFS: Admin-2 Login Credentials!");
                                        message.setText("Hello "+name+", \nYour login credentials are:\n    User ID: "+id+"\n Password: "+cred );
                                    try{
                                        Transport.send(message); 
                                    %>
                                    <center>
                                        <h3>Your Login credentials have been sent to your Email Id!</h3>
                                        <a href="http://www.<%=domain%>">click here to check your mail!</a>
                                    </center>
                                    <%}
                                    catch(Exception e){%>
                                            <center>
                                                <h3>Oops! <br />  Server failed to send your credentials due to network problem!</h3>
                                                <form action="recovery.jsp">
                                                    <input type="hidden" name="type" value="<%=accounttype%>" />
                                                    <input type="submit" value="tryAgain" /> 
                                                </form>
                                            </center>
                                    <%}
                                }
                            }
                        }
                        else{%>
                            <center>
                                <h3>Error: Invalid Details!</h3>
                                <form action="recovery.jsp">
                                    <input type="hidden" name="type" value="<%=accounttype%>" />
                                    <input type="submit" value="tryAgain" /> 
                                </form>
                            </center>
                        <%}
                    }
                    catch(Exception e){%>
                        <center>
                            <h3><%=e%></h3>
                            <form action="recovery.jsp">
                                <input type="hidden" name="type" value="<%=accounttype%>" />
                                <input type="submit" value="tryAgain" /> 
                            </form>
                        </center>
                    <%}
                }
                else{%>
                    <center >
                        <h3>Error: Account type not selected!</h3> 
                        <form action="recovery.jsp" method="post">
                            <input type="submit" value="tryAgain!" />
                        </form>
                    </center>
                <%}
            }
            else{%>
                <center >
                    <h3>Error: Account type not selected!</h3> 
                    <form action="recovery.jsp" method="post">
                        <input type="submit" value="tryAgain!" />
                    </form>
                </center>
            <%}
        }%>
    </body>
</html>
