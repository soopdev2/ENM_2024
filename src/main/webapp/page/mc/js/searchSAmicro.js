/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

var context = document.getElementById("context");

function CFPresent() {
    var err;
    if ($('#cf_sa').val() !== $('#prevcf').val()) {
        $.ajax({
            type: "GET",
            async: false,
            url: context + '/OperazioniMicro?type=checkCF&cf=' + $('#cf_sa').val(),
            success: function (data) {
                if (data !== null && data !== 'null') {
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
    if ($('#piva_sa').val() !== $('#prevpiva').val()) {
        $.ajax({
            type: "GET",
            async: false,
            url: context + '/OperazioniMicro?type=checkPiva&piva=' + $('#piva_sa').val(),
            success: function (data) {
                if (data !== null && data !== 'null') {
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
    $('html, body').animate({scrollTop: $('#kt_table_1').offset().top}, 500);
    load_table($('#kt_table_1'), contextPath  + '/QueryMicro?type=searchSA&ragionesociale=' + $('#ragionesociale').val()
            + '&protocollo=' + $('#protocollo').val() + '&piva=' + $('#piva').val() + '&cf=' + $('#cf').val() + '&protocollare='
            + $('input[name=protocollare]:checked').val() + '&nome=' + $('#nome').val() + '&cognome=' + $('#cognome').val());
}

$.getScript(contextPath + '/page/partialView/partialView.js', function () {});

var tipouser = tipoR;

var KTDatatablesDataSourceAjaxServer = function () {
    var initTable1 = function () {
        var table = $('#kt_table_1');
        table.DataTable({
            dom: `<'row'<'col-sm-12'ftr>><'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'lp>>`,
            lengthMenu: [5, 10, 25, 50],
            language: {
                'lengthMenu': 'Mostra _MENU_',
                "infoEmpty": "Mostrati 0 di 0 per 0",
                "loadingRecords": "Caricamento...",
                "search": "Cerca:",
                "zeroRecords": "Nessun risultato trovato",
                "info": "Mostrati _START_ di _TOTAL_ ",
                "emptyTable": "Nessun risultato",
                "sInfoFiltered": "(filtrato su _MAX_ risultati totali)"
            },
            ScrollX: "100%",
            sScrollXInner: "110%",
            searchDelay: 500,
            processing: true,
            pageLength: 10,
            ajax: contextPath + '/QueryMicro?type=searchSA&ragionesociale=' + $('#ragionesociale').val()
                    + '&protocollo=' + $('#protocollo').val() + '&piva=' + $('#piva').val()
                    + '&cf=' + $('#cf').val() + '&protocollare=' + $('input[name=protocollare]:checked').val()
                    + '&nome=' + $('#nome').val() + '&cognome=' + $('#cognome').val(),
            order: [],
            columns: [
                {defaultContent: ''},
                {data: 'ragionesociale', className: 'text-center text-uppercase '},
                {data: 'piva'},
                {data: 'codicefiscale', className: 'text-center text-uppercase '},
                {data: 'comune.nome_provincia', className: 'text-center text-uppercase '},
                {data: 'comune.nome', className: 'text-center text-uppercase '},
                {data: 'indirizzo'},
                {data: 'nome', className: 'text-center text-uppercase '},
                {data: 'cognome', className: 'text-center text-uppercase '},
                {data: 'telefono_sa'},
                {data: 'protocollo'},
                {data: 'visual_dataprotocollo'},
                {defaultContent: ''}
            ],
            drawCallback: function () {
                $('[data-toggle="kt-tooltip"]').tooltip();
            },
            rowCallback: function (row, data) {
                $(row).attr("id", "row_" + data.id);
            },
            columnDefs: [
                {
                    targets: 0,
                    className: 'text-center',
                    orderable: false,
                    render: function (data, type, row, meta) {
                        var option = '<div class="dropdown dropdown-inline">'
                                + '<button type="button" class="btn btn-icon btn-sm btn-icon-md btn-circle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'
                                + '<i class="flaticon-more-1"></i>'
                                + '</button>'
                                + '<div class="dropdown-menu dropdown-menu-left">';
                        option += '<a class="dropdown-item" href="javascript:void(0);" onclick="uploadPec(' + row.id + ',\'' + row.ragionesociale + '\','
                                + (row.piva === null ? '\'\'' : '\'' + row.piva + '\'')
                                + ',' + (row.codicefiscale === null ? '\'\'' : '\'' + row.codicefiscale + '\'')
                                + ');"><i class="fa fa-mail-bulk"></i> Aggiorna anagrafica</a>';
                        option += '<a class="dropdown-item" href="' + contextPath + '/redirect.jsp?page=page/mc/searchAllieviMicro.jsp&idsa=' + row.id + '" target="_blank"><i class="flaticon-users-1"></i> Allievi</a>';
                        option += '<a class="dropdown-item" href="' + contextPath + '/redirect.jsp?page=page/mc/searchPFMicro.jsp&idsa=' + row.id + '" target="_blank"><i class="fa fa-graduation-cap"></i> Progetti Formativi</a>';
                        option += '</div></div>';

                        if (tipouser === "2") {
                            return option;
                        } else {
                            return "";
                        }
                    }
                },
                {
                    targets: 1,
                    title: "RAGIONE SOCIALE"
                },
                {
                    targets: 9,
                    orderable: false
                },
                {
                    targets: 12,
                    className: 'text-center',
                    orderable: false,
                    render: function (data, type, row, meta) {
                        return '<a href="schedaSA.jsp?id=' + row.id + '" class="btn btn-io fa fa-address-card fancyProfileNoRef" style="font-size: 20px" '
                                + 'data-container="body" data-html="true" data-toggle="kt-tooltip" '
                                + 'data-placement="top" title="<h5>Visualizza scheda<br>Soggetto Esecutore</h5>"></a>';
                    }
                }
            ]
        }).columns.adjust();
    };
    return {
        init: function () {
            initTable1();
        }
    };
}();

jQuery(document).ready(function () {
    KTDatatablesDataSourceAjaxServer.init();
    $('.kt-scroll-x').each(function () {
        const ps = new PerfectScrollbar($(this)[0], {suppressScrollY: true});
    });
});

function uploadPec(idsa, rs, piva, cf) {
    var htmlp = getHtml("pecAnag", contextPath)
            .replace("@func", "checkFileExtAndDim('" + extEstensione + "');")
            .replace("@mime", extMimeType)
            .replace("@ragionesociale", rs)
            .replace("@piva", piva)
            .replace("@cf", cf)
            .replace("@numb", "PivaNumberLength(event);")
            .replace("@prevpiva", piva)
            .replace("@prevcf", cf);

    swal.fire({
        title: 'Aggiornamento anagrafica',
        html: htmlp,
        animation: false,
        showCancelButton: true,
        confirmButtonText: '&nbsp;<i class="la la-check"></i>',
        cancelButtonText: '&nbsp;<i class="la la-close"></i>',
        cancelButtonClass: "btn btn-io-n",
        confirmButtonClass: "btn btn-io",
        customClass: {
            popup: 'animated bounceInUp'
        },
        onOpen: function () {
            $('#doc').change(function (e) {
                if (e.target.files.length !== 0) {
                    if (e.target.files[0].name.length > 30) {
                        $('#label_file').html(e.target.files[0].name.substring(0, 30) + "...");
                    } else {
                        $('#label_file').html(e.target.files[0].name);
                    }
                } else {
                    $('#label_file').html("Seleziona File");
                }
            });
        },
        preConfirm: function () {
            var err = false;
            var req_piva = false;
            var req_cf = false;
            var ra_sa = $('#ragionesociale_sa');
            var piva_sa = $('#piva_sa');
            var cf_sa = $('#cf_sa');
            if (checkValue(ra_sa, false)) {
                err = true;
            }
            if (checkPIva(piva_sa) || pivaPresent()) {
                req_piva = true;
            }
            if (check_PIVA_CF(cf_sa) || CFPresent()) {
                req_cf = true;
            }
            if (req_piva && req_cf) {
                err = true;
            }

            err = !checkRequiredFileContent($('#pecAnag')) ? true : err;
            if (!err) {
                return new Promise(function (resolve) {
                    resolve({
                        "rs_sa": $('#ragionesociale_sa').val(),
                        "piva_sa": $('#piva_sa').val(),
                        "cf_sa": $('#cf_sa').val(),
                        "file": $('#doc')[0].files[0]
                    });
                });
            } else {
                return false;
            }
        }
    }).then((result) => {
        if (result.value) {
            showLoad();
            var fdata = new FormData();
            fdata.append("file", result.value.file);
            fdata.append("cf_sa", result.value.cf_sa);
            fdata.append("piva_sa", result.value.piva_sa);
            fdata.append("rs_sa", result.value.rs_sa);
            upDoc(idsa, fdata);
        } else {
            swal.close();
        }
    });
}

$(document).on('change', '#piva_sa', function (e) {
    $("#warning_iva").css("display", "none");
    if (!checkPIva($('#piva_sa'))) {
        pivaPresent();
    }
    if ($('#piva_sa').val() === "") {
        $('#piva_sa').attr("class", "form-control");
    }
});

$(document).on('change', '#cf_sa', function (e) {
    $("#warning_cf").css("display", "none");
    if (!check_PIVA_CF($('#cf_sa'))) {
        CFPresent();
    }
    if ($('#cf_sa').val() === "") {
        $('#cf_sa').attr("class", "form-control");
    }
});
