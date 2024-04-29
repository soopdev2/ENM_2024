


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
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js"></script>
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
        <link href="<%=src%>/assets/demo/default/base/style.bundle.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/custom.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/base/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/brand/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/aside/light.css" rel="stylesheet" type="text/css" />
        <link href="../../Bootstrap2024/assets/css/bootstrap-italia.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="Bootstrap2024/assets/css/global.css"/>
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">


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
        </style>
    </head>

    <body>
        <%@ include file="menu/head1.jsp"%>
        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <div class="kt-grid kt-grid--hor kt-grid--root">
            <nav class="navbar navbar-expand-lg has-megamenu" aria-label="Menu principale">
                <button type="button" aria-label="Mostra o nascondi il menu" class="custom-navbar-toggler" aria-controls="menu" aria-expanded="false" data-bs-toggle="navbarcollapsible" data-bs-target="#navbar-E">
                    <span>
                        <svg role="img" class="icon"><use href="/bootstrap-italia/dist/svg/sprites.svg#it-burger"></use></svg>
                    </span>
                </button>
                <div class="navbar-collapsable" id="navbar-E">
                    <div class="overlay fade"></div>
                    <div class="close-div">
                        <button type="button" aria-label="Chiudi il menu" class="btn close-menu">
                            <span><svg role="img" class="icon"><use href="/bootstrap-italia/dist/svg/sprites.svg#it-close-big"></use></svg></span>
                        </button>
                    </div>
                    <div class="menu-wrapper justify-content-lg-between">
                        <ul class="navbar-nav">
                            <li class="nav-item active">
                                <a class="nav-link " href="indexSoggettoAttuatore.jsp"><span>Home</span></a>
                            </li>
                            <li class="nav-item dropdown megamenu">
                                <button type="button" class="nav-link dropdown-toggle px-lg-2 px-xl-3" data-bs-toggle="dropdown" aria-expanded="false" id="megamenu-base-E" data-focus-mouse="false">
                                    <span>Allievi</span><svg role="img" class="icon icon-xs ms-1"><use href="/bootstrap-italia/dist/svg/sprites.svg#it-expand"></use></svg>
                                </button>
                                <div class="dropdown-menu shadow-lg" role="region" aria-labelledby="megamenu-base-E">
                                    <div class="megamenu pb-5 pt-3 py-lg-0">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="row">
                                                    <div class="col-12 col-lg-4">
                                                        <div class="link-list-wrapper">
                                                            <ul class="link-list">
                                                                <li>
                                                                    <a class="list-item dropdown-item" href="modello1.jsp">
                                                                        <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-pencil"></use></svg>
                                                                        <span>Aggiungi</span>
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <a class="list-item dropdown-item" href="searchAllievi.jsp">
                                                                        <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-search"></use></svg>
                                                                        <span>Cerca</span>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li class="nav-item dropdown megamenu">
                                <button type="button" class="nav-link active dropdown-toggle px-lg-2 px-xl-3" data-bs-toggle="dropdown" aria-expanded="false" id="megamenu-base-E" data-focus-mouse="false">
                                    <span>Docenti</span><svg role="img" class="icon icon-xs ms-1"><use href="/bootstrap-italia/dist/svg/sprites.svg#it-expand"></use></svg>
                                </button>
                                <div class="dropdown-menu shadow-lg" role="region" aria-labelledby="megamenu-base-E">
                                    <div class="megamenu pb-5 pt-3 py-lg-0">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="row">
                                                    <div class="col-12 col-lg-4">
                                                        <div class="link-list-wrapper">
                                                            <ul class="link-list">
                                                                <li>
                                                                    <a class="list-item dropdown-item active" href="newDocente.jsp">
                                                                        <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-pencil"></use></svg>
                                                                        <span>Aggiungi</span>
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <a class="list-item dropdown-item" href="searchDocenti_sa.jsp">
                                                                        <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-search"></use></svg>
                                                                        <span>Cerca</span>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li class="nav-item dropdown megamenu">
                                <button type="button" class="nav-link dropdown-toggle px-lg-2 px-xl-3" data-bs-toggle="dropdown" aria-expanded="false" id="megamenu-base-E" data-focus-mouse="false">
                                    <span>Progetti Formativi</span><svg role="img" class="icon icon-xs ms-1"><use href="/bootstrap-italia/dist/svg/sprites.svg#it-expand"></use></svg>
                                </button>
                                <div class="dropdown-menu shadow-lg" role="region" aria-labelledby="megamenu-base-E">
                                    <div class="megamenu pb-5 pt-3 py-lg-0">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="row">
                                                    <div class="col-12 col-lg-4">
                                                        <div class="link-list-wrapper">
                                                            <ul class="link-list">
                                                                <li>
                                                                    <a class="list-item dropdown-item" href="newProgettoFormativo.jsp">
                                                                        <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-pencil"></use></svg>
                                                                        <span>Aggiungi</span>
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <a class="list-item dropdown-item" href="searchProgettiFormativi.jsp">
                                                                        <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-search"></use></svg>
                                                                        <span>Cerca</span>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li class="nav-item dropdown megamenu">
                                <button type="button" class="nav-link dropdown-toggle px-lg-2 px-xl-3" data-bs-toggle="dropdown" aria-expanded="false" id="megamenu-base-E" data-focus-mouse="false">
                                    <span>Materiale Didattico</span><svg role="img" class="icon icon-xs ms-1"><use href="/bootstrap-italia/dist/svg/sprites.svg#it-expand"></use></svg>
                                </button>
                                <div class="dropdown-menu shadow-lg" role="region" aria-labelledby="megamenu-base-E">
                                    <div class="megamenu pb-5 pt-3 py-lg-0">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="row">
                                                    <div class="col-12 col-lg-4">
                                                        <div class="link-list-wrapper">
                                                            <ul class="link-list">
                                                                <li>
                                                                    <a class="list-item dropdown-item" href="downloadModelli.jsp">
                                                                        <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-download"></use></svg>
                                                                        <span>Download</span>
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <a class="list-item dropdown-item" href="downloadModelliFS.jsp">
                                                                        <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-download"></use></svg>
                                                                        <span>Modelli in Facsimile</span>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li class="nav-item dropdown megamenu">
                                <button type="button" class="nav-link dropdown-toggle px-lg-2 px-xl-3" data-bs-toggle="dropdown" aria-expanded="false" id="megamenu-base-E" data-focus-mouse="false">
                                    <span>FAQ</span><svg role="img" class="icon icon-xs ms-1"><use href="/bootstrap-italia/dist/svg/sprites.svg#it-expand"></use></svg>
                                </button>
                                <div class="dropdown-menu shadow-lg" role="region" aria-labelledby="megamenu-base-E">
                                    <div class="megamenu pb-5 pt-3 py-lg-0">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="row">
                                                    <div class="col-12 col-lg-4">
                                                        <div class="link-list-wrapper">
                                                            <ul class="link-list">
                                                                <li>
                                                                    <a class="list-item dropdown-item" href="myFAQ.jsp">
                                                                        <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-comment"></use></svg>
                                                                        <span>Le Mie Domande</span>
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <a class="list-item dropdown-item" href="allFAQ.jsp">
                                                                        <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-comment"></use></svg>
                                                                        <span>FAQ</span>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--ver kt-page">
                <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor kt-wrapper" id="kt_wrapper">
                    <%@ include file="menu/head.jsp"%>
                    <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor">
                        <div class="kt-subheader   kt-grid__item" id="kt_subheader">
                            <div class="kt-subheader   kt-grid__item" id="kt_subheader">
                                <div class="kt-subheader__main">
                                    <h3 class="kt-subheader__title">Docenti</h3>
                                    <span class="kt-subheader__separator kt-subheader__separator--v"></span>
                                    <a class="kt-subheader__breadcrumbs-link">Aggiungi</a>
                                </div>
                            </div>
                        </div>
                        <div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="kt-portlet" id="kt_portlet" data-ktportlet="true">
                                        <form id="kt_form" action="<%=request.getContextPath()%>/OperazioniSA?type=addDocente" 
                                              class="kt-form kt-form--label-right" method="post" enctype="multipart/form-data">
                                            <input type="hidden" name="save" id="save" value="0" />
                                            <%if (Utility.demoversion) {%>
                                            <div class="kt-portlet__head">
                                                <div class="kt-portlet__head-label">
                                                    <h3 class="kt-portlet__head-title">
                                                        <a href="<%=request.getContextPath()%>/OperazioniSA?type=generaterandomDocenti" 
                                                           class="btn btn-dark kt-font-bold"><i class="fa fa-user"></i> INSERISCI DOCENTE RANDOM</a>
                                                    </h3>
                                                </div>
                                            </div>
                                            <%}%>
                                            <div class="kt-portlet__body">
                                                <h5>ANAGRAFICA</h5>
                                                <p1>tutti i campi sono obbligatori* </p1>
                                                <div class="kt-separator kt-separator--border kt-separator--space-xs"></div>
                                                <div class="kt-section kt-section--first">
                                                    <div class="kt-section__body">
                                                        <div class="form-group row ">
                                                            <div class="col-lg-3">
                                                                <label  for="nome">Nome </label><label class="kt-font-danger kt-font-boldest"></label>
                                                                <input class="form-control obbligatory" name="nome" id="nome">
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <label for="cognome">Cognome </label><label class="kt-font-danger kt-font-boldest"></label>
                                                                <input class="form-control obbligatory" name="cognome" id="cognome">
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <label for="cf">Codice Fiscale </label><label class="kt-font-danger kt-font-boldest"></label>
                                                                <input class="form-control obbligatory" name="cf" id="cf">
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <label for="com_nas"> </label>
                                                                <label class="kt-font-danger kt-font-boldest"></label>
                                                                <div class="dropdown bootstrap-select form-control kt-" 
                                                                     id="com_nas_div" style="padding: 0;">
                                                                    <select class="form-control kt-select2-general obbligatory" 
                                                                            id="com_nas" name="com_nas" style="width: 100%">
                                                                        <option value="-">Seleziona Comune</option>
                                                                        <%for (Item i : comuni) {%>
                                                                        <option value="<%=i.getValue()%>"><%=i.getDesc()%></option>
                                                                        <%}%>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row ">
                                                            <div class="col-lg-3">
                                                                <label for="datanascita">Data Nascita </label><label class="kt-font-danger kt-font-boldest"></label>
                                                                <input type="text" class="form-control obbligatory date-picker_r" 
                                                                       name="data" id="datanascita" autocomplete="off" onkeydown="return false" />
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <label for="reg_res"></label>
                                                                <label class="kt-font-danger kt-font-boldest"></label>
                                                                <div class="dropdown bootstrap-select form-control kt-" 
                                                                     id="reg_res_div" style="padding: 0;">
                                                                    <select class="form-control kt-select2-general obbligatory" 
                                                                            id="reg_res" name="reg_res" style="width: 100%">
                                                                        <option value="-">Seleziona Regione</option>
                                                                        <%for (Item i : regioni) {%>
                                                                        <option value="<%=i.getValue()%>"><%=i.getDesc()%></option>
                                                                        <%}%>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <label for="email">Email </label><label class="kt-font-danger kt-font-boldest"></label>
                                                                <input class="form-control obbligatory" name="email" id="email">
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <label for="pecmail">PEC </label><label class="kt-font-danger kt-font-boldest"></label>
                                                                <input class="form-control obbligatory" name="pecmail" id="pecmail">
                                                            </div>

                                                        </div>
                                                        <div class="form-group row ">
                                                            <div class="col-lg-3">
                                                                <label for="telefono">Numero di cellulare (Senza +39) </label><label class="kt-font-danger kt-font-boldest"></label>
                                                                <input class="form-control obbligatory" name="telefono" id="telefono" onkeypress="return isNumber(event);">
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <label for="tit_stu"></label>
                                                                <label class="kt-font-danger kt-font-boldest"></label>
                                                                <div class="dropdown bootstrap-select form-control kt-" 
                                                                     id="tit_stu_div" style="padding: 0;">
                                                                    <select class="form-control kt-select2-general obbligatory" 
                                                                            id="tit_stu" name="tit_stu"  style="width: 100%">
                                                                        <option value="-">Seleziona titolo di studio</option>
                                                                        <%for (TitoliStudio t : ts) {%>
                                                                        <option value="<%=t.getCodice()%>"><%=t.getDescrizione()%></option>
                                                                        <%}%>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <label for="area_stu"></label>
                                                                <label class="kt-font-danger kt-font-boldest"></label>
                                                                <div class="dropdown bootstrap-select form-control kt-" 
                                                                     id="area_stu_div" style="padding: 0;">
                                                                    <select class="form-control kt-select2-general obbligatory" 
                                                                            id="area_stu" name="area_stu"  style="width: 100%">
                                                                        <option value="-">Seleziona Area di qualificazione</option>
                                                                        <%for (Item t : aq) {%>
                                                                        <option value="<%=t.getCodice()%>"><%=StringEscapeUtils.escapeHtml4(t.getDescrizione())%></option>
                                                                        <%}%>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <label for="fascia"></label>
                                                                <label class="kt-font-danger kt-font-boldest"></label>
                                                                <div class="dropdown bootstrap-select form-control kt-" 
                                                                     id="fascia_div" style="padding: 0;">
                                                                    <select class="form-control kt-select2-general obbligatory" 
                                                                            id="fascia" name="fascia">
                                                                        <option value="-">Seleziona Fascia</option>
                                                                        <%for (FasceDocenti f : fasce) {%>
                                                                        <option value="<%=f.getId()%>"><%=f.getDescrizione()%></option>
                                                                        <%}%>
                                                                    </select>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="form-group row ">
                                                        <div class="col-lg-3">
                                                            <label for="inquad"></label>
                                                            <label class="kt-font-danger kt-font-boldest"></label>
                                                            <div class="dropdown bootstrap-select form-control kt-" 
                                                                 id="inquad_div" style="padding: 0;">
                                                                <select class="form-control kt-select2-general obbligatory" 
                                                                        id="inquad" name="inquad">
                                                                    <option value="-">Seleziona Inquadramento</option>
                                                                    <%for (Item f : inq) {%>
                                                                    <option value="<%=f.getCodice()%>"><%=StringEscapeUtils.escapeHtml4(f.getDescrizione())%></option>
                                                                    <%}%>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row ">
                                                        <div class="col-lg-12" id="msgrow" style="display:block">
                                                            <label id="msg_cf"></label>
                                                        </div>
                                                    </div>
                                                </div>  
                                                <h5>TABELLA RIEPILOGATIVA DELLE ATTIVIT&#192; SVOLTE - Inserire le attivit&#224; a partire da quelle più rilevanti per l'attribuzione della fascia (max <%=nroAttivita_max%>) &nbsp;
                                                    <a href="javascript:void(0);" id="add_attivita"  class="btn btn-icon btn-primary btn-circle" style="margin: 0px; height: 2rem; width: 2rem;" data-container="body" data-html="true" data-toggle="kt-tooltip" data-placement="top" title="<h6>Aggiunti attività (da un minimo di 1 ad un massimo di <%=nroAttivita_max%>)</h6>"><i class="fa fa-folder-plus" style="font-size: 1rem;"></i></a>
                                                </h5>


                                                <div class="kt-separator kt-separator--border kt-separator--space-xs"></div>
                                                <div class="kt-section kt-section--first">
                                                    <div class="kt-section__body">

                                                        <%for (int i = 1; i <= nroAttivita_max; i++) {%>
                                                        <div id="docattivita_<%=i%>" style="display:none;">
                                                            <input type="hidden" name="attivita_vis_<%=i%>" id="attivita_vis_<%=i%>" value="0" />
                                                            <h5><center>ATTIVIT&#192; <%=i%> &nbsp;
                                                                    <%if (i > 1) {%>
                                                                    <a href="javascript:void(0);" onclick="delAttivita(<%=i%>);" id="delAttivita_<%=i%>" class="btn btn-icon btn-danger btn-circle" style="margin: 0px; height: 2rem; width: 2rem; display: none;" data-container="body" data-html="true" data-toggle="kt-tooltip" data-placement="top" title="<h6>Elimina attività</h6>"><i class="fa fa-times" style="font-size: 1rem;"></i></a>
                                                                        <%}%>
                                                                </center>
                                                            </h5>
                                                            <div class="kt-separator kt-separator--border kt-separator--space-xs"></div>
                                                            <div class="form-group row">
                                                                <div class="col-lg-3">
                                                                    <label for="tipo_att_<%=i%>"></label><label id="tipo_att_<%=i%>_obl" class='kt-font-danger kt-font-boldest'></label>
                                                                    <div class="dropdown bootstrap-select form-control kt-" 
                                                                         id="tipo_att_<%=i%>_div" style="padding: 0;">
                                                                        <select class="form-control kt-select2-general" 
                                                                                id="tipo_att_<%=i%>" name="tipo_att_<%=i%>">
                                                                            <option value="-">Seleziona Attivit&#224;</option>
                                                                            <%for (Item f : att) {%>
                                                                            <option value="<%=f.getCodice()%>"><%=StringEscapeUtils.escapeHtml4(f.getDescrizione())%></option>
                                                                            <%}%>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-3">
                                                                    <label for="committente_<%=i%>">Committente </label><label id="committente_<%=i%>_obl" class='kt-font-danger kt-font-boldest'></label>
                                                                    <input class="form-control" name="committente_<%=i%>" id="committente_<%=i%>">
                                                                </div>
                                                                <div class="col-lg-3">
                                                                    <label for="data_inizio_<%=i%>">Data inizio periodo di riferimento </label><label id="data_inizio_<%=i%>_obl" class='kt-font-danger kt-font-boldest'></label>
                                                                    <input type="text" class="form-control datepicker-custom" name="data_inizio_<%=i%>" id="data_inizio_<%=i%>" onkeydown="return false" >
                                                                </div>
                                                                <div class="col-lg-3">
                                                                    <label for="data_fine_<%=i%>">Data fine periodo di riferimento </label><label id="data_fine_<%=i%>_obl" class='kt-font-danger kt-font-boldest'></label>
                                                                    <input type="text" class="form-control datepicker-custom" name="data_fine_<%=i%>" id="data_fine_<%=i%>" onkeydown="return false" >
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <div class="col-lg-3">
                                                                    <label for="durata_<%=i%>">Durata</label><label id="durata_<%=i%>_obl" class='kt-font-danger kt-font-boldest'></label>
                                                                    <input class="form-control" onkeypress="return isNumber(event);"
                                                                           name="durata_<%=i%>" id="durata_<%=i%>">
                                                                </div>
                                                                <div class="col-lg-3">
                                                                    <label for="unita_<%=i%>"> </label><label id="unita_<%=i%>_obl" class='kt-font-danger kt-font-boldest'></label>
                                                                    <div class="dropdown bootstrap-select form-control kt-" 
                                                                         id="unita_<%=i%>_div" style="padding: 0;">
                                                                        <select class="form-control kt-select2-general" 
                                                                                id="unita_<%=i%>" name="unita_<%=i%>">
                                                                            <option value="-">Seleziona Unit&#224;</option>
                                                                            <%for (Item f : um) {%>
                                                                            <option value="<%=f.getCod()%>"><%=f.getDescrizione()%></option>
                                                                            <%}%>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-3">
                                                                    <label for="incarico_<%=i%>"></label><label id="incarico_<%=i%>_obl" class='kt-font-danger kt-font-boldest'></label> 
                                                                    <div class="dropdown bootstrap-select form-control kt-" 
                                                                         id="incarico_<%=i%>_div" style="padding: 0;">
                                                                        <select class="form-control kt-select2-general" id="incarico_<%=i%>" name="incarico_<%=i%>">
                                                                            <option value="-">Seleziona Tipologia di incarico</option>
                                                                            <%for (Item f : inq) {%>
                                                                            <option value="<%=f.getCodice()%>"><%=StringEscapeUtils.escapeHtml4(f.getDescrizione())%></option>
                                                                            <%}%>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-3">
                                                                    <label " for="fonte_<%=i%>"></label><label id="fonte_<%=i%>_obl" class='kt-font-danger kt-font-boldest'></label>
                                                                    <div class="dropdown bootstrap-select form-control kt-" 
                                                                         id="fonte_<%=i%>_div" style="padding: 0;">
                                                                        <select class="form-control kt-select2-general" id="fonte_<%=i%>" name="fonte_<%=i%>">
                                                                            <option value="-">Seleziona Fonte</option>
                                                                            <%for (Item f : fon) {%>
                                                                            <option value="<%=f.getCodice()%>"><%=StringEscapeUtils.escapeHtml4(f.getDescrizione())%></option>
                                                                            <%}%>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <div class="col-lg-3">
                                                                    <label for="progr_<%=i%>">N. progressivo di rif.</label>
                                                                    <label>
                                                                        <i class="fa fa-info-circle" 
                                                                           data-toggle="kt-popover" 
                                                                           data-trigger="hover" 
                                                                           data-container="body" 
                                                                           data-placement="bottom"
                                                                           data-content="Nel caso in cui le esperienze utili al raggiungimento della fascia di appartenenza dichiarata per il docente siano contenute in sezioni separate del cv, 
                                                                           raggruppare le attivit&#224; per tipologia e attribuire un numero progressivo da 1 a 5.
                                                                           Tale numero deve essere trascritto (anche a penna) sul cv in modo da consentire la verifica della fascia di appartenenza." 
                                                                           data-original-title="NUMERO PROGRESSIVO DI RIFERIMENTO CV"></i>
                                                                    </label><label id="progr_<%=i%>_obl" class='kt-font-danger kt-font-boldest'>*</label>
                                                                    <input class="form-control" name="progr_<%=i%>" id="progr_<%=i%>" onkeypress="return isNumber(event);" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <%}%>
                                                    </div>
                                                </div>
                                                <h5>DOCUMENTAZIONE</h5>
                                                <div class="kt-separator kt-separator--border kt-separator--space-xs"></div>
                                                <div class="kt-section kt-section--first">
                                                    <div class="kt-section__body">              
                                                        <div class="form-group row">
                                                            <div class="col-lg-12">

                                                                <div class="form-group row">
                                                                    <div class="form-group col-xl-6 col-lg-6">
                                                                        <h6>RICHIESTA ACCREDITAMENTO DOCENTE</h6>
                                                                    </div>
                                                                    <div class="form-group col-xl-6 col-lg-6">
                                                                        <label> <br>Scaricare il modello con i dati inseriti per poi caricarlo firmato digitalmente (.p7m CAdES, .pdf PAdES) nel campo seguente.</label>
                                                                        <button class="btn btn-primary btn-md btn-tall btn-wide kt-font-bold kt-font-transform-u" 
                                                                                type="button" 
                                                                                onclick="return model_funct('<%=richiesta.getId()%>');">
                                                                            Scarica
                                                                        </button>
                                                                    </div>
                                                                    <div class="form-group col-xl-4 col-lg-6">
                                                                        <div class="custom-file">
                                                                            <input type="file" tipo="obbligatory" class="custom-file-input" 
                                                                                   accept="<%=richiesta.getMimetype()%>" 
                                                                                   name="doc_<%=richiesta.getId()%>" id="doc_<%=richiesta.getId()%>" 
                                                                                   onchange="return checkFileExtAndDim('<%=richiesta.getEstensione()%>');" />
                                                                            <label style="text-align: left;" class="custom-file-label selected" id="label_file">Scegli File</label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col-xl-3 col-lg-6">
                                                                <label for="docid"></label><label class="kt-font-danger kt-font-boldest"></label>
                                                                <div class="custom-file">
                                                                    <input type="file" tipo="obbligatory" class="custom-file-input" accept="application/pdf" 
                                                                           name="docid" id="docid" onchange="return checkFileExtAndDim(['pdf']);">
                                                                    <label style="text-align: left;" class="custom-file-label selected" id="label_file">Scegli DOCUMENTO DI RICONOSCIMENTO DOCENTE </label>
                                                                </div>
                                                            </div>
                                                            <div class="col-xl-3 col-lg-6">
                                                                <label for="scadenzadoc">DATA SCADENZA DOCUMENTO DOCENTE </label><label class="kt-font-danger kt-font-boldest"></label>
                                                                <input type="text" class="form-control obbligatory date-picker_r1" name="scadenzadoc" id="scadenzadoc" 
                                                                       onkeydown="return false"  autocomplete="off"/>
                                                            </div>
                                                            <div class="col-xl-3 col-lg-6">
                                                                <label for="cv"> </label><label class="kt-font-danger kt-font-boldest"></label>
                                                                <div class="custom-file">
                                                                    <input type="file" tipo="obbligatory" class="custom-file-input" accept="application/pdf" name="cv" id="cv" onchange="return checkFileExtAndDim(['pdf']);">
                                                                    <label style="text-align: left;" class="custom-file-label selected" id="label_file">Scegli CURRICULUM VITAE DOCENTE </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="kt-portlet__foot">
                                                    <div class="kt-form__actions">
                                                        <div class="row">
                                                            <div class="offset-lg-6 col-lg-6 kt-align-right">
                                                                <a id="submit" href="javascript:void(0);" class="btn btn-primary"><font color='white'>Salva</font></a>
                                                                <a href="<%=StringEscapeUtils.escapeHtml4(pageName_)%>" class="btn btn-warning"><font color='white'>Reset</font></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%@ include file="../../Bootstrap2024/index/login/Footer_login.jsp"%>
                </div>
            </div>
        </div>
        <div id="kt_scrolltop" style="background-color: #0059b3" style="background-color: #1d32a6" class="kt-scrolltop">
            <i class="fa fa-arrow-up"></i>
        </div>
        <!--begin:: Global Mandatory Vendors -->
        <script src="<%=src%>/assets/soop/js/jquery-3.6.1.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/popper.js/dist/umd/popper.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
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
        <!-- this page -->
        <script src="<%=src%>/assets/vendors/general/select2/dist/js/select2.full.js" type="text/javascript"></script>
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