/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */





            var context = document.getElementById("context");

            $('#progetti').select2({//setta placeholder nella multiselect
                placeholder: "Seleziona Progetti"
            });


            var KTAppOptions = {
                "colors": {
                    "state": {
                        "brand": "#5d78ff",
                        "dark": "#282a3c",
                        "light": "#ffffff",
                        "primary": "#5867dd",
                        "success": "#34bfa3",
                        "info": "#36a3f7",
                        "warning": "#ffb822"
                    },
                    "base": {
                        "label": ["#c5cbe3", "#a1a8c3", "#3d4465", "#3e4466"],
                        "shape": ["#f0f3ff", "#d9dffa", "#afb4d4", "#646c9a"]
                    }
                }
            };


            function ctrlForm() {
                var err = false;
                err = checkObblFieldsContent($('#kt_form'), false) ? true : err;
                return err ? false : true;
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
                                removeOption();
                                reload();
                                swalSuccessReload("Richiesta inviata con successo!", "A breve verrà presa in carico.");
                            } else {
                                swalError("Errore!", json.message);
                            }
                        }
                    });
                }
            });

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
                        pageLength: 25,
                        ajax: context + '/QueryMicro?type=getRendicontazioni',
                        order: [],
                        columns: [
                            {data: 'progetti', className: 'text-center'},
                            {data: 'path', className: 'text-center'},
                            {data: 'timestamp', className: 'text-center'}
                        ],
                        drawCallback: function () {
                            $('[data-toggle="kt-tooltip"]').tooltip();
                        },
                        rowCallback: function (row, data) {
                            $(row).attr("id", "row_" + data.id);
                        },
                        columnDefs: [
                            {
                                targets: 2,
                                type: 'date-it',
                                render: function (data, type, row, meta) {
                                    return formattedDateTime(new Date(data));
                                }
                            }, {
                                targets: 1,
                                render: function (data, type, row, meta) {

                                    if (data === null) {
                                        return "RICHIESTA PRESA IN CARICO";
                                    } else {
                                        return "<a data-container='body' data-toggle='kt-tooltip' data-placement='top' title='Scarica' href='"
                                                + context + "/OperazioniGeneral?type=downloadDoc&path=" + data + "'><u><b>" +
                                                data.substring(data.lastIndexOf("/") + 1) + "</b><u></a>";
                                    }


                                }
                            }, {
                                targets: 0,
                                type: 'text-center',
                                orderable: false,
                                render: function (data, type, row, meta) {
                                    var json = JSON.parse(data);
                                    var cips = "";
                                    $.each(json, function (i, j) {
                                        if (i + 1 < json.length) {
                                            cips += j + "<br>";
                                        } else {
                                            cips += j;
                                        }
                                    });
                                    return cips;
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

            function reload() {
                $('html, body').animate({scrollTop: $('#kt_table_1').offset().top}, 500);
                reload_table($('#kt_table_1'));
            }

            function removeOption() {
                $("#progetti option:selected").each(function () {
                    $(this).remove();
                });
            }