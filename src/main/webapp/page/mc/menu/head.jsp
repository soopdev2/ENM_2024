<%@ page import="java.util.Date" %>
<% String no_cache = "?dummy=" + new Date().getTime(); %>

<!-- Bootstrap 5 Header -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top" style="background-color: #0059b3; border: 1px solid #0059b3; position: relative; top: -210px " >
    <div class="container-fluid">

        <!-- Menu Mobile Close Button -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTop" aria-controls="navbarTop" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Menu Wrapper -->
        <div class="collapse navbar-collapse" id="navbarTop">
            <div class="d-inline-block align-middle">
                <!-- qui puoi inserire eventuali menu -->
            </div>
        </div>

        <!-- User Bar -->
        <div class="dropdown ms-auto">
            <a style="position: relative; top: -10px;" href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <span class="me-2 d-none d-lg-inline">Ciao, <%=us.getUsername()%></span>
                <span class="badge bg-primary rounded-circle fw-bold" style="width: 35px; height: 35px; display: flex; align-items: center; justify-content: center;">
                    <%=us.getUsername().substring(0, 1).toUpperCase()%>
                </span>
            </a>
            <ul class="dropdown-menu dropdown-menu-end text-small shadow" aria-labelledby="userDropdown">
                <li>
                    <div class="p-3 text-center bg-dark text-white" style="background-image: url(<%=src%>/assets/media/bg/bg-3.jpg); background-position: left bottom; background-repeat: repeat-x;">
                        <span class="badge bg-primary rounded-circle fw-bold" style="width: 50px; height: 50px; display: inline-flex; align-items: center; justify-content: center;">
                            <%=us.getUsername().substring(0, 1).toUpperCase()%>
                        </span>
                        <div class="mt-2 fw-bold"><%=us.getUsername()%></div>
                        <div class="mt-2">
                            <a href="<%=request.getContextPath()%>/Login?type=logout" class="btn btn-sm btn-light" title="Esci">
                                <i class="flaticon-logout"></i>
                            </a>
                        </div>
                    </div>
                </li>
                <li>
                    <a class="dropdown-item d-flex align-items-center" href="<%=src%>/page/personal/chgPwd.jsp?active=yes">
                        <i class="flaticon2-gear me-2"></i>
                        <div>
                            <div class="fw-bold">Password</div>
                            <div class="small">Cambia</div>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Fancybox CSS/JS -->
<link href="<%=src%>/assets/soop/css/jquery.fancybox.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=src%>/assets/soop/js/jquery-1.10.1.min.js"></script>
<script type="text/javascript" src="<%=src%>/assets/soop/js/jquery.fancybox.js?v=2.1.5"></script>
<script type="text/javascript" src="<%=src%>/assets/soop/js/fancy.js"></script>
