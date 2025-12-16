
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.domain.EstensioniFile"%>
<%@page import="rc.so.domain.TipoDoc"%>
<%@page import="rc.so.domain.TipoDoc_Allievi"%>
<%@page import="rc.so.db.Entity"%>
<%@page import="rc.so.domain.User"%>
<%@page import="rc.so.db.Action"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User us = (User) session.getAttribute("user");
    if (us == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    } else {
        String uri_ = request.getRequestURI();
        String pageName_ = uri_.substring(uri_.lastIndexOf("/") + 1);
        if (!Action.isVisibile(String.valueOf(us.getTipo()), pageName_)) {
            response.sendRedirect(request.getContextPath() + "/page_403.jsp");
        } else {

            Entity e = new Entity();
            //EstensioniFile ext = e.getEm().find(EstensioniFile.class, "pdf");
            e.close();
            String src = Utility.checkAttribute(session, "src");
            //String iva = request.getParameter("piva") != null ? request.getParameter("piva") : "";
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Soggetti Esecutori</title>
        <meta name="description" content="Updates and statistics">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!--begin::Fonts -->
        <script src="<%=src%>/resource/webfont.js"></script>
        <script>
            WebFont.load({
                google: {
                    "families": ["Poppins:300,400,500,600,700", "Roboto:300,400,500,600,700"]
                },
                active: function () {
                    sessionStorage.fonts = true;
                }
            });
        </script>

        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/owl.carousel/dist/assets/owl.carousel.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/owl.carousel/dist/assets/owl.theme.default.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/socicon/css/socicon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon2/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/fontawesome5/css/all.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/animate.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/resource/datatbles.bundle.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/assets/demo/default/base/style.bundle.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/custom.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/base/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
        <link href="../../Bootstrap2024/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/brand/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/aside/light.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">
        <script src="../../Bootstrap2024/assets/js/popper.js"></script>
        <style>
            .kt-section__title {
                font-size: 1.2rem!important;
            }
        </style>


    </head>
    <body class="d-flex flex-column min-vh-100">
        <!-- begin:: Page -->
        <%@ include file="menu/head1.jsp"%>
        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <%@ include file="../../Bootstrap2024/index/menu/menuMc.jsp"%>
        <%@ include file="menu/head.jsp"%>




        <main class="flex-grow-1 container-fluid px-4">

            <!-- Intestazione sezione -->
            <div class="my-3">
                <h1 class="h3">Soggetti Esecutori</h1>
                <span class="text-muted">Gestisci Nuovi</span>
            </div>

            <!-- Tabella Soggetti Esecutori -->
            <div class="row">
                <div class="col-12">
                    <div class="card shadow-sm">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Soggetti Esecutori Accreditati, da confermare:</h5>
                            <button class="btn btn-sm btn-outline-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSE" aria-expanded="true">
                                <i class="it-expand"></i>
                            </button>
                        </div>
                        <div class="collapse show" id="collapseSE">
                            <div class="card-body table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="kt_table_1" style="width:100%">
                                    <thead class="text-center text-uppercase">
                                        <tr>
                                            <th>Azioni</th>
                                            <th>Ragione Sociale</th>
                                            <th>P.Iva</th>
                                            <th>Cod. Fiscale</th>
                                            <th>Provincia</th>
                                            <th>Comune</th>
                                            <th>Via</th>
                                            <th>Nome Amministratore</th>
                                            <th>Cognome Amministratore</th>
                                            <th>Telefono</th>
                                            <th>N. Protocollo</th>
                                            <th>Data</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </main>

        <%@ include file="../../Bootstrap2024/index/login/Footer_login.jsp"%>






      
        <script src="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/popper.js/dist/umd/popper.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/moment.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <!-- this page -->
        <script src="<%=src%>/assets/vendors/custom/datatables/datatables.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/loadTable.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>

        <script type="text/javascript">
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
        </script>

        <script>
        $.getScript('<%=request.getContextPath()%>/page/partialView/partialView.js', function () {});

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




        </script>

        <!--script src="js/addSA.js"></script-->
    </body>
</html>
<%
        }
    }
%>