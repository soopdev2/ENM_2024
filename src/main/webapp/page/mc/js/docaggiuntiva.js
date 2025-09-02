/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function changesino() {

    try {
        var sino = $('#tos_m0_volonta').val();
        if (sino === "1") {
            document.getElementById("div_volontasi").style.display = "";
            document.getElementById("div_volontano").style.display = "none";
        } else {
            document.getElementById("div_volontasi").style.display = "none";
            document.getElementById("div_volontano").style.display = "";

        }
    } catch (e) {
        console.error(e);
    }




}
function changealtro() {

    try {
        var noper = $('#tos_m0_noperche').val();
        if (noper === "7") {
            document.getElementById("div_altrospec").style.display = "";
        } else {
            document.getElementById("div_altrospec").style.display = "none";
        }
    } catch (e) {
        console.error(e);
    }
}

jQuery(document).ready(function () {
    changesino();
    changealtro();
});