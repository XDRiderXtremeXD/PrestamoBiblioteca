// Cuando el modal de "Ver más" se activa
document.querySelectorAll('.view-book').forEach(button => {
	button.addEventListener('click', function() {
		const button = this;

		// Capturar los datos del botón
		const id = button.getAttribute('data-id');
		const titulo = button.getAttribute('data-titulo');
		const autor = button.getAttribute('data-autor');
		const editorial = button.getAttribute('data-editorial');
		const curso = button.getAttribute('data-curso');
		const fechaLanzamiento = button.getAttribute('data-fecha-lanzamiento');
		const genero = button.getAttribute('data-genero');
		const estado = button.getAttribute('data-estado');
		const ejemplaresTotales = button.getAttribute('data-ejemplares-totales');
		const ejemplaresPrestados = button.getAttribute('data-ejemplares-prestados');
		const ejemplaresDisponibles = button.getAttribute('data-ejemplares-disponibles');

		// Insertar los datos en los campos del modal
		document.getElementById('viewBookID').textContent = id;
		document.getElementById('viewBookTitle').textContent = titulo;
		document.getElementById('viewBookAuthor').textContent = autor;
		document.getElementById('viewBookPublisher').textContent = editorial;
		document.getElementById('viewBookCourse').textContent = curso;
		document.getElementById('viewReleaseDate').textContent = fechaLanzamiento;
		document.getElementById('viewBookGenre').textContent = genero;
		document.getElementById('viewBookState').textContent = estado;
		document.getElementById('viewBookAvailableCopies').textContent = ejemplaresDisponibles;
		document.getElementById('viewBookBorrowedCopies').textContent = ejemplaresPrestados;		
	});
});

// Cuando el modal de "Editar" se activa
document.querySelectorAll('.edit-book').forEach(button => {
	button.addEventListener('click', function() {
		const button = this;

		// Capturar los datos del botón
		const id = button.getAttribute('data-id');
		const titulo = button.getAttribute('data-titulo');
		const autor = button.getAttribute('data-autor');
		const editorial = button.getAttribute('data-editorial');
		const curso = button.getAttribute('data-curso');
		const fechaLanzamiento = button.getAttribute('data-fecha-lanzamiento');
		const genero = button.getAttribute('data-genero');
		const estado = button.getAttribute('data-estado');
		const ejemplaresTotales = button.getAttribute('data-ejemplares-totales');
		const ejemplaresPrestados = button.getAttribute('data-ejemplares-prestados');
		const ejemplaresDisponibles = button.getAttribute('data-ejemplares-disponibles');

		// Insertar los datos en los campos del modal de edición
		document.getElementById('editBookTitle').value = titulo;
		document.getElementById('editBookCopyTotal').value = ejemplaresTotales;
		document.getElementById('editReleaseDate').value = fechaLanzamiento;
		document.getElementById('editBookId').value = id;
     
        console.log("Genero ",genero);
         console.log("Prestados ",ejemplaresPrestados);
     
		Array.from(document.getElementById('editLiteraryGenre').options).forEach(option => {
			option.selected = option.text === genero;
		});
		Array.from(document.getElementById('editAuthor').options).forEach(option => {
			option.selected = option.text === autor;
		});
		Array.from(document.getElementById('editBookEditorial').options).forEach(option => {
			option.selected = option.text === editorial;
		});

		Array.from(document.getElementById('editLiteraryGenre').options).forEach(option => {
			option.selected = option.text === genero;
		});

		Array.from(document.getElementById('editBookCourse').options).forEach(option => {
			option.selected = option.text === curso;
		});

		Array.from(document.getElementById('editBookState').options).forEach(option => {
			option.selected = option.text === estado;
		});

	});
});
