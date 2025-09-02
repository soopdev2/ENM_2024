/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$('#upfile').on("click", function () {
    $('#tipo_op').val('');
    if (!checkPdf()) {
        showLoad();
        $('#kt_form2').ajaxSubmit({
            error: function () {
                closeSwal();
                swalError('Errore', "Riprovare, se l'errore persiste richiedere assistenza");
            },
            success: function (resp) {
                var json = JSON.parse(resp);
                closeSwal();
                if (json.result) {
                    swalSuccessCloseFancy("Caricamento modello 2", "Operazione effettuata con successo.");
                } else {
                    swalError('Errore', "<h4>" + json.message + "</h4>");
                }
            }
        });
    }
});

function ctrlForm() {
    var err = checkObblFields();
    if ($('#allievi').val().length < min_allievi || $('#allievi').val().length > max_allievi) {//chek num max e min allievi
        err = true;
        $('#allievi_div').removeClass("is-valid-select").addClass("is-invalid-select");
        fastSwalShow("<h3>Numero minimo di allievi non raggiunto</h3>", "wobble");
    }
    return err;
}

function download_m2() {
    $('#tipo_op').val('download');
    $('#kt_form2').submit();
}

function checkPdf() {
    let err = false;
    $('#file_m2').each(function () {
        if ($(this).val() === '') {
            err = true;
            $(this).removeClass("is-valid").addClass("is-invalid");
        } else {
            $(this).removeClass("is-invalid").addClass("is-valid");
        }
    });
    return err;
}
