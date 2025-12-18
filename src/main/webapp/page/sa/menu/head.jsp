<%@page import="rc.so.util.Utility"%>
<%@page import="java.util.Date"%>
<%
    String no_cache = "?dummy=" + String.valueOf(new Date().getTime());
    String guida = Utility.checkAttribute(session, "guida");
%>

<!-- Header -->
<nav id="kt_header" class="navbar navbar-expand-lg navbar-dark fixed-top" style="background-color:#0059b3!important; border:none; position: relative; top: -200px;">
    <div class="container-fluid">

        <!-- Branding / titolo (se serve) -->
        <a class="navbar-brand d-none d-lg-inline-block" href="#">
            <i class="bi bi-mortarboard"></i>
        </a>

        <!-- Right user dropdown -->
        <div class="dropdown ms-auto">
            <a style="position: relative; top:-10px;"href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" 
               id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <span class="me-2">Ciao,</span>
                <span class="fw-bold me-2"><%=us.getSoggettoAttuatore().getRagionesociale()%></span>
                <span class="badge bg-light text-dark rounded-circle p-2">
                    <%=us.getSoggettoAttuatore().getRagionesociale().substring(0, 1).toUpperCase()%>
                </span>
            </a>

            <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
                <li>
                    <h6 class="dropdown-header">
                        <i class="bi bi-person-circle me-2"></i>
                        <%=us.getSoggettoAttuatore().getRagionesociale()%>
                    </h6>
                </li>
                <li><hr class="dropdown-divider"></li>

                <li>
                    <a class="dropdown-item fancyProfile" href="<%=src%>/page/personal/profile.jsp">
                        <i class="bi bi-card-text me-2"></i> Profilo Personale
                    </a>
                </li>
                <li>
                    <a class="dropdown-item fancyProfile" href="<%=src%>/page/personal/chgPwd.jsp?active=yes">
                        <i class="bi bi-key me-2"></i> Password
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="<%=src%>/OperazioniGeneral?type=downloadDoc&path=<%=guida%>">
                        <i class="bi bi-journal-text me-2"></i> Manuale Operativo
                    </a>
                </li>
                <li><hr class="dropdown-divider"></li>
                <li>
                    <a class="dropdown-item text-danger" href="<%=request.getContextPath()%>/Login?type=logout" id="a_logout">
                        <i class="bi bi-box-arrow-right me-2"></i> Esci
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Fancybox CSS/JS -->
<script src="../../../assets/soop/js/fancy.js"></script>

