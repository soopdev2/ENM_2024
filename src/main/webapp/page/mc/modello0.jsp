<%-- 
    Document   : uploadDocumet
    Created on : 29-gen-2020, 12.39.45
    Author     : agodino
--%>

<%@page import="rc.so.domain.MotivazioneNO"%>
<%@page import="rc.so.domain.SoggettiAttuatori"%>
<%@page import="rc.so.domain.MaturazioneIdea"%>
<%@page import="rc.so.domain.Aspettative"%>
<%@page import="rc.so.domain.Motivazione"%>
<%@page import="rc.so.domain.Canale"%>
<%@page import="rc.so.domain.Documenti_Allievi"%>
<%@page import="rc.so.domain.TipoDoc_Allievi"%>
<%@page import="rc.so.domain.Allievi"%>
<%@page import="rc.so.domain.TipoDoc_Allievi_Pregresso"%>
<%@page import="rc.so.domain.Documenti_Allievi_Pregresso"%>
<%@page import="rc.so.domain.Allievi_Pregresso"%>
<%@page import="java.util.Date"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rc.so.domain.DocumentiPrg"%>
<%@page import="rc.so.domain.TipoDoc"%>
<%@page import="java.util.List"%>
<%@page import="rc.so.db.Entity"%>
<%@page import="rc.so.db.Action"%>
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
            Allievi a = e.getEm().find(Allievi.class, Long.parseLong(request.getParameter("id")));
            Documenti_Allievi presentemod0 = e.getModello0Allievo(a);
            List<Canale> canalecon = e.findAll(Canale.class);
            List<Motivazione> motiv = e.findAll(Motivazione.class);
            List<Aspettative> aspettat = e.findAll(Aspettative.class);
            List<MaturazioneIdea> matidea = e.findAll(MaturazioneIdea.class);
            List<MotivazioneNO> motivno = e.findAll(MotivazioneNO.class);
            List<SoggettiAttuatori> salist = e.getSoggettiAttuatori("", "", "", "", "", "", "");

