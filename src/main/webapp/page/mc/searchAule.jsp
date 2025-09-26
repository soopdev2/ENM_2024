
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="rc.so.util.Utility"%>
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
        <link href="../../Bootstrap2024/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">
        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
        <script src="../../Bootstrap2024/assets/js/popper.js"></script>


    </head>
    <body class="d-flex flex-column min-vh-100">
        <!-- begin:: Page -->
        <%@ include file="menu/head1.jsp"%>
        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <%@ include file="../../Bootstrap2024/index/menu/menuMc.jsp"%>
        <%@ include file="menu/head.jsp"%>





        <main class="flex-grow-1 container-fluid px-4">

            <!-- Intestazione sezione -->
            <div class="my-3">
                <h1 class="h3">Sedi di Formazione</h1>
                <span class="text-muted">Cerca</span>
            </div>

            <!-- Form di ricerca -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card shadow-sm">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Cerca :</h5>
                            <button class="btn btn-sm btn-outline-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSearch" aria-expanded="true">
                                <i class="it-expand"></i>
                            </button>
                        </div>
                        <div class="collapse show" id="collapseSearch">
                            <div class="card-body">
                                <form onsubmit="return false;" accept-charset="ISO-8859-1" method="post">
                                    <div class="row g-3 mb-3">
                                        <div class="col-lg-4">
                                            <label class="form-label">Referente</label>
                                            <input type="text" class="form-control obbligatory" id="referente" name="referente">
                                        </div>
                                    </div>
                                    <div class="row g-3 mb-3">
                                        <div class="col-lg-4">
                                            <label class="form-label">Regione</label>
                                            <select class="form-select obbligatory" id="regione" name="regione">
                                                <option value="-">Seleziona Regione</option>
                                                <%for (Item i : regioni) {%>
                                                <option value="<%=i.getValue()%>"><%=i.getDesc()%></option>
                                                <%}%>
                                            </select>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="form-label">Provincia</label>
                                            <select class="form-select obbligatory" id="provincia" name="provincia">
                                                <option value="-">Seleziona Provincia</option>
                                            </select>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="form-label">Comune</label>
                                            <select class="form-select obbligatory" id="comune" name="comune">
                                                <option value="-">Seleziona Comune</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-end gap-2">
                                        <a onclick="refresh();" href="javascript:void(0);" class="btn btn-primary">Cerca</a>
                                        <a href="<%=StringEscapeUtils.escapeHtml4(pageName_)%>" class="btn btn-secondary">Reset</a>
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
                                    <thead class="text-center text-uppercase">
                                        <tr>
                                            <th>Azioni</th>
                                            <th>Denominazione</th>
                                            <th>Soggetto Esecutore</th>
                                            <th>Stato</th>
                                            <th>Regione</th>
                                            <th>Provincia</th>
                                            <th>Comune</th>
                                            <th>Indirizzo</th>
                                            <th>Referente</th>
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



        <input type="hidden" id="context" value="<%=request.getContextPath()%>">

        <!-- begin::Scrolltop -->
        <div id="kt_scrolltop" class="kt-scrolltop">
            <i class="fa fa-arrow-up"></i>
        </div>
        <!--begin:: Global Mandatory Vendors -->
        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
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
        <script src="../../assets/vendors/general/select2/dist/select2.full.js" type="text/javascript"></script>
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
            var contextPath = '<%=request.getContextPath()%>';
            var tipoR = '<%=tipoR%>';
        </script>

        <script src="js/searchAule.js" type="text/javascript"></script>




    </body>
</html>
<%
        }
    }
%>