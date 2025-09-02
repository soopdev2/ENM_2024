/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */



            var prg = new Map();
            var context = document.getElementById("context");
            $.getScript(context + '/page/partialView/partialView.js', function () {});

            var KTDatatablesDataSourceAjaxServer = function () {
                let stato;
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
                        ajax: context + '/QueryMicro?type=searchdaAssegnare',
                        order: [],
                        columns: [
                            {defaultContent: ''},
                            {data: 'nome', className: 'text-center text-uppercase'},
                            {data: 'cognome', className: 'text-center text-uppercase'},
                            {data: 'codicefiscale', className: 'text-center text-uppercase'},
                            {data: 'datanascita'},
                            {data: 'data_up'},
                            {data: 'tos_operatore'}
                        ],
                        drawCallback: function () {
                            $('[data-toggle="kt-tooltip"]').tooltip();
                        }
                        ,
                        rowCallback: function (row, data) {
                            $(row).attr("id", "row_" + data.id);
                        }
                        ,
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
                                    if (row.tos_operatore === null || row.tos_operatore === 'null') {
                                        option += '<a class="fancyBoxFullReload dropdown-item" href="assegnaENM.jsp?id=' +
                                                row.id + '"><i class="fa fa-user"></i> Assegna ad Operatore</a>';
                                    } else {
                                        option += '<a class="fancyBoxFullReload dropdown-item" href="assegnaENM.jsp?id=' +
                                                row.id + '"><i class="fa fa-edit"></i> Modifica assegnazione Operatore</a>';

                                    }

                                    option += '<a class="fancyBoxFullReload dropdown-item" href="modello0.jsp?id=' +
                                            row.id + '"><i class="fa fa-file"></i> Modello 0</a>';

                                    option += '<a class="fancyBoxFullReload dropdown-item" href="modello0anagr.jsp?id=' +
                                            row.id + '"><i class="fa fa-user"></i> Anagrafica Allievo</a>';
                                    option += '<a class="dropdown-item" href="javascript:void(0);" onclick="swalDocumentAgg(' + row.id + ')"><i class="fa fa-file-alt"></i> Visualizza Documentazione Integrativa</a>';
                                    option += '<a class="dropdown-item" href="javascript:void(0);" onclick="uploadDoc(' + row.id + ')"><i class="fa fa-upload"></i> Carica Documentazione Integrativa</a>';

                                    option += '</div></div>';
                                    return option;
                                }

                            }, {
                                targets: 4,
                                className: 'text-center',
                                type: 'date-it',
                                render: function (data, type, row, meta) {
                                    return formattedDate(new Date(row.datanascita));
                                }
                            },
                            {
                                targets: 5,
                                className: 'text-center',
                                type: 'date-it',
                                render: function (data, type, row, meta) {
                                    return formattedDate(new Date(row.data_up));
                                }
                            }
                        ]
                    }
                    ).columns.adjust();
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
                load_table($('#kt_table_1'), context + '/QueryMicro?type=searchdaAssegnare');
            }

            function reload() {
                $('html, body').animate({scrollTop: $('#offsetresult').offset().top}, 500);
                reload_table($('#kt_table_1'));
            }
            var context = document.getElementById("context");


            function swalDocumentAgg(idallievo) {
                $("#prg_docs").empty();
                //var doc_registro_aula = getHtml("documento_registro", context);
                var doc_prg = getHtml("documento_prg", context);
                $.get(context + "/QueryMicro?type=getDocAllievoAgg&idallievo=" + idallievo, function (resp) {
                    var json = JSON.parse(resp);
                    for (var i = 0; i < json.length; i++) {
                        var ext = json[i].tipo.estensione;
                        if (ext === null || ext === undefined || typeof ext === 'undefined' || ext === "p7m" || ext.includes("pdf")) {
                            ext = "pdf";
                        }
                        $("#prg_docs").append(
                                doc_prg.replace("@href",
                                        context + "/OperazioniGeneral?type=showDoc&path=" + json[i].path)
                                .replace("#ex", ext)
                                .replace("@nome", json[i].tipo.descrizione)
                                );
                    }
                    $('#doc_modal').modal('show');
                    $('.kt-scroll').each(function () {
                        const ps = new PerfectScrollbar($(this)[0]);
                    });
                });
            }


            function uploadDoc(idallievo) {
                var htmldoc = getHtml("uploadDoc", context).replace("@func", "checkFileExtAndDim('pdf');").replace("@mime", "application/pdf");
                swal.fire({
                    title: 'Carica Documento',
                    html: htmldoc,
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
                        $('#file').change(function (e) {
                            if (e.target.files.length !== 0)
                                //$('#label_doc').html(e.target.files[0].name);
                                if (e.target.files[0].name.length > 30)
                                    $('#label_doc').html(e.target.files[0].name.substring(0, 30) + "...");
                                else
                                    $('#label_doc').html(e.target.files[0].name);
                            else
                                $('#label_doc').html("Seleziona File");
                        });
                    },
                    preConfirm: function () {
                        var err = false;
                        err = !checkRequiredFileContent($('#uploadDoc')) ? true : err;
                        if (!err) {
                            return new Promise(function (resolve) {
                                resolve({
                                    "file": $('#file')[0].files[0]
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
                        upDoc(idallievo, "32", fdata);
                    } else {
                        swal.close();
                    }
                });
            }

            function upDoc(id, id_tipoDoc, fdata) {
                $.ajax({
                    type: "POST",
                    url: context + '/OperazioniMicro?type=uploadDocAllievo&idallievo=' + id + "&id_tipo=" + id_tipoDoc,
                    data: fdata,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        var json = JSON.parse(data);
                        if (json.result) {
                            swalSuccessReload("Documento Caricato", (json.message = !"" ? json.message : ""));
                        } else {
                            swalError("Errore", json.message);
                        }
                    },
                    error: function () {
                        swalError("Errore", "Non è stato possibile caricare il documento");
                    }
                });
            }



