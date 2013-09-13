/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function checkall(t,sect){
    var count=document.getElementById("count"+sect).value;
    var i=1;
    while(i<=count){
        document.getElementById("check"+sect+i).checked=true;
        i++;
    }
}
function uncheckall(t,sect){
    var count=document.getElementById("count"+sect).value;
    var i=1;
    while(i<=count){
        document.getElementById("check"+sect+i).checked=false;
        i++;
    }
}
function check(t,sect){ 
    var count=document.getElementById("count"+sect).value;
    var i=1;
    var flag=false;
    while(i<=count){
        if(document.getElementById("check"+sect+i).checked==true){
            flag=true;
            break;
        }
        i++;
    }
    if(!flag){
       alert("Sorry,\nyou didn't select any student of "+sect+" section!"); 
       return false;
    }
    else
        return true;
}