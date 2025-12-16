
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.domain.Faq"%>
<%@page import="rc.so.domain.CPI"%>
<%@page import="java.util.List"%>
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
            String src = Utility.checkAttribute(session, "src");
            Entity e = new Entity();
            List<Faq> faqs = e.getFaqSoggetti();
            e.close();
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - FAQ</title>
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
        <!--this page-->
        <link href="<%=src%>/assets/vendors/general/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon2/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/fontawesome5/css/all.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/animate.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/resource/faq.css" rel="stylesheet" type="text/css"/>
        <!----->
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
    <body>
        <!-- begin:: Page -->
        <%@ include file="menu/head1.jsp"%>
        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <%@ include file="../../Bootstrap2024/index/menu/menuAtt.jsp"%>
        <%@ include file="menu/head.jsp"%>



    <body class="d-flex flex-column min-vh-100">


        <main class="flex-grow-1 container-fluid px-4">

            <!-- Intestazione sezione -->
            <div class="my-3">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <h1 class="h3">FAQ</h1>
                        <span class="text-muted ms-2">consulta</span>
                    </div>
                </div>
            </div>

            <!-- Card FAQ -->
            <div class="row">
                <div class="col-12">
                    <div class="card shadow-sm border-0 rounded-3">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h3 class="h5 mb-0">FAQs:</h3>
                            <button class="btn btn-sm btn-outline-secondary" 
                                    type="button" 
                                    data-bs-toggle="collapse" 
                                    data-bs-target="#collapseAllFaq" 
                                    aria-expanded="true" 
                                    aria-controls="collapseAllFaq">
                                <span class="visually-hidden">Mostra/Nascondi tutte le FAQ</span>
                                <i class="it-expand"></i>
                            </button>
                        </div>
                        <div class="card-body">
                            <div class="accordion accordion-flush" id="accordionFaq">
                                <%for (Faq f : faqs) {%>
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="heading_<%=f.getId()%>">
                                        <button class="accordion-button collapsed" type="button" 
                                                data-bs-toggle="collapse" 
                                                data-bs-target="#collapse_<%=f.getId()%>" 
                                                aria-expanded="false" 
                                                aria-controls="collapse_<%=f.getId()%>">
                                            <%=f.getDomanda_mod()%>
                                        </button>
                                    </h2>
                                    <div id="collapse_<%=f.getId()%>" class="accordion-collapse collapse" 
                                         aria-labelledby="heading_<%=f.getId()%>" 
                                         data-bs-parent="#accordionFaq">
                                        <div class="accordion-body">
                                            <%=f.getRisposta()%>
                                        </div>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </main>

        <%@ include file="../../Bootstrap2024/index/login/Footer_login.jsp"%>






    <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
    <script src="<%=src%>/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
    <script src="<%=src%>/assets/soop/js/moment.min.js" type="text/javascript"></script>
    <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
    <script src="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
    <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
    <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
    <script src="<%=src%>/assets/vendors/general/jquery-form/dist/jquery.form.min.js" type="text/javascript"></script>
    <script src="<%=src%>/assets/vendors/general/jquery-validation/dist/jquery.validate.js" type="text/javascript"></script>
    <script src="<%=src%>/assets/vendors/general/jquery-validation/dist/additional-methods.js" type="text/javascript"></script>
    <script src="<%=src%>/assets/vendors/custom/components/vendors/jquery-validation/init.js" type="text/javascript"></script>
    <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
    <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
    <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
    <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
    <!--this page -->

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

    </script>
</body>
</html>
<%
        }
    }
%>