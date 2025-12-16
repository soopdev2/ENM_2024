<%-- 
    Document   : profile
    Created on : 18-set-2019, 12.31.26
    Author     : agodino
--%>
<%@page import="rc.so.db.Action"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="rc.so.db.Entity"%>
<%@page import="rc.so.entity.Item"%>
<%@page import="rc.so.domain.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User us = (User) session.getAttribute("user");
    if (us == null) {
    } else {
        String uri_ = request.getRequestURI();
        String pageName_ = uri_.substring(uri_.lastIndexOf("/") + 1);
        String type_ = session.getAttribute("abbonamento").toString();
        if (!Action.isVisibile(type_, pageName_)) {
            response.sendRedirect(request.getContextPath() + "/page_403.jsp");
        } else {
            String src = Utility.checkAttribute(session, "src");
            Entity e = new Entity();
            List<Item> regioni = e.listaRegioni();
            e.close();
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Profilo</title>
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

        <!--end::Fonts -->

        <!--begin::Page Vendors Styles(used by this page) -->

        <!--end::Page Vendors Styles -->

        <!--begin:: Global Mandatory Vendors -->
        <link href="<%=src%>/assets/vendors/general/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" type="text/css" />

        <!--end:: Global Mandatory Vendors -->

        <!--begin:: Global Optional Vendors -->
        <link href="<%=src%>/assets/vendors/general/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-switch/dist/css/bootstrap3/bootstrap-switch.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/owl.carousel/dist/assets/owl.carousel.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/owl.carousel/dist/assets/owl.theme.default.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/socicon/css/socicon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon2/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/fontawesome5/css/all.min.css" rel="stylesheet" type="text/css" />
        <link href="../../Bootstrap2024/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

        <!--end:: Global Optional Vendors -->

        <!--begin::Global Theme Styles(used by all pages) -->
        <link href="<%=src%>/assets/demo/default/base/style.bundle.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/custom.css" rel="stylesheet" type="text/css" />

        <!--end::Global Theme Styles -->
        <link href="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css" rel="stylesheet" type="text/css" />
        <!--begin::Layout Skins(used by all pages) -->
        <link href="<%=src%>/assets/demo/default/skins/header/base/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/brand/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/aside/light.css" rel="stylesheet" type="text/css" />
        <link href="../../Bootstrap2024/assets/js/popper.js" rel="stylesheet" type="text/css" />

        <link href="<%=src%>/resource/animate.css" rel="stylesheet" type="text/css"/>
        <!--end::Layout Skins -->
        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />

        <!--end::countDown -->
        <style type="text/css">
            .form-group {
                margin-bottom: 1rem;
            }

            .custom-file-label::after {
                color:#fff;
                background-color: #eaa21c;
            }
        </style>
    </head>


    <body class="d-flex flex-column min-vh-100"><!-- begin:: Page -->


        <main class="flex-grow-1 container-fluid px-4">


            <div class="container-fluid" id="kt_wrapper">
                <div class="row">
                    <div class="col-12">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <form id="kt_form" action="<%=request.getContextPath()%>/OperazioniSA?type=updtProfile" method="post" enctype="multipart/form-data">

                                    <!-- HEADER -->
                                    <div class="card-header d-flex justify-content-between align-items-center border-0 px-0 pb-3">
                                        <h3 class="h5 mb-0 text-primary">
                                            <i class="flaticon2-user"></i>
                                            <label data-bs-toggle="popover" data-bs-trigger="hover" data-bs-content="<h5>Username: <%=us.getUsername()%></h5>">
                                                Profilo | <b><%=us.getSoggettoAttuatore().getRagionesociale()%></b>
                                            </label>
                                            &nbsp;&nbsp;&nbsp;
                                            <% if (us.getSoggettoAttuatore().getProtocollo() == null) { %>
                                            <a data-bs-toggle="popover" data-bs-trigger="hover" data-bs-content="<h5>Soggetto Esecutore in attesa di accreditamento</h5>">
                                                <i class="flaticon2-correct text-danger"></i>
                                            </a>
                                            <% } else { %>
                                            <a data-bs-toggle="popover" data-bs-trigger="hover" data-bs-content="<h5>Soggetto Esecutore accreditato</h5>">
                                                <i class="flaticon2-correct text-success"></i>
                                            </a>
                                            <% } %>
                                        </h3>

                                        <!-- TABS -->
                                        <ul class="nav nav-pills" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link active" id="tab1" data-bs-toggle="tab" href="#kt_widget5_tab1_content" role="tab">Soggetto Esecutore</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab2" data-bs-toggle="tab" href="#kt_widget5_tab2_content" role="tab">Amministratore Delegato / Unico</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tab3" data-bs-toggle="tab" href="#kt_widget5_tab3_content" role="tab">Referente</a>
                                            </li>
                                        </ul>
                                    </div>

                                    <!-- TAB CONTENT -->
                                    <div class="tab-content mt-3">

                                        <!-- SOGGETTO ESECUTORE -->
                                        <div class="tab-pane fade show active" id="kt_widget5_tab1_content" role="tabpanel">
                                            <div class="row">
                                                <div class="col-md-5">
                                                    <h5>Soggetto Esecutore</h5>
                                                    <h6>
                                                        <% if (us.getSoggettoAttuatore().getProtocollo() != null) {%>
                                                        Numero Protocollo: <i><%=us.getSoggettoAttuatore().getProtocollo()%></i>
                                                        <% }%>
                                                    </h6>
                                                    <hr>

                                                    <div class="mb-3">
                                                        <label for="ragionesociale" class="form-label">Ragione Sociale</label>
                                                        <input class="form-control" type="text" readonly id="ragionesociale" name="ragionesociale"
                                                               value="<%=us.getSoggettoAttuatore().getRagionesociale()%>">
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="piva" class="form-label">Partita IVA</label>
                                                        <input class="form-control" type="text" readonly id="piva" name="piva"
                                                               value="<%=us.getSoggettoAttuatore().getPiva() == null ? "" : us.getSoggettoAttuatore().getPiva()%>">
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="cf" class="form-label">Codice Fiscale</label>
                                                        <input class="form-control" type="text" readonly id="cf" name="cf"
                                                               value="<%=us.getSoggettoAttuatore().getCodicefiscale() == null ? "" : us.getSoggettoAttuatore().getCodicefiscale()%>">
                                                    </div>

                                                    <h6>Contatti</h6>
                                                    <div class="mb-3">
                                                        <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="email" name="email" value="<%=us.getSoggettoAttuatore().getEmail()%>">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="pec" class="form-label">PEC <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="pec" name="pec" value="<%=us.getSoggettoAttuatore().getPec()%>">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="telefono_sa" class="form-label">Telefono <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="telefono_sa" name="telefono_sa" value="<%=us.getSoggettoAttuatore().getTelefono_sa()%>">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="cell_sa" class="form-label">Cellulare <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="cell_sa" name="cell_sa" value="<%=us.getSoggettoAttuatore().getCell_sa()%>">
                                                    </div>
                                                </div>

                                                <div class="col-md-5">
                                                    <h6>Indirizzo Sede Legale</h6>
                                                    <div class="mb-3">
                                                        <label for="indirizzo" class="form-label">Indirizzo <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="indirizzo" name="indirizzo" value="<%=us.getSoggettoAttuatore().getIndirizzo()%>">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="cap" class="form-label">CAP <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="cap" name="cap" value="<%=us.getSoggettoAttuatore().getCap()%>">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="regione" class="form-label">Regione <span class="text-danger">*</span></label>
                                                        <select class="form-select" id="regione" name="regione">
                                                            <option value="-">Seleziona Regione</option>
                                                            <% for (Item i : regioni) {
                                                                    if (i.getValue().equals(us.getSoggettoAttuatore().getComune().getRegione())) {%>
                                                            <option value="<%=i.getValue()%>" selected><%=i.getDesc()%></option>
                                                            <% } else {%>
                                                            <option value="<%=i.getValue()%>"><%=i.getDesc()%></option>
                                                            <% }
                                                                }%>
                                                        </select>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="provincia" class="form-label">Provincia <span class="text-danger">*</span></label>
                                                        <select class="form-select" id="provincia" name="provincia">
                                                            <option value="-">Seleziona Provincia</option>
                                                        </select>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="comune" class="form-label">Comune <span class="text-danger">*</span></label>
                                                        <select class="form-select" id="comune" name="comune">
                                                            <option value="-">Seleziona Comune</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- AMMINISTRATORE -->
                                        <div class="tab-pane fade" id="kt_widget5_tab2_content" role="tabpanel">
                                            <div class="row">
                                                <div class="col-md-5">
                                                    <h5>Amministratore Delegato / Unico</h5>
                                                    <div class="mb-3">
                                                        <label for="nome" class="form-label">Nome <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="nome" name="nome" value="<%=us.getSoggettoAttuatore().getNome()%>">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="cognome" class="form-label">Cognome <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="cognome" name="cognome" value="<%=us.getSoggettoAttuatore().getCognome()%>">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="kt_datepicker_4_2" class="form-label">Data Nascita <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="kt_datepicker_4_2" name="datanascita"
                                                               value="<%=new SimpleDateFormat("dd/MM/yyyy").format(us.getSoggettoAttuatore().getDatanascita())%>">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="nrodocumento" class="form-label">Numero Documento <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="nrodocumento" name="nrodocumento"
                                                               value="<%=us.getSoggettoAttuatore().getNro_documento()%>">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="kt_datepicker_4_3" class="form-label">Scadenza Documento <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="kt_datepicker_4_3" name="scadenza"
                                                               value="<%=new SimpleDateFormat("dd/MM/yyyy").format(us.getSoggettoAttuatore().getScadenza())%>">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Documento <span class="text-danger">*</span></label>
                                                        <input type="hidden" name="cartaidpath" value="<%=us.getSoggettoAttuatore().getCartaid()%>">
                                                        <input type="hidden" name="id" value="<%=us.getSoggettoAttuatore().getId()%>">
                                                        <input type="file" class="form-control" accept="application/pdf" name="cartaid" id="cartaid">
                                                    </div>
                                                </div>
                                                <div class="col-md-5">
                                                    <div id="div_preview"></div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- REFERENTE -->
                                        <div class="tab-pane fade" id="kt_widget5_tab3_content" role="tabpanel">
                                            <div class="row">
                                                <div class="col-md-5">
                                                    <h5>Referente</h5>
                                                    <div class="mb-3">
                                                        <label for="nome_ref" class="form-label">Nome <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="nome_ref" name="nome_ref" value="<%=us.getSoggettoAttuatore().getNome_refente()%>">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="tel_ref" class="form-label">Telefono <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="tel_ref" name="tel_ref"
                                                               value="<%=us.getSoggettoAttuatore().getTelefono_referente()%>">
                                                    </div>
                                                </div>
                                                <div class="col-md-5">
                                                    <div class="mb-3">
                                                        <label for="cognome_ref" class="form-label">Cognome <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="cognome_ref" name="cognome_ref"
                                                               value="<%=us.getSoggettoAttuatore().getCognome_referente()%>">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div> <!-- end tab-content -->

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



        </main>

        <!-- end:: Page -->

        <!-- begin::Quick Panel -->


        <!-- end::Quick Panel -->


        <!--begin:: Global Mandatory Vendors -->
        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/moment.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <!--end:: Global Mandatory Vendors -->
        <script src="<%=src%>/assets/vendors/general/select2/dist/js/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
        <!--begin::Global Theme Bundle(used by all pages) -->
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <!--end::Global Theme Bundle -->
        <!--begin::Page Vendors(used by this page) -->
        <script src="<%=src%>/assets/vendors/general/jquery-form/dist/jquery.form.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/custom/vendors/bootstrap-multiselectsplitter/bootstrap-multiselectsplitter.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-select/dist/js/bootstrap-select.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/jquery-validation/dist/jquery.validate.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/jquery-validation/dist/additional-methods.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/custom/components/vendors/jquery-validation/init.js" type="text/javascript"></script>

        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <!--end::Global Theme Bundle -->
        <!--begin::Page Vendors(used by this page) -->
        <script src="<%=src%>/assets/app/custom/general/components/extended/blockui1.33.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
        <!--DATERANGEPICKER -->
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
            $('#regione').on('change', function (e) {
                $("#provincia").empty();
                $("#comune").empty();
                $("#comune").append('<option value="-">. . .</option>');
                selectProvincia();
            });

            function selectProvincia() {
                var myTown = '<%=us.getSoggettoAttuatore().getComune().getNome_provincia()%>';
                $("#provincia").empty();
                if ($('#regione').val() != '-') {
                    startBlockUILoad("#provincia_div");
                    $("#provincia").append('<option value="-">Seleziona Provincia</option>');
                    $.get('<%=request.getContextPath()%>/Login?type=getProvincia&regione=' + $('#regione').val(), function (resp) {
                        var json = JSON.parse(resp);
                        for (var i = 0; i < json.length; i++) {
                            if (myTown.toLowerCase() == json[i].value.toLowerCase()) {
                                $("#provincia").append('<option selected value="' + json[i].value + '">' + json[i].desc + '</option>');
                            } else {
                                $("#provincia").append('<option value="' + json[i].value + '">' + json[i].desc + '</option>');
                            }
                        }
                        stopBlockUI("#provincia_div");
                    });
                } else {
                    $("#provincia").append('<option value="-">. . .</option>');
                }
            }

            function selectComune(provincia) {
                var myTown = '<%=us.getSoggettoAttuatore().getComune().getId()%>';
                $("#comune").empty();
                if (provincia != '-') {
                    startBlockUILoad("#comune_div");
                    $("#comune").append('<option value="-">Seleziona Comune</option>');
                    $.get('<%=request.getContextPath()%>/Login?type=getComune&provincia=' + provincia, function (resp) {
                        var json = JSON.parse(resp);
                        for (var i = 0; i < json.length; i++) {
                            if (myTown.toLowerCase() == json[i].value.toLowerCase()) {
                                $("#comune").append('<option selected value="' + json[i].value + '">' + json[i].desc + '</option>');
                            } else {
                                $("#comune").append('<option value="' + json[i].value + '">' + json[i].desc + '</option>');
                            }
                        }
                        stopBlockUI("#comune_div");
                    });
                } else {
                    $("#comune").append('<option value="-">. . .</option>');
                }
            }

            $('#provincia').on("change", function () {
                selectComune($('#provincia').val());
            });

            jQuery(document).ready(function () {
                var hash = $.trim(window.location.hash);
                if (hash) {
                    $(hash).addClass("active");
                    $('#tab2').addClass("active");
                    var scadenza = moment($('#kt_datepicker_4_3').val(), 'DD-MM-YYYY') + 3600000; //+1 UTC
                    if (scadenza < new Date().getTime()) {
                        $('#nrodocumento').attr("class", "form-control is-invalid");
                        $('#kt_datepicker_4_3').attr("class", "form-control is-invalid");
                        $('#cartaid').attr("class", "custom-file-input is-invalid");
                    } else {
                        $('#nrodocumento').removeClass("is-invalid");
                        $('#kt_datepicker_4_3').removeClass("is-invalid");
                        $('#cartaid').removeClass("form-control is-invalid");

                    }
                } else {
                    $('#kt_widget5_tab1_content').addClass("active");
                    $('#tab1').addClass("active");
                }

                selectProvincia();
                selectComune('<%=us.getSoggettoAttuatore().getComune().getNome_provincia()%>');
            });


            function ctrlForm() {
                var err = false;
//                29-04-2020 MODIFICA - NON RENDERE MODIFICABILE RAGIONE SOCIALE, PIVA, CF
//                var req_piva = false;
//                var req_cf = false;
//                var ra = $('#ragionesociale');
//                var piva = $('#piva');
//                var cf = $('#cf');
                var email = $('#email');
                var pec = $('#pec');
                var tel = $('#telefono_sa');
                var cel = $('#cell_sa');
                var indirizzo = $('#indirizzo');
                var cap = $('#cap');
                var comune = $('#comune');
                var nome_ad = $('#nome');
                var cognome_ad = $('#cognome');
                var datanascita = $('#kt_datepicker_4_2');
                var nrodocumento = $('#nrodocumento');
                var nome_ref = $('#nome_ref');
                var cognome_ref = $('#cognome_ref');
                var tel_ref = $('#tel_ref');
                var cartaid = $('#cartaid');
                var scadenza = $('#kt_datepicker_4_3');

//                if (checkValue(ra, false)) {
//                    err = true;
//                }
//                if (checkPIva(piva) || pivaPresent()) {
//                    req_piva = true;
//                }
//                if (!checkCF(cf) || CFPresent()) {
//                    req_cf = true;
//                }
//                if (req_piva && req_cf) {
//                    err = true;
//                }
                if (checkValue(tel, false)) {
                    err = true;
                }
                if (checkValue(cel, false)) {
                    err = true;
                }
                if (checkValue(indirizzo, false)) {
                    err = true;
                }
                if (checkCap(cap)) {
                    err = true;
                }
                if (checkValue(nome_ad, false)) {
                    err = true;
                }
                if (checkValue(cognome_ad, false)) {
                    err = true;
                }
                if (checkValue(datanascita, false)) {
                    err = true;
                }
                if (checkValue(nrodocumento, false)) {
                    err = true;
                }
                if (checkValue(nome_ref, false)) {
                    err = true;
                }
                if (checkValue(cognome_ref, false)) {
                    err = true;
                }
                if (checkValue(tel_ref, false)) {
                    err = true;
                }
                if (checkValue(comune, true)) {
                    err = true;
                }
                if (checkValue(scadenza, false)) {
                    err = true;
                }
                if (checkEmail(email) || Emailpresente()) {
                    err = true;
                }
                if (checkEmail(pec)) {
                    err = true;
                }

                if (cartaid.val() != '') {
                    if (!ctrlPdf(cartaid) || !checkFileDim()) {
                        err = true;
                    }
                }
                if (err) {
                    return false;
                }
                return true;
            }

            $("a[titolo=aggiorna]").on('click', function () {
                if (ctrlForm()) {
                    showLoad();
                    $('#kt_form').ajaxSubmit({
                        error: function () {
                            closeSwal();
                            swalError("Errore", "Riprovare, se l'errore persiste contattare il servizio clienti");
                        },
                        success: function (resp) {
                            var json = JSON.parse(resp);
                            closeSwal();
                            if (json.result) {
                                swalSuccess("Operazione effettuata con successo", "Aggiornamento delle informazioni profilo avvenuta correttamente.");
                                location.reload();
                            } else {
                                swalError("Errore", json.message);
                            }
                        }
                    });
                }
            });

            $('#piva').keydown(function (e) {
                if (this.value.length > 10)
                    if (!(e.which == '46' || e.which == '8' || e.which == '13')) // backspace/enter/del
                        e.preventDefault();
            });

            $('#piva').on("change", function () {
                if (!checkPIva($('#piva'))) {
                    pivaPresent();
                }
                if ($('#piva').val() == "") {
                    $('#piva').attr("class", "form-control");
                }
            });

            $('#cf').on("change", function () {
                if (checkCF($('#cf'))) {
                    CFPresent();
                }
                if ($('#cf').val() == "") {
                    $('#cf').attr("class", "form-control");
                }
            });

            function pivaPresent() {
                var err;
                if ($('#piva').val() != "<%=us.getSoggettoAttuatore().getPiva() == null ? "" : us.getSoggettoAttuatore().getPiva()%>") {
                    $.ajax({
                        type: "GET",
                        async: false,
                        url: '<%=request.getContextPath()%>/Login?type=checkPiva&piva=' + $('#piva').val(),
                        success: function (data) {
                            if (data != null && data != 'null') {
                                swal.fire({
                                    "title": 'Errore',
                                    "html": "<h3>Partita Iva già presente</h3>",
                                    "type": "error",
                                    cancelButtonClass: "btn btn-io-n",
                                });
                                $('#piva').attr("class", "form-control is-invalid");
                                err = true;
                            } else {
                                $('#piva').attr("class", "form-control is-valid");
                                err = false;
                            }
                        }
                    });
                } else {
                    err = false;
                }
                return err;
            }

            function CFPresent() {
                var err;
                if ($('#cf').val() != "<%=us.getSoggettoAttuatore().getCodicefiscale() == null ? "" : us.getSoggettoAttuatore().getCodicefiscale()%>") {
                    $.ajax({
                        type: "GET",
                        async: false,
                        url: '<%=request.getContextPath()%>/Login?type=checkCF&cf=' + $('#cf').val(),
                        success: function (data) {
                            if (data != null && data != 'null') {
                                swal.fire({
                                    "title": 'Errore',
                                    "html": "<h3>Codice Fiscale già presente</h3>",
                                    "type": "error",
                                    cancelButtonClass: "btn btn-io-n",
                                });
                                $('#cf').attr("class", "form-control is-invalid");
                                err = true;
                            } else {
                                $('#cf').attr("class", "form-control is-valid");
                                err = false;
                            }
                        }
                    });
                } else {
                    err = false;
                }
                return err;
            }

            $('#email').on("change", function () {
                if (!checkEmail($('#email'))) {
                    Emailpresente();
                }
            });

            function Emailpresente() {
                var err;
                if ($('#email').val() != "<%=us.getSoggettoAttuatore().getEmail()%>") {
                    $.ajax({
                        type: "GET",
                        async: false,
                        url: '<%=request.getContextPath()%>/Login?type=checkEmail&email=' + $('#email').val(),
                        success: function (data) {
                            if (data != null && data != 'null') {
                                swal.fire({
                                    "title": 'Errore',
                                    "html": "<h3>Email già presente</h3>",
                                    "type": "error",
                                    cancelButtonClass: "btn btn-io-n",
                                });
                                $('#email').attr("class", "form-control is-invalid");
                                err = true;
                            } else {
                                $('#email').attr("class", "form-control is-valid");
                                err = false;
                            }
                        }
                    });
                } else {
                    err = false;
                }
                return err;
            }

            $('[data-toggle="popover-hover"]').popover({
                html: true,
                trigger: 'hover',
                placement: 'bottom'
            });
        </script>

        <!--begin::Global App Bundle(used by all pages) -->
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <!--begin::flipdown -->
        <script>
            $(document).ready(function () {
                $.get("<%=request.getContextPath()%>/OperazioniGeneral?type=pdfTob64", function (data) {
                    $("<iframe />", {
                        "src": "data:application/pdf;base64," + data,
                        "width": '100%',
                        "height": '650px',
                        "type": "application/pdf",
                        css: {
                            "margin": 5,
                            "border": 0,
                            "border-radius": 10,
                        }
                    }).appendTo($('#div_preview'));
                });
            });//div_preview

            $('#cap').keydown(function (e) {
                if (this.value.length > 4)
                    if (!(e.which == '46' || e.which == '8' || e.which == '13')) // backspace/enter/del
                        e.preventDefault();
            });
        </script>
    </body>
</html>
<%}
    }%>
