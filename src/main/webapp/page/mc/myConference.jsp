<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.domain.TipoFaq"%>
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
            Long idsa = 0L;
            if (request.getParameter("idsa") != null) {
                idsa = Long.parseLong(request.getParameter("idsa"));
            }
            String src = Utility.checkAttribute(session, "src");
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Le Tue Conferenze</title>
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
        <link href="<%=src%>/resource/datatbles.bundle.css" rel="stylesheet" type="text/css"/>
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
        <link rel="stylesheet" href="../../Bootstrap2024/assets/css/bootstrap.min.css"/>
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">
        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
        <!--end::countDown -->
        <style>
            .kt-section__title {
                font-size: 1.2rem!important;
            }
        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">
        <!-- begin:: Page -->

        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <%@ include file="../../Bootstrap2024/index/menu/menuMc.jsp"%>
        <%@ include file="menu/head.jsp"%>

        <%@ include file="menu/head1.jsp"%>


        <main class="container-fluid my-4">


            <div class="container-fluid" id="kt_wrapper">

                <!-- Subheader -->
                <div class="row mb-3" id="kt_subheader">
                    <div class="col">
                        <div class="d-flex align-items-center">
                            <h3 class="mb-0">Conferenze</h3>
                            <span class="mx-2">|</span>
                            <a class="text-muted">Le Tue Conferenze</a>
                        </div>
                    </div>
                </div>

                <!-- Content -->
                <div class="container-fluid" id="kt_content">

                    <!-- Card Ricerca -->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card" id="kt_portlet">

                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h3 class="card-title mb-0">Cerca :</h3>
                                    <a href="#" data-ktportlet-tool="toggle" class="btn btn-sm btn-light">
                                        <i class="la la-angle-down" id="toggle_search"></i>
                                    </a>
                                </div>

                                <form action="" class="p-3" onsubmit="refresh();return false;" accept-charset="ISO-8859-1" method="post">
                                    <div class="row g-3">
                                        <!-- Nome -->
                                        <div class="col-lg-4 col-md-6">
                                            <label for="nome" class="form-label">Nome</label>
                                            <input class="form-control" id="nome" name="nome">
                                        </div>

                                        <!-- Stato -->
                                        <div class="col-lg-4 col-md-6">
                                            <label class="form-label d-block">Stato:</label>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" value="" checked name="stato" id="stato_all">
                                                <label class="form-check-label" for="stato_all">. .</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" value="0" name="stato" id="stato_aperta">
                                                <label class="form-check-label" for="stato_aperta">Aperta</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" value="1" name="stato" id="stato_chiusa">
                                                <label class="form-check-label" for="stato_chiusa">Chiusa</label>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Azioni -->
                                    <div class="row mt-4">
                                        <div class="col-lg-12 text-end">
                                            <a onclick="refresh();" href="javascript:void(0);" class="btn btn-primary">Cerca</a>
                                            <a href="<%=StringEscapeUtils.escapeHtml4(pageName_)%>" class="btn btn-warning">Reset</a>
                                        </div>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>

                    <!-- Card Risultati -->
                    <div class="row mt-4" id="offsetresult">
                        <div class="col-lg-12">
                            <div class="card" id="kt_portlet">

                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h3 class="card-title mb-0">Risultati :</h3>
                                    <a href="#" data-ktportlet-tool="toggle" class="btn btn-sm btn-light">
                                        <i class="la la-angle-down" id="toggle_search"></i>
                                    </a>
                                </div>

                                <div class="card-body table-responsive">
                                    <table class="table table-striped table-bordered align-middle" id="kt_table_1">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="text-uppercase text-center">Azioni</th>
                                                <th class="text-uppercase text-center">Nome</th>
                                                <th class="text-uppercase text-center">Partecipanti</th>
                                                <th class="text-uppercase text-center">Creata</th>
                                                <th class="text-uppercase text-center">Stato</th>
                                                <th class="text-uppercase text-center">Inizio</th>
                                                <th class="text-uppercase text-center">Fine</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- dati caricati via JS -->
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>
            </div>


        </main>
        <!-- begin::Scrolltop -->


        <div id="kt_scrolltop"style="background-color: #0059b3" class="kt-scrolltop">
            <i class="fa fa-arrow-up"></i>
        </div>
        <form target="_blank" id="goFAD" action="" method="POST" style="display: none">
            <input id="id" name="id">
            <input id="user" name="user">
            <input id="password" name="password">
            <input id ="view" name="view" value="1">
            <input id="type" name="type" value="login_conference"> 
        </form>
        <!--end::Modal-->
        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/moment.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js<%=no_cache%>" type="text/javascript"></script>
        <!--this page -->
        <script src="<%=src%>/assets/vendors/custom/datatables/datatables.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/loadTable.js" type="text/javascript"></script>
        <script src="<%=src%>/resource/PerfectScroolbar/perfect-scrollbar.js" type="text/javascript"></script>
        <script id="mangeFAQ" src="<%=src%>/page/mc/js/mangeFAD_Converence.js<%=no_cache%>" data-context="<%=request.getContextPath()%>" type="text/javascript"></script>
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