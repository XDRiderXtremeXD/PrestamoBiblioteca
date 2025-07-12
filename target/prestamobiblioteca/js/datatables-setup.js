function setupDataTable(tableId) {
    $(document).ready(function() {
        var table = $(tableId).DataTable({
            "searching": false,
            "lengthChange": false,
            "paging": true,
            "ordering": true,
            "language": {
                "info": "Mostrando _START_ a _END_ de _TOTAL_ registros",
                "infoEmpty": "Mostrando 0 a 0 de 0 registros",
                "paginate": {
                    "first": "Primera",
                    "previous": "Anterior",
                    "next": "Siguiente",
                    "last": "Última"
                }
            }
        });
    });
}