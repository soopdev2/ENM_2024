/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

var context = document.getElementById("context");
function ctrlForm() {
    var err = false;
    err = checkObblFields() ? true : err;
    //29-04-2020 MODIFICA - TOGLIERE IMPORTO CHECKLIST
//                if ($('#kt_inputmask_7').inputmask('unmaskedvalue') != "") {
//                    $('#kt_inputmask_7').removeClass("is-invalid").addClass("is-valid");
//                } else {
//                    $('#kt_inputmask_7').removeClass("is-valid").addClass("is-invalid");
//                    err = true;
//                }
    return !err;
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
                    var message = json.message != null ? "<h4>" + json.message + "</h4>" : "";
                    console.log(json);
//                                if (true) {
                    message += "<a href='" + context + "/OperazioniGeneral?type=downloadDoc&path=" + json.filedl + "' ><u><b>Clicca qui se il download non è iniziato.</b></u></a> ";//<i class='fa fa-cloud-download-alt'></i>
                    swalSuccessReload2("Checklist 2", message);
                    //dowbload automatico del file                                
                    var a = document.createElement('a');
                    a.href = context + '/OperazioniGeneral?type=downloadDoc&path=' + json.filedl;
                    document.body.appendChild(a);
                    a.click();
                    a.remove();
//                                } else {
//                                    swalSuccess("Checklist 2", message);
//                                }
                } else {
                    swalError("Errore!", json.message);
                }
            }
        });
    }

});
var allievi_old = [];
$('#allievi').on("change", function () {
    docsAllievi();
});
$('#allievi').select2({//setta placeholder nella multiselect
    placeholder: "Seleziona Allievi",
});
jQuery(document).ready(function () {
    docsAllievi();
});
function docsAllievi() {
    var allievi = $('#allievi').val();
    var input = "<div id='docs_@id' class='col-lg-12 col-md-12'>"
            + "<label><b>@nome</b></label>"
            + "<div class='row customcheck'>"
            + "<table style='width:100%;'>"
            + "<thead>"
            + "<tr style='font-size:13px;'>"
            + "<th style='width:20%;font-weight:300;'>Modello 1</th>"
            + "<th style='width:20%;font-weight:300;'>Modello 8</th>"
            + "<th style='width:20%;font-weight:300;'>Selfiemployement</th>"
            + "<th style='width:20%;font-weight:300;'>Piano di Impresa</th>"
            + "<th style='width:20%;font-weight:300;'>Registro presenza</th>"
            + "</tr>"
            + "</thead>"
            + "<tbody>"
            + "<td><span class='kt-switch kt-switch--outline kt-switch--icon kt-switch--primary'><label><input type='checkbox' name='m1_@id' id='m1_@id' checked><span></span></label></span></td>"
            + "<td><span class='kt-switch kt-switch--outline kt-switch--icon kt-switch--primary'><label><input type='checkbox' name='m8_@id' id='m8_@id' checked><span></span></label></span></td>"
            + "<td><span class='kt-switch kt-switch--outline kt-switch--icon kt-switch--primary'><label><input type='checkbox' name='se_@id' id='se_@id' checked><span></span></label></span></td>"
            + "<td><span class='kt-switch kt-switch--outline kt-switch--icon kt-switch--primary'><label><input type='checkbox' name='idim_@id' id='idim_@id' checked><span></span></label></span></td>"
            + "<td><span class='kt-switch kt-switch--outline kt-switch--icon kt-switch--primary'><label><input type='checkbox' name='reg_@id' id='reg_@id' checked><span></span></label></span></td>"
            + "</tbody>"
            + "</table>"
            + "</div>"
            + "</div>";
    if (allievi.length > 0) {
        if (allievi_old.length > 0) {
            $.each(allievi_old, function (i, a) {
                if (!allievi.includes(a)) {
                    $('#docs_' + a).remove();
                }
            });
        }
        $.each(allievi, function (i, a) {
            if (!allievi_old.includes(a)) {
                $('#doc_allievi').append(
                        input.split("@id").join(a)
                        .replace("@nome", $("#allievi option[value='" + a + "']").text()));
            }
        });
        allievi_old = allievi;
    } else {
        allievi_old = [];
        $('#doc_allievi').empty();
    }
}


