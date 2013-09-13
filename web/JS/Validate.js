/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function handleEnter(inField, e) {
    var charCode;
    if(e && e.which){
        charCode = e.which;
    }
    else if(window.event){
        e = window.event;
        charCode = e.keyCode;
    }
    if(charCode == 13) {
        validateLog();
    }
}
function validateLog(){
    var err="";
    //err+=validateUaccount(document.getElementById("uaccount").value);
    //err+=validateCourse(document.getElementById("course").value);
    //err+=validateDepartment(document.getElementById("department").value);
    err+=validateUname(document.getElementById("uname").value);
    err+=validatePwd(document.getElementById("upwd").value);
    if(err==""){
        document.getElementById("log").submit();
        return true;   
    }
    else{
        alert(err);
        return false;
    }
}
function validateUaccount(u){
    if(u=="Student" || u=="Faculty" || u=="Administrator" || u=="Administrator-2"){
        return "";
    }
    else
        return "Account not selected!\n"
}
function validateCourse(u){
    if(u=="B.Tech" || u=="M.Tech" || u=="MBA" || u=="MCA"){
        return "";
    }
    else
        return "Course not selected!\n"
}
function validateDepartment(u){
    if(u=="Student" || u=="Administrator"){
        if(u!="IT" && u!="BT" && u!="BME" && u!="CIVIL" && u!="CSE" && u!="ECE" && u!="EEE" && u!="MECH" ){
            return "Department not selected!\n";
        }
        else
            return "";
    }
    else
        return "";
}
function validateUname(u){
    var user=u;
    if(user=="")
        return "User ID cannot be empty\n"
    else 
        return "";
}
function validatePwd(p){
    var pwd=p;
    if(pwd=="")
        return "Password cannot be empty\n"
    else
        return "";
}
function changeBehaviour(){
    var acc=document.getElementById("uaccount").value;
    if(acc=="Student"){
        document.getElementById("course").disabled=false;
        document.getElementById("department").disabled=false;
        document.getElementById("mtechdepartment").disabled=false;
        document.getElementById("mbadepartment").disabled=false;
        //document.getElementById("mcadepartment").disabled=false;
        document.getElementById("course").style.background="#ffffff";
        document.getElementById("department").style.background="#ffffff";
        document.getElementById("mtechdepartment").style.background="#ffffff";
        document.getElementById("mbadepartment").style.background="#ffffff";
        //document.getElementById("mcadepartment").style.background="#ffffff";
    }
    else if(acc=="Faculty"){
        document.getElementById("course").disabled=true;
        document.getElementById("department").disabled=true;
        document.getElementById("mtechdepartment").disabled=true;
        document.getElementById("mbadepartment").disabled=true;
        //document.getElementById("mcadepartment").disabled=true;
        document.getElementById("course").style.background="#bbbbbb";
        document.getElementById("department").style.background="#bbbbbb";
        document.getElementById("mtechdepartment").style.background="#bbbbbb";
        document.getElementById("mbadepartment").style.background="#bbbbbb";
        //document.getElementById("mcadepartment").style.background="#bbbbbb";   
    }
    else if(acc=="Administrator"){
        document.getElementById("course").disabled=false;
        document.getElementById("department").disabled=false;
        document.getElementById("mtechdepartment").disabled=false;
        document.getElementById("mbadepartment").disabled=false;
        //document.getElementById("mcadepartment").disabled=false;
        document.getElementById("course").style.background="#ffffff";
        document.getElementById("department").style.background="#ffffff";
        document.getElementById("mtechdepartment").style.background="#ffffff";
        document.getElementById("mbadepartment").style.background="#ffffff";
        //document.getElementById("mcadepartment").style.background="#ffffff";
    }
    else if(acc=="Administrator-2"){
        document.getElementById("course").disabled=true;
        document.getElementById("department").disabled=true;
        document.getElementById("mtechdepartment").disabled=true;
        document.getElementById("mbadepartment").disabled=true;
        //document.getElementById("mcadepartment").disabled=true;
        document.getElementById("course").style.background="#bbbbbb";
        document.getElementById("department").style.background="#bbbbbb";
        document.getElementById("mtechdepartment").style.background="#bbbbbb";
        document.getElementById("mbadepartment").style.background="#bbbbbb";
        //document.getElementById("mcadepartment").style.background="#bbbbbb";
    }
    changeList();
}
function changeList(){
    var course=document.getElementById("course").value;
    if(course=="B.Tech"){
        document.getElementById("btechspec").style.display="table-row";
        document.getElementById("mtechspec").style.display="none";
        document.getElementById("mbaspec").style.display="none";
        /*document.getElementById("mcaspec").style.display="none";*/
        document.getElementById("extraspace").style.display="table-row";
    }
    else if(course=="M.Tech"){
        document.getElementById("mtechspec").style.display="table-row";
        document.getElementById("btechspec").style.display="none";
        document.getElementById("mbaspec").style.display="none";
        /*document.getElementById("mcaspec").style.display="none";*/
        document.getElementById("extraspace").style.display="table-row";
    }
    else if(course=="MBA"){
        document.getElementById("mbaspec").style.display="table-row";
        document.getElementById("btechspec").style.display="none";
        document.getElementById("mtechspec").style.display="none";
        /*document.getElementById("mcaspec").style.display="none";*/
        document.getElementById("extraspace").style.display="table-row";
    }
    else if(course=="MCA"){
        document.getElementById("extraspace").style.display="none";
        //document.getElementById("mcaspec").style.display="table-row";
        document.getElementById("btechspec").style.display="none";
        document.getElementById("mtechspec").style.display="none";
        document.getElementById("mbaspec").style.display="none";
    }
}
function change(){
    changeBehaviour();
}