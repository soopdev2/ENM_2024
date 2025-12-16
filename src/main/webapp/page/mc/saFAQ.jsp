<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.domain.SoggettiAttuatori"%>
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
            List<Faq> faqs = e.faqNoAnswer();
            List<SoggettiAttuatori> soggetti = e.findAll(SoggettiAttuatori.class);
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
    <body class="d-flex flex-column min-vh-100">
        <!-- begin:: Page -->
        <%@ include file="menu/head1.jsp"%>
        <%@ include file="../../Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <%@ include file="../../Bootstrap2024/index/menu/menuMc.jsp"%>
        <%@ include file="menu/head.jsp"%>


   <main class="flex-grow-1 container-fluid px-4">
        <div class="container-fluid px-4">

            <!-- Intestazione -->
            <div class="d-flex align-items-center mb-3">
                <h1 class="h3 me-3">FAQ</h1>
                <span class="text-muted">Domande Enti</span>
            </div>

            <!-- Portlet FAQ -->
            <div class="card shadow-sm mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">FAQs</h5>
                    <button class="btn btn-sm btn-outline-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFaq">
                        <i class="la la-angle-down"></i>
                    </button>
                </div>
                <div class="collapse show" id="collapseFaq">
                    <div class="card-body">

                        <!-- Ricerca -->
                        <div class="row mb-3">
                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-text bg-info text-white"><i class="fa fa-search"></i></span>
                                    <input type="text" id="search" class="form-control" placeholder="Cerca ...">
                                </div>
                            </div>
                        </div>

                        <!-- Enti -->
                        <h6 class="mb-2">Enti:</h6>
                        <div class="row g-2">
                            <% for (Faq f : faqs) {
                                    if (f.getRisposta() == null) {
                                        soggetti.remove(f.getSoggetto());%>
                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="input-group">
                                    <a href="javascript:void(0);" onclick="showConversation(<%=f.getSoggetto().getId()%>, true)" 
                                       class="btn btn-io-n btn-icon"><i class="fa fa-comment"></i></a>
                                    <input type="text" class="form-control" readonly value="<%=f.getSoggetto().getRagionesociale()%>">
                                    <a class="btn btn-danger btn-icon"><i class="fa fa-exclamation"></i></a>
                                </div>
                            </div>
                            <%   }
                                } %>

                            <% for (SoggettiAttuatori s : soggetti) {%>
                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="input-group">
                                    <a href="javascript:void(0);" onclick="showConversation(<%=s.getId()%>, false)" 
                                       class="btn btn-primary btn-icon"><i class="fa fa-comment"></i></a>
                                    <input type="text" class="form-control" readonly value="<%=s.getRagionesociale()%>">
                                </div>
                            </div>
                            <% }%>
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
        <script id="myFAQ" src="<%=src%>/page/mc/js/saFAQ.js<%=no_cache%>" type="text/javascript" data-context="<%=request.getContextPath()%>"></script>
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