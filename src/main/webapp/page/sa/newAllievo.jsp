<%-- 
    Document   : profile
    Created on : 18-set-2019, 12.31.26
    Author     : agodino
--%>
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.domain.Nazioni_rc"%>
<%@page import="rc.so.domain.Motivazione"%>
<%@page import="rc.so.domain.Canale"%>
<%@page import="rc.so.domain.Condizione_Lavorativa"%>
<%@page import="rc.so.domain.StatiPrg"%>
<%@page import="rc.so.domain.TipoDoc_Allievi"%>
<%@page import="rc.so.domain.Condizione_Mercato"%>
<%@page import="rc.so.domain.Comuni"%>
<%@page import="rc.so.domain.CPI"%>
<%@page import="rc.so.db.Action"%>
<%@page import="rc.so.domain.TitoliStudio"%>
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
            String src = session.getAttribute("src").toString();
            Entity e = new Entity();
            List<Nazioni_rc> cittadinanza = e.findAll(Nazioni_rc.class);
            List<Nazioni_rc> nascitaconCF = e.listaNazioni_rc();
            List<Item> regioni = e.listaRegioni();
            List<TitoliStudio> ts = e.listaTitoliStudio();
            List<CPI> cpi = e.listaCPI();
            List<Condizione_Lavorativa> condlavprec = e.findAll(Condizione_Lavorativa.class);
            List<Canale> canaleconoscenza = e.findAll(Canale.class);
            List<Motivazione> motivazioni = e.findAll(Motivazione.class);
            List<TipoDoc_Allievi> tipo_doc = e.getTipoDocAllievi(e.getEm().find(StatiPrg.class, "DV"));
            TipoDoc_Allievi mod_1 = e.getEm().find(TipoDoc_Allievi.class, 3L);
            String prv1 = e.getPath("privacy1");
            String prv2 = e.getPath("privacy2");
            String prv3 = e.getPath("privacy3");
            e.close();
            boolean fancy = request.getParameter("fb") != null && request.getParameter("fb").equals("1") ? false : true;
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>YES I Start Up - Toscana - Allievi</title>
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
        <link href="<%=src%>/resource/animate.css" rel="stylesheet" type="text/css"/>
        <link href="<%=src%>/assets/demo/default/skins/header/base/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/brand/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/skins/aside/light.css" rel="stylesheet" type="text/css" />
        <link href="<%=src%>/assets/demo/default/base/style.bundle.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="Bootstrap2024/assets/css/global.css"/>
        <link href="https://fonts.cdnfonts.com/css/titillium-web" rel="stylesheet">
        <link href="<%=src%>/resource/custom.css" rel="stylesheet" type="text/css" />

        <link rel="shortcut icon" href="<%=src%>/assets/media/logos/favicon.ico" />
        <style type="text/css">
            .form-group {
                margin-bottom: 1rem;
            }

            .custom-file-label::after {
                color:#fff;
                background-color: #eaa21c;
            }

        </style>
        <script type="text/javascript">
            function model_funct(codice) {
                if (ctrlFormNOFILE()) {
                    document.getElementById('save').value = "1";
                    document.getElementById("kt_form").target = "_blank";
                    document.getElementById("kt_form").submit();
                }
            }
        </script>
    </head>
    <body class="kt-header--fixed kt-header-mobile--fixed kt-subheader--fixed kt-subheader--enabled kt-subheader--solid kt-aside--enabled kt-aside--fixed">
        <!-- begin:: Page -->
        <%if (fancy) {%>
        <%@ include file="menu/head1.jsp"%>
        <div class="kt-grid kt-grid--hor kt-grid--root">
            <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--ver kt-page">
                <%@ include file="menu/menu.jsp"%>
                <!-- end:: Aside -->
                <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor kt-wrapper" id="kt_wrapper">
                    <%@ include file="menu/head.jsp"%>
                    <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor">
                        <div class="kt-subheader   kt-grid__item" id="kt_subheader">
                            <div class="kt-subheader   kt-grid__item" id="kt_subheader">
                                <div class="kt-subheader__main">
                                    <h3 class="kt-subheader__title">Allievi</h3>
                                    <span class="kt-subheader__separator kt-subheader__separator--v"></span>
                                    <a class="kt-subheader__breadcrumbs-link">Aggiungi</a>
                                </div>
                            </div>
                        </div>
                        <%} else {%>
                        <div class="kt-grid kt-grid--hor kt-grid--root">
                            <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--ver kt-page">
                                <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor">
                                    <%}%>
                                    <div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="alert alert-info">
                                                    MODELLO 1 - La scheda d'iscrizione deve essere compilata in ogni sua parte, i campi contrassegnati con l'asterisco sono obbligatori. La scheda generata dal sistema informativo dovr&#224; essere firmata (con firma elettronica pdf) dal NEET e caricata in piattaforma. 
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="alert alert-warning">
                                                    MODELLO 1 - Il S.I. controlla il QRCODE presente sulla domanda, si consiglia pertanto di verificare che la scansione non abbia reso illeggibile il QRCODE (in tal caso verr&#224; visualizzato un Messaggio di errore ed è necessario caricare un documento correttamente scansionato). 
                                                </div>
                                            </div>
                                        </div>

                                        <div class="kt-portlet kt-portlet--mobile">
                                            <form class="kt-form" id="kt_form" 
                                                  action="<%=request.getContextPath()%>/OperazioniSA?type=newAllievo" 
                                                  style="padding-top: 0;"  method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="save" id="save" value="0" />
                                                <%if (Utility.demoversion) {%>
                                                <div class="kt-portlet__head">
                                                    <div class="kt-portlet__head-label">
                                                        <h3 class="kt-portlet__head-title">
                                                            <a href="<%=request.getContextPath()%>/OperazioniSA?type=generaterandomAllievi" 
                                                               class="btn btn-dark kt-font-bold"><i class="fa fa-user"></i> INSERISCI 5 ALLIEVI RANDOM</a>
                                                        </h3>
                                                    </div>
                                                </div>
                                                <%}%>
                                                <div class="kt-portlet__body">
                                                    <div class="kt-section kt-section--space-md">
                                                        <div class="form-group form-group-sm row">
                                                            <div class="col-12">
                                                                <h5>Anagrafica</h5>
                                                                <div class="kt-separator kt-separator--border kt-separator--space-xs"></div>
                                                                <div class="form-row">
                                                                    <div class="form-group col-xl-3 col-lg-6">
                                                                        <label>Nome </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <input type="text" class="form-control obbligatory text-uppercase" id="nome" name="nome" />
                                                                    </div>
                                                                    <div class="form-group col-xl-3 col-lg-6">
                                                                        <label>Cognome </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <input type="text" class="form-control obbligatory text-uppercase" id="cognome" name="cognome" />
                                                                    </div>
                                                                    <div class="form-group col-xl-3 col-lg-6">
                                                                        <label>Codice fiscale </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <input class="form-control obbligatory text-uppercase" type="text" name="codicefiscale" id="codicefiscale" />
                                                                    </div>
                                                                    <div class="form-group col-xl-3 col-lg-6">
                                                                        <label>Stato di nascita <i class="fa fa-info-circle" 
                                                                                                   data-container="body" 
                                                                                                   data-toggle="kt-popover" 
                                                                                                   data-placement="bottom"
                                                                                                   data-original-title="Stato di Nascita"
                                                                                                   data-content="Possono partecipare al programma Garanzia giovani, i cittadini Italiani, 
                                                                                                   i cittadini di uno stato membro dell'Unione Europea oppure stranieri extra UE, purché con permesso di soggiorno o residenza in Italia.
                                                                                                   In mancanza, del requisito della residenza o del permesso di soggiorno l'iscrizione al percorso YES I START UP non &#232; valida."></i>
                                                                        </label>
                                                                        <label class="kt-font-danger kt-font-boldest">*</label> 


                                                                        <div class="dropdown bootstrap-select form-control kt-" id="stato_div" style="padding: 0;">
                                                                            <select class="form-control kt-select2-general obbligatory" id="stato" name="stato"  style="width: 100%">
                                                                                <option value="-">Seleziona Stato</option>
                                                                                <option value="100" data-ue="UE">ITALIA</option>
                                                                                <%for (Nazioni_rc c : nascitaconCF) {%>
                                                                                <option value="<%=c.getCodicefiscale()%>"
                                                                                        data-ue="<%=c.getUe()%>"
                                                                                        ><%=c.getNome()%></option>
                                                                                <%}%>
                                                                                <!--                                                                                <option value="100">ITALIA</option>
                                                                                <option value="200">STATO UE</option>
                                                                                <option value="300">STATO EXTRA UE</option>-->
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="form-row">
                                                                    <div class="form-group col-xl-3 col-lg-6">
                                                                        <label>Data di nascita </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <input type="text" class="form-control obbligatory date-picker_r" name="datanascita" id="datanascita"/>
                                                                    </div>
                                                                    <div class="form-group col-xl-3 col-lg-6">
                                                                        <label>Regione di nascita </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <div class="dropdown bootstrap-select form-control kt-" id="regionenascita_div" style="padding: 0;">
                                                                            <select class="form-control kt-select2-general obbligatory" id="regionenascita" name="regionenascita"  style="width: 100%">
                                                                                <option value="-">Seleziona Regione</option>
                                                                                <%for (Item i : regioni) {%>
                                                                                <option value="<%=i.getValue()%>"><%=i.getDesc()%></option>
                                                                                <%}%>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group col-xl-3 col-lg-6">
                                                                        <label>Provincia di nascita </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <div class="dropdown bootstrap-select form-control kt-" id="provincianascita_div" style="padding: 0;">
                                                                            <select class="form-control kt-select2-general obbligatory" id="provincianascita" name="provincianascita"  style="width: 100%;">
                                                                                <option value="-">Seleziona Provincia</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group col-xl-3 col-lg-6">
                                                                        <label>Comune di nascita </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <div class="dropdown bootstrap-select form-control kt-" id="comunenascita_div" style="padding: 0;">
                                                                            <select class="form-control kt-select2-general obbligatory" id="comunenascita" name="comunenascita"  style="width: 100%;">
                                                                                <option value="-">Seleziona Comune</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="form-row" id="msgrow" style="display:block">
                                                                    <label id="msg_cf"></label>
                                                                </div>
                                                                <div class="form-row">
                                                                    <div class="form-group col-xl-3 col-lg-6">
                                                                        <label>Telefono (Cellulare, senza +39) </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <input type="text" class="form-control obbligatory" 
                                                                               id="telefono" name="telefono" 
                                                                               onkeypress="return check_mobiletel_bef(event, this);" 
                                                                               onkeyup="return check_mobiletel_aft(event, this);"/>
                                                                    </div>
                                                                    <div class="form-group col-xl-3 col-lg-6">
                                                                        <label>Documento di identità </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <div class="custom-file">
                                                                            <input type="file" tipo="obbligatory" class="custom-file-input" accept="application/pdf" name="docid" id="docid" onchange="return checkFileExtAndDim(['pdf']);">
                                                                            <label class="custom-file-label selected" id='label_file'>Scegli File</label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group col-xl-3 col-lg-6">
                                                                        <label>Data scadenza documento</label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <input type="text" class="form-control obbligatory date-picker_r1" name="scadenzadoc" id="scadenzadoc" autocomplete="off"/>
                                                                    </div>
                                                                    <div class="form-group col-xl-3 col-lg-6">
                                                                        <label>Cittadinanza</label> <i class="fa fa-info-circle" 
                                                                                                       data-container="body" 
                                                                                                       data-toggle="kt-popover" 
                                                                                                       data-placement="bottom"
                                                                                                       data-original-title="Cittadinanza"
                                                                                                       data-content="Possono partecipare al programma Garanzia giovani, i cittadini Italiani, 
                                                                                                       i cittadini di uno stato membro dell'Unione Europea oppure stranieri extra UE, purché con permesso di soggiorno o residenza in Italia.
                                                                                                       In mancanza, del requisito della residenza o del permesso di soggiorno l'iscrizione al percorso YES I START UP non &#232; valida."></i><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <div class="dropdown bootstrap-select form-control kt-" id="cittadinanza_div" style="padding: 0;">
                                                                            <select class="form-control kt-select2-general obbligatory" id="cittadinanza" name="cittadinanza"  style="width: 100%">
                                                                                <option value="-">Seleziona Cittadinanza</option>
                                                                                <%for (Nazioni_rc c : cittadinanza) {%>
                                                                                <option value="<%=c.getId()%>"><%=c.getNome()%></option>
                                                                                <%}%>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>  
                                                                <h5>Residenza <i class="fa fa-info-circle" 
                                                                                 data-container="body" 
                                                                                 data-toggle="kt-popover" 
                                                                                 data-placement="bottom"
                                                                                 data-original-title="Residenza"
                                                                                 data-content="Possono partecipare al programma Garanzia giovani, i cittadini Italiani, 
                                                                                 i cittadini di uno stato membro dell'Unione Europea oppure stranieri extra UE, purché con permesso di soggiorno o residenza in Italia.
                                                                                 In mancanza, del requisito della residenza o del permesso di soggiorno l'iscrizione al percorso YES I START UP non &#232; valida."></i></h5>
                                                                <div class="kt-separator kt-separator--border kt-separator--space-xs"></div>
                                                                <div class="form-row">
                                                                    <div class="form-group col-xl-4 col-lg-6">
                                                                        <label>Indirizzo </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <input type="text" class="form-control obbligatory text-uppercase" id="indirizzores" name="indirizzores" />
                                                                    </div>
                                                                    <div class="form-group col-xl-2 col-lg-6">
                                                                        <label>Civico </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <input type="text" class="form-control obbligatory text-uppercase" id="civicores" name="civicores" />
                                                                    </div>
                                                                    <div class="form-group col-xl-2 col-lg-6">
                                                                        <label>CAP </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <input type="text" class="form-control obbligatory text-uppercase" id="capres" name="capres"  onkeypress="return isNumber(event);"/>
                                                                    </div>
                                                                    <div class="form-group col-xl-4 col-lg-6 kt-align-right">
                                                                        <label>La residenza coincide con il domicilio?</label>
                                                                        <div class="form-group kt-align-right" style="margin-bottom: 0rem;">
                                                                            <span class="kt-switch kt-switch--outline kt-switch--icon kt-switch--primary" style="">
                                                                                <label>
                                                                                    <input type="checkbox" name="checkind" id="checkind" onchange="return domicilio();">
                                                                                    <span></span>
                                                                                </label>
                                                                            </span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="form-row">
                                                                    <div class="form-group col-lg-4">
                                                                        <label>Regione di residenza </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <div class="dropdown bootstrap-select form-control kt-" id="regioneres_div" style="padding: 0;">
                                                                            <select class="form-control kt-select2-general obbligatory" id="regioneres" name="regioneres"  style="width: 100%">
                                                                                <option value="-">Seleziona Regione</option>
                                                                                <%for (Item i : regioni) {%>
                                                                                <option value="<%=i.getValue()%>"><%=i.getDesc()%></option>
                                                                                <%}%>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group col-lg-4">
                                                                        <label>Provincia di residenza </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <div class="dropdown bootstrap-select form-control kt-" id="provinciares_div" style="padding: 0;">
                                                                            <select class="form-control kt-select2-general obbligatory" id="provinciares" name="provinciares"  style="width: 100%;">
                                                                                <option value="-">Seleziona Provincia</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group col-lg-4">
                                                                        <label>Comune di residenza </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <div class="dropdown bootstrap-select form-control kt-" id="comuneres_div" style="padding: 0;">
                                                                            <select class="form-control kt-select2-general obbligatory" id="comuneres" name="comuneres"  style="width: 100%;">
                                                                                <option value="-">Seleziona Comune</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <h5>Domicilio <label class="kt-font-danger kt-font-boldest" style="display:none;" id="msgdom">Il domicilio corrisponde con la residenza</label></h5>
                                                                <div class="kt-separator kt-separator--border kt-separator--space-xs"></div>
                                                                <div class="form-row">
                                                                    <div class="form-group col-xl-4 col-lg-6">
                                                                        <label>Indirizzo </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <input type="text" class="form-control text-uppercase" id="indirizzodom" name="indirizzodom" />
                                                                    </div>
                                                                    <div class="form-group col-xl-2 col-lg-6">
                                                                        <label>Civico </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <input type="text" class="form-control text-uppercase" id="civicodom" name="civicodom" />
                                                                    </div>
                                                                    <div class="form-group col-xl-2 col-lg-6">
                                                                        <label>CAP </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <input type="text" class="form-control text-uppercase" id="capdom" name="capdom"  onkeypress="return isNumber(event);"/>
                                                                    </div>
                                                                </div>
                                                                <div class="form-row">
                                                                    <div class="form-group col-lg-4">
                                                                        <label>Regione di domicilio </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <div class="dropdown bootstrap-select form-control kt-" id="regionedom_div" style="padding: 0;">
                                                                            <select class="form-control kt-select2-general" id="regionedom" name="regionedom"  style="width: 100%">
                                                                                <option value="-">Seleziona Regione</option>
                                                                                <%for (Item i : regioni) {%>
                                                                                <option value="<%=i.getValue()%>"><%=i.getDesc()%></option>
                                                                                <%}%>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group col-lg-4">
                                                                        <label>Provincia di domicilio </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <div class="dropdown bootstrap-select form-control kt-" id="provinciadom_div" style="padding: 0;">
                                                                            <select  class="form-control kt-select2-general" id="provinciadom" name="provinciadom"  style="width: 100%;">
                                                                                <option value="-">Seleziona Provincia</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group col-lg-4">
                                                                        <label>Comune di domicilio </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <div class="dropdown bootstrap-select form-control kt-" id="comunedom_div" style="padding: 0;">
                                                                            <select class="form-control kt-select2-general" id="comunedom" name="comunedom"  style="width: 100%;">
                                                                                <option value="-">Seleziona Comune</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <br>
                                                                <h5>Dati</h5> 
                                                                <div class="kt-separator kt-separator--border kt-separator--space-xs"></div>
                                                                <div class="form-row">
                                                                    <div class="form-group col-xl-4 col-lg-6">
                                                                        <label>Titolo di studio </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <div class="dropdown bootstrap-select form-control kt-" id="titolo_studio_div" style="padding: 0;">
                                                                            <select class="form-control kt-select2-general obbligatory" id="titolo_studio" name="titolo_studio"  style="width: 100%">
                                                                                <option value="-">Seleziona titolo di studio</option>
                                                                                <%for (TitoliStudio t : ts) {%>
                                                                                <option value="<%=t.getCodice()%>"><%=t.getDescrizione()%></option>
                                                                                <%}%>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group col-xl-4 col-lg-6">
                                                                        <label>Condizione lavorativa precedente </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <!--29-04-2020 MODIFICA - CONDIZIONE LAVORATIVA PRECEDENTE-->
                                                                        <!--<input type="text" class="form-control obbligatory" id="neet" name="neet" />-->
                                                                        <div class="dropdown bootstrap-select form-control kt-" id="condizione_lavorativa_div" style="padding: 0;">
                                                                            <select class="form-control kt-select2-general obbligatory" id="condizione_lavorativa" name="condizione_lavorativa"  style="width: 100%">
                                                                                <option value="-">Seleziona condizione lavorativa precedente</option>
                                                                                <%for (Condizione_Lavorativa c : condlavprec) {%>
                                                                                <option value="<%=c.getId()%>"><%=c.getDescrizione()%></option>
                                                                                <%}%>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group col-xl-4 col-lg-6">
                                                                        <label>Canale di conoscenza </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <div class="dropdown bootstrap-select form-control kt-" id="canale_div" style="padding: 0;">
                                                                            <select class="form-control kt-select2-general obbligatory" id="canale" name="canale"  style="width: 100%">
                                                                                <option value="-">Seleziona canale di conoscenza</option>
                                                                                <%for (Canale t : canaleconoscenza) {%>
                                                                                <option value="<%=t.getId()%>"><%=t.getDescrizione()%></option>
                                                                                <%}%>
                                                                            </select>
                                                                        </div>
                                                                    </div>                                                                    
                                                                </div>  
                                                                <input type="hidden" name="condizione" value="01" />
                                                                <div class="form-row">
                                                                    <div class="form-group col-xl-4 col-lg-6">
                                                                        <label>Email </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <input type="text" class="form-control obbligatory text-lowercase" id="email" name="email"  />
                                                                    </div>
                                                                    <div class="form-group col-xl-2 col-lg-6">
                                                                        <label>Data iscrizione G.G. </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <input type="text" class="form-control obbligatory date-picker_r" name="iscrizionegg" id="iscrizionegg" />
                                                                    </div>
                                                                    <div class="form-group col-xl-4 col-lg-6">
                                                                        <label>Operatore Privato / CPI </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <div class="dropdown bootstrap-select form-control kt-" id="cpi_div" style="padding: 0;">
                                                                            <select class="form-control kt-select2-general obbligatory" id="cpi" name="cpi"  style="width: 100%">
                                                                                <option value="-">Seleziona</option>
                                                                                <%for (CPI c : cpi) {%>
                                                                                <option value="<%=c.getId()%>"><%=c.getDescrizione()%></option>
                                                                                <%}%>
                                                                            </select>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group col-xl-2 col-lg-6">
                                                                        <label>Data presa in carico </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <input type="text" class="form-control obbligatory date-picker_r" name="datacpi" id="datacpi" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-row">   
                                                                    <div class="form-group col-xl-4 col-lg-6">
                                                                        <label>Motivazione </label><label class="kt-font-danger kt-font-boldest">*</label>
                                                                        <div class="dropdown bootstrap-select form-control kt-" id="motivazione_div" style="padding: 0;">
                                                                            <select class="form-control kt-select2-general obbligatory"
                                                                                    id="motivazione" name="motivazione"  style="width: 100%">
                                                                                <option value="-">Seleziona Motivazione</option>
                                                                                <%for (Motivazione t : motivazioni) {%>
                                                                                <option value="<%=t.getId()%>"><%=t.getDescrizione()%></option>
                                                                                <%}%>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <h5>AUTORIZZAZIONI PRIVACY</h5>
                                                                <div class="kt-separator kt-separator--border kt-separator--space-xs"></div>

                                                                <div class="form-row">   
                                                                    <div class="form-group col-xl-4 col-lg-6">
                                                                        <label>Autorizzazione Privacy 1 </label><label class="kt-font-danger kt-font-boldest">*</label>

                                                                        <span class="kt-switch kt-switch--outline kt-switch--icon kt-switch--primary">
                                                                            <label>
                                                                                <input type="checkbox" class="form-control" name="prv1" id="prv1" checked disabled/>
                                                                                <span></span>
                                                                                <%=prv1%>
                                                                            </label>
                                                                        </span>

                                                                    </div>
                                                                    <div class="form-group col-xl-4 col-lg-6">
                                                                        <label>Autorizzazione Privacy 2 </label>
                                                                        <span class="kt-switch kt-switch--outline kt-switch--icon kt-switch--primary">
                                                                            <label>
                                                                                <input type="checkbox" class="form-control" name="prv2" id="prv2"/>
                                                                                <span></span>
                                                                                <%=prv2%>
                                                                            </label>
                                                                        </span>
                                                                    </div>
                                                                    <div class="form-group col-xl-4 col-lg-6">
                                                                        <label>Autorizzazione Privacy 3</label>
                                                                        <span class="kt-switch kt-switch--outline kt-switch--icon kt-switch--primary">
                                                                            <label>
                                                                                <input type="checkbox" class="form-control" name="prv3" id="prv3"/>
                                                                                <span></span>
                                                                                <%=prv3%>
                                                                            </label>
                                                                        </span>
                                                                    </div>
                                                                </div>

                                                                <%if (mod_1.getModello() != null) {%>
                                                                <h5>MODELLO 1</h5>
                                                                <div class="kt-separator kt-separator--border kt-separator--space-xs"></div>
                                                                <div class="row">
                                                                    <div class="col-12">
                                                                        <div class="alert alert-warning">
                                                                            É possibile caricare il Modello 1 firmato dal NEET anche in un secondo momento. <br>
                                                                            In tal caso è utile ricordare che lo stesso NEET non sarà "Attivo" (e dunque non disponibile per partecipare ad eventuali Progetti Formativi) fin quando il Modello 1 non sarà caricato. 
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group row">
                                                                    <div class="form-group col-xl-6 col-lg-6">
                                                                        <label>Scaricare il modello con i dati inseriti per poi caricarlo firmato dal NEET nel campo seguente.</label>
                                                                        <button class="btn btn-primary btn-md btn-tall btn-wide kt-font-bold kt-font-transform-u" 
                                                                                type="button" 
                                                                                onclick="return model_funct('<%=mod_1.getId()%>');"
                                                                                >
                                                                            Scarica
                                                                        </button>
                                                                    </div>
                                                                    <div class="form-group col-xl-4 col-lg-6">
                                                                        <div class="custom-file">
                                                                            <input type="file" <%=mod_1.getObbligatorio() == 1 ? "" : ""%> 
                                                                                   class="custom-file-input" 
                                                                                   accept="<%=mod_1.getMimetype()%>" name="doc_<%=mod_1.getId()%>" 
                                                                                   onchange="return checkFileExtAndDim('<%=mod_1.getEstensione()%>');">
                                                                            <label class="custom-file-label selected" name="label_<%=mod_1.getId()%>">Scegli File</label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <%}%>
                                                                <h5>Altra Documentazione</h5>
                                                                <div class="kt-separator kt-separator--border kt-separator--space-xs"></div>
                                                                <div class="form-group row">
                                                                    <%for (TipoDoc_Allievi t : tipo_doc) {%>
                                                                    <div class="form-group col-xl-4 col-lg-6">
                                                                        <label><%=t.getDescrizione()%></label><%=t.getObbligatorio() == 1 ? "<label id='label_doc_" + t.getId() + "' class='kt-font-danger kt-font-boldest'>*</label>" : "<label id='label_doc_" + t.getId() + "' class='kt-font-danger kt-font-boldest'></label>"%>
                                                                        <div class="custom-file">
                                                                            <input type="file" <%=t.getObbligatorio() == 1 ? "tipo='obbligatory'" : ""%> 
                                                                                   class="custom-file-input" 
                                                                                   accept="<%=t.getMimetype()%>" name="doc_<%=t.getId()%>" id="doc_<%=t.getId()%>"
                                                                                   onchange="return checkFileExtAndDim('<%=t.getEstensione()%>');">
                                                                            <label class="custom-file-label selected" name="label_<%=t.getId()%>">Scegli File</label>
                                                                        </div>
                                                                    </div>
                                                                    <%}%>
                                                                </div>
                                                                <div class="kt-portlet__foot" style="padding-left: 10px;">
                                                                    <div class="kt-form__actions">
                                                                        <div class="row">
                                                                            <a id="submit_change" href="javascript:void(0);" class="btn btn-primary" style="font-family: Poppins"><i class="flaticon2-plus-1"></i> Aggiungi</a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>    
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>     
                                        </div>
                                    </div>
                                    <%if (fancy) {%>
                                </div>
                                <%@ include file="menu/footer.jsp"%>
                                <%}%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="kt_scrolltop" style="background-color: #0059b3" class="kt-scrolltop">
            <i class="fa fa-arrow-up"></i>
        </div>
        <script src="<%=src%>/assets/soop/js/jquery-3.6.1.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/popper.js/dist/umd/popper.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
        <script src="<%=src%>/assets/vendors/general/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
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
        <script id="newAllievo" src="<%=src%>/page/sa/js/newAllievo.js" data-context="<%=request.getContextPath()%>" type="text/javascript"></script>
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
            var datep = function () {
                var arrows = {
                    leftArrow: '<i class="la la-angle-left"></i>',
                    rightArrow: '<i class="la la-angle-right"></i>'
                }

                var demos = function () {
                    $('input.dateBorth').datepicker({
                        orientation: "bottom left",
                        todayHighlight: true,
                        templates: arrows,
                        autoclose: true,
                        format: 'dd/mm/yyyy',
                        startView: 'decade',
                        endDate: new Date()
                    });

                }

                return {
                    // public functions
                    init: function () {
                        demos();
                    }
                };
            }();

            jQuery(document).ready(function () {
                datep.init();
            });
        </script>
    </body>
</html>
<%}
    }%>
