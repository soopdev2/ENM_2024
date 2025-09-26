<%-- 
    Document   : profile
    Created on : 18-set-2019, 12.31.26
    Author     : agodino
--%>
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.domain.NomiProgetto"%>
<%@page import="rc.so.domain.StatiPrg"%>
<%@page import="rc.so.domain.TipoDoc"%>
<%@page import="rc.so.domain.Docenti"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rc.so.domain.SediFormazione"%>
<%@page import="rc.so.domain.Allievi"%>
<%@page import="rc.so.db.Action"%>
<%@page import="java.util.List"%>
<%@page import="rc.so.db.Entity"%>
<%@page import="rc.so.domain.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            String src = Utility.checkAttribute(session, "src");
            Entity e = new Entity();
            List<Allievi> alunni = e.getAllieviSoggettoModello1(us.getSoggettoAttuatore());
            List<SediFormazione> sedi = e.getSediFormazione(session);
            List<NomiProgetto> nomi = e.findAll(NomiProgetto.class);
            List<Docenti> docente = e.getActiveDocenti_bySA(us.getSoggettoAttuatore());
            List<TipoDoc> tipo_doc = e.getTipoDoc(e.getEm().find(StatiPrg.class, "DV"));
            sedi = sedi == null ? new ArrayList() : sedi;
            int n_allievi = Integer.parseInt(e.getPath("min_allievi"));
            int max_allievi = Integer.parseInt(e.getPath("max_alunni"));
            e.close();
            boolean fancy = request.getParameter("fb") != null && request.getParameter("fb").equals("1") ? false : true;
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Progetti Formativi</title>
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
        <!-- this page -->
        <link href="../../Bootstrap2024/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/assets/app/custom/wizard/wizard-v1_io.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js   " rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon2/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/fontawesome5/css/all.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/base/style.bundle.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/custom.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/base/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/brand/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/aside/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/animate.css" rel="stylesheet" type="text/css"/>
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">
        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
        <script src="../../Bootstrap2024/assets/js/popper.js"></script>

        <style type="text/css">
            .form-group {
                margin-bottom: 1rem;
            }

            .custom-file-label::after {
                color:#fff;
                background-color: #eaa21c;
            }
            .offset-sm-1{
                margin-left: 5%;
            }
        </style>


        <script type="text/javascript">

            function model_funct(codice) {

                document.getElementById('save').value = "1";
                document.getElementById('modello_' + codice).value = codice;
                document.getElementById("kt_form").target = "_blank";
                document.getElementById("kt_form").submit();
            }

        </script>

    </head>
    <body>
        <!-- begin:: Page -->
        <%if (fancy) {%>
        <%@ include file="menu/head1.jsp"%>
        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <%@ include file="../../Bootstrap2024/index/menu/menuAtt.jsp"%>
        <%@ include file="menu/head.jsp"%>

        <main class="container-fluid my-4">
            <!-- Intestazione -->
            <div class="mb-3">
                <h3>Progetti Formativi</h3>
                <span class="text-muted">Aggiungi</span>
            </div>

            <!-- Messaggio info -->
            <div class="alert alert-info">
                <b>MODELLO 2</b> - - La presente richiesta, firmata digitalmente, deve essere inviata almeno 15 gg. Prima della data prevista per l'avvio del percorso ed il corso deve essere avviato entro 15 giorni dalla data di autorizzazione.
            </div>

            <!-- Wizard -->
            <div class="card shadow-sm" id="kt_wizard_v1" data-ktwizard-state="step-first">
                <!-- Wizard Nav -->
                <div class="card-header bg-white rounded-top">
                    <div class="d-flex justify-content-between">
                        <div class="wizard-nav d-flex">
                            <a class="nav-item nav-link active kt-wizard-v1__nav-item" href="#" data-ktwizard-type="step" data-ktwizard-state="current">
                                <i class="fa fa-pencil-alt"></i> 1 - Informazioni generali
                            </a>
                            <a class="nav-item nav-link kt-wizard-v1__nav-item" href="#" data-ktwizard-type="step">
                                <i class="flaticon-presentation-1"></i> 2 - Aula e Allievi
                            </a>
                            <a class="nav-item nav-link kt-wizard-v1__nav-item" href="#" data-ktwizard-type="step">
                                <i class="fa fa-chalkboard-teacher"></i> 3 - Docente
                            </a>
                            <a class="nav-item nav-link kt-wizard-v1__nav-item" href="#" data-ktwizard-type="step">
                                <i class="fa fa-file-pdf"></i> 4 - Documenti
                            </a>
                            <a class="nav-item nav-link kt-wizard-v1__nav-item" href="#" data-ktwizard-type="step">
                                <i class="fa fa-list"></i> 5 - Riepilogo
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Wizard Content -->
                <div class="card-body kt-wizard-v1__wrapper">
                    <form id="kt_form" action="<%=request.getContextPath()%>/OperazioniSA?type=newProgettoFormativo"
                          method="post" class="kt-form kt-form--label-right" accept-charset="ISO-8859-1">
                        <input type="hidden" name="save" id="save" value="0"/>

                        <!-- STEP 1 -->
                        <div class="kt-wizard-v1__content" id="step1" data-ktwizard-type="step-content" data-ktwizard-state="current">
                            <div class="form-group row">
                                <div class="col-lg-12">
                                    <label>Nome Progetto <span class="text-danger">*</span></label>
                                    <div class="dropdown bootstrap-select form-control kt-paddig_0" id="nome_pf_div">
                                        <select class="form-control kt-select2-general obbligatory" id="nome_pf" name="nome_pf">
                                            <option value="-">Seleziona Nome</option>
                                            <%for (NomiProgetto s : nomi) {%>
                                            <option value="<%=s.getId()%>"><%=s.getDescrizione()%></option>
                                            <%}%>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="svolgimento" value="M"/>
                            <div class="form-group">
                                <textarea class="form-control" id="descrizione_pf" name="descrizione_pf"
                                          placeholder="Descrizione Progetto Formativo" rows="5"></textarea>
                            </div>
                            <div class="form-group row">
                                <div class="col-lg-12">
                                    <label>Date <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control obbligatory" name="date" id="kt_daterange"
                                           placeholder="Date Inizio e Fine" readonly autocomplete="off"/>
                                </div>
                            </div>
                            <small class="text-danger">* Campi obbligatori</small>
                        </div>

                        <!-- STEP 2 -->
                        <div class="kt-wizard-v1__content" id="step2" data-ktwizard-type="step-content">
                            <div class="form-group">
                                <label>Sede <span class="text-danger">*</span></label>
                                <div class="dropdown bootstrap-select form-control kt-" id="sede_div">
                                    <select class="form-control kt-select2-general obbligatory" id="sede" name="sede" style="width:100%">
                                        <option value="-">Seleziona Sede</option>
                                        <%for (SediFormazione s : sedi) {%>
                                        <option value="<%=s.getId()%>"><%=s.getDenominazione()%></option>
                                        <%}%>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Allievi <span class="text-danger">*</span></label>
                                <div class="select-div" id="allievi_div">
                                    <select class="form-control kt-select2 obbligatory" id="allievi" name="allievi[]" multiple style="width:100%">
                                        <%for (Allievi a : alunni) {%>
                                        <option value="<%=a.getId()%>"><%=a.getCognome()%> <%=a.getNome()%> (<%=a.getCodicefiscale()%>)</option>
                                        <%}%>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- STEP 3 -->
                        <div class="kt-wizard-v1__content" id="step3" data-ktwizard-type="step-content">
                            <div class="form-group">
                                <label>Docenti <span class="text-danger">*</span></label>
                                <div class="dropdown bootstrap-select form-control kt-" id="docenti_div">
                                    <select class="form-control kt-select2 obbligatory" id="docenti" name="docenti[]" multiple style="width:100%">
                                        <%for (Docenti d : docente) {%>
                                        <option value="<%=d.getId()%>"><%=d.getCognome()%> <%=d.getNome()%></option>
                                        <%}%>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- STEP 4 -->
                        <div class="kt-wizard-v1__content" id="step4" data-ktwizard-type="step-content">
                            <%for (TipoDoc t : tipo_doc) {%>
                            <div class="form-group">
                                <label><%=t.getDescrizione()%> <%if (t.getObbligatorio() == 1) {%><span class="text-danger">*</span><%}%></label>
                                <%if (t.getModello() != null) {%>
                                <div class="mb-2">
                                    <button type="button" class="btn btn-primary" onclick="return model_funct('<%=t.getId()%>');">Scarica</button>
                                </div>
                                <%}%>
                                <input type="file" class="form-control" name="doc_<%=t.getId()%>" accept="<%=t.getMimetype()%>" 
                                       onchange="return checkFileExtAndDim('<%=t.getEstensione()%>');">
                            </div>
                            <%}%>
                        </div>

                        <!-- STEP 5 -->
                        <div class="kt-wizard-v1__content" id="step5" data-ktwizard-type="step-content">
                            <h4>Riepilogo</h4>
                            <div>
                                <p>Nome Progetto: <span id="label_titolo"></span></p>
                                <p>Descrizione: <span id="label_descrizione"></span></p>
                                <p>Date: <span id="label_date"></span></p>
                                <p>Aula: <span id="label_aula"></span></p>
                                <p>Allievi: <span id="label_alunni"></span></p>
                                <p>Docenti: <span id="label_docenti"></span></p>
                            </div>
                        </div>

                        <!-- Bottoni Wizard -->
                        <div class="kt-form__actions mt-3">
                            <div class="btn btn-warning" data-ktwizard-type="action-prev">Indietro</div>
                            <div class="btn btn-primary" data-ktwizard-type="action-submit">Salva</div>
                            <div class="btn btn-primary" id="go_next" data-ktwizard-type="action-next">Avanti</div>
                        </div>
                    </form>
                </div>
            </div>
        </main>

        <%@include file="../../Bootstrap2024/index/login/Footer_login.jsp" %>




        <div id="kt_scrolltop" style="background-color: #0059b3" class="kt-scrolltop">
            <i class="fa fa-arrow-up"></i>
        </div>
        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
        <script src="../../assets/soop/js/jquery-1.12.4.min.js" type="text/javascript"></script>
        <script src="../../assets/vendors/general/bootstrap/js/dist/dropdown.js"></script>
        <script src="<%=src%>/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/moment.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/components/extended/blockui1.33.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/jquery-form/dist/jquery.form.min.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
        <!--this page-->
        <script src="<%=src%>/assets/vendors/general/select2/dist/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-daterangepicker.js" type="text/javascript"></script><!--usa questo per modificare daterangepicker-->
        <script src="<%=src%>/assets/vendors/general/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/wizard/wizard-progetto.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>

        <script id="docenti_allievi" src="<%=src%>/page/sa/js/docenti_allievi.js<%="?dummy=" + String.valueOf(new Date().getTime())%>" data-context="<%=request.getContextPath()%>" type="text/javascript"></script>
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
            jQuery(document).ready(function () {

            });

            min_allievi = <%=n_allievi%>;
            max_allievi = <%=max_allievi%>;

            <%for (Docenti d : docente) {%>
            doc_docenti.set('<%=d.getId()%>', {"docid": "<%=d.getDocId()%>", "curriculum": "<%=d.getCurriculum()%>", "scadenza": new Date(<%=d.getScadenza_doc() == null ? "0" : d.getScadenza_doc().getTime()%>)});
            <%}%>

            $("#nome_pf").change(function (e) {
                $("#label_titolo").html("<b>" + $(this).val() + "</b>");
            });
            $("#descrizione_pf").change(function (e) {
                $("#label_descrizione").html("<b>" + $(this).val() + "</b>");
            });
            $("#kt_daterange").change(function (e) {
                $("#label_date").html("<b>" + $(this).val() + "</b>");
            });
            $("#sede").change(function (e) {
                $("#label_aula").html("<b>" + $("#" + this.id + " option[value='" + $(this).val() + "']").text() + "</b>");
            });
            $("#allievi").change(function (e) {
                var allievi = "";
                $.each($('#allievi').val(), function (i, a) {
                    allievi = allievi + $("#allievi option[value='" + a + "']").text() + "; ";
                });
                $("#label_alunni").html("<b>" + allievi + "</b>");
            });
            $("#docenti").change(function (e) {
                var docenti = "";
                $.each($('#docenti').val(), function (i, a) {
                    docenti = docenti + $("#docenti option[value='" + a + "']").text() + "; ";
                });
                $("#label_docenti").html("<b>" + docenti + "</b>");
            });


        </script>
    </body>
</html>
<%}
    }%>
