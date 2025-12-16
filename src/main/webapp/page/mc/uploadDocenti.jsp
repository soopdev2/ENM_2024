
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="java.util.List"%>
<%@page import="rc.so.domain.FasceDocenti"%>
<%@page import="rc.so.domain.User"%>
<%@page import="rc.so.db.Entity"%>
<%@page import="rc.so.db.Action"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    try {
        User us = (User) session.getAttribute("user");
        if (us == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            String uri_ = request.getRequestURI();
            String pageName_ = uri_.substring(uri_.lastIndexOf("/") + 1);
            if (!Action.isVisibile(String.valueOf(us.getTipo()), pageName_)) {
                response.sendRedirect(request.getContextPath() + "/page_403.jsp");
            } else {
                String src = Utility.checkAttribute(session, "src");
                Entity e = new Entity();
                List<FasceDocenti> fasce = e.findAll(FasceDocenti.class);
                e.close();
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Docenti</title>
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
        <link href="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css" rel="stylesheet" type="text/css" />
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
                            <h3 class="d-inline">Docenti</h3>
                            <span class="mx-2">|</span>
                            <a class="text-muted">Carica</a>
                        </div>

                        <!-- Portlet Carica File Docenti -->
                        <div class="card shadow-sm mb-4" id="kt_portlet">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Carica File Docenti :</h5>
                                <a href="#" data-ktportlet-tool="toggle" class="btn btn-sm btn-light">
                                    <i class="la la-angle-down" id="toggle_search"></i>
                                </a>
                            </div>

                            <form id="kt_form_file" action="<%=request.getContextPath()%>/OperazioniMicro?type=addDocenteFile"
                                  method="post" accept-charset="ISO-8859-1" enctype="multipart/form-data">
                                <div class="card-body">
                                    <div class="row g-3 align-items-center">
                                        <div class="col-xl-4 col-lg-6 col-md-8">
                                            <input type="file" class="form-control" 
                                                   accept="application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" 
                                                   name="file" id="file" onchange="return checkFileExtAndDim();">
                                        </div>
                                        <div class="col-lg-3">
                                            <a href="javascript:void(0);" id="submit_file" class="btn btn-primary">Carica</a>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Portlet Aggiungi Manualmente -->
                        <div class="card shadow-sm mb-4" id="kt_portlet">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Aggiungi Manualmente :</h5>
                                <a href="#" data-ktportlet-tool="toggle" class="btn btn-sm btn-light">
                                    <i class="la la-angle-down" id="toggle_search"></i>
                                </a>
                            </div>

                            <form id="kt_form" action="<%=request.getContextPath()%>/OperazioniMicro?type=addDocente"
                                  method="post" accept-charset="ISO-8859-1">
                                <div class="card-body">
                                    <div class="row g-3">
                                        <div class="col-lg-3">
                                            <label for="nome" class="form-label">Nome</label>
                                            <input class="form-control obbligatory" name="nome" id="nome">
                                        </div>
                                        <div class="col-lg-3">
                                            <label for="cognome" class="form-label">Cognome</label>
                                            <input class="form-control obbligatory" name="cognome" id="cognome">
                                        </div>
                                    </div>

                                    <div class="row g-3 mt-2">
                                        <div class="col-lg-3">
                                            <label for="cf" class="form-label">Codice Fiscale</label>
                                            <input class="form-control obbligatory" name="cf" id="cf">
                                        </div>
                                        <div class="col-lg-3">
                                            <label for="kt_datepicker_1" class="form-label">Data Nascita</label>
                                            <input class="form-control obbligatory" name="data" id="kt_datepicker_1" autocomplete="off" readonly>
                                        </div>
                                        <div class="col-lg-3">
                                            <label for="fascia" class="form-label">Fascia</label>
                                            <select class="form-control obbligatory" id="fascia" name="fascia">
                                                <option value="-">Seleziona Fascia</option>
                                                <% for (FasceDocenti f : fasce) {%>
                                                <option value="<%=f.getId()%>"><%=f.getDescrizione()%></option>
                                                <% }%>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row g-3 mt-2">
                                        <div class="col-lg-3">
                                            <label for="email" class="form-label">Email</label>
                                            <input class="form-control obbligatory" name="email" id="email">
                                        </div>
                                    </div>
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
        <script src="<%=src%>/assets/vendors/general/select2/dist/js/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
        <!-- this page -->
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/select2/dist/js/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
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
            function ctrlForm() {
                var err = false;
                err = checkObblFieldsContent($('#kt_form')) ? true : err;
                err = !checkCF($('#cf')) ? true : err;
                err = checkEmail($('#email')) ? true : err;
                return err ? false : true;
            }
            $('#submit').on('click', function () {
                if (ctrlForm()) {
                    showLoad();
                    $('#kt_form').ajaxSubmit({
                        error: function () {
                            closeSwal();
                            swalError("Errore", "Riprovare, se l'errore persiste contattare l'assistenza");
                        },
                        success: function (resp) {
                            var json = JSON.parse(resp);
                            closeSwal();
                            if (json.result) {
                                $('.form-control').val('');
                                $('.form-control').removeClass('is-valid');
                                swalSuccess("Docente aggiunto!", "Operazione effettuata con successo.");
                            } else {
                                swalError("Errore!", json.message);
                            }
                        }
                    });
                }
            });


            function ctrlFile() {
                var err = false;
                err = !checkRequiredFile() ? true : err;
                err = !checkFileExtAndDim(['xls', 'xlsx']) ? true : err;
                return err ? false : true;
            }

            $('#submit_file').on('click', function () {
                if (ctrlFile()) {
                    showLoad();
                    $('#kt_form_file').ajaxSubmit({
                        error: function () {
                            closeSwal();
                            swalError("Errore", "Riprovare, se l'errore persiste contattare l'assistenza");
                        },
                        success: function (resp) {
                            var json = JSON.parse(resp);
                            closeSwal();
                            if (json.result) {
                                $('.custom-file-input').val('');
                                $('.custom-file-input').removeClass('is-valid');
                                swalSuccess("Docente aggiunto!", "Operazione effettuata con successo.");
                            } else {
                                swalError("Errore!", json.message);
                            }
                        }
                    });
                }
            });
        </script>
    </body>
</html>
<%
            }
        }
    } catch (OutOfMemoryError e) {
        e.printStackTrace();
    }
%>