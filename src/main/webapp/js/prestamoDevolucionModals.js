document.addEventListener('DOMContentLoaded', () => {


	// Capturamos todos los botones de "Ver más"
	const edituttons = document.querySelectorAll('[data-bs-target="#editLoanModal"]');
	edituttons.forEach(button => {
		button.addEventListener('click', () => {
			const editLoanBookSelect = document.getElementById('editLoanBook');
			const editLoanStudentSelect = document.getElementById('editLoanStudent');
			// Obtener el ID del libro del atributo data-libro
			const selectedBook = button.getAttribute('data-libro');
			const selectedStudent = button.getAttribute('data-estudiante');
			
			  // Referencia a los campos de fecha en el formulario
    		const loanDateInput = document.getElementById('editLoanDate');
    		const returnDateInput = document.getElementById('editReturnDate');

   			// Obtener las fechas desde los atributos data del botón
            const loanDate = button.getAttribute('data-fecha-prestamo');
            const returnDate = button.getAttribute('data-fecha-devolucion');
            
              // Referencia a los campos de fecha en el formulario
    		const editCantidad = document.getElementById('editLoanQuantity');
    		const editObservacion = document.getElementById('editloanObservation');
            
            const cantidad = button.getAttribute('data-cantidad');
            const observacion = button.getAttribute('data-observacion');
            
            
            editCantidad.value=cantidad;
            editObservacion.textContent=observacion;


            // Asignar las fechas a los inputs
            loanDateInput.value = loanDate;
            returnDateInput.value = returnDate;
           
			
			// Establecer la selección en el campo select
			Array.from(editLoanBookSelect.options).forEach(option => {
				option.selected = option.text === selectedBook;
			});
			
			Array.from(editLoanStudentSelect.options).forEach(option => {
				option.selected = option.text === selectedStudent;
			});

			// Si tienes una librería personalizada para estilizar el select
			if (editLoanBookSelect.classList.contains('selectPersonalized')) {
				// Asegúrate de actualizar visualmente el select
				editLoanBookSelect.dispatchEvent(new Event('change'));
			}
		});
	});



	// Capturamos todos los botones de "Ver más"
	const viewButtons = document.querySelectorAll('[data-bs-target="#viewLoanModal"]');
	viewButtons.forEach(button => {
		button.addEventListener('click', () => {
			const viewLoanModal = document.getElementById('viewLoanModal');
			// Obtenemos los datos del botón
			const id = button.getAttribute('data-id');
			const libro = button.getAttribute('data-libro');
			const estudiante = button.getAttribute('data-estudiante');
			const fechaPrestamo = button.getAttribute('data-fecha-prestamo');
			const fechaDevolucion = button.getAttribute('data-fecha-devolucion');
			const cantidad = button.getAttribute('data-cantidad');
			const estado = button.getAttribute('data-estado');
			const observacion = button.getAttribute('data-observacion');

			// Rellenamos los campos del modal
			viewLoanModal.querySelector('#loanId').textContent = id;
			viewLoanModal.querySelector('#loanBook').textContent = libro;
			viewLoanModal.querySelector('#loanStudent').textContent = estudiante;
			viewLoanModal.querySelector('#loanDate').textContent = fechaPrestamo;
			viewLoanModal.querySelector('#returnDate').textContent = fechaDevolucion;
			viewLoanModal.querySelector('#loanQuantity').textContent = cantidad;
			viewLoanModal.querySelector('#loanStatus').textContent = estado;
			viewLoanModal.querySelector('#loanObservation').textContent = observacion;
		});
	});
  
  



});
