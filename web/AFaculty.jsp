<%-- 
    Document   : AFaculty
    Created on : Jul 24, 2012, 1:02:27 AM
    Author     : Anjaneyulu
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
        <link rel="stylesheet" href="CSS/redun.css" />
        <style>
            a:hover{
                text-decoration: underline;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
<%if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){
    String dept=(String)session.getAttribute("DEPT");
    try{%>
        <h3><center><u>Faculty Details of <%=dept%> Department:</u></center></h3>
        <%
        Connection con=new Connector(dept).getConnection();
        Statement st=con.createStatement();
        String sql="select * from faculty order by fname";
        ResultSet rs=st.executeQuery(sql);
        if(rs.next()){
            String fid=rs.getString("FID");
            int fcount=1;%>
            <form action="AFacultyEdit.jsp" method="post" >
            <table border="0" align="center">
            <tr><td>
            <table cellspacing="0" border="3" >
                <tr style="background-color: #9999ff">
                    <th></th>
                    <th>Sno</th>
                    <th>Name</th>
                    <th>FID</th>
                    <th>EmailId</th>
                    <th>MobileNo</th>
                </tr>
                <tr>
                    <td><input type="checkbox" name="check<%=fcount%>" value="<%=fid%>" /></td>
                    <td align="center"><%=fcount++%></td>
                    <td>&nbsp;<%=rs.getString("FNAME") %></td>
                    <td align="center"><%=fid %></td>
                    <td width="200px">&nbsp;<%=rs.getString("EMAILID") %></td>
                    <td width="100px">&nbsp;<%=rs.getString("MOBILE") %></td>
                </tr>
            <%while(rs.next()){
                fid=rs.getString("FID");%>
                <tr>
                    <td><input type="checkbox" name="check<%=fcount%>" value="<%=fid%>"/></td>
                    <td align="center"><%=fcount++%></td>
                    <td>&nbsp;<%=rs.getString("FNAME") %></td>
                    <td align="center"><%=fid %></td>
                    <td>&nbsp;<%=rs.getString("EMAILID") %></td>
                    <td>&nbsp;<%=rs.getString("MOBILE") %></td>
                </tr>
            <%}%>
            </table>
            </td></tr>
            <tr><td>
            <input type="hidden" name="count" value="<%=fcount-1%>" />
            <span style="color: #0033cc;">
                &nbsp;&nbsp;<img src="IMAGES/arrow_ltr.png" />
                <input style="display: none" id="checkall" type="radio" name="check"  />
                <label for="checkall" >
                    <a >check All</a>
                </label> / 
                <input style="display: none" id="uncheckall" type="radio" name="check" />
                <label for="uncheckall">
                    <a>Uncheck All</a>
                </label>&nbsp;&nbsp;&nbsp;&nbsp;
                <b>with selected:
                <input   id="uedit" type="radio" name="edit" value="update" checked />
                <label for="uedit">
                update
                </label>
                <input id="dedit" type="radio" name="edit" value="delete" />
                <label for="dedit">
                delete
                </label></b>
            </span>
            </td></tr></table>
             <h3><center>
                     <input type="button" value="Back" class="redbutton" onclick="history.go(-1);" />
                     <input type="submit" value="Contine" class="redbutton" style="width: 120px;margin-left: 10px;" />
             </center></h3>
            </form>
        <%}
        else{%>
            <h3><center>No Data Found!</center></h3>
            <h3><center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></center></h3>
        <%}%>
        <%--String sql="select count(*) as strength from Faculty";
        ResultSet rs=st.executeQuery(sql);%>
        <h3><center><u>Faculty Details of <%=dept%> Department:</u></center></h3>
        <%int strength=0;
        if(rs.next())
            strength=rs.getInt("strength");
        int fcount=0;
        String[] fid=new String[strength],fname=new String[strength];
        sql="select * from faculty";
        rs=st.executeQuery(sql);
        if(rs.next()){
            do{
                fid[fcount]=rs.getString("FID");
                fname[fcount]=rs.getString("FNAME");
                fcount++;
            }while(rs.next());
            if(strength<=10){%>
                <table cellspacing="0" border="5" align="center" width="300">
                    <tr height="40" bgcolor= "#9999ff" align="center">
                        <th>S.NO</th>
                        <th>FID</th>
                        <th>Name</th>
                    </tr>
                    <%int len=0;
                    while(len<strength){%>
                        <tr>
                             <td align="center"><%=len+1%></td>
                             <td align="center"><%=fid[len]%></td>
                             <td><%=fname[len]%></td>
                        </tr>
                        <%len++;
                    }%>
                </table>
            <%}
            else if(strength<=20){%>
                <table cellspacing="0" border="5" align="center" width="600">
                    <tr height="40" bgcolor= "#9999ff" align="center">
                        <th>S.NO</th>
                        <th>FID</th>
                        <th>Name</th>
                        <th width="1" style="border:0;background-color:#9999ff " ></th>
                        <th>S.NO</th>
                        <th>FID</th>
                        <th>Name</th>
                    </tr>
                    <%int len=0;
                    int sep=(int)Math.ceil((float)strength/2);
                    while(len<sep){%>
                        <tr>
                            <td align="center"><%=len+1%></td>
                            <td><%=fid[len]%></td>
                            <td><%=fname[len]%></td>
                            <td width="1" style="border-width:0;background-color:#9999ff" ></td>
                            <%if(len<strength/2){%>
                                <td align="center" ><%=len+1+sep%></td>
                                <td><%=fid[len+sep]%></td>
                                <td><%=fname[len+sep]%></td>
                            <%}%>
                        </tr>  
                    <%len++;
                    }%>
                    </table>
            <%}
            else{%>
            <table cellspacing="0" border="5" align="center" width="900">
                    <tr height="40" bgcolor= "#9999ff" align="center">
                        <th>S.NO</th>
                        <th>FID</th>
                        <th>Name</th>
                        <th width="1" style="border:0;background-color:#9999ff " ></th>
                        <th>S.NO</th>
                        <th>FID</th>
                        <th>Name</th>
                        <th width="1" style="border:0;background-color:#9999ff " ></th>
                        <th>S.NO</th>
                        <th>FID</th>
                        <th>Name</th>
                    </tr>
                    <%int len=0;
                    int sep=(int)Math.ceil((float)strength/3);
                    while(len<sep){%>
                        <tr>
                            <td align="center"><%=len+1%></td>
                            <td><%=fid[len]%></td>
                            <td><%=fname[len]%></td>
                            <td width="1" style="border-width:0;background-color:#9999ff" ></td>
                            <td align="center"><%=len+1+sep%></td>
                            <td><%=fid[len+sep]%></td>
                            <td><%=fname[len+sep]%></td>
                            <td width="1" style="border-width:0;background-color:#9999ff" ></td>
                            <%if(len+2*sep<strength){%>
                                <td align="center" ><%=len+1+2*sep%></td>
                                <td><%=fid[len+2*sep]%></td>
                                <td><%=fname[len+2*sep]%></td>
                            <%}%>
                        </tr>  
                    <%len++;
                    }%>
                    </table>
            <%}
        }else{%>
            <h3><center>No Data Found!</center></h3>
        <%}             
      //<%--if(rs.next()){%>
        <%--<table border="1" cellspacing="0" align="center" width="300">
            <tr style="height: 10mm;background-color: #9999ff">
                <th>
                    FID
                </th>
                <th>
                    FACULTY
                </th>
            </tr>
            <tr style="height: 8mm;font-weight: bold">
                <td align="center">
                    <%=rs.getString("FID")%>
                </td>
                <td>
                    <%=rs.getString("FNAME")%>
                </td>
            </tr>
            <%while(rs.next()){%>
            <tr style="height: 8mm;font-weight: bold">
                <td align="center">
                    <%=rs.getString("FID")%>
                </td>
                <td>
                    <%=rs.getString("FNAME")%>
                </td>
            </tr>
            <%}%>
        </table>
        <!--<table align="center" style="margin-top: 10px">
        <tr style="height: 10mm">
                <td colspan="2">
                    <form>
                        <button type="submit">Edit</button>
                    </form>
                </td>
            </tr>
        </table>-->
        <%}
        else{
            out.println("No Faculty Found ! ");
        }--%>
        <%con.close();
    }
    catch(Exception e){
        out.println("<center>"+e+"</center>");%>
        <h3><center><input type="button" value="Back" class="redbutton" onclick="history.go(-1);" /></center></h3>
    <%}%> 
<%}
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

