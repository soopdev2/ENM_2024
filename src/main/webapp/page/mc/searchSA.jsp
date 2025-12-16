
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.domain.EstensioniFile"%>
<%@page import="rc.so.domain.TipoDoc"%>
<%@page import="rc.so.domain.TipoDoc_Allievi"%>
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
            Entity e = new Entity();
            EstensioniFile ext = e.getEm().find(EstensioniFile.class, "pdf");
            e.close();
            String src = Utility.checkAttribute(session, "src");
            String iva2 = request.getParameter("piva") != null ? request.getParameter("piva") : "";
            String iva = StringEscapeUtils.escapeHtml4(iva2);

            int tipoR = 0;
            if (us != null) {
                tipoR = us.getTipo();
            }
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Soggetti Esecutori</title>
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

        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/owl.carousel/dist/assets/owl.carousel.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/owl.carousel/dist/assets/owl.theme.default.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/socicon/css/socicon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon2/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/fontawesome5/css/all.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/animate.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/resource/datatbles.bundle.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/assets/demo/default/base/style.bundle.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/custom.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/base/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/brand/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/aside/light.css" rel="stylesheet" type="text/css" />
        <link href="../../Bootstrap2024/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="../../Bootstrap2024/assets/css/global.css"/>
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">
        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
        <script src="../../Bootstrap2024/assets/js/popper.js"></script>
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
        <%@ include file="../../Bootstrap2024/index/menu/menuMc.jsp"%>




        <main class="flex-grow-1 container-fluid px-4">

            <!-- Intestazione sezione -->
            <div class="my-3">
                <h1 class="h3">Soggetti Esecutori</h1>
                <span class="text-muted">Cerca</span>
            </div>

            <!-- Form di ricerca -->
            <div class="row">
                <div class="col-12">
                    <div class="card shadow-sm mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Cerca :</h5>
                            <button class="btn btn-sm btn-outline-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSearch" aria-expanded="true">
                                <i class="it-expand"></i>
                            </button>
                        </div>
                        <div class="collapse show" id="collapseSearch">
                            <div class="card-body">
                                <form action="" class="row g-3" onsubmit="refresh(); return false;" accept-charset="ISO-8859-1" method="post">

                                    <!-- Soggetto Esecutore -->
                                    <div class="col-12">
                                        <label class="form-label text-primary">Soggetto Esecutore:</label>
                                    </div>
                                    <div class="col-lg-3">
                                        <label class="form-label">Ragione Sociale</label>
                                        <input type="text" class="form-control" name="ragionesociale" id="ragionesociale" autocomplete="off">
                                    </div>
                                    <div class="col-lg-2">
                                        <label class="form-label">Protocollo</label>
                                        <input type="text" class="form-control" name="protocollo" id="protocollo" autocomplete="off">
                                    </div>
                                    <div class="col-lg-2">
                                        <label class="form-label">P.Iva</label>
                                        <input type="text" class="form-control" name="piva" id="piva" value="<%=iva%>" autocomplete="off">
                                    </div>
                                    <div class="col-lg-2">
                                        <label class="form-label">Codice Fiscale</label>
                                        <input type="text" class="form-control" name="cf" id="cf" autocomplete="off">
                                    </div>

                                    <!-- Amministratore Delegato o Unico -->
                                    <div class="col-12 mt-3">
                                        <label class="form-label text-primary">Amministratore Delegato o Unico:</label>
                                    </div>
                                    <div class="col-lg-3">
                                        <label class="form-label">Nome</label>
                                        <input type="text" class="form-control" name="nome" id="nome" autocomplete="off">
                                    </div>
                                    <div class="col-lg-3">
                                        <label class="form-label">Cognome</label>
                                        <input type="text" class="form-control" name="cognome" id="cognome" autocomplete="off">
                                    </div>

                                    <!-- Pulsanti -->
                                    <div class="col-12 text-end mt-3">
                                        <a href="javascript:void(0);" onclick="refresh();" class="btn btn-primary">Cerca</a>
                                        <a href="<%=StringEscapeUtils.escapeHtml4(pageName_)%>" class="btn btn-warning">Reset</a>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Risultati -->
            <div class="row">
                <div class="col-12">
                    <div class="card shadow-sm">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Risultati :</h5>
                            <button class="btn btn-sm btn-outline-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseResults" aria-expanded="true">
                                <i class="it-expand"></i>
                            </button>
                        </div>
                        <div class="collapse show" id="collapseResults">
                            <div class="card-body table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="kt_table_1" style="width:100%">
                                    <thead>
                                        <tr class="text-center text-uppercase">
                                            <th>Azioni</th>
                                            <th>Ragione Sociale</th>
                                            <th>P.Iva</th>
                                            <th>Cod. Fiscale</th>
                                            <th>Provincia</th>
                                            <th>Comune</th>
                                            <th>Via</th>
                                            <th>Nome Amministratore</th>
                                            <th>Cognome Amministratore</th>
                                            <th>Telefono</th>
                                            <th>N. Protocollo</th>
                                            <th>Data Firma Convenzione</th>
                                            <th>Scheda SE</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </main>

        <%@ include file="../../Bootstrap2024/index/login/Footer_login.jsp"%>






        <script src="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/moment.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <!-- this page -->
        <script src="<%=src%>/assets/vendors/custom/datatables/datatables.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/loadTable.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
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
        </script>

        <script>
        var contextPath = '<%=request.getContextPath()%>';
        var tipoR = '<%=tipoR%>';
        var extEstensione = '<%=ext.getEstensione()%>';
        var extMimeType = '<%=ext.getMime_type()%>';
        </script>

        <script src="js/searchSAmicro.js"></script>
    </body>
</html>
<%
        }
    }
%>