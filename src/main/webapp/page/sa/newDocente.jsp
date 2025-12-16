


<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="rc.so.domain.TipoDoc"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.db.Database"%>
<%@page import="rc.so.domain.TitoliStudio"%>
<%@page import="rc.so.entity.Item"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="rc.so.domain.FasceDocenti"%>
<%@page import="rc.so.domain.User"%>
<%@page import="rc.so.db.Entity"%>
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
            String src = Utility.checkAttribute(session, "src");
            Entity e = new Entity();
            List<Item> regioni = e.listaRegioni();
            List<Item> comuni = e.listaComuni_totale();
            comuni.addAll(e.listaNazioni_totale());
            List<FasceDocenti> fasce = e.findAll(FasceDocenti.class);
            List<TitoliStudio> ts = e.listaTitoliStudio();
            int nroAttivita_max = Integer.parseInt(e.getPath("numAttivita_docente"));
            TipoDoc richiesta = e.getEm().find(TipoDoc.class, 34L);
            e.close();
            Database db = new Database(true);
            List<Item> aq = db.area_qualificazione();
            List<Item> inq = db.inquadramento();
            List<Item> att = db.attivita_docenti();
            List<Item> fon = db.fontifin();
            db.closeDB();
            List<Item> um = Utility.unitamisura();
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Docenti</title>
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
        <!-- this page -->
        <link href="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
        <!-- - -->
        <link href="<%=src%>/assets/vendors/general/owl.carousel/dist/assets/owl.carousel.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/owl.carousel/dist/assets/owl.theme.default.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon2/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/fontawesome5/css/all.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/animate.css" rel="stylesheet" type="text/css"/>
        <!--link href="<%=src%>/assets/demo/default/base/style.bundle.css" rel="stylesheet" type="text/css" /-->
        <link href="<%=src%>/resource/custom.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/base/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/brand/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/aside/light.css" rel="stylesheet" type="text/css" />
        <link href="../../Bootstrap2024/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">
        <script src="../../Bootstrap2024/assets/js/popper.js"></script>


        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
        <style type="text/css">
            .kt-section__title {
                font-size: 1.2rem!important;
            }

            .form-group {
                margin-bottom: 1rem;
            }

            .custom-file-label::after {
                color:#fff;
                background-color: #eaa21c;
            }

            a.disablelink > i {
                color: #7c7fb7!important;
            }

            .datepicker table tr td.highlighted.disabled, .datepicker table tr td.highlighted.disabled:active {
                background: #d9edf7;
                color: #d08902 !important;
            }

            .datepicker tbody tr > td.day {
                background: #ebedf2;
                color: #1d32a6 !important;
            }

            .datepicker tbody tr > td.day.active, .datepicker tbody tr > td.day.active {
                background: #363a90;
                color: #ffffff !important;
            }

            .datepicker table tr td.disabled, .datepicker table tr td.disabled {
                background: none;
                color: #777;
                cursor: default;
                color: #756c6e !important;
            }
            .it-footer {
                margin-top: auto; /* lo spinge in fondo */
            }
        </style>
    </head>

    <body class="d-flex flex-column min-vh-100">
        <%@ include file="menu/head1.jsp"%>

        <div class="it-header-wrapper">

            <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>

        </div>
        <%@ include file="../../Bootstrap2024/index/menu/menuAtt.jsp"%>
        <%@ include file="menu/head.jsp"%>


        <main class="container-fluid my-4">


            <!-- Intestazione sezione -->
            <div class="my-3">
                <h1 class="h3">Docenti</h1>
                <span class="text-muted">Aggiungi</span>
            </div>

            <div class="it-page-section" id="kt_content">
                <div class="card shadow-sm">
                    <form id="kt_form"
                          action="<%=request.getContextPath()%>/OperazioniSA?type=addDocente"
                          method="post"
                          enctype="multipart/form-data">

                        <input type="hidden" name="save" id="save" value="0" />

                        <% if (Utility.demoversion) {%>
                        <div class="card-header">
                            <a href="<%=request.getContextPath()%>/OperazioniSA?type=generaterandomDocenti"
                               class="btn btn-dark fw-bold">
                                <i class="fa fa-user"></i> INSERISCI DOCENTE RANDOM
                            </a>
                        </div>
                        <% } %>

                        <div class="card-body">

                            <!-- Sezione Anagrafica -->
                            <h5 class="mb-2">Anagrafica</h5>
                            <p class="small">Tutti i campi sono obbligatori *</p>
                            <hr>

                            <div class="row g-3 mb-3">
                                <div class="col-lg-3">
                                    <label for="nome" class="form-label">Nome *</label>
                                    <input type="text" class="form-control obbligatory" name="nome" id="nome">
                                </div>
                                <div class="col-lg-3">
                                    <label for="cognome" class="form-label">Cognome *</label>
                                    <input type="text" class="form-control obbligatory" name="cognome" id="cognome">
                                </div>
                                <div class="col-lg-3">
                                    <label for="cf" class="form-label">Codice Fiscale *</label>
                                    <input type="text" class="form-control obbligatory" name="cf" id="cf">
                                </div>
                                <div class="col-lg-3">
                                    <label for="com_nas" class="form-label">Comune di nascita *</label>
                                    <select class="form-select obbligatory" id="com_nas" name="com_nas">
                                        <option value="-">Seleziona Comune</option>
                                        <% for (Item i : comuni) {%>
                                        <option value="<%=i.getValue()%>"><%=i.getDesc()%></option>
                                        <% } %>
                                    </select>
                                </div>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-lg-3">
                                    <label for="datanascita" class="form-label">Data Nascita *</label>
                                    <input type="text" class="form-control obbligatory date-picker_r"
                                           name="data" id="datanascita" autocomplete="off" onkeydown="return false" />
                                </div>
                                <div class="col-lg-3">
                                    <label for="reg_res" class="form-label">Regione Residenza *</label>
                                    <select class="form-select obbligatory" id="reg_res" name="reg_res">
                                        <option value="-">Seleziona Regione</option>
                                        <% for (Item i : regioni) {%>
                                        <option value="<%=i.getValue()%>"><%=i.getDesc()%></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="col-lg-3">
                                    <label for="email" class="form-label">Email *</label>
                                    <input type="email" class="form-control obbligatory" name="email" id="email">
                                </div>
                                <div class="col-lg-3">
                                    <label for="pecmail" class="form-label">PEC *</label>
                                    <input type="email" class="form-control obbligatory" name="pecmail" id="pecmail">
                                </div>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-lg-3">
                                    <label for="telefono" class="form-label">Cellulare (senza +39) *</label>
                                    <input type="text" class="form-control obbligatory" name="telefono" id="telefono" onkeypress="return isNumber(event);">
                                </div>
                                <div class="col-lg-3">
                                    <label for="tit_stu" class="form-label">Titolo di Studio *</label>
                                    <select class="form-select obbligatory" id="tit_stu" name="tit_stu">
                                        <option value="-">Seleziona titolo di studio</option>
                                        <% for (TitoliStudio t : ts) {%>
                                        <option value="<%=t.getCodice()%>"><%=t.getDescrizione()%></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="col-lg-3">
                                    <label for="area_stu" class="form-label">Area di qualificazione *</label>
                                    <select class="form-select obbligatory" id="area_stu" name="area_stu">
                                        <option value="-">Seleziona area</option>
                                        <% for (Item t : aq) {%>
                                        <option value="<%=t.getCodice()%>"><%=StringEscapeUtils.escapeHtml4(t.getDescrizione())%></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="col-lg-3">
                                    <label for="fascia" class="form-label">Fascia *</label>
                                    <select class="form-select obbligatory" id="fascia" name="fascia">
                                        <option value="-">Seleziona fascia</option>
                                        <% for (FasceDocenti f : fasce) {%>
                                        <option value="<%=f.getId()%>"><%=f.getDescrizione()%></option>
                                        <% }%>
                                    </select>
                                </div>
                            </div>

                            <!-- Altre sezioni (Attività, Documentazione, ecc.) possono essere aggiunte nello stesso stile -->

                        </div>

                        <div class="card-footer text-end">
                            <a id="submit" href="javascript:void(0);" class="btn btn-primary me-2">Salva</a>
                            <a href="<%=StringEscapeUtils.escapeHtml4(pageName_)%>" class="btn btn-warning">Reset</a>
                        </div>

                    </form>
                </div>
            </div>
        </main>






        <%@ include file="../../Bootstrap2024/index/login/Footer_login.jsp"%>





        <!--begin:: Global Mandatory Vendors -->
        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/moment.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/jquery-form/dist/jquery.form.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js"></script>

        <!-- this page -->
        <script src="<%=src%>/assets/vendors/general/select2/dist/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-select/dist/js/bootstrap-select.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <script id="newDocente" src="<%=src%>/page/sa/js/newDocente.js<%="?dummy=" + String.valueOf(new Date().getTime())%>" data-context="<%=request.getContextPath()%>" type="text/javascript"></script> 
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


    </body>
</html>
<%
        }
    }
%>