/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

    $("a.document").click(function (e) {
        var input = $($($(this).parent()[0]).find('input')[0]);
        clickLink(input.val(), "_blank");
    });
    $("a.download").click(function (e) {
        var input = $($($(this).parent()[0]).find('input')[0]);
        console.log(input.val());
        clickLink(input.val(), "");
    });
    
    
    function deleteDocCloud(id) {
    swal.fire({
        title: '<h3 class="kt-font-io-n"><b>Conferma Eliminazione</b></h3><br>',
        html: "<h5 style='text-align:center;'>Sicuro di voler eliminare questo documento?</h5>",
        animation: false,
        showCancelButton: true,
        confirmButtonText: '&nbsp;<i class="la la-check"></i>',
        cancelButtonText: '&nbsp;<i class="la la-close"></i>',
        cancelButtonClass: "btn btn-io-n",
        confirmButtonClass: "btn btn-io",
        customClass: {
            popup: 'large-swal animated bounceInUp'
        }
    }).then((result) => {
        if (result.value) {
            $.ajax({
                type: "POST",
                url: '<%=request.getContextPath()%>/OperazioniMicro?type=deleteDocCloud&id=' + id,
                processData: false,
                contentType: false,
                success: function (data) {
                    closeSwal();
                    var json = JSON.parse(data);
                    if (json.result) {
                        swalSuccessReload("Documento Eliminato", "Operazione eseguita con successo.");
                    } else {
                        swalError("Errore", json.message);
                    }
                },
                error: function () {
                    swalError("Errore", "Non è stato possibile eliminare il documento");
                }
            });
        } else {
            swal.close();
        }
    });
}
    $("a.delete").click(function (){
         deleteDocCloud($($($(this).parent()[0]).find('input')[0]).val());
    });
    function clickLink(link, target) {
        var a = document.createElement('a');
        a.href = link;
        a.target = target;
        document.body.appendChild(a);
        a.click();
        a.remove();
    }
