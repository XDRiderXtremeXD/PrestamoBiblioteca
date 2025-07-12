document.addEventListener('DOMContentLoaded', () => {
    // Botones "Ver más"
    document.querySelectorAll('[data-bs-target="#viewCourseModal"]').forEach(button => {
        button.addEventListener('click', () => {
            const id = button.getAttribute('data-id');
            const nombre = button.getAttribute('data-nombre');
            const nivel = button.getAttribute('data-nivel');
            const descripcion = button.getAttribute('data-descripcion');
            const estado = button.getAttribute('data-estado');

            // Setear valores en el modal
            document.getElementById('viewCourseID').textContent = id || '-';
            document.getElementById('viewCourseName').textContent = nombre || '-';
            document.getElementById('viewCourseLevel').textContent = nivel || '-';
            document.getElementById('viewCourseDescription').textContent = descripcion || '-';

            const estadoElement = document.getElementById('viewCourseState');
            estadoElement.textContent = estado || '-';
            estadoElement.classList.toggle('text-success', estado.toLowerCase() === 'activo');
            estadoElement.classList.toggle('text-danger', estado.toLowerCase() !== 'activo');
        });
    });

    // Botones "Editar"
    document.querySelectorAll('[data-bs-target="#editCourseModal"]').forEach(button => {
        button.addEventListener('click', () => {
            const id = button.getAttribute('data-id');
            const nombre = button.getAttribute('data-nombre');
            const nivel = button.getAttribute('data-nivel');
            const descripcion = button.getAttribute('data-descripcion');
            const estado = button.getAttribute('data-estado');
            
            console.log(id);
            
            document.getElementById('editCursoId').value = id;
            document.getElementById('editCourseName').value = nombre;
            document.getElementById('editCourseDescription').value = descripcion;

            Array.from(document.getElementById('editCourseLevel').options).forEach(option => {
                option.selected = option.text === nivel;
            });
            Array.from(document.getElementById('editCourseState').options).forEach(option => {
                option.selected = option.text.toLowerCase() === estado.toLowerCase();
            });
        });
    });
});
