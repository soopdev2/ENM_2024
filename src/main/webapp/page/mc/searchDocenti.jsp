
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.db.Entity"%>
<%@page import="java.util.List"%>
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
            String src = Utility.checkAttribute(session, "src");
            

int tipoR = 0;
    if (us != null) {
        tipoR = us.getTipo();
    }

    boolean rend = Action.rendicontazione_abilitata(us.getUsername());

    String uri = request.getRequestURI();
    String pageName = uri.substring(uri.lastIndexOf("/") + 1);
    String home = "", sa = "", allievi = "", docenti = "", aule = "", progettoformativo = "", cloud = "", faq = "", fad = "", activity = "",
            cad = "";
    switch (pageName) {
        case "indexMicrocredito.jsp":
            home = "kt-menu__item--active";
            break;
        case "searchSA.jsp":
        case "addSA.jsp":
            sa = "kt-menu__item--open kt-menu__item--here";
            break;
        case "searchAllieviMicro.jsp":
        case "manageAllievi.jsp":
            allievi = "kt-menu__item--open kt-menu__item--here";
            break;
        case "uploadDocenti.jsp":
        case "searchDocenti.jsp":
            docenti = "kt-menu__item--open kt-menu__item--here";
            break;
        case "uploadAule.jsp":
        case "searchAule.jsp":
            aule = "kt-menu__item--open kt-menu__item--here";
            break;
        case "searchPFMicro.jsp":
        case "extractFiles.jsp":
        case "dUnit.jsp":
            progettoformativo = "kt-menu__item--open kt-menu__item--here";
            break;
        case "downloadModelli.jsp":
        case "downloadModelliFS.jsp":
            cloud = "kt-menu__item--open kt-menu__item--here";
            break;
        case "saFAQ.jsp":
        case "mangeFAQ.jsp":
            faq = "kt-menu__item--open kt-menu__item--here";
            break;
        case "createFADconference.jsp":
        case "myConference.jsp":
            fad = "kt-menu__item--open kt-menu__item--here";
            break;
        case "createCad.jsp":
        case "myCad.jsp":
        case "addCpiUser.jsp":
        case "cpiUser.jsp":
            cad = "kt-menu__item--open kt-menu__item--here";
            break;
        case "addActivity.jsp":
        case "searchActivity.jsp":
        case "showActivity.jsp":
            activity = "kt-menu__item--open kt-menu__item--here";
            break;
        default:
            break;
    }
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

        <link href="<%=src%>/assets/vendors/general/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" type="text/css" />
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
        <!-- this page -->
        <link href="<%=src%>/resource/datatbles.bundle.css" rel="stylesheet" type="text/css"/>


    </head>
    <body>
        <!-- begin:: Page -->
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
                                        <a class="nav-link" href="indexMicrocredito.jsp"><span>Home</span></a>
                                    </li>
                                    <li class="nav-item dropdown megamenu">
                                        <button type="button" class="nav-link dropdown-toggle px-lg-2 px-xl-3" data-bs-toggle="dropdown" aria-expanded="false" id="megamenu-base-E" data-focus-mouse="false">
                                            <span>Soggetti Attuatori</span><svg role="img" class="icon icon-xs ms-1"><use href="/bootstrap-italia/dist/svg/sprites.svg#it-expand"></use></svg>
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
                                                                            <a class="list-item dropdown-item" href="searchSA.jsp">
                                                                                <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-search"></use></svg>
                                                                                <span>Cerca</span>
                                                                            </a>
                                                                        </li>
                                                                        <li>
                                                                            <a class="list-item dropdown-item" href="addSA.jsp">
                                                                                <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-pencil"></use></svg>
                                                                                <span>Gestisci Nuovi</span>
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
                                            <span>Sedi di Formazione</span><svg role="img" class="icon icon-xs ms-1"><use href="/bootstrap-italia/dist/svg/sprites.svg#it-expand"></use></svg>
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
                                                                            <a class="list-item dropdown-item" href="searchAule.jsp">
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
                                                                            <a class="list-item dropdown-item" href="searchDocenti.jsp">
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
                                                                            <a class="list-item dropdown-item" href="searchAllieviMicro.jsp">
                                                                                <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-search"></use></svg>
                                                                                <span>Cerca</span>
                                                                            </a>
                                                                        </li>
                                                                        <li>
                                                                            <a class="list-item dropdown-item" href="manageAllievi.jsp">
                                                                                <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-pencil"></use></svg>
                                                                                <span>Gestisci Nuovi</span>
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
                                                                            <a class="list-item dropdown-item" href="searchPFMicro.jsp">
                                                                                <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-search"></use></svg>
                                                                                <span>Cerca</span>
                                                                            </a>
                                                                        </li>
                                                                        <li>
                                                                            <a class="list-item dropdown-item" href="dUnit.jsp">
                                                                                <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-list"></use></svg>
                                                                                <span>Unità didattiche</span>
                                                                            </a>
                                                                        </li>
                                                                        <li>
                                                                            <a class="list-item dropdown-item" href="rend.jsp">
                                                                                <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-card"></use></svg>
                                                                                <span>Rendicontazione</span>
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
                                                                                <span>Gestisci</span>
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
                                                                            <a class="list-item dropdown-item" href="saFAQ.jsp">
                                                                                <svg role="img" class="icon icon-sm me-2"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-comment"></use></svg>
                                                                                <span>Domande SE</span>
                                                                            </a>
                                                                        </li>
                                                                        <li>
                                                                            <a class="list-item dropdown-item" href="mangeFAQ.jsp">
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
                                </ul>
                            </div>
                        </div>
                    </nav>
            <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--ver kt-page">
                <!-- end:: Aside -->
                <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor kt-wrapper" id="kt_wrapper">
                    <%@ include file="menu/head.jsp"%>
                    <!-- begin:: Footer -->
                    <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor">
                        <!-- begin:: Content Head -->
                        <div class="kt-subheader   kt-grid__item" id="kt_subheader">
                            <div class="kt-subheader   kt-grid__item" id="kt_subheader">
                                <div class="kt-subheader__main">
                                    <h3 class="kt-subheader__title">Docenti</h3>
                                    <span class="kt-subheader__separator kt-subheader__separator--v"></span>
                                    <a class="kt-subheader__breadcrumbs-link">Cerca</a>
                                </div>
                            </div>
                        </div>
                        <div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="kt-portlet" id="kt_portlet" data-ktportlet="true"><!--io-background-->
                                        <div class="kt-portlet__head">
                                            <div class="kt-portlet__head-label">
                                                <h3 class="kt-portlet__head-title" >
                                                    Cerca :
                                                </h3>
                                            </div>
                                            <div class="kt-portlet__head-toolbar">
                                                <div class="kt-portlet__head-group">
                                                    <a href="#" data-ktportlet-tool="toggle" class="btn btn-sm btn-icon btn-clean btn-icon-md"><i class="la la-angle-down" id="toggle_search"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <form action="" class="kt-form kt-form--label-right" onsubmit="return ctrlForm();" accept-charset="ISO-8859-1" method="post">
                                            <div class="kt-portlet__body paddig_0_t paddig_0_b">
                                                <div class="kt-section kt-section--first">
                                                    <div class="kt-section__body"><br>
                                                        <div class="form-group row">
                                                            <div class="col-lg-3">
                                                                <label>Nome</label>
                                                                <input class="form-control" name="nome" id="nome" autocomplete="off">
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <label>Cognome</label>
                                                                <input class="form-control" name="cognome" id="cognome" autocomplete="off">
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <label>Codice Fiscale</label>
                                                                <input class="form-control" name="cf" id="cf" autocomplete="off">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="kt-portlet__foot">
                                                        <div class="kt-form__actions">
                                                            <div class="row">
                                                                <div class="offset-lg-6 col-lg-6 kt-align-right">
                                                                    <a onclick="refresh();" href="javascript:void(0);" class="btn btn-primary"><font color='white'>Cerca</font></a>
                                                                    <a href="<%=StringEscapeUtils.escapeHtml4(pageName_)%>" class="btn btn-warning"><font color='white'>Reset</font></a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <div class="row" id="offsetresult">
                                <div class="col-lg-12">
                                    <div class="kt-portlet" id="kt_portlet" data-ktportlet="true">
                                        <div class="kt-portlet__head">
                                            <div class="kt-portlet__head-label col-lg-8">
                                                <div class="col-lg-4">
                                                    <h3 class="kt-portlet__head-title text" >
                                                        Risultati :
                                                    </h3>
                                                </div>
                                            </div>
                                            <div class="kt-portlet__head-toolbar">
                                                <div class="kt-portlet__head-group">
                                                    <a href="#" data-ktportlet-tool="toggle" class="btn btn-sm btn-icon btn-clean btn-icon-md"><i class="la la-angle-down" id="toggle_search"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="kt-portlet__body kt-scroll-x">
                                            <table class="table table-striped table-bordered " cellspacing="0" id="kt_table_1" style="width:100%;border-collapse: collapse;"> 
                                                <thead>
                                                    <tr>
                                                        <th class="text-uppercase text-center">Azioni</th>
                                                        <th class="text-uppercase text-center">Nome</th>
                                                        <th class="text-uppercase text-center">Cognome</th>
                                                        <th class="text-uppercase text-center">Codice Fiscale</th>
                                                        <th class="text-uppercase text-center">Data Nascita</th>
                                                        <th class="text-uppercase text-center">Soggetto Esecutore</th>
                                                        <th class="text-uppercase text-center">Fascia</th>
                                                        <th class="text-uppercase text-center">Stato</th>
                                                        <th class="text-uppercase text-center">Provenienza Domanda</th>
                                                        <th class="text-uppercase text-center">Data Webinair</th>
                                                    </tr>
                                                </thead>
                                            </table>  
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end:: Content Head -->
                    </div>
                    <%@ include file="../../Bootstrap2024/index/login/Footer_login.jsp"%>
                    <!-- end:: Footer -->
                    <!-- end:: Content -->
                </div>
            </div>
        </div>

        <!-- begin::Scrolltop -->
        <div id="kt_scrolltop" style="background-color: #0059b3" class="kt-scrolltop">
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
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/components/extended/blockui1.33.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
        <!-- this page -->
        <script src="<%=src%>/assets/vendors/custom/datatables/datatables.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/loadTable.js" type="text/javascript"></script>

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

            var context = '<%=request.getContextPath()%>';
            var tipouser = '<%=tipoR%>';
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
                load_table($('#kt_table_1'), '<%=request.getContextPath()%>/QueryMicro?type=searchDocenti&soggettoattuatore=' + $('#soggettoattuatore').val()
                        + '&cf=' + $('#cf').val() + '&nome=' + $('#nome').val() + '&cognome=' + $('#cognome').val(), );
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
                    url: '<%=request.getContextPath()%>' + '/OperazioniMicro?type=rejectDocente&id=' + id,
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

        </script>
    </body>
</html>
<%
        }
    }
%>