
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.domain.CPI"%>
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
            Entity e = new Entity();
            List<CPI> cpi = e.listaCPI();
            e.close();
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Crea Utente CPI</title>
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
        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
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

        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
        <style>
            .ui-datepicker-other-month.ui-state-disabled:not(.my_class) span{
                color: red;
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
                        <div class="card mb-3">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Crea Utente CPI</h5>
                                <a href="#" class="btn btn-sm btn-light" data-bs-toggle="collapse" data-bs-target="#formCpiBody" aria-expanded="true">
                                    <i class="la la-angle-down"></i>
                                </a>
                            </div>
                            <div class="card-body collapse show" id="formCpiBody">
                                <form id="kt_form" action="<%=request.getContextPath()%>/OperazioniMicro?type=addCpiUser" method="post" accept-charset="ISO-8859-1">
                                    <div class="row g-3">
                                        <div class="col-xl-4 col-lg-6">
                                            <label for="nome" class="form-label">Nome <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control obbligatory" name="nome" id="nome">
                                        </div>
                                        <div class="col-xl-4 col-lg-6">
                                            <label for="cognome" class="form-label">Cognome <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control obbligatory" name="cognome" id="cognome">
                                        </div>
                                        <div class="col-xl-4 col-lg-6">
                                            <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                                            <input type="email" class="form-control obbligatory" name="email" id="email">
                                        </div>
                                        <div class="col-xl-4 col-lg-6">
                                            <label for="cpi" class="form-label">CPI <span class="text-danger">*</span></label>
                                            <select class="form-select obbligatory" id="cpi" name="cpi">
                                                <option value="-">Seleziona CPI</option>
                                                <% for (CPI c : cpi) {%>
                                                <option value="<%=c.getId()%>"><%=c.getDescrizione()%></option>
                                                <% }%>
                                            </select>
                                        </div>
                                    </div>
                                    <small class="text-danger mt-2 d-block">* Campi obbligatori</small>
                                    <div class="mt-3 d-flex justify-content-end gap-2">
                                        <button type="submit" class="btn btn-primary">Salva</button>
                                        <a href="<%=StringEscapeUtils.escapeHtml4(pageName_)%>" class="btn btn-warning">Reset</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </main>
        <%@include file="../../Bootstrap2024/index/login/Footer_login.jsp" %>

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
        <script src="<%=src%>/assets/vendors/general/select2/dist/js/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
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
                        }};
        </script>
        <script>
            $("#email").change(function () {
                verifyEmail($(this));
            });

            function verifyEmail(email) {
                var err = checkEmail(email);
                if (!err) {
                    $.ajax({
                        type: 'POST',
                        async: false,
                        url: "<%=request.getContextPath() + "/Login"%>",
                        data: {"type": "checkEmailUser", "email": email.val()},
                        success: function (resp) {
                            console.log(resp);
                            if (resp != null && resp != "null") {
                                email.attr("class", "form-control is-invalid");
                                fastSwal("Email gi&agrave; presente", "chiudi", "wooble");
                                err = true;
                            }
                        }
                    });
                }
                return err;
            }

            function ctrlForm() {
                var err = checkObblFieldsContent($("#kt_form"));
                err = verifyEmail($("#email")) ? true : err;
                return err;
            }

            $("#submit").click(function () {
                submitForm($("#kt_form"), "Utente CPI Creato!", "Operazione effettuata con successo.", !ctrlForm(), true);
            });
        </script>
    </body>
</html>
<%
        }
    }
%>