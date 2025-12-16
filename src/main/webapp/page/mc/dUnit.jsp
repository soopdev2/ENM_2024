<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.domain.UnitaDidattiche"%>
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
            List<UnitaDidattiche> ud = e.getUD();
            List<String> fasi = e.getFasi_UD();
            e.close();
            String src = Utility.checkAttribute(session, "src");
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Unità Didattiche</title>
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
        <link href="../../Bootstrap2024/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">
        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
        <script src="../../Bootstrap2024/assets/js/popper.js"></script>
        <!--end::countDown -->
        <style>
            .kt-section__title {
                font-size: 1.2rem!important;
            }
            .daterangepicker.ltr.auto-apply.show-calendar.opensright{
                z-index: 9999;
            }
        </style>
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
                <h1 class="h3">Unità Didattiche</h1>
                <span class="text-muted">Cerca</span>
            </div>

            <!-- Filtro di ricerca -->
            <div class="row">
                <div class="col-12">
                    <div class="card shadow-sm">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Cerca :</h5>
                            <button class="btn btn-sm btn-outline-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFilter" aria-expanded="true">
                                <i class="it-expand"></i>
                            </button>
                        </div>
                        <div class="collapse show" id="collapseFilter">
                            <div class="card-body">
                                <form class="row g-3" onsubmit="refresh();return false;">
                                    <div class="col-lg-4">
                                        <label class="form-label" for="codiceud">Unità Didattica</label>
                                        <select class="form-select" id="codiceud" name="codiceud">
                                            <option value="-">Seleziona Unità didattica</option>
                                            <%for (UnitaDidattiche i : ud) {%>
                                            <option value="<%=i.getCodice()%>"><%=i.getCodice()%></option>
                                            <%}%>
                                        </select>
                                    </div>
                                    <div class="col-lg-3">
                                        <label class="form-label" for="fase">Fase Progetto</label>
                                        <select class="form-select" id="fase" name="fase">
                                            <option value="-">Seleziona fase</option>
                                            <%for (String i : fasi) {%>
                                            <option value="<%=i%>"><%=i%></option>
                                            <%}%>
                                        </select>
                                    </div>
                                    <div class="col-12 text-end mt-3">
                                        <a onclick="refresh();" class="btn btn-primary">Cerca</a>
                                        <a href="<%=StringEscapeUtils.escapeHtml4(pageName_)%>" class="btn btn-warning">Reset</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Risultati -->
            <div class="row mt-4">
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
                                <table class="table table-striped table-bordered table-hover text-center" id="kt_table_1" style="width:100%">
                                    <thead class="text-uppercase">
                                        <tr>
                                            <th>Azioni</th>
                                            <th>Codice</th>
                                            <th>Fase Progetto</th>
                                            <th>Descrizione</th>
                                            <th>Ore</th>
                                            <th>Documenti</th>
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





        <!--start:Modal-->
        <div class="modal fade" id="allievi_table" tabindex="-1" role="dialog" aria-labelledby="Allievi Progetto Formativo" aria-hidden="true" style="padding: 0!important;">
            <div class="modal-dialog modal-full modal-dialog-centered" role="document">
                <div class="modal-content center">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Allievi Progetto</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="kt-scroll" style="max-height: 750px; min-height: 750px;">
                            <table class="table table-bordered" id="kt_table_allievi" style="width: 100%;">
                                <thead style="width: 100%;">
                                    <tr>
                                        <th class="text-uppercase text-center">Azioni</th>
                                        <th class="text-uppercase text-center">Nome</th>
                                        <th class="text-uppercase text-center">Cognome</th>
                                        <th class="text-uppercase text-center">Codice Fiscale</th>
                                        <th class="text-uppercase text-center">Data Nascita</th>
                                        <th class="text-uppercase text-center">Domicilio</th>
                                        <th class="text-uppercase text-center">Modello 8</th>
                                        <th class="text-uppercase text-center">SELFIEmployement</th>
                                        <th class="text-uppercase text-center">Documento Id.</th>
                                        <th class="text-uppercase text-center">Esito</th>
                                        <th class="text-uppercase text-center">Importo</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="doc_modal" tabindex="-1" role="dialog" aria-labelledby="Documenti" aria-hidden="true"> 
            <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Documenti</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        </button>
                    </div>
                    <div class="modal-body kt-scroll" style="max-height: 750px;">
                        <div style="text-align: center;">
                            <div class="row col-12" id="prg_docs"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="register_modal" tabindex="-1" role="dialog" aria-labelledby="Registro Aula" aria-hidden="true"> 
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Registro Aula</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        </button>
                    </div>
                    <div class="modal-body kt-scroll" style="max-height: 500px;">
                        <div class="row col-12" id="register_docs_modal">

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end::Modal-->
        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
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
        <script src="<%=src%>/assets/vendors/general/select2/dist/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/jquery-form/dist/jquery.form.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/custom/datatables/datatables.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/loadTable.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="<%=src%>/page/mc/js/control.js<%=no_cache%>" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/inputmask/dist/inputmask/inputmask.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/inputmask/dist/inputmask/jquery.inputmask.js" type="text/javascript"></script>
        <script id="dUnit" defer src="<%=src%>/page/mc/js/dUnit.js<%=no_cache%>" data-context="<%=request.getContextPath()%>" type="text/javascript"></script>
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