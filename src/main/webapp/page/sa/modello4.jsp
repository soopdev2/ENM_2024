<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.LinkedList"%>
<%@page import="rc.so.domain.TipoDoc"%>
<%@page import="java.util.Date"%>
<%@page import="rc.so.domain.Allievi"%>
<%@page import="rc.so.domain.Lezioni_Modelli"%>
<%@page import="rc.so.domain.ModelliPrg"%>
<%@page import="java.util.Map"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.domain.LezioneCalendario"%>
<%@page import="rc.so.domain.ProgettiFormativi"%>
<%@page import="rc.so.domain.SoggettiAttuatori"%>
<%@page import="rc.so.db.Action"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="rc.so.db.Entity"%>
<%@page import="rc.so.entity.Item"%>
<%@page import="rc.so.domain.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User us = (User) session.getAttribute("user");
    if (us == null) {
    } else {
        String uri_ = request.getRequestURI();
        String pageName_ = uri_.substring(uri_.lastIndexOf("/") + 1);
        if (!Action.isVisibile(String.valueOf(us.getTipo()), pageName_)) {
            response.sendRedirect(request.getContextPath() + "/page_403.jsp");
        } else {
            String src = Utility.checkAttribute(session, "src");
            Lezioni_Modelli temp = null;
            int maxGruppi = 12;
            Entity e = new Entity();
            ProgettiFormativi p = e.getEm().find(ProgettiFormativi.class, Long.parseLong(request.getParameter("id")));
            TipoDoc modello = e.getEm().find(TipoDoc.class, 6L);
            List<LezioneCalendario> lezioniCalendario = e.getLezioniByModello(4);
            ModelliPrg m4 = Utility.filterModello4(p.getModelli());
            int gruppi = !m4.getStato().equalsIgnoreCase("S") ? Utility.numberGroupsModello4(p)
                    : (Utility.maxGroupsCreation(p) < maxGruppi ? Utility.maxGroupsCreation(p) : maxGruppi);
            String disG = m4.getStato().equalsIgnoreCase("S") ? "" : "disabled='true'";
            List<Lezioni_Modelli> lezioni = m4.getLezioni();
            List<LezioneCalendario> grouppedByLezione = Utility.grouppedByLezione(lezioniCalendario);
            boolean isEditable = Utility.isEditableModel(lezioni);
            String idsedefisica = p.getSedefisica() != null ? String.valueOf(p.getSedefisica().getId()) : "";
            e.close();
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Modello 4</title>
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
        <link href="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
        <!-- - -->
        <link href="<%=src%>/assets/vendors/general/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/owl.carousel/dist/assets/owl.carousel.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/owl.carousel/dist/assets/owl.theme.default.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon2/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/fontawesome5/css/all.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-timepicker/css/bootstrap-timepicker.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/animate.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/assets/demo/default/skins/header/base/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/brand/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/aside/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/base/style.bundle.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/custom.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
        <link href="../../Bootstrap2024/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

    </head>
    <!-- begin:: Page -->
    <body class="d-flex flex-column min-vh-100">

        <div class="container-fluid">
            <div id="kt_content">
                <!-- Modello 4 - Gruppi -->
                <div class="card mb-3">
                    <div class="card-body">
                        <input type="hidden" id="pId" name="pId" value="<%=p.getId()%>">
                        <input type="hidden" id="m4Stato" name="m4Stato" value="<%=m4.getStato()%>">
                        <input type="hidden" id="m4Id" name="m4Id" value="<%=m4.getId()%>">
                        <input type="hidden" id="startPrg" name="startPrg" value="<%=p.getStart().getTime()%>">
                        <input type="hidden" id="endPrg" name="endPrg" value="<%=p.getEnd().getTime()%>">

                        <div class="row mb-3">
                            <div class="col-4">
                                <h5>Modello 4 - Gruppi</h5>
                            </div>
                            <div class="col-8 text-end">
                                <% if (!m4.getStato().equalsIgnoreCase("OK")) { %>
                                <div class="btn-group" role="group">
                                    <button id="deleteAll" disabled class="btn btn-danger">Elimina tutte le lezioni</button>
                                </div>
                                <% } %>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <% for (int i = 1; i <= gruppi; i++) {%>
                            <div class="col-md-6 col-lg-6">
                                <label for="param_<%=i%>">Gruppo <%=i%></label>
                                <select class="form-control obbligatory" <%=disG%> id="param_<%=i%>" name="param_<%=i%>" multiple="multiple"></select>
                            </div>
                            <% } %>
                        </div>

                        <div class="text-center mb-3">
                            <button id="createGroups" disabled style="display:none" class="btn btn-primary">
                                <i class="fa fa-users"></i> Crea gruppi
                            </button>
                        </div>

                        <% String esito = (String) session.getAttribute("esito4");
                    if (esito != null && !esito.trim().equals("") && !esito.trim().equals("OK")) {%>
                        <div class="alert alert-danger"><%=esito%></div>
                        <% } %>

                        <div id="lezioni_m4" style="display:none;">
                            <h5>
                                Modello 4 - Calendario 
                                <i class="fa fa-info-circle" 
                                   data-container="body" 
                                   data-toggle="popover" 
                                   data-html="true"
                                   data-placement="bottom"
                                   data-original-title="Calendario"
                                   data-content="Eventuali variazioni, di date e docenti, dovranno essere <u>preventivamente e tempestivamente</u> comunicate all'ENM tramite apposita funzionalità della piattaforma.
                                   <b>Le modifiche saranno autorizzate mediante aggiornamento del calendario corso validato presente in piattaforma.</b>">
                                </i>
                            </h5>

                            <div class="alert alert-info">
                                <i class="fa fa-info-circle"></i> N.B. Prima di caricare il modello è necessario controllare attentamente che le informazioni riportate nel modello siano le medesime dei calendari (data, ora, docenti).
                            </div>

                            <% if (!m4.getStato().equalsIgnoreCase("OK")) { %>
                            <div class="alert alert-warning">
                                <h5>Caricamento Calendario modello 4</h5>
                                <p>N.B. se il caricamento del calendario avviene dopo le ore 12:00 nell'ultima giornata di Fase A NON sarà possibile far partire la fase B il giorno successivo, ma bisognerà attendere un ulteriore giorno.</p>
                            </div>
                            <% } %>

                            <% for (int i = 1; i <= gruppi; i++) {%>
                            <div class="row mb-2">
                                <div class="col-4">
                                    <h5><i class="fa fa-users"></i> Gruppo <%=i%></h5>
                                </div>
                                <div class="col-8 text-end">
                                    <% if (!m4.getStato().equalsIgnoreCase("OK")) {%>
                                    <div class="btn-group" role="group">
                                        <button id="deleteByGroup_<%=i%>" disabled class="btn btn-danger">Elimina da una data lezione</button>
                                        <button id="deleteAllGroup_<%=i%>" disabled class="btn btn-danger">Elimina tutte le lezioni</button>
                                    </div>
                                    <% } %>
                                </div>
                            </div>

                            <div class="row g-3 mb-3">
                                <% for (LezioneCalendario lez : grouppedByLezione) {
                                    temp = Utility.lezioneFilteredByGroup(lezioni, lez.getId(), i); %>
                                <div class="col-lg-2 col-md-4 col-sm-6 text-center">
                                    <% if (lez.isDoppia()) {%>
                                    <a href="javascript:void(0)" id="a_lez<%=lez.getLezione()%>_<%=i%>" onclick="uploadLezioneDouble(<%=p.getId()%>,<%=m4.getId()%>,<%=lez.getLezione()%>, <%=i%>)">
                                        <i id="mainIcon_<%=lez.getLezione()%>_<%=i%>" class="fa fa-file-invoice" style="font-size:100px;"></i>
                                    </a>
                                    <% } else { %>
                                    <% if (temp == null) {%>
                                    <a href="javascript:void(0)" id="a_lez<%=lez.getLezione()%>_<%=i%>" onclick="uploadLezione(<%=p.getId()%>, <%=m4.getId()%>, <%=lez.getLezione()%>, <%=i%>, '<%=lez.getUd1()%>', '<%=idsedefisica%>')">
                                        <i id="mainIcon_<%=lez.getLezione()%>_<%=i%>" class="fa fa-file-invoice" style="font-size:100px;"></i>
                                    </a>
                                    <% } else {%>
                                    <a href="javascript:void(0)" id="a_lez<%=lez.getLezione()%>_<%=i%>" onclick="lezioniSingle(<%=lez.getId()%>, <%=lez.getLezione()%>, <%=i%>, '<%=lez.getUd1()%>', '<%=idsedefisica%>')">
                                        <i class="fa fa-file-invoice" style="font-size:100px;"></i>
                                    </a>
                                    <% } %>
                                    <% }%>

                                    <div class="mt-2">
                                        <h6>Modulo <%=lez.getUd1()%></h6>
                                    </div>
                                </div>
                                <% } %>
                            </div>

                            <% if (i != gruppi) { %>
                            <hr>
                            <% } %>
                            <% } %>

                            <% if (m4.getStato().equals("R")) {%>
                            <div class="mt-3">
                                <form action="<%=request.getContextPath()%>/OperazioniSA" method="POST" target="_blank" class="mb-2">
                                    <input type="hidden" name="type" value="scaricamodello4" />
                                    <input type="hidden" name="idpr" value="<%=StringEscapeUtils.escapeHtml4(request.getParameter("id"))%>" />
                                    <button type="submit" class="btn btn-primary">Scarica</button>
                                </form>

                                <form action="<%=request.getContextPath()%>/OperazioniSA" method="POST" enctype="multipart/form-data">
                                    <input type="hidden" name="type" value="salvamodello4" />
                                    <input type="hidden" name="idpr" value="<%=StringEscapeUtils.escapeHtml4(request.getParameter("id"))%>" />
                                    <input type="hidden" name="idmodello" value="<%=m4.getId()%>" />
                                    <div class="mb-3">
                                        <input type="file" required class="form-control" name="doc_<%=modello.getId()%>" accept="<%=modello.getMimetype()%>" onchange="return checkFileExtAndDim('<%=modello.getEstensione()%>');">
                                    </div>
                                    <button type="submit" class="btn btn-primary"><i class="flaticon2-plus-1"></i> Carica Modello 4</button>
                                </form>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>

                <% if (p.getStato().getId().equalsIgnoreCase("ATB") && isEditable) { %>
                <div class="card mb-3">
                    <div class="card-body text-center">
                        <p>Un'eventuale modifica del calendario comporterebbe il passaggio del progetto nello step precedente, <br>
                            con conseguente generazione di un nuovo Modello 4 da firmare digitalmente e caricare sulla piattaforma.</p>
                        <button id="revert" disabled class="btn btn-danger">Modifica calendario</button>
                    </div>
                </div>
                <% }%>
            </div>
        </div>





        <div id="kt_scrolltop" style="background-color: #0059b3" class="kt-scrolltop">
            <i class="fa fa-arrow-up"></i>
        </div>
        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>

        <script src="<%=src%>/assets/vendors/general/popper.js/dist/umd/popper.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/moment.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/jquery-form/dist/jquery.form.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/components/extended/blockui1.33.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <!--this page -->
        <script src="<%=src%>/assets/vendors/general/select2/dist/js/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-select/dist/js/bootstrap-select.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-timepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-timepicker/js/bootstrap-timepicker.js" type="text/javascript"></script>
        <script id="modello4" defer src="<%=src%>/page/sa/js/modello4.js<%="?dummy=" + String.valueOf(new Date().getTime())%>" 
        data-context="<%=request.getContextPath()%>" type="text/javascript"></script>
        <input type="hidden" id="systemtype" value="<%=Utility.iswindows()%>" />
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
<%}
    }%>
