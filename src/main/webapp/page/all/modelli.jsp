<%-- 
    Document   : modelli
    Created on : 2-mar-2020, 12.41.15
    Author     : agodino
--%>
<%@page import="rc.so.db.Action"%>
<%@page import="rc.so.domain.Cloud"%>
<%@page import="java.util.List"%>
<%@page import="rc.so.db.Entity"%>
<%  Entity e = new Entity();
    List<Cloud> clouds = e.getCloudFilesByTipo(tipo);/*e.findAll(Cloud.class)*/;
    e.close();
%>
<div class="row">
    <%for (Cloud c : clouds) {
            if (Action.isModifiable(c.getVisible(), String.valueOf(us.getTipo()))) {%>
    <div class='col-xl-3 col-lg-6 col-md-6 col-sm-12 form-group'>
        <div class='row'>
            <div class='col-4 paddig_0_r' style="text-align: center;">
                <a href='' class='btn-icon kt-font-io' onclick="return false;">
                    <i class='fa fa-file-pdf' style='font-size: 100px;'></i>
                </a>
            </div>
            <div class='col-1 paddig_0_l' style='text-align: left;'>
                <input type="hidden" value="<%=request.getContextPath()%>/OperazioniGeneral?type=downloadDoc&path=<%=c.getPath().replaceAll("\\\\", "/")%>">
                <a class="btn btn-icon btn-sm btn-io-n download" href="javascript:void(0);" onclick="" data-container="body" data-html="true" data-toggle="kt-tooltip" title="Scarica documento">
                    <i class="fa fa-arrow-down"></i>
                </a>
            </div>
            <%if (us.getTipo() == 2) {%>
            <div class='col-1 paddig_0_l' style='text-align: left;'>
                <input type="hidden" value="<%=c.getId()%>">
                <a class="btn btn-icon btn-sm btn-danger delete" href="javascript:void(0);" onclick="" data-container="body" data-html="true" data-toggle="kt-tooltip" title="Elimina documento">
                    <i class="fa fa-times"></i>
                </a>
            </div>
            <%}%>    
        </div>
        <div class='row'>
            <h5 class='kt-font-io-n'><%=c.getNome().replaceAll("_", " ")%></h5>
        </div>
    </div>
    <%}
        }%>
</div>

<script src="js/modelli.js"</script>