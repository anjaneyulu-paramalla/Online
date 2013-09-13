/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function validateLog(){
    var err="";
    err+=validateUaccount(document.getElementById("uaccount").value);
    err+=validateDepartment(document.getElementById("department").value);
    err+=validateUname(document.getElementById("uname").value);
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
    if(u!="Student" && u!="Faculty" && u!="Administrator" && u!="Administrator-2"){
        return "Account not selected!\n"
    }
    else
        return "";
}
function validateDepartment(u){
    if(u=="Student" || u=="Administrator"){
        if(u!="IT" && u!="BT" && u!="BME" && u!="CIVIL" && u!="CSE" && u!="ECE" && u!="EEE" && u!="MECH" ){
            return "Department not selected!\n"
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
function changeBehaviour(){
    var acc=document.getElementById("uaccount").value;
    if(acc=="Student"){
        document.getElementById("department").disabled=false;
        document.getElementById("department").style.background="#ffffff";
    }
    else if(acc=="Faculty"){
        document.getElementById("department").disabled=true;
        document.getElementById("department").style.background="#bbbbbb";
    }
    else if(acc=="Administrator"){
        document.getElementById("department").disabled=false;
        document.getElementById("department").style.background="#ffffff";
    }
    else if(acc=="Administrator-2"){
        document.getElementById("department").disabled=true;
        document.getElementById("department").style.background="#bbbbbb";
    }
}
function change(){
    changeBehaviour();
}
