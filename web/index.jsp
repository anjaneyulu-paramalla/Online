<%-- 
    Document   : index
    Created on : Feb 7, 2013, 7:58:20 PM
    Author     : Anji
--%>

<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Error.jsp"%>
<!DOCTYPE html>
<%
if((session.getAttribute("UID")==null || session.getAttribute("UYEAR")==null || session.getAttribute("USECTION")==null || session.getAttribute("SDEPT")==null) && (session.getAttribute("AID")==null ||session.getAttribute("DEPT")==null) &&(session.getAttribute("PID")==null || session.getAttribute("PYEAR")==null || session.getAttribute("PSECTION")==null || session.getAttribute("PCOURSE")==null) && (session.getAttribute("PAID")==null ||session.getAttribute("PACOURSE")==null)  && (session.getAttribute("FACID")==null ||session.getAttribute("FACDEPT")==null) && (session.getAttribute("FACAID")==null )){%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::GRIET</title>
        <link rel="stylesheet" href="CSS/login.css" />
        <script type="text/javascript" src="JS/Validate.js"></script>
        <!--script type="text/javascript" src="JS/resolution.js"></script-->
    </head>
    <body style="background-image: url(IMAGES/back.jpg);background-size: 100% 160%;background-repeat: repeat-x;background-color:#00a9e7 " onload="change()">
        <center><img src="./IMAGES/logo.jpg" height="150" width="1000" /></center>
        <table width="1000"  align="center" style="margin-top: -10px;margin-bottom: 0px">
            <tr>
                <td width="150"></td>
                <td width="700"><marquee behavior="alternate" scrollamount="2"><font face="algerian" size="4" color="#E62E00"><b>GOKARAJU RANGARAJU INSTITUTE OF ENGINEERING & TECHNOLOGY</b></font></marquee ></td>
                <td></td>
            </tr>
        </table>
        <table width="1000" border="2" align="center" cellspacing="0" class="Main" style="border-bottom-width: 0px" >
            <tr>
                <td  align="center" colspan="3" class="Ftitle">ONLINE FEEDBACK SYSTEM</td>
            </tr>
            <tr>
                <td width="700" height="380" valign="top" style="background-color: aliceblue">
                   <table  width="100%" >
                       <tr>
                           <th width="5">
                           <th  align="left" ><p style="color: #BF1D1C;font-size: 24px">About GRIET</p></th>
                       </tr>
                       <tr>
                           <td></td>
                           <th align="left" style="color: #B3781A;font-size: 22px">
                               Vision
                           </th>
                       </tr>
                       <tr>
                           <td></td>
                           <td>
                               <p style="font-size: 20px;margin-top: 5px;margin-left: 10px">To be among the best of the institutions for engineers and 
                    technologists with attitudes, skills and knowledge and to become an epicenter of 
                    creative solutions.</p>
                           </td>
                       </tr>
                       <tr>
                           <td></td>
                           <th align="left" style="color: #B3781A;font-size: 22px">
                               Mission
                           </th>
                       </tr>
                       <tr  >
                           <td></td>
                           <td >
                               <p style="font-size: 20px;margin-top: 5px;margin-left: 10px">
                                   To acheive and impart quality education with an emphasis on practical skills and social relevance.
                               </p>
                           </td>
                       </tr>
                       <tr>
                           <td></td>
                           <th align="left" style="color: #B3781A;font-size: 22px">Quality Policy</th>
                       </tr>
                       <tr>
                           <td></td>
                           <td>
                               <p style="font-size: 20px;margin-top: 5px;margin-left: 10px">
                                   To provide an integrated learning environment to enable students 
                    to grow towards their full potential and meet the high expectations of the 
                    Industry and the Society.
                               </p>
                           </td>
                       </tr>
                   </table>
                </td>
                <td width="1" class="vline"></td> 
                <td valign="top" align="right" class="login"  height="350" >
                    <table> 
                        <form id="log" name="log"  action="verify.jsp" method="post" >
                            <tr height="6mm" />
                            <tr><td colspan="2" align="center" ><img src="IMAGES/login.jpg"  /></td></tr>
                            <tr>
                                <td align="right" valign="bottom" ><b>Account</b></td>
                                <td align="left">
                                    <select id="uaccount" name="uaccount" onchange="changeBehaviour()" >
                                        <%String uac=request.getParameter("uaccount"); 
                                        if(uac!=null && uac.toLowerCase().equals("student")){%>
                                            <option selected>Student</option>
                                        <%}
                                        else{%>
                                            <option>Student</option>
                                        <%}
                                        if(uac!=null && uac.toLowerCase().equals("faculty")){%>
                                        <option selected>Faculty</option>
                                        <%}
                                        else{%>
                                            <option>Faculty</option>
                                        <%}
                                        if(uac!=null && uac.toLowerCase().equals("administrator")){%>
                                            <option selected>Administrator</option>
                                        <%}
                                        else{%>
                                            <option>Administrator</option>
                                        <%}
                                        if(uac!=null && uac.toLowerCase().equals("administrator-2")){%>
                                            <option selected>Administrator-2</option>
                                        <%}
                                        else{%>
                                            <option>Administrator-2</option>
                                        <%}%>
                                    </select>
                                </td>
                            </tr>
                            <tbody>
                            <tr height="8px "/>
                            <tr>
                                <td align="right" valign="bottom" ><b>Course</b></td>
                                <td align="left" >
                                    <select id="course" name="ucourse" onchange="changeList()">
                                        <%String ucourse=request.getParameter("course");
                                        if(ucourse!=null &&ucourse.equals("B.Tech")) {%>
                                            <option selected>B.Tech</option>
                                        <%}
                                       else{%>
                                            <option>B.Tech</option>
                                       <%}
                                       if(ucourse!=null &&ucourse.equals("M.Tech")) {%>
                                            <option selected>M.Tech</option>
                                        <%}
                                       else{%>
                                            <option>M.Tech</option>
                                       <%}
                                       if(ucourse!=null &&ucourse.equals("MBA")) {%>
                                            <option selected>MBA</option>
                                        <%}
                                       else{%>
                                            <option>MBA</option>
                                       <%}
                                       if(ucourse!=null &&ucourse.equals("MCA")) {%>
                                            <option selected>MCA</option>
                                        <%}
                                       else{%>
                                            <option>MCA</option>
                                       <%}%>
                                    </select>
                                </td>
                            </tr>
                            <tr height="8px "/>
                            <tr id="btechspec">
                                <td align="right" valign="bottom"><b>Department</b></td>
                                <td align="left" >
                                    <select id="department" name="udept">
                                        <%String udept=request.getParameter("department");
                                        if(udept!=null &&udept.equals("IT")) {%>
                                            <option selected>IT</option>
                                        <%}
                                       else{%>
                                       <option>IT</option>
                                       <%}%>
                                       <%if(udept!=null &&udept.equals("BT")) {%>
                                            <option selected>BT</option>
                                        <%}
                                       else{%>
                                       <option>BT</option>
                                       <%}%>
                                       <%if(udept!=null && udept.equals("BME")) {%>
                                            <option selected>BME</option>
                                       <%}
                                       else{%>
                                            <option>BME</option>
                                       <%}%>
                                       <%if(udept!=null && udept.equals("CIVIL")) {%>
                                            <option selected>CIVIL</option>
                                        <%}
                                       else{%>
                                       <option>CIVIL</option>
                                       <%}%>
                                       <%if(udept!=null && udept.equals("CSE")) {%>
                                            <option selected>CSE</option>
                                       <%}
                                       else{%>
                                            <option>CSE</option>
                                       <%}%>
                                       <%if(udept!=null && udept.equals("ECE")) {%>
                                            <option selected>ECE</option>
                                        <%}
                                       else{%>
                                            <option>ECE</option>
                                       <%}%>
                                       <%if(udept!=null && udept.equals("EEE")) {%>
                                            <option selected>EEE</option>
                                        <%}
                                       else{%>
                                            <option>EEE</option>
                                       <%}%> 
                                       <%if(udept!=null &&udept.equals("MECH")) {%>
                                            <option selected>MECH</option>
                                        <%}
                                       else{%>
                                            <option>MECH</option>
                                       <%}%>
                                       <%if(udept!=null &&udept.equals("MCA")) {%>
                                            <option selected>MCA</option>
                                        <%}
                                       else{%>
                                            <option>MCA</option>
                                       <%}%>
                                    </select>
                                </td>
                            </tr>
                            <tr style="display:none" id="mtechspec">
                                <td align="right" valign="bottom" ><b>Specialization</b></td>
                                <td align="left" >
                                    <select id="mtechdepartment" name="mtechudept">
                                       <%String mtechudept=request.getParameter("mtechdepartment");
                                       if(mtechudept!=null &&mtechudept.equals("CSE-MT")) {%>
                                            <option selected>CSE-MT</option>
                                       <%}
                                       else{%>
                                            <option>CSE-MT</option>
                                       <%}
                                       if(mtechudept!=null &&mtechudept.equals("EC")) {%>
                                            <option selected>EC</option>
                                       <%}
                                       else{%>
                                            <option>EC</option>
                                       <%} 
                                       if(mtechudept!=null &&mtechudept.equals("DFM")) {%>
                                            <option selected>DFM</option>
                                       <%}
                                       else{%>
                                            <option>DFM</option>
                                       <%}
                                       if(mtechudept!=null &&mtechudept.equals("PE")) {%>
                                            <option selected>PE</option>
                                       <%}
                                       else{%>
                                            <option>PE</option>
                                       <%}
                                       if(mtechudept!=null &&mtechudept.equals("SE")) {%>
                                            <option selected>SE</option>
                                       <%}
                                       else{%>
                                            <option>SE</option>
                                       <%}
                                       if(mtechudept!=null &&mtechudept.equals("VLSI")) {%>
                                            <option selected>VLSI</option>
                                       <%}
                                       else{%>
                                            <option>VLSI</option>
                                       <%}%>
                                    </select>
                                </td>
                            </tr>
                            <tr style="display:none" id="mbaspec">
                                <td align="right" valign="bottom" ><b>Specialization</b></td>
                                <td align="left" >
                                    <select id="mbadepartment" name="mbaudept">
                                        <%String mbaudept=request.getParameter("mbadepartment");
                                        if(mbaudept!=null &&mbaudept.equals("HR")) {%>
                                            <option selected>HR</option>
                                        <%}
                                       else{%>
                                            <option>HR</option>
                                       <%}%>
                                       <%if(mbaudept!=null &&mbaudept.equals("MA")) {%>
                                            <option selected>MA</option>
                                        <%}
                                       else{%>
                                            <option>MA</option>
                                       <%}%> 
                                    </select>
                                </td>
                            </tr>
                           <!-- <tr style="display:none" id="mcaspec">
                                <td align="right" valign="bottom" ><b>Specialization</b></td>
                                <td align="left" >
                                    <select id="mcadepartment" name="mcaudept">
                                        <%String mcaudept=request.getParameter("mcadepartment");
                                        if(mcaudept!=null &&mcaudept.equals("CS")) {%>
                                            <option selected>CS</option>
                                        <%}
                                       else{%>
                                            <option>CS</option>
                                       <%}%>
                                    </select>
                                </td>
                            </tr>-->
                            </tbody>
                            <tr id="extraspace" height="8px "/>
                            <tr><td align="right" valign="bottom" >User ID</td><td align="left" ><input  type="text" id="uname" name="uname"/></td></tr>
                            <tr height="8px "/>
                            <tr><td align="right" valign="bottom" >Password</td><td align="left" ><input onkeypress="handleEnter(this, event)" type="Password" id="upwd" name="upwd"/></td></tr>
                            <tr height="8px "/>
                            <tr><td colspan="2" align="left" style="color:red;font-weight:bold" >
                                    <noscript>
                                    <table >
                                        <tr><td >
                                        <div style="max-width: 280px;">        
                                        <% String s=request.getParameter("invalid");
                                        if(s!=null){
                                            if(s.equals("Empty UserID/Paswword")){%>
                                                User Id/Password is empty!
                                            <%}
                                             else{%>
                                                Invalid User ID/Password!
                                            <%}
                                        }%>
                                        </div>
                                        </td></tr>
                                    </table>
                                    </noscript>
                                </td>
                            </tr>
                            <tr><td ></td><td align="left" >  &nbsp;<input type="button" value="Log In" class="button" onclick="return validateLog()" /></td></tr>
                            <tr><td colspan="2" align="center" >  &nbsp;<a class="cant" href="recovery.jsp" target="_blank" >Can't access your account?</a></td></tr>
                            <tr><td colspan="2" ><hr/></td></tr>
                        </form>
                 </table>
                 <table >
                     <tr>
                         <td align="left">
                             <b><span style="color:#cc3300;font-size: 120%">Tip:</span></b><span style="color: #000000;font-weight: normal">&nbsp;&nbsp;Hold '<b>Ctrl</b>' and use '<b>+</b>' or '<b style="font-family: arial">-</b>' to fit the screen to your browser!</span>
                         </td>
                     </tr>
                 </table>
                </td>
            </tr>
            <% 
            Calendar calendar=Calendar.getInstance();
            int CYear=calendar.get(Calendar.YEAR);
            %> 
            <tr class="ref "><td colspan="3" class="cap"><b>Copyright &copy; <%=CYear%> This site content is licensed under a <a href="license.jsp" target="_blank">MIT License</a>.Best viewed with a resolution 
        of 1024x768 or above.</b></td></tr>
        </table>
    </body>
    <%String str=request.getParameter("invalid");
        if(str!=null ){%>
            <script language="javascript" type="text/javascript">
                alert("Invalid Credentials");
            </script>
        <%}%>
</html>
<%}
else if(session.getAttribute("UID")!=null && session.getAttribute("UYEAR")!=null && session.getAttribute("USECTION")!=null && session.getAttribute("SDEPT")!=null){%>
    <jsp:forward page="Main.jsp" />
<%}
else if(session.getAttribute("AID")!=null && session.getAttribute("DEPT")!=null){%>
    <jsp:forward page="AdminMain.jsp" />
<%}
else if(session.getAttribute("PID")!=null && session.getAttribute("PYEAR")!=null && session.getAttribute("PSECTION")!=null && session.getAttribute("PCOURSE")!=null){%>
    <jsp:forward page="PGMain.jsp" />
<%}
else if(session.getAttribute("PAID")!=null && session.getAttribute("PACOURSE")!=null){%>
    <jsp:forward page="PGAdminMain.jsp" />
<%}
else if(session.getAttribute("FACID")!=null && session.getAttribute("FACDEPT")!=null){%>
    <jsp:forward page="FacMain.jsp" />
<%}
else if((session.getAttribute("FACAID")!=null)){%>
    <jsp:forward page="FacAdminMain.jsp" />
<%}%>