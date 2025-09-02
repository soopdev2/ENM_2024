/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

var context = document.getElementById("context").value;


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
            ajax: context + '/QueryMicro?type=searchCpiUser',
            order: [],
            columns: [
//                            {defaultContent: ''},
                {data: 'nome', className: 'text-center'},
                {data: 'cognome', className: 'text-center'},
                {data: 'email', className: 'text-center'},
                {data: 'cpi.descrizione', className: 'text-center'},
            ],
            drawCallback: function () {
                $('[data-toggle="kt-tooltip"]').tooltip();
            },
            rowCallback: function (row, data) {
                $(row).attr("id", "row_" + data.id);
            },
            columnDefs: []
        }).columns.adjust();
    };
    return {
        init: function () {
            initTable1();
        },
    };
}();

jQuery(document).ready(function () {
    KTDatatablesDataSourceAjaxServer.init();
    $('.kt-scroll-x').each(function () {
        const ps = new PerfectScrollbar($(this)[0], {suppressScrollY: true});
    });
});
function refresh() {
    $('html, body').animate({scrollTop: $('#offsetresult').offset().top}, 500);
    load_table($('#kt_table_1'), context + '/QueryMicro?type=searchCpiUser');
}

function reload() {
    $('html, body').animate({scrollTop: $('#offsetresult').offset().top}, 500);
    reload_table($('#kt_table_1'));
}