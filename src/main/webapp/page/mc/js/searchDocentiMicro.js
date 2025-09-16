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
            ajax: context + '/QueryMicro?type=searchDocenti&cf=' + $('#cf').val()
                    + '&nome=' + $('#nome').val() + '&cognome=' + $('#cognome').val(),
            order: [],
            columns: [
                {defaultContent: ''},
                {data: 'nome', className: 'text-center text-uppercase '},
                {data: 'cognome', className: 'text-center text-uppercase '},
                {data: 'codicefiscale', className: 'text-center text-uppercase '},
                {data: 'datanascita', className: 'text-center'},
                {data: 'soggetto.ragionesociale', className: 'text-center text-uppercase '},
                {data: 'fascia.descrizione', className: 'text-center text-uppercase '},
                {data: 'descrizionestato', className: 'text-center text-uppercase '},
                {data: 'tipo_inserimento', className: 'text-center text-uppercase '},
                {data: 'datawebinair', className: 'text-center text-uppercase '}
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
                                + '   <i class="flaticon-more-1"></i>'
                                + '</button>'
                                + '<div class="dropdown-menu dropdown-menu-left">';
                        if (tipouser === "2") {
                            if (row.stato === "A") {
                                option += '<a class="fancyBoxReload dropdown-item" href="modifyDocente.jsp?id=' + row.id + '"><i class="fa fa-edit"></i>Modifica</a>';
                                option += '<a class="dropdown-item" href="javascript:void(0);" onclick="swalTablePrg(' + row.id + ')"><i class="fa fa-list"></i>Progetti Formativi</a>';
                            } else if (row.stato === "DV" || row.stato === "W") {
                                option += '<a class="fancyBoxReload dropdown-item kt-font-success" href="modifyDocente.jsp?id=' + row.id + '"><i class="fa fa-check kt-font-success" style="margin-top:-2px"></i>Accredita</a>';
                                option += '<a class="dropdown-item kt-font-danger" href="javascript:void(0);" onclick="rejectDocente(' + row.id + ')"><i class="flaticon2-delete kt-font-danger" style="margin-top:-2px"></i>Rigetta</a>';
                            }
                        }

                        if (row.docId !== null) {
                            option += '<a class="fancyDocument dropdown-item" href="' + context + '/OperazioniGeneral?type=showDoc&path=' + row.docId + '"><i class="fa fa-address-card"></i>Visualizza Documento Identità</a>';
                        }
                        if (row.curriculum !== null) {
                            option += '<a class="fancyDocument dropdown-item" href="' + context + '/OperazioniGeneral?type=showDoc&path=' + row.curriculum + '"><i class="fa fa-file-invoice"></i>Visualizza Curriculum</a>';
                        }
                        if (row.richiesta_accr !== null && row.richiesta_accr !== "" && row.richiesta_accr !== "-") {
                            option += '<a class="fancyDocument dropdown-item" href="' + context + '/OperazioniGeneral?type=showDoc&path=' + row.richiesta_accr + '"><i class="fa fa-file-pdf"></i>Visualizza Richiesta Accreditamento</a>';
                        }
                        option += '</div></div>';
                        return option;
                    }
                }, {
                    targets: 4,
                    type: 'date-it',
                    render: function (data, type, row, meta) {
                        return formattedDate(new Date(row.datanascita));
                    }
                }, {
                    targets: 7,
                    className: 'text-center',
                    render: function (data, type, row, meta) {
                        if (data === "RIGETTATO" && row.motivo !== null) {
                            data += "&nbsp;<i class='fa fa-info-circle kt-font-danger' data-container='body' data-html='true' data-toggle='kt-tooltip' data-placement='top' " +
                                    "title=\"<h6><b>MOTIVO RIGETTO</b>:<br><h6 style='text-align:justify;'>" + row.motivo.replace(/"/g, '\'') + "</h6>\"></i>";
                        }
                        return data;
                    }
                }, {
                    targets: 8,
                    className: 'text-center',
                    render: function (data, type, row, meta) {
                        if (data === null || data === "null" || data === "") {
                            return "ACCREDITAMENTO";
                        }
                        return data;
                    }
                }, {
                    targets: 9,
                    className: 'text-center',
                    render: function (data, type, row, meta) {
                        if (data === null || data === "null" || row.datawebinair === null) {
                            return "";
                        }
                        return formattedDate(new Date(row.datawebinair));
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
    $('html, body').animate({scrollTop: $('#offsetresult').offset().top}, 500);
    load_table($('#kt_table_1'), context + '/QueryMicro?type=searchDocenti&soggettoattuatore=' + $('#soggettoattuatore').val()
            + '&cf=' + $('#cf').val() + '&nome=' + $('#nome').val() + '&cognome=' + $('#cognome').val());
}

function reload() {
    $('html, body').animate({scrollTop: $('#offsetresult').offset().top}, 500);
    reload_table($('#kt_table_1'));
}

function swalTablePrg(iddocente) {
    swal.fire({
        html: '<table class="table table-bordered" id="kt_table_allievi">'
                + '<thead>'
                + '<tr>'
                + '<th class="text-uppercase text-center">Nome</th>'
                + '<th class="text-uppercase text-center">Descrizione</th>'
                + '<th class="text-uppercase text-center">Ore</th>'
                + '<th class="text-uppercase text-center">Data Inizio</th>'
                + '<th class="text-uppercase text-center">Data Fine</th>'
                + '<th class="text-uppercase text-center">CIP</th>'
                + '<th class="text-uppercase text-center">Soggetto Esecutore</th>'
                + '<th class="text-uppercase text-center">Stato</th>'
                + '<th class="text-uppercase text-center">Errore O Verificare</th>'
                + '</tr>'
                + '</thead>'
                + '</table>',
        width: '95%',
        scrollbarPadding: true,
        showCloseButton: true,
        showCancelButton: false,
        showConfirmButton: false,
        onOpen: function () {
            $("#kt_table_allievi").DataTable({
                dom: `<'row'<'col-sm-12'ftr>><'row'<'col-sm-12 col-md-2'i><'col-sm-12 col-md-10 dataTables_pager'lp>>`,
                lengthMenu: [15, 25, 50],
                language: {
                    "lengthMenu": "Mostra _MENU_",
                    "infoEmpty": "Mostrati 0 di 0 per 0",
                    "loadingRecords": "Caricamento...",
                    "search": "Cerca:",
                    "zeroRecords": "Nessun risultato trovato",
                    "info": "Mostrati _END_ di _TOTAL_ ",
                    "emptyTable": "Nessun risultato",
                    "sInfoFiltered": "(filtrato su _MAX_ risultati totali)"
                },
                scrollY: "40vh",
                ajax: context + '/QueryMicro?type=searchProgettiDocente&iddocente=' + iddocente,
                order: [],
                columns: [
                    {data: 'nome.descrizione'},
                    {data: 'descrizione'},
                    {data: 'ore'},
                    {data: 'start'},
                    {data: 'end'},
                    {data: 'cip'},
                    {data: 'soggetto.ragionesociale'},
                    {data: 'stato.descrizione'},
                    {data: 'stato.tipo'}
                ]
            });
        }
    });
}

function rejectDocente(id) {
    //                var html = "<h4 style='text-align:center;'>Sicuro di voler rigettare il Docente selezionato?</h4>";
    var html = "<div class='form-group' id='swal_motivo'><textarea class='form-control obbligatory' id='motivo' placeholder='Motivazione del rigetto'></textarea></div>";
    swal.fire({
        title: '<h2 class="kt-font-io-n"><b>Rigetta Docente</b></h2><br>',
        html: html,
        animation: false,
        showCancelButton: true,
        confirmButtonText: '&nbsp;<i class="la la-check"></i>',
        cancelButtonText: '&nbsp;<i class="la la-close"></i>',
        cancelButtonClass: "btn btn-danger",
        confirmButtonClass: "btn btn-primary",
        width: '750px',
        customClass: {
            popup: 'animated bounceInUp'
        },
        preConfirm: function () {
            var err = false;
            err = checkObblFieldsContent($('#swal_motivo')) ? true : err;
            if (!err) {
                return new Promise(function (resolve) {
                    resolve({
                        "motivo": $('#motivo').val()
                    });
                });
            } else {
                return false;
            }
        }
    }).then((result) => {
        if (result.value) {
            rigetta(id, result.value);
        } else {
            swal.close();
        }
    });
}

function rigetta(id, result) {
    showLoad();
    $.ajax({
        type: "POST",
        data: result,
        url: context + '/OperazioniMicro?type=rejectDocente&id=' + id,
        success: function (data) {
            closeSwal();
            var json = JSON.parse(data);
            if (json.result) {
                swalSuccess("Docente Rigettato", "Docente rigettato con successo");
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

function downloadExcel(iddocente, cognome) {
    showLoad();
    $.ajax({
        type: "POST",
        url: context + '/OperazioniMicro?type=downloadExcelDocente',
        data: {id: iddocente},
        success: function (data) {
            closeSwal();
            download("Lezioni_" + cognome + ".xlsx", data, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        },
        error: function () {
            swalError("Errore", "Non è stato possibile modificare il documento");
        }
    });
}