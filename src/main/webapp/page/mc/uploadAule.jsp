
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.entity.Item"%>
<%@page import="java.util.List"%>
<%@page import="rc.so.domain.User"%>
<%@page import="rc.so.db.Entity"%>
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
            List<Item> regioni = e.listaRegioni();
            e.close();
            String src = Utility.checkAttribute(session, "src");
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Sedi di Formazione</title>
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
        <!-- this page -->
        <link href="<%=src%>/assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
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
        <!-- this page -->

        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
        <style>
            .kt-section__title {
                font-size: 1.2rem!important;
            }
        </style>
    </head>

    <body class="d-flex flex-column min-vh-100">


        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <%@ include file="../../Bootstrap2024/index/menu/menuMc.jsp"%>
        <%@ include file="menu/head1.jsp"%>
        <%@ include file="menu/head.jsp"%>

        <main class="container-fluid my-4">


            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <!-- Subheader -->
                        <div id="kt_subheader" class="py-3 border-bottom mb-3">
                            <h3 class="d-inline">Sedi di Formazione</h3>
                            <span class="mx-2">|</span>
                            <a class="text-muted">Carica</a>
                        </div>

                        <!-- Portlet -->
                        <div class="card shadow-sm mb-4" id="kt_portlet">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Aggiungi Manualmente :</h5>
                                <a href="#" data-ktportlet-tool="toggle" class="btn btn-sm btn-light">
                                    <i class="la la-angle-down" id="toggle_search"></i>
                                </a>
                            </div>

                            <form id="kt_form" action="<%=request.getContextPath()%>/OperazioniMicro?type=addAula"
                                  method="post" accept-charset="ISO-8859-1">
                                <div class="card-body">
                                    <div class="mb-3 row">
                                        <div class="col-lg-4">
                                            <label for="denom" class="form-label">Denominazione <span class="text-danger">*</span></label>
                                            <input class="form-control obbligatory" name="denom" id="denom">
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <div class="col-lg-4">
                                            <label for="regione" class="form-label">Regione <span class="text-danger">*</span></label>
                                            <select class="form-control obbligatory" id="regione" name="regione">
                                                <option value="-">Seleziona Regione</option>
                                                <%for (Item i : regioni) {%>
                                                <option value="<%=i.getValue()%>"><%=i.getDesc()%></option>
                                                <%}%>
                                            </select>
                                        </div>

                                        <div class="col-lg-4">
                                            <label for="provincia" class="form-label">Provincia <span class="text-danger">*</span></label>
                                            <select class="form-control obbligatory" id="provincia" name="provincia">
                                                <option value="-">Seleziona Provincia</option>
                                            </select>
                                        </div>

                                        <div class="col-lg-4">
                                            <label for="comune" class="form-label">Comune <span class="text-danger">*</span></label>
                                            <select class="form-control obbligatory" id="comune" name="comune">
                                                <option value="-">Seleziona Comune</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <div class="col-lg-12">
                                            <label for="via" class="form-label">Indirizzo <span class="text-danger">*</span></label>
                                            <input class="form-control obbligatory" name="via" id="via">
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <div class="col-lg-4">
                                            <label for="referente" class="form-label">Referente <span class="text-danger">*</span></label>
                                            <input class="form-control obbligatory" name="referente" id="referente">
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <div class="col-lg-4">
                                            <label for="phone" class="form-label">Telefono</label>
                                            <input class="form-control" name="phone" id="phone" onkeypress="return isNumber(event);">
                                        </div>
                                        <div class="col-lg-4">
                                            <label for="cellulare" class="form-label">Cellulare</label>
                                            <input class="form-control" name="cellulare" id="cellulare" onkeypress="return isNumber(event);">
                                        </div>
                                        <div class="col-lg-4">
                                            <label for="email" class="form-label">Email</label>
                                            <input class="form-control" name="email" id="email">
                                        </div>
                                    </div>

                                    <p class="text-danger fw-bold small">* Campi Obbligatori</p>
                                </div>

                                <div class="card-footer text-end">
                                    <a id="submit" href="javascript:void(0);" class="btn btn-primary text-white">Salva</a>
                                    <a href="<%=StringEscapeUtils.escapeHtml4(pageName_)%>" class="btn btn-warning text-white">Reset</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>



        </main>        
        <%@ include file="../../Bootstrap2024/index/login/Footer_login.jsp"%>

       
        <input type="hidden" id="context" value="<%=request.getContextPath()%>">

        <!--begin:: Global Mandatory Vendors -->
        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/popper.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/moment.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/jquery-form/dist/jquery.form.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/components/extended/blockui1.33.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
        <!-- this page -->
        <script src="<%=src%>/assets/vendors/general/bootstrap-select/dist/js/bootstrap-select.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/select2/dist/js/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/dropzone/dist/dropzone.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/dropzone/dist/min/dropzone.min.js" type="text/javascript"></script>
        <script src="js/uploadAule.js" type="text/javascript"></script>
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