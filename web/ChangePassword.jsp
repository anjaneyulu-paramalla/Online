<%-- 
    Document   : ChangePassword
    Created on : Jul 18, 2012, 3:34:59 PM
    Author     : Anjaneyulu
--%>

<%@page import="DataConnection.Connector"%>
<%@page import="java.sql.ResultSet" errorPage="Error.jsp"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
        <link rel="stylesheet" href="CSS/ChangeButton.css" />
    </head>
    <body>
<%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){
    String dept=(String)session.getAttribute("DEPT");
    String aid=""+session.getAttribute("AID");
    String currentPass=request.getParameter("currentPass");
    String newPass=request.getParameter("newPass");
    String confirm_newPass=request.getParameter("confirm_newPass");
    if(currentPass.isEmpty()){%>
        <center>
            <h3>Password Cannot be Empty</h3> 
            <form action="Change.jsp">
                <button type="submit" >Try Again</button>
            </form>
        </center>
    <%}
    else{
        if(newPass.isEmpty()){%>
            <center>
                <h3>New Password Field Cannot be Empty</h3>
                <form action="Change.jsp">
                    <button type="submit" >Try Again</button>
                </form>
            </center>
        <%}
        else if(!newPass.equals(confirm_newPass)){%>
            <center>
                <h3>Passwords did not Match</h3>
                <form action="Change.jsp">
                    <button type="submit" >Try Again</button>
                </form>
            </center>
        <%}
        else{
            try{
                Connection con=new Connector(dept).getConnection();
                Statement st=con.createStatement();
                String sql="select * from Admin where AID='"+aid+"'";
                ResultSet rs=st.executeQuery(sql);
                if(rs.next()){
                    String pass=rs.getString("PASSWORD");
                    if(pass.equals(currentPass)){
                        sql="update Admin set PASSWORD='"+newPass+"' where AID='"+aid+"'";
                        int r=st.executeUpdate(sql);
                        if(r!=0){%>
                            <center>
                                <h2>Password has been Changed Successfully!</h2>
                                <form action="Settings.jsp">
                                    <button type="submit" >Go to Home Page</button>
                                </form>
                            </center>
                        <%}
                    }
                    else{%>
                         <center>
                             <h3>Incorrect Password</h3>
                            <form action="Change.jsp">
                                 <button type="submit" >Try Again</button>
                            </form>
                         </center>
                    <%}
                }
                else{%>
                    <center>
                        <h3>Invalid Credentials</h3>
                        <form action="Change.jsp">
                            <button type="submit" >Try Again</button>
                        </form>
                    </center>
                <%}
            }
            catch(Exception e){
                out.print("<center>"+e+"</center>");
            }
        }
    }    
  }
  else{%>
    <form action="./" target="_top" id="autosubmit"  method="post" onload="myfunc()">
        <input type="hidden" name="uaccount" value="Student" />
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
                <input type="hidden" name="uaccount" value="Student" /><br />
                <button type="submit">LogIn</button>
            </form>
            </h2>
        </center>
    </noscript>  
  <%}%>
    </body>
</html>