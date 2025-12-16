
<%@page import="rc.so.util.Utility"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="rc.so.domain.FadMicro"%>
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
            FadMicro fad = e.getEm().find(FadMicro.class, Long.parseLong(request.getParameter("idFad")));
            e.close();
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            String src = Utility.checkAttribute(session, "src");
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Crea Conferenza</title>
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
        <link href="<%=src%>/assets/vendors/general/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css" rel="stylesheet" type="text/css" />
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
            .input-group {
                margin-bottom: 5px;
            }
        </style>
    </head>

    <body class="d-flex flex-column min-vh-100">


        <main class="container-fluid my-4">


            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">

                        <!-- begin:: Content -->
                        <div class="row" id="kt_content">
                            <div class="col-12">
                                <div class="card">

                                    <!-- Header -->
                                    <div class="card-header">
                                        <h3 class="card-title">Modifica Conferenza:</h3>
                                    </div>

                                    <!-- Body -->
                                    <div class="card-body">
                                        <form id="kt_form"
                                              action="<%=request.getContextPath()%>/OperazioniMicro?type=modifyFAD"
                                              method="post" accept-charset="ISO-8859-1">

                                            <input type="hidden" name="idFad" value="<%=fad.getId()%>">

                                            <div class="mb-4">
                                                <div class="row g-3">
                                                    <div class="col-lg-6 col-md-12">
                                                        <label for="name_fad" class="form-label">Nome <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control obbligatory"
                                                               name="name_fad" id="name_fad"
                                                               onkeydown="return blockspecialcharacter();"
                                                               value="<%=fad.getNomestanza()%>">
                                                    </div>
                                                    <div class="col-lg-6 col-md-12">
                                                        <label for="range" class="form-label">Data e ora di inizio e fine <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control obbligatory"
                                                               name="range" id="range"
                                                               autocomplete="off" readonly
                                                               placeholder="Selezionare data e ora inizio fine"
                                                               value ="<%=fad.getInizio() != null ? sdf.format(fad.getInizio()) + " - " + sdf.format(fad.getFine()) : ""%>">
                                                    </div>
                                                </div>

                                                <div class="row g-3 mt-3">
                                                    <div class="col-lg-6 col-md-12" id="paretcipant">
                                                        <label class="form-label">Partecipanti <span class="text-danger">*</span></label>
                                                        <% for (String s : fad.getList_partecipanti()) {%>
                                                        <div class="input-group mb-2">
                                                            <span class="input-group-text bg-primary text-white"><i class="fa fa-at"></i></span>
                                                            <input type="text" name="email[]" class="form-control obbligatory"
                                                                   placeholder="Email" value="<%=s%>">
                                                            <button type="button" class="btn btn-danger delete">
                                                                <i class="fa fa-times"></i>
                                                            </button>
                                                        </div>
                                                        <% }%>
                                                    </div>
                                                </div>

                                                <div class="row mt-2">
                                                    <div class="col text-end">
                                                        <a id="add" href="javascript:void(0);" class="btn btn-link">
                                                            <i class="fa fa-plus"></i> aggiungi
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>

                                            <p class="text-danger fw-bold" style="font-size: 0.9rem;">* Campi Obbligatori</p>

                                            <!-- Footer con pulsante -->
                                            <div class="card-footer text-end">
                                                <a id="submit" href="javascript:void(0);" class="btn btn-primary btn-lg">Salva</a>
                                            </div>
                                        </form>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <!-- end:: Content -->

                    </div>
                </div>
            </div>



        </main>


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
        <script src="<%=src%>/assets/soop/js/utility.js<%="?dummy=" + String.valueOf(new Date().getTime())%>" type="text/javascript"></script>
        <!-- this page -->
        <script src="<%=src%>/assets/vendors/general/bootstrap-select/dist/js/bootstrap-select.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/select2/dist/js/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/dropzone/dist/dropzone.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/dropzone/dist/min/dropzone.min.js" type="text/javascript"></script>
        <script src="js/modifyFacConference.js" type="text/javascript"></script>
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