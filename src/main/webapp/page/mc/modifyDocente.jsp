<%-- 
    Document   : uploadDocumet
    Created on : 29-gen-2020, 12.39.45
    Author     : agodino
--%>

<%@page import="rc.so.util.Utility"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="rc.so.domain.Docenti"%>
<%@page import="rc.so.db.Entity"%>
<%@page import="rc.so.db.Action"%>
<%@page import="rc.so.domain.User"%>
<%@page import="rc.so.domain.FasceDocenti"%>
<%@page import="java.util.List"%>
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
            List<FasceDocenti> fasce = e.findAll(FasceDocenti.class);
            Docenti d = e.getEm().find(Docenti.class, Long.parseLong(request.getParameter("id")));
            e.close();
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Progetti Formativi</title>
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
        <!--this page-->
        <link href="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
        <!-- - -->
        <link href="<%=src%>/assets/vendors/general/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
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

    </head>

    <body class="d-flex flex-column min-vh-100">

        <main class="container-fluid my-4">

            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">

                        <!-- begin:: Content -->
                        <div class="row" id="kt_content">
                            <div class="col-12">
                                <div class="card">

                                    <!-- Header -->
                                    <div class="card-header">
                                        <h3 class="card-title">Modifica Docente:</h3>
                                    </div>

                                    <!-- Body -->
                                    <div class="card-body">
                                        <form id="kt_form" action="<%=request.getContextPath()%>/OperazioniMicro?type=modifyDocente"
                                              method="post" accept-charset="ISO-8859-1" class="needs-validation" novalidate>

                                            <input type="hidden" name="id" value="<%=d.getId()%>">

                                            <div class="mb-4">
                                                <div class="row g-3">
                                                    <div class="col-lg-3">
                                                        <label for="nome" class="form-label">Nome</label>
                                                        <input type="text" class="form-control obbligatory" name="nome" id="nome" value="<%=d.getNome()%>">
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <label for="cognome" class="form-label">Cognome</label>
                                                        <input type="text" class="form-control obbligatory" name="cognome" id="cognome" value="<%=d.getCognome()%>">
                                                    </div>
                                                </div>

                                                <div class="row g-3 mt-2">
                                                    <div class="col-lg-3">
                                                        <label for="cf" class="form-label">Codice Fiscale</label>
                                                        <input type="text" class="form-control obbligatory" name="cf" id="cf" value="<%=d.getCodicefiscale()%>">
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <label for="data" class="form-label">Data Nascita</label>
                                                        <input type="text" class="form-control dp obbligatory"
                                                               name="data" id="data"
                                                               autocomplete="off"
                                                               value="<%=new SimpleDateFormat("dd/MM/yyyy").format(d.getDatanascita())%>"
                                                               readonly>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <label for="fascia" class="form-label">Fascia</label>
                                                        <select class="form-select obbligatory kt-select2-general" id="fascia" name="fascia">
                                                            <option value="-">Seleziona Fascia</option>
                                                            <% for (FasceDocenti f : fasce) { %>
                                                            <% if (f.equals(d.getFascia())) {%>
                                                            <option selected value="<%=f.getId()%>"><%=f.getDescrizione()%></option>
                                                            <% } else {%>
                                                            <option value="<%=f.getId()%>"><%=f.getDescrizione()%></option>
                                                            <% } %>
                                                            <% }%>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="row g-3 mt-2">
                                                    <div class="col-lg-3">
                                                        <label for="email" class="form-label">Email</label>
                                                        <input type="email" class="form-control obbligatory" name="email" id="email"
                                                               value="<%=d.getEmail() == null ? "" : d.getEmail()%>">
                                                    </div>
                                                    <%
                                                        String dweb = "";
                                                        if (d.getDatawebinair() != null) {
                                                            dweb = new SimpleDateFormat("dd/MM/yyyy").format(d.getDatawebinair());
                                                        }
                                                    %>
                                                    <div class="col-lg-3">
                                                        <label for="dataweb" class="form-label">Data Webinar</label>
                                                        <input type="text" class="form-control dp"
                                                               name="dataweb" id="dataweb"
                                                               autocomplete="off"
                                                               value="<%=dweb%>"
                                                               readonly>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Footer con pulsanti -->
                                            <div class="card-footer text-end">
                                                <% if (d.getStato().equals("DV")) { %>
                                                <a id="submit" href="javascript:void(0);" class="btn btn-success">
                                                    Accredita e Salva dati
                                                </a>
                                                <% } else { %>
                                                <a id="submit" href="javascript:void(0);" class="btn btn-primary">
                                                    Salva
                                                </a>
                                                <% }%>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end:: Content -->

                    </div>
                </div>
            </div>



        </main>                                                
        <div id="kt_scrolltop" style="background-color: #0059b3" class="kt-scrolltop">
            <i class="fa fa-arrow-up"></i>
        </div>
        <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
        <script src="../../Bootstrap2024/assets/js/popper.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/moment.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/bundle/app.bundle.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/components/extended/blockui1.33.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/soop/js/utility.js<%="?dummy=" + String.valueOf(new Date().getTime())%>" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/jquery-form/dist/jquery.form.min.js" type="text/javascript"></script>
        <!--this page-->
        <script src="<%=src%>/assets/vendors/general/select2/dist/js/select2.full.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/select2.js" type="text/javascript"></script>
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
        </script>
        <script>
            function ctrlForm() {
                var err = false;
                err = checkObblFieldsContent($('#kt_form')) ? true : err;
                err = !checkCF($('#cf')) ? true : err;
                err = checkEmail($('#email')) ? true : err;
                return !err;
            }

            $('#cancelbutton').on('click', function () {

            });
            $('#submit').on('click', function () {
                submitForm($('#kt_form'), "Docente modificato!", "Operazione effettuata con successo.", ctrlForm(), false);
            });
        </script>
    </body>
</html>
<%}
    }%>