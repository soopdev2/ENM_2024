<%@page import="rc.so.domain.Presenze_Lezioni_Allievi"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rc.so.domain.Presenze_Lezioni"%>
<%@page import="rc.so.domain.Allievi"%>
<%@page import="rc.so.domain.Docenti"%>
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
            Lezioni_Modelli lm = e.getEm().find(Lezioni_Modelli.class, Long.parseLong(request.getParameter("idcalendar")));

            ProgettiFormativi p = lm.getModello().getProgetto();

            //  String idsedefisica = p.getSedefisica() != null ? String.valueOf(p.getSedefisica().getId()) : "";
            Presenze_Lezioni pl1 = e.getPresenzeLezione(lm);
            List<Presenze_Lezioni_Allievi> pa1 = new ArrayList<>();
            boolean modify = (pl1 == null);

            if (pl1 != null) {
                pa1 = e.getpresenzelezioniGiornata(pl1);
            }

            e.close();
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Registro presenze</title>
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
        <link href="<%=src%>/assets/raf/jquery-confirm.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/resource/custom.css" rel="stylesheet" type="text/css" />
        <link href="../../Bootstrap2024/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />

    </head>


    <body class="d-flex flex-column min-vh-100">
        <!-- begin:: Page -->


        <main class="container-fluid my-4">

            <div class="container-fluid">

                <div class="card mb-3">
                    <div class="card-body">

                        <h5>
                            <a href="modello3.jsp?id=<%=p.getId()%>" class="btn btn-light btn-sm" data-bs-toggle="tooltip" data-bs-placement="top" title="TORNA INDIETRO">
                                <i class="fa fa-arrow-left"></i>
                            </a>
                            REGISTRO PRESENZE LEZIONE <%=Utility.sdfITA.format(lm.getGiorno())%> - 
                            <%=lm.getLezione_calendario().getUnitadidattica().getCodice()%> 
                            (<%=lm.getLezione_calendario().getUnitadidattica().getDescrizione()%>)
                        </h5>

                        <% if (modify) {%>
                        <form action="<%=request.getContextPath()%>/OperazioniSA" method="POST" target="_blank" class="mb-3">
                            <input type="hidden" name="type" value="SCARICAREGISTROCARTACEOBASE" />
                            <input type="hidden" name="idcalendar" value="<%=lm.getId()%>" />
                            <button type="submit" class="btn btn-primary btn-sm">
                                <i class="fa fa-file-download"></i> SCARICA REGISTRO CARTACEO DA COMPILARE
                            </button>
                        </form>
                        <% } %>

                        <% String esito = (String) session.getAttribute("esito3");
                            if (esito != null && !esito.trim().equals("") && !esito.trim().equals("OK")) {%>
                        <div class="alert alert-danger">
                            <%=esito%>
                        </div>
                        <% }%>

                        <form action="<%=request.getContextPath()%>/OperazioniSA" method="POST" enctype="multipart/form-data">
                            <input type="hidden" name="type" value="SALVAPRESENZELEZIONE" />
                            <input type="hidden" name="idpr" value="<%=p.getId()%>" />
                            <input type="hidden" name="idcalendar" value="<%=lm.getId()%>" />
                            <input type="hidden" id="orastandardlezione" value="<%=lm.getLezione_calendario().getOre()%>"/>

                            <div class="row mb-3">
                                <label class="col-md-2 col-form-label fw-bold text-danger">ORA INIZIO</label>
                                <div class="col-md-4">
                                    <% if (modify) {%>
                                    <select class="form-select" id="orai" name="orai" required onchange="return populatedatafine(this);">
                                        <option value="<%=lm.getOrainizio()%>" selected><%=lm.getOrainizio()%></option>
                                        <% String[] orari = {"08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30",
                                                "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30",
                                                "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00"};
                                            for (String o : orari) {%>
                                        <option value="<%=o%>"><%=o%></option>
                                        <% } %>
                                    </select>
                                    <% } else {%>
                                    <span class="fw-bold"><%=pl1.getOrainizio()%></span>
                                    <% } %>
                                </div>

                                <label class="col-md-2 col-form-label fw-bold text-danger">ORA FINE</label>
                                <div class="col-md-4">
                                    <% if (modify) {%>
                                    <select class="form-select" id="oraf" name="oraf" required>
                                        <option value="<%=lm.getOrafine()%>" selected><%=lm.getOrafine()%></option>
                                    </select>
                                    <% } else {%>
                                    <span class="fw-bold"><%=pl1.getOrafine()%></span>
                                    <% } %>
                                </div>
                            </div>

                            <hr>

                            <div class="row mb-3">
                                <label class="col-md-2 col-form-label fw-bold text-danger">DOCENTE</label>
                                <div class="col-md-4">
                                    <% if (modify) {%>
                                    <select class="form-select" id="docente" name="docente" required>
                                        <option selected value="<%=lm.getDocente().getId()%>">
                                            <%=lm.getDocente().getCognome()%> <%=lm.getDocente().getNome()%> - <%=lm.getDocente().getCodicefiscale()%>
                                        </option>
                                    </select>
                                    <% } else {%>
                                    <span class="fw-bold"><%=pl1.getDocente().getCognome()%> <%=pl1.getDocente().getNome()%> - <%=pl1.getDocente().getCodicefiscale()%></span>
                                    <% } %>
                                </div>
                            </div>

                            <hr>

                            <div class="row mb-3">
                                <label class="col-md-2 col-form-label fw-bold text-danger">ALLIEVI</label>
                                <div class="col-md-10">
                                    <table class="table table-hover table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Cognome e Nome</th>
                                                <th>Codice Fiscale</th>
                                                <th>Presenza SI/NO</th>
                                                <th>Orario Ingresso/Uscita</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (Allievi a1 : Utility.estraiAllieviOK(p)) {
                                                    boolean modifyallievo = false;
                                                    String allievo_presente = "0";
                                                    String allievo_orai = "";
                                                    String allievo_oraf = "";
                                                    for (Presenze_Lezioni_Allievi pla : pa1) {
                                                        if (pla.getAllievo().getId().equals(a1.getId())) {
                                                            modifyallievo = true;
                                                            allievo_presente = pla.getDurata() > 0 ? "1" : "0";
                                                            allievo_orai = pla.getOrainizio();
                                                            allievo_oraf = pla.getOrafine();
                                                        }
                                                    }
                                            %>
                                        <input type="hidden" id="modify_<%=a1.getId()%>" name="modify_<%=a1.getId()%>" value="<%=modifyallievo%>" />
                                        <input type="hidden" id="startoi_<%=a1.getId()%>" value="<%=allievo_orai%>" />
                                        <input type="hidden" id="startof_<%=a1.getId()%>" value="<%=allievo_oraf%>" />
                                        <tr>
                                            <td><%=a1.getCognome()%> <%=a1.getNome()%></td>
                                            <td><%=a1.getCodicefiscale()%></td>
                                            <td>
                                                <% if (modify) {%>
                                                <select class="form-select" id="sino_<%=a1.getId()%>" name="sino_<%=a1.getId()%>" required onchange="return checkorariomax();">
                                                    <option value="1" <%= allievo_presente.equals("1") ? "selected" : ""%>>SI</option>
                                                    <option value="0" <%= allievo_presente.equals("0") ? "selected" : ""%>>NO</option>
                                                </select>
                                                <% } else {%>
                                                <span class="fw-bold"><%=allievo_presente.equals("1") ? "SI" : "NO"%></span>
                                                <% } %>
                                            </td>
                                            <td class="row g-2">
                                                <div class="col-md-6">
                                                    <% if (modify) {%>
                                                    <select class="form-select sel-presenza" id="orai_<%=a1.getId()%>" name="orai_<%=a1.getId()%>" required>
                                                        <option value="<%=lm.getOrainizio()%>" selected><%=lm.getOrainizio()%></option>
                                                    </select>
                                                    <% } else if (allievo_presente.equals("1")) {%>
                                                    <span class="fw-bold"><%=allievo_orai%></span>
                                                    <% } %>
                                                </div>
                                                <div class="col-md-6">
                                                    <% if (modify) {%>
                                                    <select class="form-select sel-presenza" id="oraf_<%=a1.getId()%>" name="oraf_<%=a1.getId()%>" required>
                                                        <option value="<%=lm.getOrafine()%>" selected><%=lm.getOrafine()%></option>
                                                    </select>
                                                    <% } else if (allievo_presente.equals("1")) {%>
                                                    <span class="fw-bold"><%=allievo_oraf%></span>
                                                    <% } %>
                                                </div>
                                            </td>
                                        </tr>
                                        <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <% if (modify) { %>
                            <div class="mb-3">
                                <label class="form-label">REGISTRO PRESENZE FIRMATO DIGITALMENTE</label>
                                <input type="file" class="form-control" name="registrofirmato" id="registrofirmato" accept="application/pkcs7-mime,application/pdf" required onchange="return checkFileExtAndDim('pdf,p7m');">
                            </div>
                            <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> SALVA DATI</button>
                        </form>
                        <% } else {%>
                        </form>
                        <form action="<%=request.getContextPath()%>/OperazioniSA" method="POST" target="_blank">
                            <input type="hidden" name="type" value="SCARICAREGISTROCARTACEO" />
                            <input type="hidden" name="idpresenza" value="<%=pl1.getIdpresenzelezioni()%>" />
                            <button type="submit" class='btn btn-success'><i class="fa fa-file-download"></i> SCARICA REGISTRO FIRMATO DIGITALMENTE</button>
                        </form>
                        <% }%>

                    </div>
                </div>

            </div>
        </main>




        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/popper.js" type="text/javascript"></script>
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
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-select/dist/js/bootstrap-select.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-timepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap-timepicker/js/bootstrap-timepicker.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/raf/jquery-confirm.min.js" type="text/javascript"></script>
        <input type="hidden" id="systemtype" value="<%=Utility.iswindows()%>" />
        <script id="calendarjs" defer src="<%=src%>/page/sa/js/calendar.js" data-context="<%=request.getContextPath()%>" type="text/javascript"></script>
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
