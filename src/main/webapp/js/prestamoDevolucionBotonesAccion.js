    function searchPrestamo() {
		console.log("hola");
        // Obtener el valor del campo de búsqueda
        var filtro = document.getElementById("customSearch").value;
  console.log(document.getElementById("customSearch").value);
        // Crear la URL dinámica con el filtro como parámetro
        var url = "PrestamoDevolucionServlet?type=listFilter&filtro="+filtro;

        // Redirigir a la URL con el parámetro de búsqueda
        location.href = url;
    }