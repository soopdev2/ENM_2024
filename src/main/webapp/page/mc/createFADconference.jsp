
<%@page import="rc.so.util.Utility"%>
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


        <%@ include file="menu/head1.jsp"%>
        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <%@ include file="../../Bootstrap2024/index/menu/menuMc.jsp"%>
        <%@ include file="menu/head.jsp"%>

        <main class="container-fluid ,y-4">

            <div class="container-fluid kt-grid kt-grid--hor kt-grid--root">
                <div class="row kt-grid__item kt-grid__item--fluid">
                    <div class="col-12 kt-grid__item kt-grid kt-grid--hor kt-wrapper" id="kt_wrapper">

                        <!-- begin:: Subheader -->
                        <div class="row kt-grid__item kt-grid__item--fluid">
                            <div class="col-12">
                                <div class="subheader py-2 px-3 kt-subheader" id="kt_subheader">
                                    <div class="d-flex align-items-center">
                                        <h3 class="kt-subheader__title">Conferenze</h3>
                                        <span class="kt-subheader__separator mx-2"></span>
                                        <a class="kt-subheader__breadcrumbs-link">Crea</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end:: Subheader -->

                        <!-- begin:: Content -->
                        <div class="row kt-grid__item kt-grid__item--fluid" id="kt_content">
                            <div class="col-12">
                                <div class="card kt-portlet" id="kt_portlet" data-ktportlet="true">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <h3 class="card-title kt-portlet__head-title">Crea Conferenza :</h3>
                                        <div class="kt-portlet__head-toolbar">
                                            <button type="button" data-ktportlet-tool="toggle" class="btn btn-sm btn-icon btn-clean btn-icon-md">
                                                <i class="la la-angle-down" id="toggle_search"></i>
                                            </button>
                                        </div>
                                    </div>

                                    <form id="kt_form" action="<%=request.getContextPath()%>/OperazioniMicro?type=creaFAD" 
                                          class="kt-form kt-form--label-right" accept-charset="ISO-8859-1" method="post">
                                        <div class="card-body kt-portlet__body">
                                            <div class="kt-section kt-section--first">
                                                <div class="kt-section__body mb-3">

                                                    <div class="row g-3 form-group">
                                                        <div class="col-lg-6 col-md-12">
                                                            <label>Nome <span class="kt-font-danger">*</span></label>
                                                            <input class="form-control obbligatory" name="name_fad" onkeydown="return blockspecialcharacter();">
                                                        </div>
                                                        <div class="col-lg-6 col-md-12">
                                                            <label>Data e ora di inizio e fine <span class="kt-font-danger">*</span></label>
                                                            <input type="text" class="form-control obbligatory" name="range" id="range" autocomplete="off" 
                                                                   readonly placeholder="Selezionare data e ora inizio fine">
                                                        </div>
                                                    </div>

                                                    <div class="row g-3 mt-2">
                                                        <div class="col-lg-6 col-md-12">
                                                            <label>Note</label>
                                                            <textarea rows="2" class="form-control" placeholder="eventuali note" name="note" id="note"></textarea>
                                                        </div>
                                                        <div class="col-lg-6 col-md-12" id="paretcipant">
                                                            <label>Partecipanti <span class="kt-font-danger">*</span></label>
                                                            <div class="input-group mb-2">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text"><i class="fa fa-at"></i></span>
                                                                </div>
                                                                <input type="text" name="email[]" class="form-control obbligatory" placeholder="Email">
                                                                <div class="input-group-append">
                                                                    <button type="button" class="btn btn-danger delete" title="Elimina" data-toggle="tooltip"><i class="fa fa-times"></i></button>
                                                                </div>
                                                            </div>
                                                            <div class="text-end">
                                                                <a id="add" href="javascript:void(0);"><i class="fa fa-plus"></i> aggiungi</a>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>

                                                <small class="kt-font-danger kt-font-bold">* Campi Obbligatori</small>
                                            </div>
                                        </div>

                                        <div class="card-footer kt-portlet__foot">
                                            <div class="d-flex justify-content-end">
                                                <a id="submit" href="javascript:void(0);" class="btn btn-primary btn-lg">Crea</a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- end:: Content -->

                    </div>
                </div>
            </div>


        </main>
        <%@ include file="../../Bootstrap2024/index/login/Footer_login.jsp"%>

        <div id="kt_scrolltop" style="background-color: #0059b3" class="kt-scrolltop">
            <i class="fa fa-arrow-up"></i>
        </div>

        <form target="_blank" id="goFAD" action="" method="POST" style="display: none">
            <input id="id" name="id">
            <input id="user" name="user">
            <input id="password" name="password">
            <input id="type" name="type" value="login_conference"> 
        </form>        
        <!--begin:: Global Mandatory Vendors -->
        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/popper.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
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
        <script src="<%=src%>/assets/soop/js/utility.js<%=no_cache%>" type="text/javascript"></script>
        <!-- this page -->
        <script src="<%=src%>/assets/vendors/general/bootstrap-select/dist/js/bootstrap-select.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/select2/dist/js/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/dropzone/dist/dropzone.js" type="text/javascript"></script>
        <script src="js/createFADconference.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/dropzone/dist/min/dropzone.min.js" type="text/javascript"></script>
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