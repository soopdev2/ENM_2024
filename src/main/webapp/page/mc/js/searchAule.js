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


var tipouser = '<%=tipoR%>';


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
//                        responsive: true,
            ScrollX: "100%",
            sScrollXInner: "110%",
            searchDelay: 500,
            processing: true,
            pageLength: 10,
            ajax: context + '/QueryMicro?type=searchSedi&referente=' + $('#referente').val() + "&regione=" + $('#regione').val()
                    + "&provincia=" + $('#provincia').val() + "&comune=" + $('#comune').val(),
            order: [],
            columns: [
                {defaultContent: ''},
                {data: 'denominazione', className: 'text-center'},
                {data: 'soggetto.ragionesociale', className: 'text-center'},
                {data: 'descrizionestato', className: 'text-center'},
                {data: 'comune.regione', className: 'text-center'},
                {data: 'comune.nome_provincia', className: 'text-center'},
                {data: 'comune.nome', className: 'text-center'},
                {data: 'indirizzo', className: 'text-center'},
                {data: 'referente', className: 'text-center'}
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

                        if (tipouser === "2" && row.stato === "DV") {
                            var option = '<div class="dropdown dropdown-inline">'
                                    + '<button type="button" class="btn btn-icon btn-sm btn-icon-md btn-circle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'
                                    + '   <i class="flaticon-more-1"></i>'
                                    + '</button>'
                                    + '<div class="dropdown-menu dropdown-menu-left">';
                            option += '<a class="dropdown-item kt-font-success" href="javascript:void(0);" onclick="validateAula(' + row.id + ',1)"><i class="fa fa-check kt-font-success" style="margin-top:-2px"></i>Accredita</a>';
                            option += '<a class="dropdown-item kt-font-success" href="javascript:void(0);" onclick="validateAula(' + row.id + ',2)"><i class="fa fa-check kt-font-success" style="margin-top:-2px"></i>Accredita per massimo 8 allievi</a>';
                            option += '<a class="dropdown-item kt-font-danger" href="javascript:void(0);" onclick="rejectAula(' + row.id + ')"><i class="flaticon2-delete kt-font-danger" style="margin-top:-2px"></i>Rigetta</a>';
                            option += '</div></div>';
                            return option;
                        } else {
                            return "";
                        }
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


function refresh() {
    $("#toolbar").css("display", "none");
    $('html, body').animate({scrollTop: $('#offsetresult').offset().top}, 500);
    load_table($('#kt_table_1'), context + '/QueryMicro?type=searchSedi&referente=' + $('#referente').val() + "&regione=" + $('#regione').val()
            + "&provincia=" + $('#provincia').val() + "&comune=" + $('#comune').val(), );
}




function validateAula(id, statusdest) {
    var html = "<h4 style='text-align:center;'>Sicuro di voler accreditare la Sede di Formazione scelta?</h4>";
    swal.fire({
        title: '<h2 class="kt-font-io-n"><b>Accredita Sede di Formazione</b></h2><br>',
        html: html,
        animation: false,
        showCancelButton: true,
        confirmButtonText: '&nbsp;<i class="la la-check"></i>',
        cancelButtonText: '&nbsp;<i class="la la-close"></i>',
        cancelButtonClass: "btn btn-io-n",
        confirmButtonClass: "btn btn-io",
        width: '750px',
        customClass: {
            popup: 'animated bounceInUp'
        }
    }).then((result) => {
        if (result.value) {
            changestatus(id, statusdest);
        } else {
            swal.close();
        }
    });
}

function rejectAula(id) {
    var html = "<h4 style='text-align:center;'>Sicuro di voler rigettare la Sede di Formazione scelta?</h4>";
    swal.fire({
        title: '<h2 class="kt-font-io-n"><b>Rigetta Sede di Formazione</b></h2><br>',
        html: html,
        animation: false,
        showCancelButton: true,
        confirmButtonText: '&nbsp;<i class="la la-check"></i>',
        cancelButtonText: '&nbsp;<i class="la la-close"></i>',
        cancelButtonClass: "btn btn-io-n",
        confirmButtonClass: "btn btn-io",
        width: '750px',
        customClass: {
            popup: 'animated bounceInUp'
        }
    }).then((result) => {
        if (result.value) {
            changestatus(id, 'KO');
        } else {
            swal.close();
        }
    });
}

function changestatus(id, status) {

    var statusdest = status;
    if (statusdest === 1 || statusdest === "1") {
        statusdest = "OK";
    } else if (statusdest === 2 || statusdest === "2") {
        statusdest = "OK1";
    }

    showLoad();
    $.ajax({
        type: "POST",
        url: context + '/OperazioniMicro?type=validateAula&id=' + id + "&status=" + statusdest,
        success: function (data) {
            closeSwal();
            var json = JSON.parse(data);
            if (json.result) {
                if (status === 'OK' || status === 'OK1') {
                    swalSuccess("Sede di Formazione Accreditata", "Sede di formazione accreditata con successo");
                } else if (status === 'KO') {
                    swalSuccess("Sede di Formazione Rigettata", "Sede di formazione rigettata con successo");
                }
                refresh();
            } else {
                swalError("Errore", json.message);
            }
        },
        error: function () {
            swalError("Errore", "Non è stato possibile effettuare l'operazione scelta.");
        }
    });
}










