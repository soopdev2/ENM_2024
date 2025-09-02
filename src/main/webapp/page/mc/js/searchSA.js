/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

var context = document.getElementById("context");

function CFPresent() {
    var err;
    if ($('#cf_sa').val() != $('#prevcf').val()) {
        $.ajax({
            type: "GET",
            async: false,
            url: context + '/OperazioniMicro?type=checkCF&cf=' + $('#cf_sa').val(),
            success: function (data) {
                if (data != null && data != 'null') {
                    $('#warning_cf').css("display", "");
                    $('#cf_sa').attr("class", "form-control is-invalid");
                    err = true;
                } else {
                    $("#warning_cf").css("display", "none");
                    $('#cf_sa').attr("class", "form-control is-valid");
                    err = false;
                }
            }
        });
    } else {
        err = false;
    }
    return err;
}

function pivaPresent() {
                var err;
                if ($('#piva_sa').val() != $('#prevpiva').val()) {
                    $.ajax({
                        type: "GET",
                        async: false,
                        url: context + '/OperazioniMicro?type=checkPiva&piva=' + $('#piva_sa').val(),
                        success: function (data) {
                            if (data != null && data != 'null') {
                                $('#warning_iva').css("display", "");
                                $('#piva_sa').attr("class", "form-control is-invalid");
                                err = true;
                            } else {
                                $("#warning_iva").css("display", "none");
                                $('#piva_sa').attr("class", "form-control is-valid");
                                err = false;
                            }
                        }
                    });
                } else {
                    err = false;
                }
                return err;
            }

  function upDoc(id, fdata) {
                $.ajax({
                    type: "POST",
                    url: context + '/OperazioniMicro?type=uploadPec&idsa=' + id,
                    data: fdata,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        var json = JSON.parse(data);
                        if (json.result) {
                            swalSuccessReload("Documento Caricato", "Operazione effettuata con successo");
                        } else {
                            swalError("Errore", json.message);
                        }
                    },
                    error: function () {
                        swalError("Errore", "Non è stato possibile caricare il documento");
                    }
                });
            }
            
            function refresh() {
                $("#toolbar").css("display", "none");
                $('html, body').animate({scrollTop: $('#offsetresult').offset().top}, 500);
                load_table($('#kt_table_1'), context + '/QueryMicro?type=searchSA&ragionesociale=' + $('#ragionesociale').val()
                        + '&protocollo=' + $('#protocollo').val() + '&piva=' + $('#piva').val() + '&cf=' + $('#cf').val() + '&protocollare='
                        + $('input[name=protocollare]:checked').val() + '&nome=' + $('#nome').val() + '&cognome=' + $('#cognome').val());
            }