<%-- 
    Document   : AdminAccount
    Created on : Feb 15, 2013, 12:29:01 AM
    Author     : Anji
--%>

<%@page import="org.data.connection.Connector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
        <style type="text/css">
            th,td{
                border-width: 0px;
            } 
            button.link{
                border:none;
                background:none;
                /*text-decoration: underline;*/
                font-family: "times new roman",sans-serif;
                font-size: 20px;
                color:blue;
                padding:0px;
                cursor:pointer;
            }
            button.link:visited{
                text-decoration:underline;
                cursor:pointer;
                color:#6633ff;
            }
            button.link:hover{
                /*font-style: italic;*/
                text-decoration:underline;
                cursor:pointer;
            }
        </style>
    </head>
    <body>
    <%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){
        String aid=(String)session.getAttribute("AID");
        String dept=(String)session.getAttribute("DEPT");
        try{
            Connection con=new Connector(dept).getConnection();
            Statement st=con.createStatement();
            String sql="select AID,ANAME,EMAILID,MOBILE from admin where AID='"+aid+"'";
            ResultSet rs=st.executeQuery(sql);
            if(rs.next()){%>  
            <center><h2 style="display: inline"><u>Account Details</u>:</h2></center><br />
            <table align="center" border="3"  width="400" style="border-radius:10px;background-color: #ccffcc">
                <tr><form action="AEdit.jsp" method="post" >
                    <input type="hidden" name="option" value="cname" />
                    <th align="right">Name:</th>
                    <td align="left"><%=rs.getString("ANAME") %></td>
                    <th><button class="link" type="submit" ><small>Edit</small></button></th>
                </form>
                </tr>
                <tr>
                    <th align="right">Admin ID:</th>
                    <td colspan="2" align="left"><%=rs.getString("AID") %></td>
                </tr>
                <tr><form action="AEdit.jsp" method="post" >
                    <input type="hidden" name="option" value="cemail" />
                    <th align="right">Email Id:</th>
                    <td align="left"><%=rs.getString("EMAILID") %></td>
                    <th><button class="link" type="submit" ><small>Edit</small></button></th>
                </form>
                </tr>
                <tr><form action="AEdit.jsp" method="post" >
                    <input type="hidden" name="option" value="cmobile" />
                    <th align="right">Mobile No:</th>
                    <td align="left"><%=rs.getString("MOBILE") %>
                    </td>
                    <th><button class="link" type="submit" ><small>Edit</small></button></th>
                </form>
                </tr>
                <tr /><tr /><tr /><tr /><tr />
                <tr>
                    <th colspan="3" >
                        <form action="AEdit.jsp" method="post" >
                            <input type="hidden" name="option" value="cpass" />
                            <button class="link" type="submit" ><small>Change Password</small></button>
                        </form>
                    </th>
                </tr>
            </table>
            <%}
            st.close();
            con.close();
        }
        catch(Exception e){
            out.print("<center>"+e+"</center>");
        }           
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
