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
            String src = session.getAttribute("src").toString();
            Entity en = new Entity();
            int tipo = Integer.parseInt(en.getPath("MaterialeDidattico_Generico"));
            en.close();
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Materiale didattico</title>
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
        <link href="<%=src%>/assets/demo/default/base/style.bundle.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/custom.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/assets/demo/default/skins/header/base/light.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/assets/demo/default/skins/header/menu/light.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/assets/demo/default/skins/brand/light.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/assets/demo/default/skins/aside/light.css" rel="stylesheet" type="text/css"/>
        <link href="../../Bootstrap2024/assets/css/bootstrap-italia.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="Bootstrap2024/assets/css/global.css"/>
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">
        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico"/>
    </head>
    <body>
        <%@ include file="menu/head1.jsp"%>
        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <div class="kt-grid kt-grid--hor kt-grid--root">
            <nav class="navbar navbar-expand-lg has-megamenu" aria-label="Menu principale">
                <button type="button" aria-label="Mostra o nascondi il menu" class="custom-navbar-toggler" aria-controls="menu" aria-expanded="false" data-bs-toggle="navbarcollapsible" data-bs-target="#navbar-E">
                    <span>
                        <svg role="img" class="icon"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-burger"></use></svg>
                    </span>
                </button>
                <div class="navbar-collapsable" id="navbar-E">
                    <div class="overlay fade"></div>
                    <div class="close-div">
                        <button type="button" aria-label="Chiudi il menu" class="btn close-menu">
                            <span><svg role="img" class="icon"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-close-big"></use></svg></span>
                        </button>
                    </div>
                    <div class="menu-wrapper justify-content-lg-between">
                        <ul class="navbar-nav">
                            <li class="nav-item active">
                                <a class="nav-link  " href="indexSoggettoAttuatore.jsp"><span>Home</span></a>
                            </li>
                            <li class="nav-item dropdown megamenu">
                                <button type="button" class="nav-link dropdown-toggle px-lg-2 px-xl-3" data-bs-toggle="dropdown" aria-expanded="false" id="megamenu-base-E" data-focus-mouse="false">
                                    <span>Allievi</span><svg role="img" class="icon icon-xs ms-1"><use href=""></use></svg>
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
                                <button type="button" class="nav-link dropdown-toggle px-lg-2 px-xl-3" data-bs-toggle="dropdown" aria-expanded="false" id="megamenu-base-E" data-focus-mouse="false">
                                    <span>Docenti</span><svg role="img" class="icon icon-xs ms-1"><use href=""></use></svg>
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
                                                                    <a class="list-item dropdown-item" href="newDocente.jsp">
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
                                    <span>Progetti Formativi</span><svg role="img" class="icon icon-xs ms-1"><use href=""></use></svg>
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
                                <button type="button" class="nav-link active dropdown-toggle px-lg-2 px-xl-3" data-bs-toggle="dropdown" aria-expanded="false" id="megamenu-base-E" data-focus-mouse="false">
                                    <span>Materiale Didattico</span><svg role="img" class="icon icon-xs ms-1"><use href=""></use></svg>
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
                                    <span>FAQ</span><svg role="img" class="icon icon-xs ms-1"><use href=""></use></svg>
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
                                    <h3 class="kt-subheader__title">Materiale didattico</h3>
                                    <span class="kt-subheader__separator kt-subheader__separator--v"></span>
                                    <a class="kt-subheader__breadcrumbs-link">Download</a>
                                </div>
                            </div>
                        </div>
                        <div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
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
                                        <div class="kt-portlet__body">
                                            <%@ include file="../all/modelli.jsp"%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%@ include file="../../Bootstrap2024/index/login/Footer_login.jsp"%>
                    </div>
                </div>
            </div>
        </div>
        <div id="kt_scrolltop"style="background-color: #0059b3" class="kt-scrolltop">
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
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
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