/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

var context = document.getElementById("context");

$('#regione').on('change', function (e) {
    $("#provincia").empty();
    $("#comune").empty();
    $("#comune").append('<option value="-">. . .</option>');
    if ($('#regione').val() !== '-') {
        startBlockUILoad("#provincia_div");
        $("#provincia").append('<option value="-">Seleziona Provincia</option>');
        $.get(context + '/Login?type=getProvincia&regione=' + $('#regione').val(), function (resp) {
            var json = JSON.parse(resp);
            for (var i = 0; i < json.length; i++) {
                $("#provincia").text('<option value="' + json[i].value + '">' + json[i].desc + '</option>');
            }
            stopBlockUI("#provincia_div");
        });
    } else {
        $("#provincia").append('<option value="-">. . .</option>');
    }
});

$('#provincia').on('change', function (e) {
    $("#comune").empty();
    if ($('#provincia').val() !== '-') {
        startBlockUILoad("#comune_div");
        $("#comune").append('<option value="-">Seleziona Comune</option>');
        $.get(context + '/Login?type=getComune&provincia=' + $('#provincia').val(), function (resp) {
            var json = JSON.parse(resp);
            for (var i = 0; i < json.length; i++) {
                $("#comune").text('<option value="' + json[i].value + '">' + json[i].desc + '</option>');
            }
            stopBlockUI("#comune_div");
        });
    } else {
        $("#comune").append('<option value="-">. . .</option>');
    }
});
function ctrlForm() {
    var err = false;
    err = checkObblFields() ? true : err;
    if ($('#email').val() !== '') {
        err = checkEmail($('#email')) ? true : err;
    }
    return err ? false : true;
}
$('#submit').on('click', function () {
    if (ctrlForm()) {
        showLoad();
        $('#kt_form').ajaxSubmit({
            error: function () {
                closeSwal();
                swalError("Errore", "Riprovare, se l'errore persiste contattare l'assistenza");
            },
            success: function (resp) {
                var json = JSON.parse(resp);
                closeSwal();
                if (json.result) {
                    resetInput();
                    swalSuccess("Sede di formazione aggiunta!", "Operazione effettuata con successo.");
                } else {
                    swalError("Errore!", json.message);
                }
            }
        });
    }
});


function ctrlFile() {
    var err = false;
    err = !checkRequiredFile() ? true : err;
    err = !checkFileExtAndDim(['xls', 'xlsx']) ? true : err;
    return err ? false : true;
}

$('#submit_file').on('click', function () {
    if (ctrlFile()) {
        showLoad();
        $('#kt_form_file').ajaxSubmit({
            error: function () {
                closeSwal();
                swalError("Errore", "Riprovare, se l'errore persiste contattare l'assistenza");
            },
            success: function (resp) {
                var json = JSON.parse(resp);
                closeSwal();
                if (json.result) {
                    $('.custom-file-input').val('');
                    $('.custom-file-input').removeClass('is-valid');
                    swalSuccess("Aula aggiunta!", "Operazione effettuata con successo.");
                } else {
                    swalError("Errore!", json.message);
                }
            }
        });
    }
});