/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function ctrlForm() {
    var err = false;
    err = checkObblFields() ? true : err;
    var email = $("input[name='email[]']");
    $.each(email, function (i, e) {
        err = checkEmail($(e)) ? true : err;
    });
    return err;
}
$('#submit').on('click', function () {
    if (!ctrlForm()) {
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

                    swalCountDownFunc("Conferenza Creata Con Successo", "ti connetterai automaticamnte tra:",
                            function connectFAD() {
                                var form = $("#goFAD");
                                form.attr("action", json.link);
                                $("#id").val(json.id);
                                $("#password").val(json.pwd);
                                $("#user").val(json.email);
                                form.submit();
                            });
                } else {
                    swalError("Errore!", json.message);
                }
            }
        });
    }
});

$("#add").click(function () {
    $("#paretcipant").append('<div class="input-group">'
            + '<div class="input-group-prepend">'
            + '<a class="btn btn-primary btn-icon"><i class="fa fa-at"></i></a>'
            + '</div>'
            + '<input type="text" name="email[]" class="form-control obbligatory" placeholder="Email">'
            + '<div class="input-group-append">'
            + '<a title="Elimina" data-container="body" data-html="true" data-toggle="kt-tooltip" href="javascript:void(0);" class="btn btn-danger btn-icon delete"><i class="fa fa-times"></i></a>'
            + '</div>'
            + '</div>');
    $('[data-toggle="kt-tooltip"]').tooltip();
    delete_event();
});

function delete_event() {
    $("a.delete").click(function () {
        $('[data-toggle="kt-tooltip"]').tooltip('dispose');
        $($(this).parent()).parent().remove();
        $('[data-toggle="kt-tooltip"]').tooltip();
        if ($("input[name='email[]']").length == 0) {
            $("#add").trigger("click");
        }
    });
}

function blockspecialcharacter(e) {
    e = (e) ? e : window.event;
    var key = document.all ? key = e.keyCode : key = e.which;
    return ((key > 64 && key < 91) || (key > 96 && key < 123) || key == 8 || key == 32 || "0123456789".includes(e.key) || "èéòàù".includes(e.key));
}

var days = ["Do", "Lu", "Ma", "Me", "Gi", "Ve", "Sa"];
var months = ["Gennaio", "Febbraio", "Marzo", "April", "Maggio", "Giugno", "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre"];

jQuery(document).ready(function () {
    $('#range').daterangepicker({
        timePicker: true,
        autoApply: true,
        timePickerIncrement: 5,
        locale: {
            firstDay: 1,
            format: 'DD/MM/YYYY HH:mm',
            daysOfWeek: days,
            monthNames: months,
        }
    });

});
