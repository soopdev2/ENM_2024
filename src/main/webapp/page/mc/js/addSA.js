/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

var KTDatatablesDataSourceAjaxServer = function () {
    var initTable1 = function () {
        var table = $('#kt_table_1');
        table.DataTable({
            dom: `<'row'<'col-sm-12'Bftr>><'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'lp>>`,
            buttons: [
                {
                    extend: 'excelHtml5',
                    text: '<i class="fa fa-file-excel-o"></i> Esporta Excel',
                    columns: ':not(.noVis)'
                }
            ],
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
            ajax: '<%=request.getContextPath()%>/QueryMicro?type=nuoviSA',
            order: [],
            columns: [
                {defaultContent: ''},
                {data: 'ragionesociale'},
                {data: 'piva'},
                {data: 'codicefiscale'},
                {data: 'comune.nome_provincia'},
                {data: 'comune.nome'},
                {data: 'indirizzo'},
                {data: 'nome'},
                {data: 'cognome'},
                {data: 'telefono_sa'},
                {data: 'protocollo'},
                {data: 'visual_dataprotocollo'}
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
                    className: 'text-center noVis',
                    orderable: false,
                    render: function (data, type, row, meta) {
                        var option = '<div class="dropdown dropdown-inline">'
                                + '<button type="button" class="btn btn-icon btn-sm btn-icon-md btn-circle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'
                                + '<i class="flaticon-more-1"></i>'
                                + '</button>'
                                + '<div class="dropdown-menu dropdown-menu-left">';
                        //opzione ACCETTA
                        option += '<a class="dropdown-item" href="javascript:void(0);" onclick="return accettaSA(' + row.id + ');"><i class="la la-check-square"></i> CONFERMA </a>';
                        option += '</div></div>';
                        return option;
                    }
                },
                {
                    targets: 1,
                    title: "RAGIONE SOCIALE"
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



function accettaSA(idsa) {
    $.ajax({
        async: false,
        type: "POST",
        url: '<%=request.getContextPath()%>/OperazioniMicro?type=accreditaSA&idsa=' + idsa,
        success: function (data) {
            var json = JSON.parse(data);
            if (json.result) {
                swalSuccessReload("Operazione Completata", "Soggetto Esecutore caricato correttamente a sistema.");
            } else {
                swalError("Errore", json.message);
            }
        },
        error: function () {
            swalError("Errore", "Non è stato possibile effettuare l'operazione scelta. Riprovare.");
        }
    });
}

function refresh() {
    $("#toolbar").css("display", "none");
    $('html, body').animate({scrollTop: $('#offsetresult').offset().top}, 500);
    load_table($('#kt_table_1'), '<%=request.getContextPath()%>/QueryMicro?type=nuoviSA');
}
