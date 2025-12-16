<%-- 
    Document   : login1
    Created on : 15-ott-2019, 10.42.32
--%>
<%@page import="rc.so.db.Entity"%>
<%@page import="rc.so.util.Utility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <%
        response.addHeader("X-Frame-Options", "SAMEORIGIN");
        Entity e = new Entity();
        String mantenance = e.getPath("mantenance");
        //String manuale = e.getPath("manualeSA");
        e.close();
        if (mantenance.equals("Y")) {
            Utility.redirect(request, response, "noService.jsp");
        }
    %>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana</title>
        <meta name="description" content="Login page example">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="_csrf" content="4bfd1575-3ad1-4d21-96c7-4ef2d9f86721"/>
        <meta name="_csrf_header" content="X-CSRF-TOKEN"/>
        <!--<meta http-equiv="Content-Security-Policy" content="default-src * 'unsafe-inline' 'unsafe-eval'">-->
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">

        <!--begin::Fonts -->
        <script src="resource/webfont.js"></script>
        <script>
            function heidiDecode(hex) {
                var str = '';
                var shift = parseInt(hex.substr(-1));
                hex = hex.substr(0, hex.length - 1);
                for (var i = 0; i < hex.length; i += 2)
                    str += String.fromCharCode(parseInt(hex.substr(i, 2), 16) - shift);
                return str;
            }

            WebFont.load({
                google: {
                    "families": ["Poppins:300,400,500,600,700", "Roboto:300,400,500,600,700", "Architects Daughter:300,400,500,600,700"]
                },
                active: function () {
                    sessionStorage.fonts = true;
                }
            });
        </script>
        <link rel="stylesheet" href="Bootstrap2024/assets/css/bootstrap.min.css"/>
        <link href="assets/app/custom/login/login-v3.default.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/general/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/general/animate.css/animate.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/general/socicon/css/socicon.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/custom/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/custom/vendors/flaticon/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/custom/vendors/flaticon2/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/custom/vendors/fontawesome5/css/all.min.css" rel="stylesheet" type="text/css" />
        <!--link href="assets/demo/default/base/style.bundle.css" rel="stylesheet" type="text/css" /-->
        <link href="resource/custom.css" rel="stylesheet" type="text/css" />

        <link rel="shortcut icon" href="assets/media/logos/favicon.ico" />


    </head>
    <body class="d-flex flex-column min-vh-100">
        <%@include file="Bootstrap2024/index/login/Header_login.jsp" %>

        <main class="flex-grow-1 d-flex align-items-center justify-content-center bg-white">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">

                        <div class="it-card-wrapper">
                            <div class="it-card">
                                <div class="it-card-header text-center">
                                    <% if (Utility.demoversion) { %>
                                    <img src="resource/demologo.png" alt="Demo" height="100"/>
                                    <% } else if (Utility.test) { %>
                                    <img src="resource/beta.png" alt="Beta" height="100"/>
                                    <% } %>
                                    <h2 class="mt-3 text-primary">Accedi</h2>
                                </div>

                                <div class="it-card-body">
                                    <form action="Login?type=login" method="post" onsubmit="return ctrlForm();">
                                        <input type="hidden" name="_csrf" value="..."/>

                                        <div class="form-group mb-3">
                                            <label for="user">Username</label>
                                            <input type="text" class="form-control" id="user" name="username" autocomplete="off">
                                        </div>
                                        <br>
                                        <div class="form-group mb-3">
                                            <label for="password">Password</label>
                                            <input type="password" class="form-control" id="password" name="password" autocomplete="off">
                                        </div>

                                        <div class="d-flex justify-content-between mb-3">
                                            <a href="faq.jsp" class="it-link">FAQ</a>
                                            <a href="javascript:;" id="kt_login_forgot" class="it-link">Password dimenticata?</a>
                                        </div>

                                        <button type="submit" class="btn btn-primary it-btn w-100">Login</button>
                                    </form>
                                </div>

                                <div class="it-card-footer text-center">
                                    <a href="javascript:void(0);" onclick="document.getElementById('manform').submit();" class="it-link">
                                        <span class="icon"><i class="fa fa-file-pdf text-danger"></i></span>
                                        Guida all'uso della piattaforma
                                    </a>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </main>

        <%@ include file="Bootstrap2024/index/login/Footer_login.jsp"%>





        <!-- end:: Page -->

        <!--begin:: Global Mandatory Vendors -->
        <script src="assets/soop/js/utility.js" type="text/javascript"></script>
        <script>
                                            function ctrlForm() {
                                                var err = false;
                                                var user = $("#user");
                                                var pass = $("#password");
                                                if (checkValue(user, false)) {
                                                    err = true;
                                                }
                                                if (checkValue(pass, false)) {
                                                    err = true;
                                                }
                                                if (err) {
                                                    $("#drop_login").trigger('click');
                                                    return false;
                                                }
                                                swal.fire({
                                                    title: 'Sto Accedendo...',
                                                    text: '',
                                                    onOpen: function () {
                                                        swal.showLoading();
                                                    }
                                                });
                                                return true;
                                            }
        </script>

        <script>
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


        <script type="text/javascript" src="assets/soop/js/jquery.fancybox.min.js"></script>
        <script type="text/javascript" src="assets/soop/js/fancy.js"></script>
        <script src="assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
        <script src="assets/vendors/general/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
        <script src="assets/soop/js/moment.min.js" type="text/javascript"></script>
        <script src="assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="assets/vendors/general/jquery-form/dist/jquery.form.min.js" type="text/javascript"></script>
        <script src="assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <script src="assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <script src="assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="assets/app/custom/login/login-general.js" type="text/javascript"></script>
        <script src="assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <script src="assets/vendors/base/vendors.bundle.js" type="text/javascript"></script>

        <script type="text/javascript">
            function ctrlEmail() {
                var err = true;
                var email = $('#email');
                if (checkValue(email, false)) {
                    err = false;
                }
                return err;
            }

            $("#submit_pwd").on('click', function () {
                if (ctrlEmail()) {
                    showLoad();
                    $('#kt_form_pwd').ajaxSubmit({
                        error: function () {
                            closeSwal();
                            swal.fire({
                                "title": 'Errore',
                                "text": "Riprovare, se l'errore persiste contattare il servizio clienti",
                                "type": "error",
                                cancelButtonColor: "#3a2c7a",
                                cancelButtonClass: "btn btn-io-n"
                            });
                        },
                        success: function (resp) {
                            var json = JSON.parse(resp);
                            closeSwal();
                            if (json.result) {
                                swalSuccessReload("Password cambiata con successo!", "Hai ricevuto una mail al tuo indirizzo contenente la nuova password da modificare al prossimo accesso");
                            } else {
                                $('#email').attr("class", "form-control is-invalid");
                                swal.fire({
                                    "title": '<h3><b>Errore!</b></h3>',
                                    "html": "<h5>" + json.messagge + "</h5>",
                                    "type": "error",
                                    cancelButtonClass: "btn btn-io-n"
                                });
                            }
                        }
                    });
                }
            }
            );
        </script>

        <script type="text/javascript">
            <%  String esito = request.getParameter("esito");
                if (esito == null) {
                    esito = "";
                } else if (esito.equals("KO")) {%>
        swal.fire({
            type: 'error',
            title: 'Credenziali errate',
            confirmButtonColor: '#363a90'
        });
            <%} else if (esito.equals("banned")) {%>
        swal.fire({
            type: 'error',
            title: 'Utenza bloccata',
            confirmButtonColor: '#363a90'
        });
            <%}%>

        function clickLink(link, target) {
            var a = document.createElement('a');
            a.href = link;
            a.target = target;
            document.body.appendChild(a);
            a.click();
            a.remove();
        }

        //$( document ).ready(function() {
//    alert(heidiDecode('676673756A6D6A7B7B621'));
//});



        </script>



    </body>

    <!-- end::Body -->
</html>