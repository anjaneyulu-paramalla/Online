/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

window.onload = check_width
function check_width() {
    var correctwidth=1500;
    //var correctheight=800;
    // You can personalize "correctwidth" according to your layout.
    if (screen.width!=correctwidth) { 
        //document.body.style.zoom= screen.width / correctwidth; 
        //document.body.style.zoom=screen.height/correctheight;
     }
}