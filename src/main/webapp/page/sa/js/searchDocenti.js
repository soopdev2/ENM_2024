/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


  function swalTablePrg(iddocente) {
                swal.fire({
                    html: '<table class="table table-bordered" id="kt_table_allievi">'
                            + '<thead>'
                            + '<tr>'
                            + '<th class="text-uppercase text-center">Nome</th>'
                            + '<th class="text-uppercase text-center">Data Inizio</th>'
                            + '<th class="text-uppercase text-center">Data Fine</th>'
                            + '<th class="text-uppercase text-center">Soggetto Esecutore</th>'
                            + '</tr>'
                            + '</thead>'
                            + '</table>',
                    width: '75%',
                    scrollbarPadding: true,
                    showCloseButton: true,
                    showCancelButton: false,
                    showConfirmButton: false,
                    onOpen: function () {
                        $("#kt_table_allievi").DataTable({
                            dom: `<'row'<'col-sm-12'ftr>><'row'<'col-sm-12 col-md-2'i><'col-sm-12 col-md-10 dataTables_pager'lp>>`,
                            lengthMenu: [15, 25, 50],
                            language: {
                                "lengthMenu": "Mostra _MENU_",
                                "infoEmpty": "Mostrati 0 di 0 per 0",
                                "loadingRecords": "Caricamento...",
                                "search": "Cerca:",
                                "zeroRecords": "Nessun risultato trovato",
                                "info": "Mostrati _END_ di _TOTAL_ ",
                                "emptyTable": "Nessun risultato",
                                "sInfoFiltered": "(filtrato su _MAX_ risultati totali)"
                            },
                            scrollY: "40vh",
                            ajax: '<%=request.getContextPath()%>/QuerySA?type=searchProgettiDocente&iddocente=' + iddocente,
                            order: [],
                            columns: [
                                {data: 'nome.descrizione'},
                                {data: 'start'},
                                {data: 'end'},
                                {data: 'soggetto.ragionesociale'}
                            ], columnDefs: [
                                {
                                    targets: 1,
                                    type: 'date-it',
                                    render: function (data, type, row, meta) {
                                        return formattedDate(new Date(data));
                                    }
                                }, {
                                    targets: 2,
                                    type: 'date-it',
                                    render: function (data, type, row, meta) {
                                        return formattedDate(new Date(data));
                                    }
                                }
                            ]
                        });
                    }
                });
            }
            
             function reload() {
                $('html, body').animate({scrollTop: $('#offsetresult').offset().top}, 500);
                reload_table($('#kt_table_1'));
            }
            
            function swaleditMail(iddocente, mailaddress) {

                var html = "<div class='form-group' id='swal_doc'>"
                        + "<label>Mail:</label>"
                        + "<input class='form-control obbligatory' id='email_d' name='email_d' value='" + mailaddress + "' />"
                        + "</div>";
                swal.fire({
                    title: '<h2 class="kt-font-io-n"><b>Modifica Email Docente</b></h2><br>',
                    html: html,
                    animation: false,
                    showCancelButton: true,
                    confirmButtonText: '&nbsp;<i class="la la-check"></i>',
                    cancelButtonText: '&nbsp;<i class="la la-close"></i>',
                    cancelButtonClass: "btn btn--n",
                    confirmButtonClass: "btn btn-io",
                    width: '750px',
                    customClass: {
                        popup: 'animated bounceInUp'
                    },
                    preConfirm: function () {
                        return new Promise(function (resolve) {
                            resolve({
                                "email": $('#email_d').val()
                            });
                        });
                    }
                }).then((result) => {
                    if (result.value) {
                        modifyMail(iddocente, result.value);
                    } else {
                        swal.close();
                    }
                });
            }