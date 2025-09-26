<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="rc.so.domain.Presenze_Lezioni"%>
<%@page import="rc.so.domain.TipoDoc"%>
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
            Entity e = new Entity();
            ProgettiFormativi p = e.getEm().find(ProgettiFormativi.class, Long.parseLong(request.getParameter("id")));
            List<LezioneCalendario> lezioniCalendario = e.getLezioniByModello(3);
            TipoDoc modello = e.getEm().find(TipoDoc.class, 2L);
            int checkStaff = (int) Utility.membriAttivi(p.getStaff_modelli());
            Lezioni_Modelli temp = null;
            ModelliPrg m3 = Utility.filterModello3(p.getModelli());
            List<Lezioni_Modelli> lezioni = m3.getLezioni();
            List<LezioneCalendario> grouppedByLezione = Utility.grouppedByLezione(lezioniCalendario);
            boolean isEditable = Utility.isEditableModel(lezioni);
            String idsedefisica = p.getSedefisica() != null ? String.valueOf(p.getSedefisica().getId()) : "";
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Modello 3</title>
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
 <link href="../../Bootstrap2024/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />

    </head>


    <body class="d-flex flex-column min-vh-100">


        <!-- begin:: Page -->
        <div class="container-fluid">
            <!-- Modello 3 - Calendario -->
            <div id="kt_content">
                <div class="card mb-3">
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-4">
                                <h5>
                                    Modello 3 - Calendario
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
                            </div>
                            <div class="col-8 text-end">
                                <% if (!m3.getStato().equalsIgnoreCase("OK")) { %>
                                <div class="btn-group" role="group">
                                    <button id="deleteBy" disabled class="btn btn-danger">Elimina da una data lezione</button>
                                    <button id="deleteAll" disabled class="btn btn-danger">Elimina tutte le lezioni</button>
                                </div>
                                <% } %>
                            </div>
                        </div>

                        <div class="alert alert-info">
                            <i class="fa fa-info-circle"></i> N.B. Prima di caricare il modello è necessario controllare attentamente che le informazioni riportate nel modello siano le medesime dei calendari (data, ora, docenti).
                        </div>

                        <% String esito = (String) session.getAttribute("esito3");
                    if (esito != null && !esito.trim().equals("") && !esito.trim().equals("OK")) {%>
                        <div class="alert alert-danger"><%=esito%></div>
                        <% } %>

                        <div class="row g-3">
                            <% for (LezioneCalendario lez : grouppedByLezione) {
                            temp = Utility.lezioneFiltered(lezioni, lez.getId()); %>
                            <div class="col-lg-2 col-md-4 col-sm-6 text-center mb-3">
                                <% if (lez.isDoppia()) {%>
                                <a href="javascript:void(0)" id="a_lez<%=lez.getLezione()%>" onclick="uploadLezioneDouble(<%=p.getId()%>,<%=m3.getId()%>,<%=lez.getLezione()%>)">
                                    <i id="mainIcon_<%=lez.getLezione()%>" class="fa fa-file-invoice" style="font-size: 100px;"></i>
                                </a>
                                <% } else { %>
                                <% if (temp == null) {%>
                                <a href="javascript:void(0)" id="a_lez<%=lez.getLezione()%>" onclick="uploadLezione(<%=p.getId()%>, <%=m3.getId()%>, <%=lez.getLezione()%>, '<%=lez.getUd1()%>', '<%=idsedefisica%>')">
                                    <i id="mainIcon_<%=lez.getLezione()%>" class="fa fa-file-invoice" style="font-size: 100px;"></i>
                                </a>
                                <% } else {%>
                                <a href="javascript:void(0)" id="a_lez<%=lez.getLezione()%>" onclick="lezioniSingle(<%=lez.getId()%>, <%=lez.getLezione()%>)">
                                    <i class="fa fa-file-invoice" style="font-size: 100px;"></i>
                                </a>
                                <% if (!temp.getTipolez().equals("F")) {
                                            Presenze_Lezioni pl1 = e.getPresenzeLezione(temp.getId());
                                            String btn = pl1 == null ? "btn-primary" : "btn-success";%>
                                <a href="calendar.jsp?idcalendar=<%=temp.getId()%>" class="btn btn-sm <%=btn%>" data-toggle="tooltip" title="INSERISCI/VISUALIZZA REGISTRO PRESENZE">
                                    <i class="fa fa-calendar-alt" style="font-size: 20px;"></i>
                                </a>
                                <% } %>
                                <% } %>
                                <% }%>

                                <div class="mt-2">
                                    <h6>Modulo <%=lez.getUd1()%> <% if (temp != null && temp.getTipolez().equals("F")) { %> (FAD) <% } %></h6>
                                </div>
                            </div>
                            <% } %>
                        </div>

                        <% if (Utility.demoversion) {%>
                        <a href="<%=request.getContextPath()%>/OperazioniSA?type=simulacalendario&modello=3&idpr=<%=p.getId()%>&idmodello=<%=m3.getId()%>" class="btn btn-dark mb-3">
                            <i class="fa fa-user"></i> SIMULA INSERIMENTO CALENDARIO
                        </a>
                        <% } %>

                        <% if (m3.getStato().equals("R")) { %>
                        <% if (checkStaff < 2) { %>
                        <div class="alert alert-warning">
                            <h5>Membri Staff - Soggetto Esecutore per accesso alla FAD (Fase A - Fase B)</h5>
                            <p>Attenzione, si ricorda che l'inserimento dei membri può essere effettuato solamente prima del caricamento del modello 3.</p>
                        </div>
                        <% }%>

                        <div class="mb-3">
                            <form action="<%=request.getContextPath()%>/OperazioniSA" method="POST" target="_blank">
                                <input type="hidden" name="type" value="scaricamodello3" />
                                <input type="hidden" name="idpr" value="<%=StringEscapeUtils.escapeHtml4(request.getParameter("id"))%>" />
                                <button type="submit" class="btn btn-primary mb-2">Scarica</button>
                            </form>

                            <form action="<%=request.getContextPath()%>/OperazioniSA" method="POST" enctype="multipart/form-data">
                                <input type="hidden" name="type" value="salvamodello3" />
                                <input type="hidden" name="idpr" value="<%=StringEscapeUtils.escapeHtml4(request.getParameter("id"))%>" />
                                <input type="hidden" name="idmodello" value="<%=m3.getId()%>" />
                                <div class="mb-3">
                                    <input type="file" required class="form-control" name="doc_<%=modello.getId()%>" accept="<%=modello.getMimetype()%>" onchange="return checkFileExtAndDim('<%=modello.getEstensione()%>');">
                                </div>
                                <button type="submit" class="btn btn-primary">Carica Modello 3</button>
                            </form>
                        </div>
                        <% } %>

                        <% if (p.getStato().getId().equalsIgnoreCase("ATA") && isEditable) { %>
                        <div class="text-center mt-3">
                            <p>Un'eventuale modifica del calendario comporterebbe il passaggio del progetto nello step precedente, con conseguente generazione di un nuovo Modello 3 da firmare digitalmente e caricare sulla piattaforma.</p>
                            <button id="revert" disabled class="btn btn-danger">Modifica calendario</button>
                        </div>
                        <% }%>
                    </div>
                </div>
            </div>
        </div>





        <div id="kt_scrolltop" style="background-color: #0059b3" class="kt-scrolltop">
            <i class="fa fa-arrow-up"></i>
        </div>
        <script src="<%=src%>/assets/vendors/general/jquery/dist/jquery.js" type="text/javascript"></script>
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
          <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
        <!--this page -->
        <script src="<%=src%>/assets/vendors/general/select2/dist/js/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-select/dist/js/bootstrap-select.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-timepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-timepicker/js/bootstrap-timepicker.js" type="text/javascript"></script>
        <input type="hidden" id="systemtype" value="<%=Utility.iswindows()%>" />
        <script id="modello3" defer src="<%=src%>/page/sa/js/modello3.js" data-context="<%=request.getContextPath()%>" type="text/javascript"></script>
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
