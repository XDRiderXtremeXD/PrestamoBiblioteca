document.addEventListener('DOMContentLoaded', () => {
    // Capturamos todos los botones de "Ver más"
    const viewButtons = document.querySelectorAll('[data-bs-target="#viewAuthorModal"]');
    viewButtons.forEach(button => {
        button.addEventListener('click', () => {
            // Obtenemos los datos del botón
            const id = button.getAttribute('data-id');
            const nombre = button.getAttribute('data-nombre');
            const nacionalidad = button.getAttribute('data-nacionalidad');
            const generoLiterario = button.getAttribute('data-id-genero-literario');
            const fechaNacimiento = button.getAttribute('data-fecha-nacimiento');
            const biografia = button.getAttribute('data-biografia');
            const estado = button.getAttribute('data-estado');
            
            // Referencias a los campos del modal "Ver más"
            document.getElementById('viewAuthorID').textContent = id;
            document.getElementById('viewAuthorName').textContent = nombre;
            document.getElementById('viewAuthorNationality').textContent = nacionalidad;
            document.getElementById('viewAuthorGenre').textContent = generoLiterario;
            document.getElementById('viewAuthorBirthDate').textContent = fechaNacimiento;
            document.getElementById('viewAuthorBio').textContent = biografia;
            document.getElementById('viewAuthorPhoto').src = "ruta/a/foto/" + id + ".jpg"; // Actualiza con la ruta de la foto
            document.getElementById('viewAuthorPhoto').alt = "Foto de " + nombre;
            document.getElementById('viewAuthorBio').textContent = biografia;

            // Actualizar estado
            const estadoElement = document.getElementById('viewAuthorBio');
            estadoElement.textContent = estado;
            estadoElement.classList.toggle('text-success', estado === 'Activo');
            estadoElement.classList.toggle('text-danger', estado !== 'Activo');
        });
    });

    // Capturamos todos los botones de "Editar"
    const editButtons = document.querySelectorAll('[data-bs-target="#editAuthorModal"]');
    editButtons.forEach(button => {
        button.addEventListener('click', () => {
            // Obtenemos los datos del botón
            const id = button.getAttribute('data-id');
            const nombre = button.getAttribute('data-nombre');
            const nacionalidad = button.getAttribute('data-nacionalidad');
            const generoLiterario = button.getAttribute('data-id-genero-literario');
            const fechaNacimiento = button.getAttribute('data-fecha-nacimiento');
            const biografia = button.getAttribute('data-biografia');
            const estado = button.getAttribute('data-estado');
            
            // Referencias a los campos del modal "Editar"
            document.getElementById('editAuthorName').value = nombre;
            document.getElementById('edirAuthorNationality').value = nacionalidad;
            document.getElementById('editLiteraryGenre').value = generoLiterario;
            document.getElementById('editAuthorBirthDate').value = fechaNacimiento;
            
            // Actualizar estado (opcional si el campo estado también se puede editar)
            document.getElementById('editAuthorState').value = estado;
            document.getElementById('editAuthorBio').value = biografia;
        });
    });
});
