document.addEventListener('DOMContentLoaded', () => {
    const viewLoanModal = document.getElementById('viewLoanModal');
    // Capturamos todos los botones de "Ver más"
    const viewButtons = document.querySelectorAll('[data-bs-target="#viewLoanModal"]');
    viewButtons.forEach(button => {
        button.addEventListener('click', () => {
			console.log("Entra1");
            // Obtenemos los datos del botón
            const id = button.getAttribute('data-id');
            const libro = button.getAttribute('data-libro');
            const estudiante = button.getAttribute('data-estudiante');
            const fechaPrestamo = button.getAttribute('data-fecha-prestamo');
            const fechaDevolucion = button.getAttribute('data-fecha-devolucion');
            const cantidad = button.getAttribute('data-cantidad');
            const estado = button.getAttribute('data-estado');
            
            console.log(estudiante);

            // Rellenamos los campos del modal
            viewLoanModal.querySelector('#loanId').textContent = id;
            viewLoanModal.querySelector('#loanBook').textContent = libro;
            viewLoanModal.querySelector('#loanStudent').textContent = estudiante;
            viewLoanModal.querySelector('#loanDate').textContent = fechaPrestamo;
            viewLoanModal.querySelector('#returnDate').textContent = fechaDevolucion;
            viewLoanModal.querySelector('#loanQuantity').textContent = cantidad;
            viewLoanModal.querySelector('#loanStatus').textContent = estado;
            
            document.querySelector('.filter-option-inner-inner').textContent = "Nuevo título aquí";
        });
    });    
});
