document.querySelectorAll('.showSweetAlert').forEach(button => {
    button.addEventListener('click', function (event) {
        // Prevenir el envío del formulario
        event.preventDefault();

        // Obtener los datos de texto e icono desde los atributos del botón
        const text = this.getAttribute('data-text');
        const icon = this.getAttribute('data-icon');

        // Llamar a la función para mostrar la alerta
        showSweetAlert(text, icon);
    });
});

function showSweetAlert(text, icon = 'success') {
    Swal.fire({
        title: '¡Éxito!',
        text: text,
        icon: icon,
        background: 'var(--bs-body-bg)',
        color: 'var(--bs-body-color)',
        customClass: {
            popup: '',
            confirmButton: 'btn btn-success',
        },
        buttonsStyling: false,
        confirmButtonText: 'Aceptar'
    });
}
