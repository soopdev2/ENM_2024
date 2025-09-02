/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function getMaxhours(idselect, check) {
    var selected_2 = $('#' + idselect).val();
    $('#form_add select').each(
            function (index) {
                var input = $(this);
                var ew = '_docereg';
                if (check) {
                    ew = '_docereg_' + idselect.split("_")[2];
                }
                if (input.attr('id').endsWith(ew)) {
                    var selected = $('#' + input.attr('id')).val();
                    if (BigInt(selected_2) > BigInt(selected)) {
                        $('#' + idselect).val(selected).trigger('change');
                        $('#modaltexterror').html("Le ore dell'allievo non possono superare quelle del docente della lezione (<b>"
                                + $("#" + input.attr('id') + " option:selected").text() + "</b>).");
                        $('#modalerror').modal('toggle');
                        return false;
                    }
                }
            }
    );
}

function setMaxhours(idselect, check) {
    var selected = $('#' + idselect).val();
    $('#form_add select').each(
            function (index) {
                var input = $(this);
                var ew = '_allreg';
                if (check) {
                    ew = '_allreg_' + idselect.split("_")[2];
                }
                if (input.attr('id').endsWith(ew)) {
                    var selected_2 = $('#' + input.attr('id')).val();
                    if (BigInt(selected_2) > BigInt(selected)) {
                        $('#' + input.attr('id')).val(selected).trigger('change');
                    }
                }
            }
    );
}
