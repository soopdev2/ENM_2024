
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
        <link href="<%=src%>/assets/vendors/custom/fullcalendar/fullcalendar.bundle.css" rel="stylesheet" type="text/css"/>
        <!-- - -->
        <link href="<%=src%>/resource/animate.css" rel="stylesheet" type="text/css"/>
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
            .ui-datepicker-other-month.ui-state-disabled:not(.my_class) span{
                color: red;
            }
            .block{
                display: block;
            }
            .popover-body{
                color:#000!important;
                font-size: 1rem!important;
                font-weight: bold;
            }
        </style>
    </head>

    <body class="d-flex flex-column min-vh-100">
        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <%@ include file="../../Bootstrap2024/index/menu/menuMc.jsp"%>
        <%@ include file="menu/head.jsp"%>


        <main class="container-fluid my-4">
            <div class="container-fluid" id="kt_wrapper">

                <!-- Subheader -->
                <div class="row mb-3" id="kt_subheader">
                    <div class="col">
                        <div class="d-flex align-items-center">
                            <h3 class="mb-0">CAD</h3>
                            <span class="mx-2">|</span>
                            <a class="text-muted">I Miei CAD</a>
                        </div>
                    </div>
                </div>

                <!-- Content -->
                <div class="row" id="kt_content">
                    <div class="col-lg-12">
                        <div class="card" id="kt_portlet">

                            <!-- Card header -->
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h3 class="card-title mb-0">I Miei CAD :</h3>
                                <a href="#" data-ktportlet-tool="toggle" class="btn btn-sm btn-light">
                                    <i class="la la-angle-down" id="toggle_search"></i>
                                </a>
                            </div>

                            <!-- Card body -->
                            <div class="card-body">
                                <div class="row">
                                    <div id="kt_calendar" class="col-12"></div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </main>




        <div id="kt_scrolltop" style="background-color: #0059b3" class="kt-scrolltop">
            <i class="fa fa-arrow-up"></i>
        </div>

        <form target="_blank" id="goCAD" action="" method="POST" style="display: none">
            <input id="id" name="id">
            <input id="user" name="user">
            <input id="password" name="password">
            <input id="view" name="view" value="1">
            <input id="type" name="type" value="login_cad"> 
        </form>        
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
        <script src="<%=src%>/assets/soop/js/utility.js<%=no_cache%>" type="text/javascript"></script>
        <!-- this page -->
        <script src='<%=src%>/assets/vendors/custom/fullcalendar/core/main.js'></script>
        <script src='<%=src%>/assets/vendors/custom/fullcalendar/interaction/main.js'></script>
        <script src='<%=src%>/assets/vendors/custom/fullcalendar/daygrid/main.js'></script>
        <script src='<%=src%>/assets/vendors/custom/fullcalendar/timegrid/main.js'></script>
        <script src='<%=src%>/assets/vendors/custom/fullcalendar/list/main.js'></script>
        <script src="<%=src%>/assets/vendors/custom/fullcalendar/core/locales-all.min.js" type="text/javascript"></script>
        <script id="myCad" src="<%=src%>/page/all/js/myCad.js<%=no_cache%>" data-context="<%=request.getContextPath()%>" type="text/javascript"></script>
        <script type="text/javascript">
            var KTAppOptions =
                    {
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
                                "shape": ["#f0f3ff", "#d9dffa", "#afb4d4", "#646c9a"]}
                        }
                    };
        </script>
    </body>
</html>
<%
        }
    }
%>