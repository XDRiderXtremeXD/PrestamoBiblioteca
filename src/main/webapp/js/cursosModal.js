document.addEventListener('DOMContentLoaded', () => {
    // Capturamos todos los botones de "Ver más"
    const viewButtons = document.querySelectorAll('[data-bs-target="#viewCourseModal"]');
    viewButtons.forEach(button => {
        button.addEventListener('click', () => {
            // Obtenemos los datos del botón
            const id = button.getAttribute('data-id');
            const nombre = button.getAttribute('data-nombre');
            const nivel = button.getAttribute('data-nivel');
            const descripcion = button.getAttribute('data-descripcion');
            const estado = button.getAttribute('data-estado');
            
            // Referencias a los campos del modal "Ver más"
            document.getElementById('viewCourseID').textContent = id;
            document.getElementById('viewCourseName').textContent = nombre;
            document.getElementById('viewCourseLevel').textContent = nivel;
            document.getElementById('viewCourseDescription').textContent = descripcion;
            
            // Actualizar estado
            const estadoElement = document.getElementById('viewCourseState');
            estadoElement.textContent = estado;
            estadoElement.classList.toggle('text-success', estado === 'Activo');
            estadoElement.classList.toggle('text-danger', estado !== 'Activo');
        });
    });

    // Capturamos todos los botones de "Editar"
    const editButtons = document.querySelectorAll('[data-bs-target="#editCourseModal"]');
    editButtons.forEach(button => {
        button.addEventListener('click', () => {
            // Obtenemos los datos del botón
            const id = button.getAttribute('data-id');
            const nombre = button.getAttribute('data-nombre');
            const nivel = button.getAttribute('data-nivel');
            const descripcion = button.getAttribute('data-descripcion');
            const estado = button.getAttribute('data-estado');
            
            // Referencias a los campos del modal "Editar"
            document.getElementById('editCourseName').value = nombre;
            document.getElementById('editCourseDescription').value = descripcion;
            
            
            
             Array.from(document.getElementById('editCourseLevel').options).forEach(option => {
				option.selected = option.text === nivel;
			});
			 Array.from(document.getElementById('editCourseState').options).forEach(option => {
				option.selected = option.text === estado;
			});
            
            
        });
    });
});
