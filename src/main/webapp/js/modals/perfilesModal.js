document.addEventListener('DOMContentLoaded', () => {
    // Botones de "Ver más"
    const viewButtons = document.querySelectorAll('[data-bs-target="#viewProfileModal"]');
    viewButtons.forEach(button => {
        button.addEventListener('click', () => {
            const id = button.getAttribute('data-id');
            const usuario = button.getAttribute('data-usuario');
            const correo = button.getAttribute('data-correo-electronico');
            const nombres = button.getAttribute('data-nombres');
            const apellidos = button.getAttribute('data-apellidos');
            const rol = button.getAttribute('data-rol');
            const foto = button.getAttribute('data-foto-perfil');
            const estado = button.getAttribute('data-estado');

            // Referencias en el modal "Ver Perfil"
            document.getElementById('viewProfileID').textContent = id;
            document.getElementById('viewProfileUsername').textContent = usuario;
            document.getElementById('viewProfileEmail').textContent = correo;
            document.getElementById('viewProfileFirstName').textContent = nombres;
            document.getElementById('viewProfileLastName').textContent = apellidos;
            document.getElementById('viewProfileRole').textContent = rol;
            document.getElementById('viewProfilePhoto').setAttribute('src', foto);

            const estadoElement = document.getElementById('viewProfileState');
            estadoElement.textContent = estado;
            estadoElement.classList.toggle('text-success', estado.toLowerCase() === 'activo');
            estadoElement.classList.toggle('text-danger', estado.toLowerCase() !== 'activo');
        });
    });

    // Botones de "Editar"
    const editButtons = document.querySelectorAll('[data-bs-target="#editProfileModal"]');
    editButtons.forEach(button => {
        button.addEventListener('click', () => {
            const id = button.getAttribute('data-id');
            const usuario = button.getAttribute('data-usuario');
            const correo = button.getAttribute('data-correo-electronico');
            const nombres = button.getAttribute('data-nombres');
            const apellidos = button.getAttribute('data-apellidos');
            const rol = button.getAttribute('data-rol');
            const estado = button.getAttribute('data-estado');

            // Referencias en el modal "Editar Perfil"
            document.getElementById('editProfileId').value = id;
            document.getElementById('editProfileUsername').value = usuario;
            document.getElementById('editProfileEmail').value = correo;
            document.getElementById('editProfileFirstName').value = nombres;
            document.getElementById('editProfileLastName').value = apellidos;
            
            console.log(id);

            // Seleccionar el rol
            const roleSelect = document.getElementById('editProfileRole');
            Array.from(roleSelect.options).forEach(option => {
                option.selected = option.value === rol;
            });

            // Seleccionar el estado
            const stateSelect = document.getElementById('editProfileState');
            Array.from(stateSelect.options).forEach(option => {
                option.selected = option.value.toLowerCase() === estado.toLowerCase();
            });
        });
    });
    
    // Para el botón "Eliminar"
	const deleteModal = document.getElementById('deleteProfileModal');
	if (deleteModal) {
		deleteModal.addEventListener('show.bs.modal', function (event) {
			const button = event.relatedTarget;
			const profileId = button.getAttribute('data-id');
			const inputId = deleteModal.querySelector('#deleteProfileId');
			if (inputId) inputId.value = profileId;
		});
	}
});
