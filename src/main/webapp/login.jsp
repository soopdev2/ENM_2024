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
        <meta http-equiv="Content-Security-Policy" content="default-src * 'unsafe-inline' 'unsafe-eval'">
        <link rel="stylesheet" href="Bootstrap2024/assets/css/global.css"/>
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
        <link rel="stylesheet" href="./Bootstrap2024/assets/css/bootstrap-italia.min.css"/>
        <link href="assets/app/custom/login/login-v3.default.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/general/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/general/animate.css/animate.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/general/socicon/css/socicon.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/custom/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/custom/vendors/flaticon/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/custom/vendors/flaticon2/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendors/custom/vendors/fontawesome5/css/all.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/demo/default/base/style.bundle.css" rel="stylesheet" type="text/css" />
        <link href="resource/custom.css" rel="stylesheet" type="text/css" />
        <link href="assets/demo/default/skins/header/base/light.css" rel="stylesheet" type="text/css" />
        <link href="assets/demo/default/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
        <link href="assets/demo/default/skins/brand/light.css" rel="stylesheet" type="text/css" />
        <link href="assets/demo/default/skins/aside/light.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="assets/media/logos/favicon.ico" />
        <script src="./Bootstrap2024/assets/js/bootstrap-italia.min.js"></script>


    </head>
    <body class="kt-header--fixed kt-header-mobile--fixed kt-subheader--fixed kt-subheader--enabled kt-subheader--solid kt-aside--enabled kt-aside--fixed kt-page--loading">
        <%@include file="Bootstrap2024/index/login/Header_login.jsp" %>

        <div class="kt-grid kt-grid--ver kt-grid--root">
            <div class="kt-grid kt-grid--hor kt-grid--root  kt-login kt-login--v3 kt-login--signin" id="kt_login">
                <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor" style="background-color: white;">
                    <div class="kt-grid__item kt-grid__item--fluid kt-login__wrapper">
                        <div class="kt-login__container">

                            <hr>
                            <div class="kt-login__signin">
                                <div class="kt-login__head">
                                    <%if (Utility.demoversion) {%>
                                    <div class="kt-login__title">
                                        <img src="resource/demologo.png" alt="" height="100"/>
                                    </div>
                                    <%} else {%>
                                    <%if (Utility.test) {%>
                                    <br>
                                    <div class="kt-login__title">
                                        <img src="resource/beta.png" alt="" height="100"/>
                                    </div>
                                    <%}%>
                                    <%}%>
                                    <div class="kt-login__title" style="color: #0066CC" >Accedi</div>
                                </div>
                                <form action="Login?type=login" id="kt-form" class="kt-form" htmlEscape="true" onsubmit="return ctrlForm();" accept-charset="ISO-8859-1" method="post">
                                    <input type="hidden"
                                           name="_csrf"
                                           value="4bfd1575-3ad1-4d21-96c7-4ef2d9f86721"/>
                                    <div class="form-group">
                                        <label for="user" class="active" style="color: #0066CC" >Username</label>
                                        <input class="form-control" type="text" name="username" id="user" autocomplete="off">
                                    </div>
                                    <div class="form-group" >
                                        <label for="password" class="active" style="color: #0066CC" >Password</label>
                                        <input class="form-control" type="password" name="password" id="password" autocomplete="off">
                                    </div>
                                    <div class="row kt-login__extra">
                                        <div class="col-6 kt-align-left">
                                            <div class="col">
                                                <a href="faq.jsp" class="" style="font-size: 18px;"><b> FAQ</b></a>
                                            </div>
                                        </div>
                                        <div class="col-6 kt-align-right">
                                            <a href="javascript:;" id="kt_login_forgot" class="">Password dimenticata ?</a>
                                        </div>
                                    </div>
                                    <div class="kt-login__actions">
                                        <button id="kt_login_signin_submit" type="submit" class="btn btn-primary" style="background-color:#0066CC"  >Login</button>
                                    </div>
                                </form>
                                <form id="manform" target="_blank" htmlEscape="true"
                                      action="<%=request.getContextPath()%>/OperazioniGeneral" 
                                      method="POST">
                                    <input type="hidden"
                                           name="_csrf"
                                           value="4bfd1575-3ad1-4d21-96c7-4ef2d9f86721"/>
                                    <input type="hidden" name="type"
                                           value="onlyDownloadnew">
                                    <input type="hidden" name="path"
                                           value="<%="manualeSA"%>">
                                </form>
                                <div class="row kt-login__extra">
                                    <div class="col-12 text-center" 
                                         style="margin-top:10px;">
                                        <div class="col">
                                            <a href="" onclick="document.getElementById('manform').submit();"
                                               class="kt-login__link document"
                                               >

                                                <i class="fa fa-file-pdf kt-font-danger2"></i> 
                                                Guida all'uso della piattaforma

                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <script type="text/javascript">
                                    var img = document.getElementById('blinking_image');
                                    var interval = window.setInterval(function () {
                                        if (img.style.visibility === 'hidden') {
                                            img.style.visibility = 'visible';
                                        } else {
                                            img.style.visibility = 'hidden';
                                        }
                                    }, 500);
                                </script>

                            </div>
                            <div class="kt-login__forgot">
                                <div class="kt-login__head">
                                    <h3 class="kt-login__title" style="color: #0066CC" >Password dimenticata ?</h3>
                                    <div class="kt-login__desc">Inserisci il tuo username per effettuare il reset password:</div>
                                </div>
                                <form class="kt-form" id="kt_form_pwd" action="Login?type=forgotPwd" htmlEscape="true">
                                    <input type="hidden"
                                           name="_csrf"
                                           value="4bfd1575-3ad1-4d21-96c7-4ef2d9f86721"/>
                                    <div class="input-group">
                                        <input class="form-control" type="text" placeholder="Email O Username"  name="email" id="email" autocomplete="off">
                                    </div>
                                    <div class="kt-login__actions">
                                        <a href="jascript:void(0);" id="submit_pwd" class="btn btn-primary" style="background-color:#0066CC" ><i class="fa fa-save"></i> CONTINUA</a>&nbsp;&nbsp;
                                        <button id="kt_login_forgot_cancel" class="btn btn-warning"><i class="fa fa-arrow-left"></i> INDIETRO</button>
                                    </div>
                                </form>
                            </div>
                            <hr>

                        </div>
                    </div>
                    <%@ include file="Bootstrap2024/index/login/Footer_login.jsp"%>


                </div>
            </div>

            <!-- end:: Page -->

            <script type="text/javascript" src="assets/soop/js/jquery-3.6.1.min.js"></script>
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
            <script src="assets/soop/js/jquery-3.6.1.js" type="text/javascript"></script>
            <script src="assets/vendors/general/popper.js/dist/umd/popper.js" type="text/javascript"></script>
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