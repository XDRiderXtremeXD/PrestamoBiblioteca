document.addEventListener('DOMContentLoaded', () => {
    // Capturamos todos los botones de "Ver más"
    const viewButtons = document.querySelectorAll('[data-bs-target="#viewProfileModal"]');
    viewButtons.forEach(button => {
        button.addEventListener('click', () => {
            // Obtenemos los datos del botón
            const id = button.getAttribute('data-id');
            const usuario = button.getAttribute('data-usuario');
            const correoElectronico = button.getAttribute('data-correo-electronico');
            const nombres = button.getAttribute('data-nombres');
            const apellidos = button.getAttribute('data-apellidos');
            const rol = button.getAttribute('data-rol');
            const fotoPerfil = button.getAttribute('data-foto-perfil');
            const estado = button.getAttribute('data-estado');
            
            // Referencias a los campos del modal "Ver más"
            document.getElementById('viewProfileID').textContent = id;
            document.getElementById('viewProfileUsername').textContent = usuario;
            document.getElementById('viewProfileEmail').textContent = correoElectronico;
            document.getElementById('viewProfileFirstName').textContent = nombres;
            document.getElementById('viewProfileLastName').textContent = apellidos;
            document.getElementById('viewProfileRole').textContent = rol;
            document.getElementById('viewProfilePhoto').setAttribute('src', fotoPerfil);
            
            // Mostrar el estado en el color adecuado
            const estadoElement = document.getElementById('viewProfileState');
            estadoElement.textContent = estado;
            estadoElement.classList.toggle('text-success', estado === 'Activo');
            estadoElement.classList.toggle('text-danger', estado !== 'Activo');
        });
    });
});

document.addEventListener('DOMContentLoaded', () => {
    // Capturamos todos los botones de "Editar"
    const editButtons = document.querySelectorAll('[data-bs-target="#editProfileModal"]');
    editButtons.forEach(button => {
        button.addEventListener('click', () => {
            // Obtenemos los datos del botón
            const id = button.getAttribute('data-id');
            const usuario = button.getAttribute('data-usuario');
            const correoElectronico = button.getAttribute('data-correo-electronico');
            const nombres = button.getAttribute('data-nombres');
            const apellidos = button.getAttribute('data-apellidos');
            const rol = button.getAttribute('data-rol');
            
            // Referencias a los campos del modal "Editar"
            document.getElementById('editProfileUsername').value = usuario;
            document.getElementById('editProfileEmail').value = correoElectronico;
            document.getElementById('editProfileFirstName').value = nombres;
            document.getElementById('editProfileLastName').value = apellidos;
            
            Array.from(document.getElementById('profileRole').options).forEach(option => {
				option.selected = option.text === rol;
			});
        });
    });
});

