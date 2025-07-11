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


			editCantidad.value = cantidad;
			editObservacion.textContent = observacion;


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


// Script para actualizar el modal cuando se hace clic en el botón para cambiar estado
document.addEventListener('DOMContentLoaded', function() {
	// Seleccionar todos los botones para cambiar estado
	const changeStateButtons = document.querySelectorAll('[data-bs-toggle="modal"][data-bs-target="#confirmStatusChangeModal"]');

	changeStateButtons.forEach(button => {
		button.addEventListener('click', function() {
			// Obtener el ID del préstamo desde los atributos data-* del botón
			const idPrestamo = button.getAttribute('data-id');
			var estado = button.getAttribute('data-estado');  // No lo estamos usando, ya que el estado es fijo 'Devuelto'

			// Asignar el ID del préstamo al campo oculto en el modal
			document.getElementById('idPrestamo').value = idPrestamo;
			// Actualizar el texto del estado en el modal, si es necesario
			document.getElementById('estadoPrestamo').textContent = estado == "Devuelto" ? "Prestado" : "Devuelto";

			if (estado == "Devuelto") {
				document.getElementById('estadoPrestamo').classList.add('text-danger');  // Añadir clase 'text-danger'
				document.getElementById('estadoPrestamo').classList.remove('text-success');  // Eliminar clase 'text-success'
			}
			else {
				document.getElementById('estadoPrestamo').classList.remove('text-danger');  // Añadir clase 'text-danger'
				document.getElementById('estadoPrestamo').classList.add('text-success');  // Eliminar clase 'text-success'}	

			}
		});
	});
});

// Función para manejar la confirmación del cambio de estado
function cambiarEstado() {
	const idPrestamo = document.getElementById('idPrestamo').value;
    const nuevoEstado=document.getElementById('estadoPrestamo').textContent;
    
    console.log("aca  ",nuevoEstado);
    
	if (idPrestamo) {
		// Redirigir al servlet con el ID del préstamo y el nuevo estado
		window.location.href = `PrestamoDevolucionServlet?type=changeState&idPrestamo=${idPrestamo}&nuevoEstado=${nuevoEstado}`;
	} else {
		alert("El ID del préstamo no es válido.");
	}
}
