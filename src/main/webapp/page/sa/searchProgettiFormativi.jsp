
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.domain.StatiPrg"%>
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
            Entity e = new Entity();
            List<StatiPrg> stati = e.getStatiPrg();
            int max_ore_day = Integer.parseInt(e.getPath("max_ore_day"));
            e.close();
            String src = Utility.checkAttribute(session, "src");
            String icip = StringEscapeUtils.escapeHtml4(request.getParameter("icip")) != null ? StringEscapeUtils.escapeHtml4(request.getParameter("icip")) : "";
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Progetti Formativi Cerca</title>
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
        <!--this page-->
        <link href="<%=src%>/resource/datatbles.bundle.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-timepicker/css/bootstrap-timepicker.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css" rel="stylesheet" type="text/css" />
        <!--fine-->
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
        <link href="../../Bootstrap2024/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
        <link rel="stylesheet" href="Bootstrap2024/assets/css/global.css"/>
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">
        <script src="../../Bootstrap2024/assets/js/popper.js"></script>
        <!--end::countDown -->
        <style>
            .kt-section__title {
                font-size: 1.2rem!important;
            }
            .fancybox-overlay {
                z-index: 1000000 !important;
            }
        </style>
    </head>
    <body>
        <%@ include file="menu/head1.jsp"%>
        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <%@ include file="../../Bootstrap2024/index/menu/menuAtt.jsp"%>
        <%@ include file="menu/head.jsp"%>


        <div class="kt-page-loader kt-page-loader--logo">
            <img height="100" alt="Logo" src="<%=src%>/assets/media/logos/logo.png"/>
            <div class="kt-spinner kt-spinner--io"></div>
        </div>

        <main class="container-fluid my-4">
            <!-- Intestazione -->
            <div class="mb-3">
                <h3>Progetti Formativi</h3>
                <span class="text-muted">Cerca</span>
            </div>

            <!-- Box Ricerca -->
            <div class="card shadow-sm mb-4" id="kt_portlet" data-ktportlet="true">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3 class="card-title m-0">Cerca :</h3>
                    <div class="card-toolbar">
                        <a href="#" data-ktportlet-tool="toggle" class="btn btn-sm btn-icon btn-clean btn-icon-md">
                            <i class="la la-angle-down" id="toggle_search"></i>
                        </a>
                    </div>
                </div>

                <form action="" class="card-body p-3" onsubmit="refresh(); return false;" method="post" accept-charset="ISO-8859-1">
                    <div class="row g-3">
                        <div class="col-lg-3">
                            <label for="cip" class="form-label">CIP</label>
                            <input type="text" class="form-control" value="<%=icip%>" name="cip" id="cip" autocomplete="off">
                        </div>
                        <div class="col-lg-3">
                            <label for="stato" class="form-label">Stato</label>
                            <div class="dropdown bootstrap-select form-control kt-" id="stato_div" style="padding: 0; height: 35px;">
                                <select class="form-control kt-select2-general" id="stato" name="stato" style="width: 100%;">
                                    <option value="-">Seleziona Stato</option>
                                    <%for (StatiPrg i : stati) {%>
                                    <option value="<%=i.getTipo()%>"><%=i.getDescrizione()%></option>
                                    <%}%>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end mt-4">
                        <a onclick="refresh();" href="javascript:void(0);" class="btn btn-primary me-2"><font color="white">Cerca</font></a>
                        <a href="<%=StringEscapeUtils.escapeHtml4(pageName_)%>" class="btn btn-warning"><font color="white">Reset</font></a>
                    </div>
                </form>
            </div>

            <!-- Risultati -->
            <div class="card shadow-sm" id="kt_portlet" data-ktportlet="true">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3 class="card-title m-0">Risultati :</h3>
                    <div class="card-toolbar">
                        <a href="#" data-ktportlet-tool="toggle" class="btn btn-sm btn-icon btn-clean btn-icon-md">
                            <i class="la la-angle-down" id="toggle_search"></i>
                        </a>
                    </div>
                </div>

                <div class="card-body table-responsive kt-scroll-x">
                    <table class="table table-striped table-bordered text-center" id="kt_table_1" style="width:100%;">
                        <thead class="table-light">
                            <tr>
                                <th class="text-uppercase">Azioni</th>
                                <th class="text-uppercase">ID</th>
                                <th class="text-uppercase">Data Inizio</th>
                                <th class="text-uppercase">Data Fine</th>
                                <th class="text-uppercase">CIP</th>
                                <th class="text-uppercase">Allievi</th>
                                <th class="text-uppercase">Stato</th>
                                <th class="text-uppercase">Motivo Errore</th>
                                <th class="text-uppercase">Errore O Verificare</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>

        </main>
        <%@ include file="../../Bootstrap2024/index/login/Footer_login.jsp"%>




        <div id="kt_scrolltop"style="background-color: #0059b3" class="kt-scrolltop">
            <i class="fa fa-arrow-up"></i>
        </div>
        <!--start:Modal-->

        <!-- Allievi Modal -->
        <div class="modal fade" id="allievi_table" tabindex="-1" aria-labelledby="Allievi Progetto Formativo" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen modal-dialog-centered">
                <div class="modal-content text-center">
                    <div class="modal-header">
                        <h5 class="modal-title">Allievi Progetto</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="kt-scroll" style="max-height: 750px; min-height: 750px;">
                            <table class="table table-bordered" id="kt_table_allievi" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th class="text-uppercase text-center">Azioni</th>
                                        <th class="text-uppercase text-center">Nome</th>
                                        <th class="text-uppercase text-center">Cognome</th>
                                        <th class="text-uppercase text-center">Codice Fiscale</th>
                                        <th class="text-uppercase text-center">Stato</th>
                                        <th class="text-uppercase text-center">Motivazione</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Documenti Modal -->
        <div class="modal fade" id="doc_modal" tabindex="-1" aria-labelledby="Documenti" aria-hidden="true">
            <div class="modal-dialog modal-xl modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Documenti</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center">
                            <div class="kt-scroll row col-12" id="prg_docs" style="max-height: 750px;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Registro Aula Modal -->
        <div class="modal fade" id="register_modal" tabindex="-1" aria-labelledby="Registro Aula" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Registro Aula</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body kt-scroll" style="max-height: 500px;">
                        <div class="row col-12" id="register_docs_modal"></div>
                    </div>
                </div>
            </div>
        </div>

        <!--end::Modal-->


        <script src="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/jquery/dist/jquery.js" type="text/javascript"></script>
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
        <!--this page -->
        <script src="<%=src%>/assets/vendors/general/select2/dist/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/custom/datatables/datatables.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/loadTable.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-timepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-timepicker/js/bootstrap-timepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <script id="ore_max" data-context="<%=max_ore_day%>" type="text/javascript"></script>
        <script id="searchProgettiFormativi" src="<%=src%>/page/sa/js/searchProgettiFormativi.js<%=no_cache%>" 
                data-context="<%=request.getContextPath()%>" 
                data-typeuser="<%=us.getTipo()%>"
                data-demoversion="<%=Utility.demoversion%>"
        type="text/javascript"></script>
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