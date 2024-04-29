
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
        <link rel="stylesheet" href="Bootstrap2024/assets/css/global.css"/>
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
    <body class="kt-header--fixed kt-header-mobile--fixed kt-subheader--fixed kt-subheader--enabled kt-subheader--solid kt-aside--enabled kt-aside--fixed">
        <div class="kt-grid kt-grid--hor kt-grid--root">
            <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--ver kt-page">
                <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor">
                    <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor">
                        <div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
                            <div class="kt-portlet kt-portlet--mobile">
                                <div class="kt-portlet__head">
                                    <div class="kt-portlet__head-label">
                                        <h3 class="kt-portlet__head-title">
                                            Modifica Conferenza:
                                        </h3>
                                    </div>
                                </div>
                                <div class="kt-portlet__body">
                                    <form id="kt_form" action="<%=request.getContextPath()%>/OperazioniMicro?type=modifyFAD" class="kt-form kt-form--label-right" accept-charset="ISO-8859-1" method="post">
                                        <input type="hidden" name="idFad" value="<%=fad.getId()%>">
                                        <div class="kt-portlet__body paddig_0_t paddig_0_b">
                                            <div class="kt-section kt-section--first">
                                                <div class="kt-section__body"><br>
                                                    <div class="row form-group">
                                                        <div class="col-lg-6 col-md-12">
                                                            <label>Nome</label><label class="kt-font-danger">*</label>
                                                            <input class="form-control obbligatory" name="name_fad" onkeydown="return blockspecialcharacter();" value="<%=fad.getNomestanza()%>">
                                                        </div>
                                                        <div class="col-lg-6 col-md-12">
                                                            <label>Data e ora di inizio e fine</label><label class="kt-font-danger">*</label>
                                                            <input type="text" class="form-control obbligatory" name="range" id="range"  autocomplete="off" readonly placeholder="Selezionare data e ora inizio fine" value ="<%=fad.getInizio() != null ? sdf.format(fad.getInizio()) + " - " + sdf.format(fad.getFine()) : ""%>">
                                                        </div>
                                                    </div>
                                                    <div class="row form-group-marginless">
                                                        <div class="col-lg-6 col-md-12" id="paretcipant">
                                                            <label>Patecipanti</label><label class="kt-font-danger">*</label>
                                                            <%for (String s : fad.getList_partecipanti()) {%>
                                                            <div class="input-group">
                                                                <div class="input-group-prepend">
                                                                    <a class="btn btn-primary btn-icon"><i class="fa fa-at"></i></a>
                                                                </div>
                                                                <input type="text" name="email[]" class="form-control obbligatory" placeholder="Email" value="<%=s%>">
                                                                <div class="input-group-append">
                                                                    <a href="javascript:void(0);" title="Elimina" data-container="body" data-html="true" data-toggle="kt-tooltip" class="btn btn-danger btn-icon delete"><i class="fa fa-times"></i></a>
                                                                </div>
                                                            </div>
                                                            <%}%>
                                                        </div>
                                                    </div>
                                                    <div class="row col"><div class="text-right col-lg-6 col-md-12 paddig_0_r"><a id="add" href="javascript:void(0);"><i class="fa fa-plus"></i> aggiungi</a></div></div>
                                                </div>
                                                <label class="kt-font-danger kt-font-bold"><font size="2" >* Campi Obbligatori</font></label>
                                                <div class="kt-portlet__foot">
                                                    <div class="kt-form__actions">
                                                        <div class="row">
                                                            <div class="col-lg-6 kt-align-right">
                                                                <a id="submit" href="javascript:void(0);" class="btn btn-primary btn-lg"><font color='white'>Salva</font></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>	
                </div>
            </div>
        </div>
        <div id="kt_scrolltop"style="background-color: #0059b3" class="kt-scrolltop">
            <i class="fa fa-arrow-up"></i>
        </div>       
        <!--begin:: Global Mandatory Vendors -->
        <script src="<%=src%>/assets/soop/js/jquery-3.6.1.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/popper.js/dist/umd/popper.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
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
                err = checkObblFields() ? true : err;
                var email = $("input[name='email[]']");
                $.each(email, function (i, e) {
                    err = checkEmail($(e)) ? true : err;
                });
                return err;
            }
            $('#submit').on('click', function () {
                if (!ctrlForm()) {
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
                                swalSuccess("Conferenza Modificata", "Conferenza modificata con successo");
                            } else {
                                swalError("Errore!", json.message);
                            }
                        }
                    });
                }
            });

            function delete_event() {
                $("a.delete").click(function () {
                    $('[data-toggle="kt-tooltip"]').tooltip('dispose');
                    $($(this).parent()).parent().remove();
                    $('[data-toggle="kt-tooltip"]').tooltip();
                    if ($("input[name='email[]']").length == 0) {
                        $("#add").trigger("click");
                    }
                });
            }

            $("#add").click(function () {
                $("#paretcipant").append('<div class="input-group">'
                        + '<div class="input-group-prepend">'
                        + '<a class="btn btn-primary btn-icon"><i class="fa fa-at"></i></a>'
                        + '</div>'
                        + '<input type="text" name="email[]" class="form-control obbligatory" placeholder="Email">'
                        + '<div class="input-group-append">'
                        + '<a title="Elimina" data-container="body" data-html="true" data-toggle="kt-tooltip" href="javascript:void(0);" class="btn btn-danger btn-icon delete"><i class="fa fa-times"></i></a>'
                        + '</div>'
                        + '</div>');
                $('[data-toggle="kt-tooltip"]').tooltip();
                delete_event();
            });


            function blockspecialcharacter(e) {
                e = (e) ? e : window.event;
                var key = document.all ? key = e.keyCode : key = e.which;
                return ((key > 64 && key < 91) || (key > 96 && key < 123) || key == 8 || key == 32 || "0123456789".includes(e.key) || "èéòàù".includes(e.key));
            }

            var days = ["Do", "Lu", "Ma", "Me", "Gi", "Ve", "Sa"];
            var months = ["Gennaio", "Febbraio", "Marzo", "April", "Maggio", "Giugno", "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre"];

            jQuery(document).ready(function () {
                $('#range').daterangepicker({
                    timePicker: true,
                    autoApply: true,
                    timePickerIncrement: 5,
                    locale: {
                        firstDay: 1,
                        format: 'DD/MM/YYYY HH:mm',
                        daysOfWeek: days,
                        monthNames: months,
                    }
                });
                delete_event();
            });

        </script>
    </body>
</html>
<%
        }
    }
%>