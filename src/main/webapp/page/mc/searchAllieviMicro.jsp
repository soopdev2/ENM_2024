
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.domain.CPI"%>
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
            Entity e = new Entity();
            List<CPI> cpi = e.listaCPI();
            List<SoggettiAttuatori> sa_list = e.findAll(SoggettiAttuatori.class);
            e.close();
            String src = Utility.checkAttribute(session, "src");
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Allievi</title>
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
        <link href="<%=src%>/assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/datatbles.bundle.css" rel="stylesheet" type="text/css"/>
        <!-- - -->
        <link href="<%=src%>/assets/vendors/general/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/socicon/css/socicon.css" rel="stylesheet" type="text/css" />
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
        <%@ include file="menu/head1.jsp"%>
        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <%@ include file="../../Bootstrap2024/index/menu/menuMc.jsp"%>
        <%@ include file="menu/head.jsp"%>





        <main class="flex-grow-1 container-fluid px-4">

            <!-- Intestazione sezione -->
            <div class="my-3">
                <h1 class="h3">Allievi</h1>
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
                                <form accept-charset="ISO-8859-1" method="post">
                                    <div class="row g-3 mb-3">
                                        <div class="col-lg-3">
                                            <label class="form-label">Soggetto Esecutore</label>
                                            <select class="form-select" id="soggettoattuatore" name="soggettoattuatore">
                                                <option value="-">Seleziona Soggetto Esecutore</option>
                                                <% for (SoggettiAttuatori i : sa_list) {%>
                                                <option value="<%=i.getId()%>" <%= (i.getId() == idsa) ? "selected" : ""%>><%=i.getRagionesociale()%></option>
                                                <% }%>
                                            </select>
                                        </div>
                                        <div class="col-lg-3">
                                            <label class="form-label">Nome</label>
                                            <input type="text" class="form-control" name="nome" id="nome" autocomplete="off">
                                        </div>
                                        <div class="col-lg-3">
                                            <label class="form-label">Cognome</label>
                                            <input type="text" class="form-control" name="cognome" id="cognome" autocomplete="off">
                                        </div>
                                        <div class="col-lg-3">
                                            <label class="form-label">Codice Fiscale</label>
                                            <input type="text" class="form-control" name="cf" id="cf" autocomplete="off">
                                        </div>
                                    </div>
                                    <input type="hidden" name="cpi" value="-" />

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
                                <table class="table table-striped table-bordered table-hover text-center" id="kt_table_1" style="width:100%">
                                    <thead class="text-uppercase">
                                        <tr>
                                            <th>Azioni</th>
                                            <th>Nome</th>
                                            <th>Cognome</th>
                                            <th>Codice Fiscale</th>
                                            <th>Data Nascita</th>
                                            <th>Residenza</th>
                                            <th>Soggetto Esecutore</th>
                                            <th>Assegnato a Operatore ENM</th>
                                            <th>Stato di partecipazione</th>
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
        <div class="modal fade" id="doc_modal" tabindex="-1" role="dialog" aria-labelledby="Documenti Allievo" aria-hidden="true">
            <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Documenti Allievo</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        </button>
                    </div>
                    <div class="modal-body">
                        <div style="text-align: center;">
                            <div class="row col-12" id="prg_docs"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--end:Modal-->
        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/moment.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
        <!-- this page -->
        <script src="<%=src%>/assets/vendors/custom/datatables/datatables.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/loadTable.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/select2/dist/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
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
            var context = '<%=request.getContextPath()%>';
        </script>

        <script src="js/searchAllieviMicro.js" type="text/javascript"></script>




    </body>
</html>
<%
        }
    }
%>