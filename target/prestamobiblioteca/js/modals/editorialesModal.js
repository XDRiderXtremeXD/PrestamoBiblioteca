// Script para los botones de "Ver Más" y "Editar"
document.addEventListener('DOMContentLoaded', function() {

	// Para el botón "Ver Más"
	const viewButtons = document.querySelectorAll('[data-bs-target="#viewPublisherModal"]');
	viewButtons.forEach(button => {
		button.addEventListener('click', function() {
			// Obtenemos los datos del botón
			const id = this.getAttribute('data-id');
			const nombre = this.getAttribute('data-nombre');
			const nacionalidad = this.getAttribute('data-nacionalidad');
			const generoLiterario = this.getAttribute('data-genero-literario');
			const anioFundacion = this.getAttribute('data-anio-fundacion');
			const paginaWeb = this.getAttribute('data-pagina-web');
			const direccion = this.getAttribute('data-direccion');
			const estado = this.getAttribute('data-estado');
			const foto = this.getAttribute('data-foto');

			// Asignamos los datos al modal
			document.getElementById('viewPublisherID').textContent = id;
			document.getElementById('viewPublisherName').textContent = nombre;
			document.getElementById('viewPublisherNationality').textContent = nacionalidad;
			document.getElementById('viewPublisherGenre').textContent = generoLiterario;
			document.getElementById('viewPublisherYear').textContent = anioFundacion;
			document.getElementById('viewPublisherWebsite').innerHTML = `<a href="${paginaWeb}" target="_blank">${paginaWeb}</a>`;
			document.getElementById('viewPublisherAddress').textContent = direccion;
			document.getElementById('viewPublisherState').textContent = estado;
			document.getElementById('viewPublisherPhoto').setAttribute('src', foto);
		});
	});

	// Para el botón "Editar"
	const editButtons = document.querySelectorAll('[data-bs-target="#editPublisherModal"]');
	editButtons.forEach(button => {
		button.addEventListener('click', function() {
			// Obtenemos los datos del botón
			const id = this.getAttribute('data-id');
			const nombre = this.getAttribute('data-nombre');
			const nacionalidad = this.getAttribute('data-nacionalidad');
			const generoLiterario = this.getAttribute('data-genero-literario');
			const anioFundacion = this.getAttribute('data-anio-fundacion');
			const paginaWeb = this.getAttribute('data-pagina-web');
			const direccion = this.getAttribute('data-direccion');
			const estado = this.getAttribute('data-estado');
			const foto = this.getAttribute('data-foto');

			console.log(id);

			// Asignamos los datos al modal
			document.getElementById('editPublisherName').value = nombre;
			document.getElementById('editPublisherNationality').value = nacionalidad;
			document.getElementById('editPublisherYear').value = anioFundacion;
			document.getElementById('editPublisherWebsite').value = paginaWeb;
			document.getElementById('editPublisherAddress').value = direccion;
			document.getElementById('editEditorialId').value = id;

			Array.from(document.getElementById('editLiteraryGenre').options).forEach(option => {
				option.selected = option.text === generoLiterario;
			});

			Array.from(document.getElementById('editPublisherState').options).forEach(option => {
				option.selected = option.text === estado;
			});

		});
	});


	// Para el botón "Eliminar"
	const deleteModal = document.getElementById('deletePublisherModal');
	if (deleteModal) {
		deleteModal.addEventListener('show.bs.modal', function (event) {
			const button = event.relatedTarget;
			const editorialId = button.getAttribute('data-id');
			const inputId = deleteModal.querySelector('#deleteEditorialId');
			inputId.value = editorialId;
		});
	}

});
