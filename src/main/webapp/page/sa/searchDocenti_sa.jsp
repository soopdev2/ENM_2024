
<%@page import="rc.so.util.Utility"%>
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
        String pageName_ = StringEscapeUtils.escapeHtml4(uri_.substring(uri_.lastIndexOf("/") + 1));
        if (!Action.isVisibile(String.valueOf(us.getTipo()), pageName_)) {
            response.sendRedirect(request.getContextPath() + "/page_403.jsp");
        } else {
            String src = Utility.checkAttribute(session, "src");
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Docenti</title>
        <meta name="description" content="Updates and statistics">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!--begin::Fonts -->
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
        <link href="<%=src%>/resource/animate.css" rel="stylesheet" type="text/css"/>
        <!--end:: Global Optional Vendors -->
        <link href="<%=src%>/resource/datatbles.bundle.css" rel="stylesheet" type="text/css"/>
        <!--begin::Global Theme Styles(used by all pages) -->
        <link href="<%=src%>/assets/demo/default/base/style.bundle.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/custom.css" rel="stylesheet" type="text/css" />
        <script src="../../Bootstrap2024/assets/js/popper.js"></script>

        <!--end::Global Theme Styles -->

        <!--begin::Layout Skins(used by all pages) -->
        <link href="<%=src%>/assets/demo/default/skins/header/base/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/brand/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/aside/light.css" rel="stylesheet" type="text/css" />
        <link href="../../Bootstrap2024/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">

        <!--end::Layout Skins -->
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
        <%@ include file="menu/head1.jsp"%>
        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <%@ include file="../../Bootstrap2024/index/menu/menuAtt.jsp"%>
        <%@ include file="menu/head.jsp"%>



        <main class="flex-grow-1 container-fluid px-4">
            <br>
            <!-- Breadcrumb / Intestazione -->
            <div class="row mb-3">
                <div class="col-12">
                    <h3 class="mb-0">Docenti</h3>
                    <small class="text-muted">Cerca</small>
                </div>
            </div>

            <!-- BOX RICERCA -->
            <div class="card shadow-sm mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="card-title m-0">Cerca :</h5>
                    <button class="btn btn-sm btn-outline-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#searchForm" aria-expanded="true">
                        <i class="bi bi-chevron-down"></i>
                    </button>
                </div>
                <div class="collapse show" id="searchForm">
                    <form action="" class="p-3" onsubmit="return ctrlForm();" accept-charset="ISO-8859-1" method="post">
                        <div class="row g-3">
                            <div class="col-lg-3">
                                <label for="nome" class="form-label">Nome</label>
                                <input type="text" class="form-control" name="nome" id="nome" autocomplete="off">
                            </div>
                            <div class="col-lg-3">
                                <label for="cognome" class="form-label">Cognome</label>
                                <input type="text" class="form-control" name="cognome" id="cognome" autocomplete="off">
                            </div>
                            <div class="col-lg-3">
                                <label for="cf" class="form-label">Codice Fiscale</label>
                                <input type="text" class="form-control" name="cf" id="cf" autocomplete="off">
                            </div>
                        </div>

                        <div class="d-flex justify-content-end mt-4">
                            <a onclick="refresh();" href="javascript:void(0);" class="btn btn-primary me-2">
                                <span class="text-white">Cerca</span>
                            </a>
                            <a href="<%=pageName_%>" class="btn btn-warning">
                                <span class="text-white">Reset</span>
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- RISULTATI -->
            <div id="offsetresult"></div>
            <div class="card shadow-sm">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="card-title m-0">Risultati :</h5>
                    <button class="btn btn-sm btn-outline-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#resultTable" aria-expanded="true">
                        <i class="bi bi-chevron-down"></i>
                    </button>
                </div>
                <div class="collapse show" id="resultTable">
                    <div class="card-body table-responsive">
                        <table class="table table-striped table-bordered align-middle text-center" id="kt_table_1" style="width:100%;">
                            <thead class="table-light">
                                <tr>
                                    <th class="text-uppercase">Azioni</th>
                                    <th class="text-uppercase">Nome</th>
                                    <th class="text-uppercase">Cognome</th>
                                    <th class="text-uppercase">Codice Fiscale</th>
                                    <th class="text-uppercase">Data Nascita</th>
                                    <th class="text-uppercase">Fascia</th>
                                    <th class="text-uppercase">Stato</th>
                                    <th class="text-uppercase">Provenienza Domanda</th>
                                    <th class="text-uppercase">Data Webinair</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- I risultati verranno popolati dinamicamente -->
                            </tbody>
                        </table>
                    </div>
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
        <script src="<%=src%>/assets/vendors/general/select2/dist/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <!--DATATABLE -->
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/custom/datatables/datatables.bundle.js" type="text/javascript"></script>
        <script src="../../assets/vendors/custom/datatables/datatables.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/loadTable.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <script src="../sa/js/searchDocenti.js" type="text/javascript"></script>
        <!-- -->
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
            // Esporto le variabili che mi servono dal server
            const contextPath = '<%= request.getContextPath()%>';
        </script>


    </body>
</html>
<%
        }
    }
%>