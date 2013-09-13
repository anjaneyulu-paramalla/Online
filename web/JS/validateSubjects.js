/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function validateSubjects(t){
    var count=t.sub.value;
    alert(count);
    var i=0,err="",errCount=0;
    while(i<count){
        var c1=document.getElementById((i+1)+"s");
        var c2=document.getElementById((i+1)+"c");
        var c3=document.getElementById((i+1)+"f");
        if(c1==null||c2==null||c3.value=="Select"){
            errCount++;
            if(i<count-1)
                err+=i+1+",";
            else
                err+=i+1;
        }
        i++;
    }
    if(err=="")
        return true;
    else{
        if(errCount>1)
            alert("Please fill the subjects "+err+" competely!");
        else
            alert("Please fill the subject "+err+" competely!");
        return false;
    }
}