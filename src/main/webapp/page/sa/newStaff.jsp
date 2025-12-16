
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="java.util.Date"%>
<%@page import="rc.so.domain.StaffModelli"%>
<%@page import="rc.so.domain.ProgettiFormativi"%>
<%@page import="rc.so.entity.Item"%>
<%@page import="java.util.ArrayList"%>
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
            int nro_staff = 2;
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Membri Staff</title>
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
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">
        <link href="../../Bootstrap2024/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />




        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
       
    </head>


   <body>
    <div class="container-fluid">
        <!-- Titolo e descrizione generale -->
        <div class="row mb-3">
            <div class="col-12">
                <div id="card_body">
                    <h5>Inserimento membri dello Staff Soggetto Esecutore per accesso alla FAD (Fase A - Fase B)</h5>
                </div>
                <div id="card_footer" class="mb-3">
                    L'inserimento di membri dello staff non è obbligatorio per la prosecuzione del Progetto Formativo.<br>
                    Caricamento massimo 2 membri, possibile solo prima del modello 3.
                </div>
            </div>
        </div>

        <!-- Loop membri staff -->
        <%for (int i = 0; i < nro_staff; i++) {
            int cnt = i + 1;%>
            <div class="row mb-3">
                <div class="col-12">
                    <form id="kt_form_<%=i%>" action="<%=request.getContextPath()%>/OperazioniSA?type=manageMembriStaff&row=<%=i%>" method="post">
                        <input type="hidden" name="mid_<%=i%>" id="mid_<%=i%>" />
                        <input type="hidden" name="pf<%=i%>" value="<%=StringEscapeUtils.escapeHtml4(request.getParameter("id"))%>" />
                        
                        <h5>Membro #<%=cnt%></h5>
                        <hr>
                        
                        <div class="row g-3">
                            <div class="col-md-3">
                                <label for="nome<%=i%>" class="form-label">Nome *</label>
                                <input type="text" class="form-control" name="nome<%=i%>" id="nome<%=i%>">
                            </div>
                            <div class="col-md-3">
                                <label for="cognome<%=i%>" class="form-label">Cognome *</label>
                                <input type="text" class="form-control" name="cognome<%=i%>" id="cognome<%=i%>">
                            </div>
                            <div class="col-md-3">
                                <label for="email<%=i%>" class="form-label">Email *</label>
                                <input type="email" class="form-control" name="email<%=i%>" id="email<%=i%>">
                            </div>
                            <div class="col-md-3">
                                <label for="telefono<%=i%>" class="form-label">Telefono *</label>
                                <input type="text" class="form-control" id="telefono<%=i%>" name="telefono<%=i%>" onkeypress="return isNumber(event);">
                            </div>
                        </div>

                        <div id="sameMember<%=i%>" class="text-danger mt-2" style="display: none;">
                            <b>Il membro inserito/modificato è già presente.</b>
                        </div>

                        <div class="mt-3 d-flex gap-2">
                            <a id="submit_<%=i%>" href="javascript:void(0);" class="btn btn-primary">Salva</a>
                            <a id="delete_<%=i%>" onclick="deleteMembro(<%=i%>)" href="javascript:void(0);" class="btn btn-danger" style="display: none;">Elimina</a>
                        </div>
                    </form>
                </div>
            </div>
        <%}%>
    </div>



    <!-- Scripts JS esterni -->
    <script src="<%=src%>/assets/soop/js/jquery-3.7.1.js"></script>
    <script src="<%=src%>/assets/vendors/general/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%=src%>/assets/vendors/general/js-cookie/src/js.cookie.js"></script>
    <script src="<%=src%>/assets/soop/js/moment.min.js"></script>
    <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js"></script>
    <script src="<%=src%>/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js"></script>
    <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js"></script>
    <script src="<%=src%>/assets/vendors/general/jquery-form/dist/jquery.form.min.js"></script>
    <script src="<%=src%>/assets/demo/default/base/scripts.bundle.js"></script>
    <script src="<%=src%>/assets/app/bundle/app.bundle.js"></script>
    <script src="<%=src%>/assets/vendors/general/sweetalert2/dist/sweetalert2.js"></script>
    <script src="<%=src%>/assets/soop/js/utility.js"></script>
    <script src="<%=src%>/assets/app/custom/general/crud/forms/widgets/bootstrap-datepicker.js"></script>
    <script src="<%=src%>/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.js"></script>
    <script id="newStaff" src="<%=src%>/page/sa/js/newStaff.js?<%="?dummy=" + String.valueOf(new Date().getTime())%>" data-context="<%=request.getContextPath()%>" defer pId="<%=StringEscapeUtils.escapeHtml4(request.getParameter("id"))%>" nro="2"></script>
</body>








</html>
<%
        }
    }
%>