%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Assegna Operatore ENM</title>
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
        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/owl.carousel/dist/assets/owl.carousel.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/owl.carousel/dist/assets/owl.theme.default.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/socicon/css/socicon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/flaticon2/flaticon.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/custom/vendors/fontawesome5/css/all.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/base/style.bundle.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/custom.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/base/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/brand/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/aside/light.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="../../Bootstrap2024/assets/css/bootstrap.min.css"/>
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">
        <link href="<%=src%>/resource/animate.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
        <!--this page-->
        <link href="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css" rel="stylesheet" type="text/css" />
        <!--fancy-->
        <link href="<%=src%>/assets/soop/css/jquery.fancybox.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="<%=src%>/assets/soop/js/jquery-3.6.1.min.js"></script>
        <script type="text/javascript" src="<%=src%>/assets/soop/js/jquery.fancybox.min.js"></script>
        <script type="text/javascript" src="<%=src%>/assets/soop/js/fancy.js"></script>
    </head>

    <body class="d-flex flex-column min-vh-100">

        <main class="container-fluid my-4">

            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card mb-3">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    Modello 0 - Pre-Iscrizione Allievo: 
                                    <b><%=a.getCognome()%> <%=a.getNome()%> (<%=a.getCodicefiscale()%>)</b>
                                </h5>
                            </div>

                            <% if (presentemod0 == null) {%>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-3"><strong>Cognome:</strong> <%=a.getCognome()%></div>
                                    <div class="col-md-3"><strong>Nome:</strong> <%=a.getNome()%></div>
                                    <div class="col-md-3"><strong>Data di Nascita:</strong> <%=Utility.sdfITA.format(a.getDatanascita())%></div>
                                    <div class="col-md-3"><strong>Codice Fiscale:</strong> <%=a.getCodicefiscale()%></div>
                                </div>
                                <hr>
                                <h6>COLLOQUIO-INTERVISTA</h6>

                                <form method="POST" action="<%=request.getContextPath()%>/OperazioniMicro">
                                    <input type="hidden" name="type" value="salvamodello0" />
                                    <input type="hidden" name="idallievo" value="<%=a.getId()%>" />

                                    <div class="row mb-3">
                                        <div class="col-md-3"><strong>DATA COLLOQUIO:</strong> <%=Utility.sdfITA.format(new Date())%></div>
                                        <div class="col-md-3"><strong>SIGLA OPERATORE ENM:</strong> <%=us.getSiglaenm()%></div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Modalità di svolgimento del colloquio</label>
                                            <select class="form-select" name="tos_m0_modalitacolloquio" required>
                                                <option value="">Seleziona Risposta</option>
                                                <option value="1">IN PRESENZA</option>
                                                <option value="2">TELEFONICO</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Grado di conoscenza del percorso YISU</label>
                                            <select class="form-select" name="tos_m0_gradoconoscenza" required>
                                                <option value="">Seleziona Risposta</option>
                                                <option value="1">ALTO</option>
                                                <option value="2">MEDIO</option>
                                                <option value="3">SCARSO</option>
                                                <option value="4">NULLO</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Attraverso quale canale è venuto a conoscenza del progetto?</label>
                                            <select class="form-select" name="tos_m0_canaleconoscenza" required>
                                                <option value="">Seleziona Risposta</option>
                                                <% for (Canale c1 : canalecon) {%>
                                                <option value="<%=c1.getId()%>"><%=c1.getDescrizione()%></option>
                                                <% } %>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Motivazione principale a frequentare YISU-Toscana</label>
                                            <select class="form-select" name="tos_m0_motivazione" required>
                                                <option value="">Seleziona Risposta</option>
                                                <% for (Motivazione c1 : motiv) {%>
                                                <option value="<%=c1.getId()%>"><%=c1.getDescrizione()%></option>
                                                <% } %>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Quanto ritiene utile il percorso YISU?</label>
                                            <select class="form-select" name="tos_m0_utilita" required>
                                                <option value="">Seleziona Risposta</option>
                                                <option value="1">PER NULLA UTILE</option>
                                                <option value="2">POCO UTILE</option>
                                                <option value="3">UTILE</option>
                                                <option value="4">ABBASTANZA UTILE</option>
                                                <option value="5">MOLTO UTILE</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Cosa si aspetta frequentando YISU?</label>
                                            <select class="form-select" name="tos_m0_aspettative" required>
                                                <option value="">Seleziona Risposta</option>
                                                <% for (Aspettative c1 : aspettat) {%>
                                                <option value="<%=c1.getId()%>"><%=c1.getDescrizione()%></option>
                                                <% } %>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Maturazione idea di impresa/attività</label>
                                            <select class="form-select" name="tos_m0_maturazione" required>
                                                <option value="">Seleziona Risposta</option>
                                                <% for (MaturazioneIdea c1 : matidea) {%>
                                                <option value="<%=c1.getId()%>"><%=c1.getDescrizione()%></option>
                                                <% }%>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Indirizzo email</label>
                                            <input class="form-control" name="tos_mail" value="<%=a.getEmail()%>" />
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Conferma volontà di frequentare YISU</label>
                                            <select class="form-select" name="tos_m0_volonta" onchange="return changesino();" required>
                                                <option value="">Seleziona Risposta</option>
                                                <option value="1">SI</option>
                                                <option value="0">NO</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row mb-3" id="div_volontasi">
                                        <div class="col-md-6">
                                            <label class="form-label">Soggetto Esecutore</label>
                                            <select class="form-select" name="soggetto">
                                                <% for (SoggettiAttuatori c1 : salist) {%>
                                                <option value="<%=c1.getId()%>"><%=c1.getRagionesociale()%> <%=e.getProvinceSediFormazione(c1)%></option>
                                                <% } %>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Consapevole delle assenze?</label>
                                            <select class="form-select" name="tos_m0_consapevole">
                                                <option value="0">Inapplicabile</option>
                                                <option value="1">SI</option>
                                                <option value="2">NO</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row mb-3" id="div_volontano">
                                        <div class="col-md-6">
                                            <label class="form-label">Se NO, perché?</label>
                                            <select class="form-select" name="tos_m0_noperche" onchange="return changealtro();">
                                                <% for (MotivazioneNO c1 : motivno) {%>
                                                <option value="<%=c1.getId()%>"><%=c1.getDescrizione()%></option>
                                                <% } %>
                                            </select>
                                        </div>
                                        <div class="col-md-6" id="div_altrospec">
                                            <label class="form-label">Specificare Altro:</label>
                                            <input class="form-control" name="tos_m0_noperchealtro" autocomplete="off">
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Note ENM</label>
                                        <textarea class="form-control" name="tos_m0_note" autocomplete="off"></textarea>
                                    </div>

                                    <div class="d-flex justify-content-start">
                                        <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> SALVA DATI</button>
                                    </div>
                                </form>
                            </div>
                            <% } else {%>
                            <div class="card-body d-flex flex-column gap-2">
                                <form action="<%=request.getContextPath()%>/OperazioniGeneral" method="POST" target="_blank">
                                    <input type="hidden" name="type" value="onlyDownload" />
                                    <input type="hidden" name="path" value="<%=presentemod0.getPath()%>" />
                                    <button type="submit" class="btn btn-success"><i class="fa fa-file-pdf"></i> SCARICA MODELLO 0</button>
                                </form>

                                <form action="<%=request.getContextPath()%>/OperazioniGeneral" method="POST">
                                    <input type="hidden" name="type" value="sendmailModello0" />
                                    <input type="hidden" name="idallievo" value="<%=a.getId()%>" />
                                    <input type="hidden" name="maildest" value="<%=a.getEmail()%>" />
                                    <input type="hidden" name="path" value="<%=presentemod0.getPath()%>" />
                                    <button type="submit" class="btn btn-primary"><i class="fa fa-file-pdf"></i> INVIA MODELLO 0 AL DISCENTE</button>
                                </form>
                            </div>
                            <% } %>

                            <% if (Utility.getRequestValue(request, "esito").equals("OK")) { %>
                            <div class="alert alert-success m-3">OPERAZIONE COMPLETATA CON SUCCESSO!</div>
                            <% } %>
                            <% if (Utility.getRequestValue(request, "esito").equals("KO")) { %>
                            <div class="alert alert-danger m-3">ERRORE DURANTE L'OPERAZIONE! RIPROVARE.</div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>


        </main> 
        <%e.close();%>
       
        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/popper.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/moment.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/jquery-form/dist/jquery.form.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/jquery-validation/dist/jquery.validate.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/jquery-validation/dist/additional-methods.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/components/extended/blockui1.33.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <!--this page-->
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
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
                                function changesino() {

                                    try {
                                        var sino = $('#tos_m0_volonta').val();
                                        if (sino === "") {
                                            document.getElementById("div_volontasi").style.display = "none";
                                            document.getElementById("div_volontano").style.display = "none";

                                        } else if (sino === "1") {
                                            document.getElementById("div_volontasi").style.display = "";
                                            document.getElementById("div_volontano").style.display = "none";
                                        } else {
                                            document.getElementById("div_volontasi").style.display = "none";
                                            document.getElementById("div_volontano").style.display = "";

                                        }
                                    } catch (e) {
                                        console.error(e);
                                    }




                                }
                                function changealtro() {

                                    try {
                                        var noper = $('#tos_m0_noperche').val();
                                        if (noper === "7") {
                                            document.getElementById("div_altrospec").style.display = "";
                                        } else {
                                            document.getElementById("div_altrospec").style.display = "none";
                                        }
                                    } catch (e) {
                                        console.error(e);
                                    }
                                }

                                jQuery(document).ready(function () {
                                    changesino();
                                    changealtro();
                                });
        </script>
    </body>
</html>
<%}
    }%>