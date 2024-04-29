<%@page import="rc.so.domain.ProgettiFormativi"%>
<%@page import="rc.so.domain.StatiPrg"%>
<%@page import="rc.so.db.Entity"%>
<%@page import="java.util.List"%>
<%@page import="rc.so.domain.SoggettiAttuatori"%>
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
            String src = session.getAttribute("src").toString();
            Entity e = new Entity();
            List<ProgettiFormativi> progetti = e.getProgettiDaRendicontare();
            e.close();
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
        <link href="<%=src%>/assets/vendors/general/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/resource/datatbles.bundle.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" type="text/css" />
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
        <!--end::countDown -->
        <style>
            .kt-section__title {
                font-size: 1.2rem!important;
            }
            .daterangepicker.ltr.auto-apply.show-calendar.opensright{
                z-index: 9999;
            }

            a.disablelink > i {
                color: #7c7fb7!important;
            }
            .select2-dropdown {
                z-index: 99999!important;
            }
        </style>
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
                                <button type="button" class="nav-link active dropdown-toggle px-lg-2 px-xl-3" data-bs-toggle="dropdown" aria-expanded="false" id="megamenu-base-E" data-focus-mouse="false">
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
                                    <h3 class="kt-subheader__title">Progetti Formativi</h3>
                                    <span class="kt-subheader__separator kt-subheader__separator--v"></span>
                                    <a class="kt-subheader__breadcrumbs-link">Rendicontazione</a>
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
                                                    Scegli i progetti da rendicontare:
                                                </h3>
                                            </div>
                                            <div class="kt-portlet__head-toolbar">
                                                <div class="kt-portlet__head-group">
                                                    <a href="#" data-ktportlet-tool="toggle" class="btn btn-sm btn-icon btn-clean btn-icon-md"><i class="la la-angle-down" id="toggle_search"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <form id="kt_form" action="<%=request.getContextPath()%>/OperazioniMicro?type=crearendicontazione" class="kt-form kt-form--label-right" accept-charset="ISO-8859-1" method="post">
                                            <div class="kt-portlet__body paddig_0_t paddig_0_b">
                                                <div class="kt-section kt-section--first">
                                                    <div class="kt-section__body">
                                                        <div class="form-group row">
                                                            <div class="col-lg-12">
                                                                <br/>
                                                                <label>Progetti</label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                <div class="dropdown bootstrap-select form-control kt-" id="progetti_div">
                                                                    <select class="form-control kt-select2 obbligatory" id="progetti" name="progetti[]" multiple="multiple">
                                                                        <%for (ProgettiFormativi p : progetti) {%>
                                                                        <option value="<%=p.getId()%>"><%=p.getCip()%></option>
                                                                        <%}%>
                                                                    </select>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="form-group row"><div class="col-lg-6">
                                                                <a href="javascript:void(0);" id="submit" class="btn btn-primary"><i class="fa fa-check"></i> Invia Richiesta</a>
                                                            </div></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
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
                                            <table class="table table-striped table-bordered " cellspacing="0" id="kt_table_1" style="width:100%; border-collapse: collapse;"> 
                                                <thead>
                                                    <tr>
                                                        <th class="text-uppercase text-center">CIP Progetto/i</th>
                                                        <th class="text-uppercase text-center">File Rendicontazione</th>
                                                        <th class="text-uppercase text-center">Data Richiesta</th>
                                                    </tr>
                                                </thead>
                                            </table>  
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%@ include file="../../Bootstrap2024/index/login/Footer_login.jsp"%>
                </div>
            </div>
        </div>
        <!-- begin::Scrolltop -->
        <div id="kt_scrolltop" style="background-color: #0059b3" class="kt-scrolltop">
            <i class="fa fa-arrow-up"></i>
        </div>
        <!--start:Modal-->
        <!--end::Modal-->
        <script src="<%=src%>/assets/soop/js/jquery-3.6.1.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/popper.js/dist/umd/popper.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/moment.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
        <link href="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css" rel="stylesheet" type="text/css" />
        <!--this page -->
        <script src="<%=src%>/assets/vendors/general/select2/dist/js/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/jquery-form/dist/jquery.form.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/custom/datatables/datatables.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/loadTable.js" type="text/javascript"></script>
        <script src="<%=src%>/resource/PerfectScroolbar/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="<%=src%>/page/mc/js/control.js<%=no_cache%>" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/inputmask/dist/inputmask/inputmask.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/inputmask/dist/inputmask/jquery.inputmask.js" type="text/javascript"></script>
        <script type="text/javascript">



            var context = '<%=request.getContextPath()%>';

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
        </script>
    </body>
</html>
<%
        }
    }
%>