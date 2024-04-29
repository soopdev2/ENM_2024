
<%@page import="rc.so.entity.Item"%>
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
            Long idsa = 0L;
            if (request.getParameter("idsa") != null) {
                idsa = Long.parseLong(request.getParameter("idsa"));
            }
            Entity e = new Entity();
            List<Item> regioni = e.listaRegioni();
            e.close();
            String src = session.getAttribute("src").toString();
            





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
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Sedi di Formazione</title>
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
        <link href="<%=src%>/resource/datatbles.bundle.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <!-- - -->
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
                                        <button type="button" class="nav-link active dropdown-toggle px-lg-2 px-xl-3" data-bs-toggle="dropdown" aria-expanded="false" id="megamenu-base-E" data-focus-mouse="false">
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
                                        <button type="button" class="nav-link  dropdown-toggle px-lg-2 px-xl-3" data-bs-toggle="dropdown" aria-expanded="false" id="megamenu-base-E" data-focus-mouse="false">
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
                                    <h3 class="kt-subheader__title">Sedi di Formazione</h3>
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
                                        <form action="" class="kt-form kt-form--label-right" onsubmit="return false;" accept-charset="ISO-8859-1" method="post">
                                            <div class="kt-portlet__body paddig_0_t paddig_0_b">
                                                <div class="kt-section kt-section--first">
                                                    <div class="kt-section__body"><br>
                                                        <div class="form-group row">
                                                            <div class="col-lg-4">
                                                                <label>Referente</label>
                                                                <input class="form-control obbligatory" name="referente" id="referente">
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col-lg-4">
                                                                <label>Regione</label>
                                                                <div class="dropdown bootstrap-select form-control kt- " id="regione_div" style="padding: 0;height: 35px;">
                                                                    <select class="form-control kt-select2-general obbligatory" id="regione" name="regione"  style="width: 100%">
                                                                        <option value="-">Seleziona Regione</option>
                                                                        <%for (Item i : regioni) {%>
                                                                        <option value="<%=i.getValue()%>"><%=i.getDesc()%></option>
                                                                        <%}%>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <label>Provincia</label>
                                                                <div class="dropdown bootstrap-select form-control kt-" id="provincia_div" style="padding: 0;height: 35px;">
                                                                    <select class="form-control kt-select2-general obbligatory" id="provincia" name="provincia"  style="width: 100%;">
                                                                        <option value="-">Seleziona Provincia</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <label>Comune</label>
                                                                <div class="dropdown bootstrap-select form-control kt-" id="comune_div" style="padding: 0;height: 35px;">
                                                                    <select class="form-control kt-select2-general obbligatory" id="comune" name="comune"  style="width: 100%;">
                                                                        <option value="-">Seleziona Comune</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="kt-portlet__foot">
                                                        <div class="kt-form__actions">
                                                            <div class="row">
                                                                <div class="offset-lg-6 col-lg-6 kt-align-right">
                                                                    <a onclick="refresh();" href="javascript:void(0);" class="btn btn-io"><font color='white'>Cerca</font></a>
                                                                    <a href="<%=pageName_%>" class="btn btn-io-n"><font color='white'>Reset</font></a>
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
                                            <table class="table table-striped table-bordered " cellspacing="0" id="kt_table_1"style="width:100%;border-collapse: collapse;"> 
                                                <thead>
                                                    <tr>
                                                        <th class="text-uppercase text-center">Azioni</th>
                                                        <th class="text-uppercase text-center">Denominazione</th>
                                                        <th class="text-uppercase text-center">Soggetto Esecutore</th>
                                                        <th class="text-uppercase text-center">Stato</th>
                                                        <th class="text-uppercase text-center">regione</th>
                                                        <th class="text-uppercase text-center">provincia</th>
                                                        <th class="text-uppercase text-center">comune</th>
                                                        <th class="text-uppercase text-center">indirizzo</th>
                                                        <th class="text-uppercase text-center">referente</th>
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
        <div id="kt_scrolltop" class="kt-scrolltop">
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
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/components/extended/blockui1.33.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
        <!-- this page -->
        <script src="<%=src%>/assets/vendors/general/select2/dist/js/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
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
            $('#regione').on('change', function (e) {
                $("#provincia").empty();
                $("#comune").empty();
                $("#comune").append('<option value="-">. . .</option>');
                if ($('#regione').val() !== '-') {
                    startBlockUILoad("#provincia_div");
                    $("#provincia").append('<option value="-">Seleziona Provincia</option>');
                    $.get('<%=request.getContextPath()%>/Login?type=getProvincia&regione=' + $('#regione').val(), function (resp) {
                        var json = JSON.parse(resp);
                        for (var i = 0; i < json.length; i++) {
                            $("#provincia").append('<option value="' + json[i].value + '">' + json[i].desc + '</option>');
                        }
                        stopBlockUI("#provincia_div");
                    });
                } else {
                    $("#provincia").append('<option value="-">. . .</option>');
                }
            });
        </script>
        <script>
            $('#provincia').on('change', function (e) {
                $("#comune").empty();
                if ($('#provincia').val() !== '-') {
                    startBlockUILoad("#comune_div");
                    $("#comune").append('<option value="-">Seleziona Comune</option>');
                    $.get('<%=request.getContextPath()%>/Login?type=getComune&provincia=' + $('#provincia').val(), function (resp) {
                        var json = JSON.parse(resp);
                        for (var i = 0; i < json.length; i++) {
                            $("#comune").append('<option value="' + json[i].value + '">' + json[i].desc + '</option>');
                        }
                        stopBlockUI("#comune_div");
                    });
                } else {
                    $("#comune").append('<option value="-">. . .</option>');
                }
            });
        </script>
        <script>
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
                        ajax: '<%=request.getContextPath()%>/QueryMicro?type=searchSedi&referente=' + $('#referente').val() + "&regione=" + $('#regione').val()
                                + "&provincia=" + $('#provincia').val() + "&comune=" + $('#comune').val(),
                        order: [],
                        columns: [
                            {defaultContent: ''},
                            {data: 'denominazione', className: 'text-center'},
                            {data: 'soggetto.ragionesociale', className: 'text-center'},
                            {data: 'descrizionestato', className: 'text-center'},
                            {data: 'comune.regione', className: 'text-center'},
                            {data: 'comune.nome_provincia', className: 'text-center'},
                            {data: 'comune.nome', className: 'text-center'},
                            {data: 'indirizzo', className: 'text-center'},
                            {data: 'referente', className: 'text-center'}
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

                                    if (tipouser === "2" && row.stato === "DV") {
                                        var option = '<div class="dropdown dropdown-inline">'
                                                + '<button type="button" class="btn btn-icon btn-sm btn-icon-md btn-circle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'
                                                + '   <i class="flaticon-more-1"></i>'
                                                + '</button>'
                                                + '<div class="dropdown-menu dropdown-menu-left">';
                                        option += '<a class="dropdown-item kt-font-success" href="javascript:void(0);" onclick="validateAula(' + row.id + ',1)"><i class="fa fa-check kt-font-success" style="margin-top:-2px"></i>Accredita</a>';
                                        option += '<a class="dropdown-item kt-font-success" href="javascript:void(0);" onclick="validateAula(' + row.id + ',2)"><i class="fa fa-check kt-font-success" style="margin-top:-2px"></i>Accredita per massimo 8 allievi</a>';
                                        option += '<a class="dropdown-item kt-font-danger" href="javascript:void(0);" onclick="rejectAula(' + row.id + ')"><i class="flaticon2-delete kt-font-danger" style="margin-top:-2px"></i>Rigetta</a>';
                                        option += '</div></div>';
                                        return option;
                                    } else {
                                        return "";
                                    }
                                }
                            }
                        ]
                    }).columns.adjust();
                };
                return {
                    init: function () {
                        initTable1();
                    },
                };
            }();
            jQuery(document).ready(function () {
                KTDatatablesDataSourceAjaxServer.init();
                $('.kt-scroll-x').each(function () {
                    const ps = new PerfectScrollbar($(this)[0], {suppressScrollY: true});
                });
            });
            function refresh() {
                $("#toolbar").css("display", "none");
                $('html, body').animate({scrollTop: $('#offsetresult').offset().top}, 500);
                load_table($('#kt_table_1'), '<%=request.getContextPath()%>/QueryMicro?type=searchSedi&referente=' + $('#referente').val() + "&regione=" + $('#regione').val()
                        + "&provincia=" + $('#provincia').val() + "&comune=" + $('#comune').val(), );
            }




            function validateAula(id, statusdest) {
                var html = "<h4 style='text-align:center;'>Sicuro di voler accreditare la Sede di Formazione scelta?</h4>";
                swal.fire({
                    title: '<h2 class="kt-font-io-n"><b>Accredita Sede di Formazione</b></h2><br>',
                    html: html,
                    animation: false,
                    showCancelButton: true,
                    confirmButtonText: '&nbsp;<i class="la la-check"></i>',
                    cancelButtonText: '&nbsp;<i class="la la-close"></i>',
                    cancelButtonClass: "btn btn-io-n",
                    confirmButtonClass: "btn btn-io",
                    width: '750px',
                    customClass: {
                        popup: 'animated bounceInUp',
                    }
                }).then((result) => {
                    if (result.value) {
                        changestatus(id, statusdest);
                    } else {
                        swal.close();
                    }
                });
            }
            function rejectAula(id) {
                var html = "<h4 style='text-align:center;'>Sicuro di voler rigettare la Sede di Formazione scelta?</h4>";
                swal.fire({
                    title: '<h2 class="kt-font-io-n"><b>Rigetta Sede di Formazione</b></h2><br>',
                    html: html,
                    animation: false,
                    showCancelButton: true,
                    confirmButtonText: '&nbsp;<i class="la la-check"></i>',
                    cancelButtonText: '&nbsp;<i class="la la-close"></i>',
                    cancelButtonClass: "btn btn-io-n",
                    confirmButtonClass: "btn btn-io",
                    width: '750px',
                    customClass: {
                        popup: 'animated bounceInUp',
                    }
                }).then((result) => {
                    if (result.value) {
                        changestatus(id, 'KO');
                    } else {
                        swal.close();
                    }
                });
            }

            function changestatus(id, status) {

                var statusdest = status;
                if (statusdest === 1 || statusdest === "1") {
                    statusdest = "OK";
                } else if (statusdest === 2 || statusdest === "2") {
                    statusdest = "OK1";
                }

                showLoad();
                $.ajax({
                    type: "POST",
                    url: '<%=request.getContextPath()%>' + '/OperazioniMicro?type=validateAula&id=' + id + "&status=" + statusdest,
                    success: function (data) {
                        closeSwal();
                        var json = JSON.parse(data);
                        if (json.result) {
                            if (status === 'OK' || status === 'OK1') {
                                swalSuccess("Sede di Formazione Accreditata", "Sede di formazione accreditata con successo");
                            } else if (status === 'KO') {
                                swalSuccess("Sede di Formazione Rigettata", "Sede di formazione rigettata con successo");
                            }
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

        </script>
    </body>
</html>
<%
        }
    }
%>