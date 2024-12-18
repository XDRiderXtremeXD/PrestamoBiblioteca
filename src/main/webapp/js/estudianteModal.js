document.addEventListener('DOMContentLoaded', function() {
    // Manejo del evento de "Ver Más"
    document.querySelectorAll('.view-student').forEach(function(button) {
        button.addEventListener('click', function() {
            // Obtener los atributos data-* del botón
            let idEstudiante = this.getAttribute('data-id');
            let dni = this.getAttribute('data-dni');
            let nombres = this.getAttribute('data-nombres');
            let apellidos = this.getAttribute('data-apellidos');
            let direccion = this.getAttribute('data-direccion');
            let telefono = this.getAttribute('data-telefono');
            let correoElectronico = this.getAttribute('data-correo-electronico');
            let fechaNacimiento = this.getAttribute('data-fecha-nacimiento');
            let genero = this.getAttribute('data-genero');
            let facultad = this.getAttribute('data-facultad');
            let estado = this.getAttribute('data-estado');

            // Asignar los valores al modal "Ver Más"
            document.getElementById('viewStudentID').textContent = idEstudiante;
            document.getElementById('viewStudentDNI').textContent = dni;
            document.getElementById('viewStudentFirstName').textContent = nombres;
            document.getElementById('viewStudentLastName').textContent = apellidos;
            document.getElementById('viewStudentAddress').textContent = direccion;
            document.getElementById('viewStudentPhone').textContent = telefono;
            document.getElementById('viewStudentEmail').textContent = correoElectronico;
            document.getElementById('viewStudentBirthDate').textContent = fechaNacimiento;
            document.getElementById('viewStudentGender').textContent = genero;
            document.getElementById('viewStudentFaculty').textContent = facultad;
            document.getElementById('viewStudentState').textContent = estado;
        });
    });

    // Manejo del evento de "Editar"
    document.querySelectorAll('.edit-student').forEach(function(button) {
        button.addEventListener('click', function() {
            // Obtener los atributos data-* del botón
            let idEstudiante = this.getAttribute('data-id');
            let dni = this.getAttribute('data-dni');
            let nombres = this.getAttribute('data-nombres');
            let apellidos = this.getAttribute('data-apellidos');
            let direccion = this.getAttribute('data-direccion');
            let telefono = this.getAttribute('data-telefono');
            let correoElectronico = this.getAttribute('data-correo-electronico');
            let fechaNacimiento = this.getAttribute('data-fecha-nacimiento');
            let genero = this.getAttribute('data-genero');
            let facultad = this.getAttribute('data-facultad');
            let estado = this.getAttribute('data-estado');

            // Asignar los valores al formulario de edición
            document.getElementById('editStudentDNI').value = dni;
            document.getElementById('editStudentFirstName').value = nombres;
            document.getElementById('editStudentLastName').value = apellidos;
            document.getElementById('editStudentAddress').value = direccion;
            document.getElementById('editStudentPhone').value = telefono;
            document.getElementById('editStudentEmail').value = correoElectronico;
            document.getElementById('editStudentBirthDate').value = fechaNacimiento;
            
       
         Array.from(document.getElementById('editFaculty').options).forEach(option => {
				option.selected = option.text === facultad;
			});
			 Array.from(document.getElementById('editstudentGender').options).forEach(option => {
				option.selected = option.text === genero;
			});
			
			Array.from(document.getElementById('editStudentState').options).forEach(option => {
				option.selected = option.text === estado;
			});
       
        });
    });
});
