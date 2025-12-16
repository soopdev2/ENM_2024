
<%@page import="rc.so.domain.Allievi"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="rc.so.domain.DocumentiPrg"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.function.Predicate"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.List"%>
<%@page import="rc.so.domain.StatiPrg"%>
<%@page import="rc.so.domain.ProgettiFormativi"%>
<%@page import="rc.so.db.Entity"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            String src = Utility.checkAttribute(session, "src");
            Date today = new Date();
            Date todaynotime = Date.from(LocalDateTime.now().truncatedTo(ChronoUnit.DAYS).atZone(ZoneId.systemDefault()).toInstant());
            List<ProgettiFormativi> FA = new ArrayList();
            List<DocumentiPrg> docs = new ArrayList();
            List<DocumentiPrg> filtered = new ArrayList();
            Entity e = new Entity();
            String messaggio = e.getPath("messageToSA");
            double ore_filter = 0;

            for (ProgettiFormativi p : e.ProgettiSA_Fa(us.getSoggettoAttuatore())) {
                docs = p.getDocumenti();
                filtered = new ArrayList<>();
                ore_filter = 0;
                for (DocumentiPrg o : docs) {
                    if (o.getGiorno() != null && o.getGiorno().equals(todaynotime)) {
                        filtered.add(o);
                        ore_filter += o.getOre();
                    }
                }
                if (filtered.size() < 2 && ore_filter < 5) {
                    FA.add(p);
                }
            }

            e.close();
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Home Page</title>
        <meta name="description" content="Updates and statistics">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
        <link href="<%=src%>/assets/vendors/general/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon2/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/fontawesome5/css/all.min.css" rel="stylesheet" type="text/css" />
        <!--link href="<%=src%>/assets/demo/default/base/style.bundle.css" rel="stylesheet" type="text/css" /-->
        <link href="<%=src%>/resource/custom.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/base/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/brand/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/aside/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css" rel="stylesheet" type="text/css" />
        <link href="../../Bootstrap2024/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>


        <!-- Popper.js (necessario per dropdown, tooltip, popover) -->
        <script src="../../Bootstrap2024/assets/js/popper.js"></script>




        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">
        <style>
            #containerCanvas {
                position: inherit;
                padding-top: 0;

            }
            .kt-portlet .kt-iconbox .kt-iconbox--animate-slow {
                height: 90%;
            }
            .kt-widget27__title{
                font-size: 7vh!important;
            }
            .kt-notification__item {
                border-radius: 5px;
                margin-bottom:1.5rem;
            }
            .kt-notification__item:after{
                color: #a7abc300 !important;
            }
            .kt-iconbox{
                border-radius: 5px;
            }

            .custom-redbox:before{
                font-family: 'Flaticon';
                content: "\f1af";
            }
            .custom-redbox.message:before{
                font-family: 'Flaticon2';
                content: "";
            }
            .custom-greenbox:before{
                font-family: 'Flaticon';
                content: "\f1b7";
            }
            .custom-yellowbox:before{
                font-family: 'Flaticon';
                content: "\f19f";
            }
            .custom-bluebox:before{
                font-family: 'Flaticon2';
                content: "\f126";
            }
            .custom-greenbox.sa:before{
                font-family: 'Flaticon2';
                content: "\f126";
            }




        </style>
    </head>
    <body>
        <%@include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp" %>
        <%@ include file="../../Bootstrap2024/index/menu/menuAtt.jsp"%>
        <%@ include file="menu/head.jsp"%>

        <div class="it-grid">

            <main class="it-main">

                <div class="it-content-wrapper bg-white" 
                     style="background-image: url(<%=src%>/resource/bg.png); background-size: cover; background-position: center;">

                    <!-- NAV PILLS -->
                    <div class="it-header-navbar-wrapper bg-light">
                        <ul class="nav nav-pills nav-fill" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active text-primary bg-white" id="tab2" data-bs-toggle="pill" href="#kt_widget5_tab2_content" role="tab">
                                    Riepilogo
                                </a>
                            </li>
                            <% if (us.getTipo() == 1) { %>
                            <li class="nav-item">
                                <a class="nav-link text-primary bg-white" id="tab1" data-bs-toggle="pill" href="#kt_widget5_tab1_content" role="tab">
                                    Dashboard
                                </a>
                            </li>
                            <% } %>
                        </ul>
                    </div>

                    <div class="tab-content p-3" style="min-height: 100vh">

                        <!-- DASHBOARD -->
                        <div class="tab-pane fade" id="kt_widget5_tab1_content" role="tabpanel">
                            <div class="container-fluid">

                                <% if (!messaggio.equals("")) {%>
                                <div class="alert alert-danger" role="alert">
                                    <%=messaggio%>
                                </div>
                                <% } %>

                                <%
                                    String[] contatori = Action.contatoriHomeSA(us);
                                %>

                                <div class="row g-3">
                                    <div class="col-xl-3 col-lg-6 col-md-6">
                                        <button type="button" class="btn btn-primary btn-lg w-100">
                                            Allievi totali 
                                            <span class="badge bg-light text-primary"><%=contatori[0]%></span>
                                        </button>
                                    </div>

                                    <div class="col-xl-3 col-lg-6 col-md-6">
                                        <button type="button" class="btn btn-primary btn-lg w-100">
                                            Allievi formati 
                                            <span class="badge bg-light text-primary"><%=contatori[1]%></span>
                                        </button>
                                    </div>

                                    <div class="col-xl-3 col-lg-6 col-md-6">
                                        <button type="button" class="btn btn-primary btn-lg w-100">
                                            Progetti totali 
                                            <span class="badge bg-light text-primary"><%=contatori[2]%></span>
                                        </button>
                                    </div>

                                    <div class="col-xl-3 col-lg-6 col-md-6">
                                        <button type="button" class="btn btn-primary btn-lg w-100">
                                            Progetti conclusi 
                                            <span class="badge bg-light text-primary"><%=contatori[3]%></span>
                                        </button>
                                    </div>
                                </div>

                                <% if (Utility.demoversion) {%>
                                <div class="row mt-4">
                                    <div class="col-xl-4 col-lg-6 col-md-6">
                                        <a href="<%=request.getContextPath()%>/OperazioniSA?type=resetdatidemo"
                                           class="btn btn-outline-danger w-100">
                                            <i class="fa fa-times"></i> RESET DATI DEMO
                                        </a>
                                    </div>
                                </div>
                                <% } %>

                                <% if (today.after(us.getSoggettoAttuatore().getScadenza())) { %>
                                <div class="row mt-4">
                                    <div class="col-xl-4 col-lg-6 col-md-6">
                                        <div class="alert alert-warning d-flex align-items-center">
                                            <i class="fa fa-exclamation-triangle me-2 fs-3"></i>
                                            <div>
                                                <h5 class="alert-heading">Documento Scaduto</h5>
                                                <p class="mb-0">
                                                    <a href="javascript:void(0);" onclick="rinnovoCartaID();" class="link-primary">Carica nuovo documento AD/AU</a>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% }%>
                            </div>
                        </div>

                        <!-- RIEPILOGO -->
                        <div class="tab-pane fade show active" id="kt_widget5_tab2_content" role="tabpanel">
                            <div class="row g-4">
                                <div class="col-lg-8">
                                    <div class="row g-4">
                                        <div class="col-xl-6">
                                            <h5 class="text-warning fw-bold">Soggetto Attuatore</h5>
                                            <p class="text-primary mb-1"><b>Ragione Sociale:</b> <%=us.getSoggettoAttuatore().getRagionesociale()%></p>
                                            <% if (us.getSoggettoAttuatore().getPiva() != null && !us.getSoggettoAttuatore().getPiva().equalsIgnoreCase("")) {%>
                                            <p class="text-primary mb-1"><b>Partita IVA:</b> <%=us.getSoggettoAttuatore().getPiva()%></p>
                                            <% } %>
                                            <% if (us.getSoggettoAttuatore().getCodicefiscale() != null && !us.getSoggettoAttuatore().getCodicefiscale().equalsIgnoreCase("")) {%>
                                            <p class="text-primary mb-1"><b>Codice Fiscale:</b> <%=us.getSoggettoAttuatore().getCodicefiscale()%></p>
                                            <% }%>
                                            <p class="text-primary mb-1"><b>Email:</b> <%=us.getSoggettoAttuatore().getEmail()%></p>
                                            <p class="text-primary mb-1"><b>PEC:</b> <%=us.getSoggettoAttuatore().getPec()%></p>
                                            <p class="text-primary mb-1"><b>Telefono:</b> <%=us.getSoggettoAttuatore().getTelefono_sa()%></p>
                                            <p class="text-primary mb-1"><b>Cellulare:</b> <%=us.getSoggettoAttuatore().getCell_sa()%></p>
                                            <p class="text-primary mb-1"><b>Indirizzo:</b> <%=us.getSoggettoAttuatore().getIndirizzo()%></p>
                                            <p class="text-primary mb-1"><b>Comune:</b> <%=us.getSoggettoAttuatore().getComune().getNome()%> 
                                                (<%=us.getSoggettoAttuatore().getCap()%>, <%=us.getSoggettoAttuatore().getComune().getNome_provincia()%>)</p>
                                        </div>
                                        <div class="col-xl-6">
                                            <h5 class="text-warning fw-bold">Amministratore Delegato / Unico</h5>
                                            <p class="text-primary mb-1"><b>Nome:</b> <%=us.getSoggettoAttuatore().getNome()%></p>
                                            <p class="text-primary mb-1"><b>Cognome:</b> <%=us.getSoggettoAttuatore().getCognome()%></p>
                                            <p class="text-primary mb-1"><b>Data Nascita:</b> <%=sdf.format(us.getSoggettoAttuatore().getDatanascita())%></p>
                                            <p class="text-primary mb-1"><b>Numero Documento:</b> <%=us.getSoggettoAttuatore().getNro_documento()%></p>
                                            <p class="text-primary mb-1"><b>Scadenza Documento:</b> <%=sdf.format(us.getSoggettoAttuatore().getScadenza())%></p>

                                            <h5 class="text-warning fw-bold mt-3">Referente</h5>
                                            <p class="text-primary mb-1"><b>Nome:</b> <%=us.getSoggettoAttuatore().getNome_refente()%></p>
                                            <p class="text-primary mb-1"><b>Cognome:</b> <%=us.getSoggettoAttuatore().getCognome_referente()%></p>
                                            <p class="text-primary mb-1"><b>Telefono:</b> <%=us.getSoggettoAttuatore().getTelefono_referente()%></p>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-4">
                                    <div id="div_preview"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <a id="chgPwd" href="<%=src%>/page/personal/chgPwd.jsp" 
                       class="btn btn-outline-primary d-none">Cambio Password</a>
                </div>
            </main>

            <!-- MODAL -->
            <div class="modal fade" id="kt_modal_6" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="text_modal_title"></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Chiudi"></button>
                        </div>
                        <div class="modal-body" id="text_modal_html"></div>
                    </div>
                </div>
            </div>
        </div>


        <%@include file="../../Bootstrap2024/index/login/Footer_login.jsp" %>


        <!--begin:: Global Mandatory Vendors -->
        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/moment.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.min.js" type="text/javascript"></script>

        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <!--end::Global Theme Bundle -->
        <!--begin::Page Vendors(used by this page) -->


        <!--end::Global Theme Bundle -->
        <!--begin::Page Vendors(used by this page) -->
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
            $('[data-toggle="popover-hover"]').popover({
                html: true,
                trigger: 'hover',
                placement: 'right'
            });
        </script>
        <script>
            $('.kt-scroll').each(function () {
                const ps = new PerfectScrollbar($(this)[0]);
            });

            function rinnovoCartaID() {
                swal.fire({
                    title: 'Nuovo documento d\'identità AD/AU',
                    html: "<div id='formCartaId'>" +
                            "<div class='custom-file'>" +
                            "<input type='file' tipo='obbligatory' class='custom-file-input' accept='application/pdf' name='cartaid' id='cartaid' onchange='return checkFileExtAndDim([&quot;pdf&quot;])'>" +
                            "<label class='custom-file-label selected' id='label_file'>Seleziona File</label>" +
                            "<div><br><input class='form-control obbligatory' id='numerodoc' name='numerodoc' placeholder='Numero documento'></div>" +
                            "<div><br><input class='form-control dp obbligatory' id='datascadenza' name='datascadenza' placeholder='Data scadenza'></div>" +
                            "<br></div></div>",
                    animation: false,
                    showCancelButton: true,
                    confirmButtonText: '&nbsp;<i class="la la-check"></i>',
                    cancelButtonText: '&nbsp;<i class="la la-close"></i>',
                    cancelButtonClass: "btn btn-danger",
                    confirmButtonClass: "btn btn-primary",
                    customClass: {
                        popup: 'animated bounceInUp'
                    },
                    onOpen: function () {

                        $('#cartaid').on('change', function () {
                            ctrlPdf($('#cartaid'));
                        })
                        var arrows = {
                            leftArrow: '<i class="la la-angle-left"></i>',
                            rightArrow: '<i class="la la-angle-right"></i>'
                        }
                        $('input.dp').datepicker({
                            templates: arrows,
                            orientation: "bottom left",
                            todayHighlight: true,
                            autoclose: true,
                            format: 'dd/mm/yyyy',
                            startDate: new Date(),
                        });
                    },
                    preConfirm: function () {
                        var err = false;
                        err = !checkRequiredFileContent($('#formCartaId')) ? true : err;
                        err = checkObblFieldsContent($('#formCartaId')) ? true : err;
                        if (!err) {
                            return new Promise(function (resolve) {
                                //                                formCartaId = $('#formCartaId');
                                resolve({
                                    "numerodoc": $('#numerodoc').val(),
                                    "datascadenza": $('#datascadenza').val(),
                                    "cartaid": $('#cartaid')[0].files[0]
                                });
                            });
                        } else {
                            return false;
                        }
                    },
                }).then((result) => {
                    if (result.value) {
                        showLoad();
                        var fdata = new FormData();
                        fdata.append("cartaid", result.value.cartaid);
                        fdata.append("numerodoc", result.value.numerodoc);
                        fdata.append("datascadenza", result.value.datascadenza);
                        upDoc(fdata);
                    } else {
                        swal.close();
                    }
                }
                );
            }

            function upDoc(fdata) {
                $.ajax({
                    type: "POST",
                    url: "<%=request.getContextPath()%>/OperazioniSA?type=updtCartaIDAD",
                    data: fdata,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        console.log(data);
                        var json = JSON.parse(data);
                        if (json.result) {
                            swalSuccessReload("Documento d'identità AD/AU", json.message);
                        } else {
                            swalError("Errore", json.message);
                        }
                    },
                    error: function () {
                        swalError("Errore", "Non è stato possibile caricare il documento d'identità");
                    }
                });
            }

            $(document).ready(function () {
                $.get("<%=request.getContextPath()%>/OperazioniGeneral?type=pdfTob64", function (data) {
                    $("<iframe />", {
                        "src": "data:application/pdf;base64," + data,
                        "width": '100%',
                        "height": '800px',
                        "type": "application/pdf",
                        css: {
                            "margin": 5,
                            "border": 0,
                            "border-radius": 10,
                        }
                    }).appendTo($('#div_preview'));
                });
            }); //div_preview


            function fancyBoxClose() {
                $('div.fancybox-overlay.fancybox-overlay-fixed').css('display', 'none');
            }

            jQuery(document).ready(function () {
            <%if (us.getStato() == 2) {%>
                $('#chgPwd')[0].click();
            <%}%>
            <%if (us.getTipo() == 3) {%>
                $('#tab2').trigger("click");
                $('#infoko').css("display", "");
            <%} else {%>
                $('#tab1').trigger("click");
                $('#infook').css("display", "");
            <%}%>
            });

            <%if (request.getParameter("fileNotFound") != null) {%>
            swalError("<h2>File Non Trovato<h2>", "<h4>Il file richiesto non esiste.</h4>");
            <%}%>

        </script>
    </body>
</html>
<%
        }
    }
%>
