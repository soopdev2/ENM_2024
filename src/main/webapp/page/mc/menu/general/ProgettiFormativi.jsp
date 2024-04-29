<%-- 
    Document   : rubrica
    Created on : 18-giu-2019, 9.23.22
    Author     : rcosco
--%>
<li class="kt-menu__item <%=progettoformativo%>" aria-haspopup="true" data-ktmenu-submenu-toggle="hover">
    <a href="javascript:;" class="kt-menu__link kt-menu__toggle">
        <span class="kt-menu__link-icon"><i class="fa fa-file-alt"></i></span>
        <span class="kt-menu__link-text">Progetti Formativi</span>
        <i class="kt-menu__ver-arrow la la-angle-right"></i>
    </a>
    <div class="kt-menu__submenu">
        <span class="kt-menu__arrow"></span>
        <ul class="kt-menu__subnav">
            <li class="kt-menu__item <%=pageName.equals("searchPFMicro.jsp") ? "kt-menu__item--active" : ""%>" aria-haspopup="true">
                <a href="searchPFMicro.jsp" class="kt-menu__link">
                    <i class="kt-menu__link-bullet fa fa-search">
                        <span></span>
                    </i>
                    <span class="kt-menu__link-text">Cerca</span>
                </a>
            </li>
            
            <li class="kt-menu__item <%=pageName.equals("dUnit.jsp") ? "kt-menu__item--active" : ""%>" aria-haspopup="true">
                <a href="dUnit.jsp" class="kt-menu__link">
                    <i class="kt-menu__link-bullet fa fa-list-ol">
                        <span></span>
                    </i>
                    <span class="kt-menu__link-text">Unit� Didattiche</span>
                </a>
            </li>
            <%if(tipoR == 2 && rend){%>
                <li class="kt-menu__item <%=pageName.equals("rend.jsp") ? "kt-menu__item--active" : ""%>" aria-haspopup="true">
                <a href="rend.jsp" class="kt-menu__link">
                    <i class="kt-menu__link-bullet fa fa-money-bill">
                        <span></span>
                    </i>
                    <span class="kt-menu__link-text">Rendicontazione</span>
                </a>
            </li>
            <%}%>
        </ul>
    </div>
</li>