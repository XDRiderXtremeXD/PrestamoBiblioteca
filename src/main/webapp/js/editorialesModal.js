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

            // Asignamos los datos al modal
            document.getElementById('editPublisherName').value = nombre;
            document.getElementById('editPublisherNationality').value = nacionalidad;
            document.getElementById('editPublisherYear').value = anioFundacion;
            document.getElementById('editPublisherWebsite').value = paginaWeb;
            document.getElementById('editPublisherAddress').value = direccion;
            
      Array.from(document.getElementById('editLiteraryGenre').options).forEach(option => {
				option.selected = option.text === generoLiterario;
			});
			
			Array.from(document.getElementById('editPublisherState').options).forEach(option => {
				option.selected = option.text === estado;
			});

        });
    });

});
