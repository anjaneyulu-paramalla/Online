/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function checkall(t,dept){
    var count=document.getElementById("count"+dept).value;
    var i=1;
    while(i<=count){
        document.getElementById("check"+dept+i).checked=true;
        i++;
    }
}
function uncheckall(t,dept){
    var count=document.getElementById("count"+dept).value;
    var i=1;
    while(i<=count){
        document.getElementById("check"+dept+i).checked=false;
        i++;
    }
}
function check(t,dept){ 
    var count=document.getElementById("count"+dept).value;
    var i=1;
    var flag=false;
    while(i<=count){
        if(document.getElementById("check"+dept+i).checked==true){
            flag=true;
            break;
        }
        i++;
    }
    if(!flag){
       alert("Sorry,\nyou didn't select any faculty of "+dept+" Department!"); 
       return false;
    }
    else
        return true;
}