<%-- 
    Document   : login1
    Created on : 15-ott-2019, 10.42.32
    Author     : dolivo
--%>
<%@page import="rc.so.domain.Faq"%>
<%@page import="java.util.List"%>
<%@page import="rc.so.db.Entity"%>
<%@page import="rc.so.entity.Item"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Entity e = new Entity();
    List<Faq> faqs = e.getFaqPublic();
    e.close();
    response.addHeader("X-Frame-Options", "SAMEORIGIN");
%>
<html>
    <!-- begin::Head -->
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana</title>
        <meta name="description" content="Login page example">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="Content-Security-Policy" content="default-src * 'unsafe-inline' 'unsafe-eval' data: blob:;">
        <script src="resource/webfont.js"></script>
        <script>
            WebFont.load({
                google: {
                    "families": ["Poppins:300,400,500,600,700", "Roboto:300,400,500,600,700", "Architects Daughter:300,400,500,600,700"]
                },
                active: function () {
                    sessionStorage.fonts = true;
                }
            });
        </script>
        <!-- this page -->
        <link href="assets/app/custom/login/login-v3.default.css" rel="stylesheet" type="text/css" />
        <!-- - -->
        <!--this page-->
        <link href="assets/vendors/general/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/custom/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/custom/vendors/flaticon/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/custom/vendors/flaticon2/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/custom/vendors/fontawesome5/css/all.min.css" rel="stylesheet" type="text/css" />
        <link href="resource/animate.css" rel="stylesheet" type="text/css"/>
        <link href="resource/faq.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="Bootstrap2024/assets/css/bootstrap.min.css"/>
        <!----->
        <link href="resource/custom.css" rel="stylesheet" type="text/css" />
        <link href="assets/demo/default/skins/header/base/light.css" rel="stylesheet" type="text/css" />
        <link href="assets/demo/default/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
        <link href="assets/demo/default/skins/brand/light.css" rel="stylesheet" type="text/css" />
        <link href="assets/demo/default/skins/aside/light.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="assets/media/logos/favicon.ico" />
    </head>
    <!-- end::Head -->

    <!-- begin::Body -->

    <body class="d-flex flex-column min-vh-100">

        <!-- begin:: Page -->
        <div class="container-fluid d-flex flex-column justify-content-center align-items-center bg-light min-vh-100" id="kt_login">

            <!-- Wrapper -->
            <div class="w-100 d-flex flex-column align-items-center py-5" style="background-image: url(assets/media/bg/bg-3.jpg); background-size: cover;">

                <!-- Logo -->
                <div class="mb-3">
                    <a href="login.jsp">
                        <img src="assets/media/logos/logo.png" width="320" alt="Logo">
                    </a>
                </div>

                <!-- Titolo -->
                <div class="text-center mb-4">
                    <h3 class="fw-bold" style="font-size:2.2rem"><b>FAQs</b></h3>
                </div>

                <!-- Torna indietro -->
                <div class="row justify-content-start w-100 mb-3 px-3">
                    <div class="col-auto">
                        <a href="login.jsp" style="position: relative; left:380px;"  class="text-decoration-none">&larr; torna indietro</a>
                    </div>
                </div>

                <!-- Accordion FAQ -->
                <div class="col-lg-8 col-md-10 col-sm-12">
                    <div class="accordion" id="accordionExample1">
                        <% for (Faq f : faqs) {%>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="heading_<%=f.getId()%>">
                                <button class="accordion-button collapsed text-start" type="button"
                                        data-bs-toggle="collapse"
                                        data-bs-target="#collapse_<%=f.getId()%>"
                                        aria-expanded="false"
                                        aria-controls="collapse_<%=f.getId()%>">
                                    <%=f.getDomanda_mod()%>
                                </button>
                            </h2>
                            <div id="collapse_<%=f.getId()%>" class="accordion-collapse collapse"
                                 aria-labelledby="heading_<%=f.getId()%>" data-bs-parent="#accordionExample1">
                                <div class="accordion-body text-start">
                                    <%=f.getRisposta()%>
                                </div>
                            </div>
                        </div>
                        <% }%>
                    </div>
                </div>

            </div>
        </div>
        <!-- end:: Page -->

        <!-- Scripts -->
        <script src="assets/soop/js/jquery-3.7.1.js"></script>
        <script src="assets/vendors/general/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="assets/vendors/general/js-cookie/src/js.cookie.js"></script>
        <script src="assets/soop/js/moment.min.js"></script>
        <script src="assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js"></script>
        <script src="assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js"></script>
        <script src="assets/vendors/general/sticky-js/dist/sticky.min.js"></script>
        <script src="assets/demo/default/base/scripts.bundle.js"></script>
        <script src="assets/vendors/general/jquery-form/dist/jquery.form.min.js"></script>
        <script src="assets/vendors/general/jquery-validation/dist/jquery.validate.js"></script>
        <script src="assets/vendors/general/jquery-validation/dist/additional-methods.js"></script>
        <script src="assets/vendors/custom/components/vendors/jquery-validation/init.js"></script>
        <script src="assets/vendors/general/sweetalert2/dist/sweetalert2.js"></script>
        <script src="Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
        <script src="assets/soop/js/utility.js"></script>
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
                        "warning": "#ffb822",
                        "danger": "#fd3995"
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