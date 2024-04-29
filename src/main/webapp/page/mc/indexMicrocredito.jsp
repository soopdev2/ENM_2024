w
<%@page import="rc.so.domain.Estrazioni"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="java.util.HashMap"%>
<%@page import="rc.so.domain.StatiPrg"%>
<%@page import="java.util.Map"%>
<%@page import="rc.so.domain.ProgettiFormativi"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="rc.so.domain.Allievi"%>
<%@page import="java.util.List"%>
<%@page import="rc.so.db.Entity"%>
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
            String src = Utility.checkAttribute(session, "src");
            Entity e = new Entity();
            List<Estrazioni> est = e.getEstazioniDesc();
            List<SoggettiAttuatori> lsa = new ArrayList<>();
            for (SoggettiAttuatori sa : e.getSoggettiAttuatori()) {
                if (sa.getProtocollo() != null) {
                    lsa.add(sa);
                }
            }

            Long messaggi = e.countFAQ();
            e.close();

            //PREGRESSO RAF
            //END PREGRESSO RAF
            int i = 0;
            String[] styles;
            String bgc;
            Map<StatiPrg, Long> requirementCountMap = new HashMap();

%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Home Page</title>
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

        <link href="<%=src%>/assets/vendors/general/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" type="text/css" />

        <link href="<%=src%>/assets/vendors/general/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-switch/dist/css/bootstrap3/bootstrap-switch.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/ion-rangeslider/css/ion.rangeSlider.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/nouislider/distribute/nouislider.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/owl.carousel/dist/assets/owl.carousel.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/owl.carousel/dist/assets/owl.theme.default.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/socicon/css/socicon.css" rel="stylesheet" type="text/css" />
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
        <link href="../../Bootstrap2024/assets/css/bootstrap-italia.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="Bootstrap2024/assets/css/global.css"/>
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">
        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
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
            .accordion.accordion-toggle-plus .card .card-header .card-title:after {
                color: #363a90!important;
            }
            .kt-notification__item2 {
                border-radius: 5px;
                background-color: #c2eee1!important;
                margin-bottom:1.5rem;
            }
            .custom-yellowbox.faq:before{
                font-family: 'Flaticon';
                content: "\f177";
            }
            .custom-bluebox.allievi:before{
                font-family: 'Flaticon';
                content: "\f1af";
            }
            .custom-redbox:before{
                font-family: 'Flaticon';
                content: "\f1af";
            }
            .custom-greenbox.terminati:before{
                font-family: 'Flaticon2';
                content: "\f126";
            }
            .custom-greenbox:before{
                font-family: 'Flaticon';
                content: "\f1b7";
            }
            .custom-greenbox.soggetti:before{
                font-family: 'Flaticon';
                content: "\f114";
            }
            .custom-greybox.docente:before{
                font-family: 'Flaticon';
                content: "\f11d";
            }
            .custom-bluebox:before{
                font-family: 'Flaticon';
                content: "\f114";
            }
            .custom-redbox.soggetti:before{
                font-family: 'Flaticon';
                content: "\f114";
            }
            .custom-yellowbox:before{
                font-family: 'Flaticon2';
                content: "\f126";
            }
        </style>
    </head>

    <body>
        <!-- begin:: Page -->                   
        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <div class="kt-grid kt-grid--hor kt-grid--root">
            <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--ver kt-page">
                <!-- end:: Aside -->
                <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor kt-wrapper" id="kt_wrapper">
                    <%@ include file="menu/head.jsp"%>
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
                                        <a class="nav-link active" href="indexMicrocredito.jsp"><span>Home</span></a>
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

                    <!-- begin:: Footer -->
                    <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor" style="background-image: url(<%=src%>/resource/bg.png); background-size: cover;background-position: center; background-color: #fff;">
                        <!-- begin:: Content Head -->

                        <div class="tab-content" style="margin-right: 10px; ">

                            <div class="row">
                                <div class="col-xl-9 col-lg-9 col-md-9 col-sm-12" style="padding-right: 0px;">
                                    <%
                                        String[] contatori = Action.contatoriHome();
                                    %>


                                    <div class="row flex col-lg-12"  style="margin-right: 0px; padding-right: 0px;">
                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button1">
                                                Allievi da validare 
                                                <span class="badge bg-white text-primary"><%=contatori[0]%></span>
                                            </button>

                                        </div>
                                        <script>
                                            const button1 = document.getElementById('button1');
                                            button1.addEventListener('click', function () {
                                                window.location.href = "searchAllieviMicro.jsp"
                                            }
                                            )
                                        </script>

                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button2">
                                                Allievi validati 
                                                <span class="badge bg-white text-primary"><%=contatori[1]%></span>
                                            </button>

                                        </div>
                                        <script>
                                            const button2 = document.getElementById('button2');
                                            button2.addEventListener('click', function () {
                                                window.location.href = "searchAllieviMicro.jsp"
                                            }
                                            )
                                        </script>
                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button3">
                                                Allievi formati 
                                                <span class="badge bg-white text-primary"><%=contatori[2]%></span>
                                            </button>

                                        </div>
                                        <script>
                                            const button3 = document.getElementById('button3');
                                            button3.addEventListener('click', function () {
                                                window.location.href = "searchAllieviMicro.jsp"
                                            }
                                            )
                                        </script>


                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button4">
                                                SE da validare 
                                                <span class="badge bg-white text-primary"><%=contatori[3]%></span>
                                            </button>

                                        </div>
                                        <script>
                                            const button4 = document.getElementById('button4');
                                            button4.addEventListener('click', function () {
                                                window.location.href = "searchSA.jsp";
                                            }
                                            )
                                        </script>
                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button5">
                                                SE attivi 
                                                <span class="badge bg-white text-primary"><%=contatori[4]%></span>
                                            </button>

                                        </div>
                                        <script>
                                            const button5 = document.getElementById('button5');
                                            button5.addEventListener('click', function () {
                                                window.location.href = "searchSA.jsp";
                                            }
                                            )
                                        </script>

                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button6">
                                                Docenti da validare
                                                <span class="badge bg-white text-primary"><%=contatori[5]%></span>
                                            </button>

                                        </div>

                                        <script>
                                            const button6 = document.getElementById('button6');
                                            button6.addEventListener('click', function () {
                                                window.location.href = "searchDocenti.jsp";
                                            }
                                            )
                                        </script>


                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button7">
                                                Docenti validati
                                                <span class="badge bg-white text-primary"><%=contatori[6]%></span>
                                            </button>

                                        </div>

                                        <script>
                                            const button7 = document.getElementById('button7');
                                            button7.addEventListener('click', function () {
                                                window.location.href = "searchDocenti.jsp";
                                            }
                                            )
                                        </script>


                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button8">
                                                PF in attuazione
                                                <span class="badge bg-white text-primary"><%=contatori[7]%></span>
                                            </button>

                                        </div>

                                        <script>
                                            const button8 = document.getElementById('button8');
                                            button8.addEventListener('click', function () {
                                                window.location.href = "searchPFMicro.jsp";
                                            }
                                            )
                                        </script>

                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button9">
                                                PF conclusi
                                                <span class="badge bg-white text-primary"><%=contatori[8]%></span>
                                            </button>

                                        </div>

                                        <script>
                                            const button9 = document.getElementById('button9');
                                            button9.addEventListener('click', function () {
                                                window.location.href = "searchPFMicro.jsp?tipo=archiviato";
                                            }
                                            )
                                        </script>


                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button10">
                                                PF attesa validazione M2
                                                <span class="badge bg-white text-primary"><%=contatori[9]%></span>
                                            </button>

                                        </div>

                                        <script>
                                            const button10 = document.getElementById('button10');
                                            button10.addEventListener('click', function () {
                                                window.location.href = "searchPFMicro.jsp";
                                            }
                                            )
                                        </script>

                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button11">
                                                PF validati M2 
                                                <span class="badge bg-white text-primary"><%=contatori[10]%></span>
                                            </button>

                                        </div>

                                        <script>
                                            const button11 = document.getElementById('button11');
                                            button11.addEventListener('click', function () {
                                                window.location.href = "searchPFMicro.jsp";
                                            }
                                            )
                                        </script>

                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button12">
                                                PF attesa validazione M3
                                                <span class="badge bg-white text-primary"><%=contatori[11]%></span>
                                            </button>

                                        </div>
                                    </div>

                                    <script>
                                        const button12 = document.getElementById('button12');
                                        button12.addEventListener('click', function () {
                                            window.location.href = "searchPFMicro.jsp";
                                        }
                                        )
                                    </script>


                                    <div class="row flex col-lg-12"  style="margin-right: 0px; padding-right: 0px;">
                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button13">
                                                PF validati M3
                                                <span class="badge bg-white text-primary"><%=contatori[12]%></span>
                                            </button>

                                        </div>

                                        <script>
                                            const button13 = document.getElementById('button13');
                                            button13.addEventListener('click', function () {
                                                window.location.href = "searchPFMicro.jsp";
                                            }
                                            )
                                        </script>

                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button14">
                                                PF attesa validazione M4
                                                <span class="badge bg-white text-primary"><%=contatori[13]%></span>
                                            </button>

                                        </div>

                                        <script>
                                            const button14 = document.getElementById('button14');
                                            button14.addEventListener('click', function () {
                                                window.location.href = "searchPFMicro.jsp";
                                            }
                                            )
                                        </script>

                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button15">
                                                PF validati M4
                                                <span class="badge bg-white text-primary"><%=contatori[14]%></span>
                                            </button>

                                        </div>

                                        <script>
                                            const button15 = document.getElementById('button15');
                                            button15.addEventListener('click', function () {
                                                window.location.href = "searchPFMicro.jsp";
                                            }
                                            )
                                        </script>


                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button16">
                                                PF attesa controllo M6
                                                <span class="badge bg-white text-primary"><%=contatori[15]%></span>
                                            </button>

                                        </div>

                                        <script>
                                            const button16 = document.getElementById('button16');
                                            button16.addEventListener('click', function () {
                                                window.location.href = "searchPFMicro.jsp";
                                            }
                                            )
                                        </script>


                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button17">
                                                PF controllati M6
                                                <span class="badge bg-white text-primary"><%=contatori[16]%></span>
                                            </button>

                                        </div>

                                        <script>
                                            const button17 = document.getElementById('button17');
                                            button17.addEventListener('click', function () {
                                                window.location.href = "searchPFMicro.jsp";
                                            }
                                            )

                                        </script>

                                        <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 1.5rem;">
                                            <button type="button" class="btn btn-primary btn-lg btn-me" id="button18">
                                                FAQ in attesa
                                                <span class="badge bg-white text-primary"><%=messaggi%></span>
                                            </button>

                                        </div>
                                        <script>
                                            const button18 = document.getElementById('button18');
                                            button18.addEventListener('click', function () {
                                                window.location.href = "saFAQ.jsp";
                                            }
                                            )
                                        </script>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-12" style="padding-left: 0px;">
                                    <div class="kt-portlet kt-portlet--height-fluid" style="border-radius: 5px; display:block;">
                                        <div class="kt-portlet__head">
                                            <div class="kt-portlet__head-label">
                                                <h3 class="kt-portlet__head-title kt-font-io">
                                                    Bacheca
                                                </h3>
                                            </div>
                                            <div class="kt-portlet__head-toolbar">
                                                <ul class="nav nav-pills nav-pills-sm nav-pills-label nav-pills-bold" role="tablist">
                                                    <li class="nav-item">
                                                        <a class="nav-link active" data-toggle="tab" href="#sat" role="tab">
                                                            Soggetti Esecutori
                                                        </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link" data-toggle="tab" href="#export" role="tab">
                                                            Estrazione File
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>

                                        <div class="kt-portlet__body" >
                                            <div class="tab-content">
                                                <div class="tab-pane active kt-scroll" id="sat" style="max-height: 650px;" aria-expanded="true">
                                                    <div class="accordion accordion-solid accordion-toggle-plus " id="accordionExample6" >
                                                        <%for (SoggettiAttuatori s : lsa) {
                                                                bgc = i % 2 == 0 ? "background-color: #46c8ef38" : "background-color: #089eff52";
                                                                i++;%>
                                                        <div class="card" style="border-radius: 5px;">
                                                            <div class="card-header" id="heading<%=s.getId()%>" >
                                                                <div class="card-title collapsed kt-font-io " style="<%=bgc%>" data-toggle="collapse" data-target="#collapse<%=s.getId()%>" aria-expanded="false" aria-controls="collapse<%=s.getId()%>">
                                                                    <i class="flaticon-presentation-1 kt-font-io" style="font-size: 2rem;"></i> <b><%=s.getRagionesociale()%></b>
                                                                </div>
                                                            </div>
                                                            <div id="collapse<%=s.getId()%>" class="collapse" aria-labelledby="heading<%=s.getId()%>" data-parent="#accordionExample6">
                                                                <div class="card-body kt-font-io" style="border-radius: 5px;">
                                                                    <div class="row ">
                                                                        <div class="col-lg-8">
                                                                            <h5>Progetti formativi: <%=s.getProgettiformativi().size()%></h5>
                                                                        </div>
                                                                        <div class="col-lg-4">
                                                                            <h5><i class="flaticon-users-1" style="font-size: 1.5rem;"></i> Allievi: <%=s.getAllievi().size()%></h5>
                                                                        </div>
                                                                    </div>
                                                                    <%requirementCountMap = Utility.GroupByAndCount(s);
                                                                        for (Map.Entry<StatiPrg, Long> sd : requirementCountMap.entrySet()) {
                                                                            styles = Utility.styleMicro(sd.getKey());
                                                                    %>
                                                                    <h6>
                                                                        <a href="<%=src%>/page/mc/searchPFMicro.jsp?tipo=<%=sd.getKey().getTipo()%>&sa=<%=s.getId()%>" style="<%=styles[0]%>">
                                                                            <span class="fa-stack">
                                                                                <span class="fa fa-circle fa-stack-2x" style="<%=styles[0]%>"></span>
                                                                                <strong class="fa-stack-1x kt-font-white">
                                                                                    <%=sd.getValue()%>    
                                                                                </strong>
                                                                            </span>
                                                                            &nbsp;&nbsp;<%=styles[1]%>
                                                                        </a>
                                                                    </h6>
                                                                    <%}%>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <%}%>
                                                    </div>
                                                </div>


                                                <div class="tab-pane" id="export" aria-expanded="false">

                                                    <%

                                                        for (Estrazioni e1 : est) {
                                                            if (e1.getPath() != null) {
                                                    %>
                                                    <div class="kt-notification">
                                                        <a href="<%=request.getContextPath()%>/OperazioniGeneral?type=downloadDoc&path=<%=e1.getPath()%>" 
                                                           class="kt-notification__item kt-notification__item2" target="_blank">
                                                            <div class="kt-notification__item-icon">
                                                                <i class="fa fa-file-excel" 
                                                                   style="font-size: 2rem; color: #006b4c;"></i>
                                                            </div>
                                                            <div class="kt-notification__item-details ">
                                                                <div class="kt-notification__item-title" style="color: #006b4c;">
                                                                    <b style="font-size: 15px;"><%=e1.getProgetti()%></b>
                                                                </div> 
                                                                <div class="kt-notification__item-time kt-font-io">
                                                                    <b><%=e1.getVisualTime()%></b><br>
                                                                </div>
                                                            </div>
                                                        </a>
                                                    </div>
                                                    <%}
                                                    }%>
                                                </div>
                                            </div>
                                        </div>

                                    </div> 
                                </div>

                            </div>      
                            <!-- end:: Content Head -->
                            <a id="chgPwd" href="<%=src%>/page/personal/chgPwd.jsp" class="btn btn-outline-brand btn-sm fancyProfileNoClose" style="display:none;"></a>
                        </div>
                        <!-- end:: Footer -->
                        <!-- end:: Content -->
                    </div>
                    <br>

                    <%@include file="../../Bootstrap2024/index/login/Footer_login.jsp" %>

                    <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                        <button id="showmod1" type="button" class="btn btn-outline-brand btn-sm" data-toggle="modal" data-target="#kt_modal_6">Launch Modal</button>
                    </div>
                    <div class="modal fade" id="kt_modal_6" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="text_modal_title"></h5>
                                    <button type="button" id='close_kt_modal_6' class="close" data-target="#kt_modal_6" data-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body" id="text_modal_html"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="kt_scrolltop" style="background-color: #0059b3" class="kt-scrolltop">
            <i class="fa fa-arrow-up"></i>
        </div>

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
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
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
                                        $('.kt-scroll').each(function () {
                                            const ps = new PerfectScrollbar($(this)[0]);
                                        });
        </script>

        <script>
            function fancyBoxClose() {
                $('div.fancybox-overlay.fancybox-overlay-fixed').css('display', 'none');
            }
            jQuery(document).ready(function () {
            <%if (us.getStato() == 2) {%>
                $('#chgPwd')[0].click();
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
