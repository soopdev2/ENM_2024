
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
        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <%@ include file="../../Bootstrap2024/index/menu/menuAtt.jsp"%>
        <%@ include file="menu/head.jsp"%>

        <main class="container-fluid py-4">
            <!-- Page header -->
            <div class="row mb-3">
                <div class="col-12 d-flex align-items-center">
                    <h3 class="me-2">Progetti Formativi</h3>
                    <span class="vr me-2"></span>
                    <a href="#">Cerca</a>
                </div>
            </div>

            <!-- Search Form -->
            <div class="row mb-3">
                <div class="col-12">
                    <div class="card" id="kt_portlet">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Cerca :</h5>
                            <button class="btn btn-sm btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#searchBody" aria-expanded="true">
                                <i class="la la-angle-down" id="toggle_search"></i>
                            </button>
                        </div>
                        <div class="collapse show" id="searchBody">
                            <form class="card-body row g-3" onsubmit="refresh();return false;" method="post">
                                <div class="col-lg-3">
                                    <label for="cip" class="form-label">CIP</label>
                                    <input type="text" class="form-control" value="<%=icip%>" name="cip" id="cip" autocomplete="off">
                                </div>
                                <div class="col-lg-3">
                                    <label for="stato" class="form-label">Stato</label>
                                    <select class="form-select" id="stato" name="stato">
                                        <option value="-">Seleziona Stato</option>
                                        <%for (StatiPrg i : stati) {%>
                                        <option value="<%=i.getTipo()%>"><%=i.getDescrizione()%></option>
                                        <%}%>
                                    </select>
                                </div>
                                <div class="col-12 d-flex justify-content-end mt-2">
                                    <a href="javascript:void(0);" onclick="refresh();" class="btn btn-primary me-2">Cerca</a>
                                    <a href="<%=StringEscapeUtils.escapeHtml4(pageName_)%>" class="btn btn-warning">Reset</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Risultati -->
            <div class="row" id="offsetresult">
                <div class="col-12">
                    <div class="card" id="kt_portlet">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Risultati :</h5>
                            <button class="btn btn-sm btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#resultBody" aria-expanded="true">
                                <i class="la la-angle-down" id="toggle_search"></i>
                            </button>
                        </div>
                        <div class="card-body collapse show" id="resultBody">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered" id="kt_table_1">
                                    <thead class="text-center text-uppercase">
                                        <tr>
                                            <th>Azioni</th>
                                            <th>ID</th>
                                            <th>Data Inizio</th>
                                            <th>Data Fine</th>
                                            <th>CIP</th>
                                            <th>Allievi</th>
                                            <th>Stato</th>
                                            <th>Motivo Errore</th>
                                            <th>Errore O Verificare</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Riempito via JS -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modals -->
            <div class="modal fade" id="allievi_table" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-full modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Allievi Progetto</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="table-responsive kt-scroll" style="max-height: 750px;">
                                <table class="table table-bordered" id="kt_table_allievi">
                                    <thead>
                                        <tr class="text-center text-uppercase">
                                            <th>Azioni</th>
                                            <th>Nome</th>
                                            <th>Cognome</th>
                                            <th>Codice Fiscale</th>
                                            <th>Stato</th>
                                            <th>Motivazione</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="doc_modal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-xl modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Documenti</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body text-center">
                            <div class="kt-scroll row col-12" id="prg_docs" style="max-height: 750px;"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="register_modal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Registro Aula</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body kt-scroll" style="max-height: 500px;">
                            <div class="row col-12" id="register_docs_modal"></div>
                        </div>
                    </div>
                </div>
            </div>
        </main>



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