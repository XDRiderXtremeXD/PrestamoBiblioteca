package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Estudiante;
import entidades.Libro;
import entidades.PrestamoDevolucion; // Cambiado para referirse a PrestamoDevolucion
import modelos.EstudianteModel;
import modelos.LibroModel;
import modelos.PrestamoDevolucionModel; // Cambiado para el modelo de PrestamoDevolucion

/**
 * Servlet implementation class PrestamoDevolucionServlet
 */
@WebServlet("/PrestamoDevolucionServlet")
public class PrestamoDevolucionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String type = request.getParameter("type");
		System.out.println("Acción recibida: " + type);

		// Selección de la acción basada en el parámetro 'type'
		switch (type) {
		case "list":
			listPrestamosDevoluciones(request, response);
			break;
		case "view":
			getPrestamoDevolucion(request, response);
			break;
		case "create":
			createPrestamoDevolucion(request, response);
			break;
		case "update":
			updatePrestamoDevolucion(request, response);
			break;
		case "changeState":
			changeState(request, response);
			break;
		default:
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
			break;
		}
	}

	private void changeState(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    // Obtener los parámetros de la solicitud
	    int idPrestamo = Integer.parseInt(request.getParameter("idPrestamo"));
	    String nuevoEstado = request.getParameter("nuevoEstado");

	    // Crear el objeto PrestamoDevolucion
	    PrestamoDevolucion prestamoDevolucion = new PrestamoDevolucion();
	    prestamoDevolucion.setIdPrestamo(idPrestamo);
	    prestamoDevolucion.setEstado(nuevoEstado);

	    // Llamar al modelo para cambiar el estado del préstamo/devolución
	    PrestamoDevolucionModel model = new PrestamoDevolucionModel();
	    int resultado = model.updatePrestamo(prestamoDevolucion); // Usamos updatePrestamo para actualizar el estado

	    if (resultado > 0) {
	        // Si la actualización fue exitosa, redirigir al listado
	        response.sendRedirect("PrestamoDevolucionServlet?type=list");
	    } else {
	        // En caso de error, redirigir o mostrar mensaje de error
	        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al cambiar el estado");
	    }
	}

	// Método para obtener un prestamo/devolución por ID
	private void getPrestamoDevolucion(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		PrestamoDevolucionModel model = new PrestamoDevolucionModel();
		PrestamoDevolucion prestamoDevolucion = model.getPrestamo(id);

		// Establecer el prestamoDevolucion como atributo de la solicitud
		request.setAttribute("prestamoDevolucion", prestamoDevolucion);
		// request.getRequestDispatcher("prestamoDevolucionView.jsp").forward(request,
		// response);
	}

	// Método para listar todos los prestamos y devoluciones
	private void listPrestamosDevoluciones(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrestamoDevolucionModel model = new PrestamoDevolucionModel();
		List<PrestamoDevolucion> data = model.listPrestamo(); // Llamada al modelo para obtener la lista de
																// prestamos/devoluciones

		LibroModel model2 = new LibroModel();
		List<Libro> libros = model2.listLibro(); // Llamada al modelo para obtener la lista de prestamos/devoluciones

		EstudianteModel model3 = new EstudianteModel();
		List<Estudiante> estudiantes = model3.listEstudiante(); // Llamada al modelo para obtener la lista de
																// prestamos/devoluciones

		// Establecer la lista de prestamosDevoluciones como atributo de la solicitud
		request.setAttribute("data", data);
		request.setAttribute("libros", libros);
		request.setAttribute("estudiantes", estudiantes);
		request.getRequestDispatcher("pyd.jsp").forward(request, response);
	}

	// Método para crear un nuevo prestamoDevolucion
	private void createPrestamoDevolucion(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Recuperar los parámetros del formulario
		String Libro = request.getParameter("idLibro");
		String Estudiante = request.getParameter("idEstudiante");
		String fechaPrestamo = request.getParameter("fechaPrestamo");
		String fechaDevolucion = request.getParameter("fechaDevolucion");
		int cantidad = Integer.parseInt(request.getParameter("cantidad"));
		String estado = request.getParameter("estado");
		String observacion = request.getParameter("observacion");

		// Crear el objeto PrestamoDevolucion
		PrestamoDevolucion prestamoDevolucion = new PrestamoDevolucion();
		prestamoDevolucion.setLibro(Libro);
		prestamoDevolucion.setEstudiante(Estudiante);
		prestamoDevolucion.setFechaPrestamo(java.sql.Date.valueOf(fechaPrestamo));
		prestamoDevolucion.setFechaDevolucion(java.sql.Date.valueOf(fechaDevolucion));
		prestamoDevolucion.setCantidad(cantidad);
		prestamoDevolucion.setEstado(estado);
		prestamoDevolucion.setObservacion(observacion);

		// Llamar al modelo para crear el prestamoDevolucion
		PrestamoDevolucionModel model = new PrestamoDevolucionModel();
		model.createPrestamo(prestamoDevolucion);

		// Redirigir al listado de prestamos
		// response.sendRedirect("PrestamoDevolucionServlet?type=list");
	}

	// Método para actualizar un prestamoDevolucion existente
	private void updatePrestamoDevolucion(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		String Libro = request.getParameter("idLibro");
		String Estudiante = request.getParameter("idEstudiante");
		String fechaPrestamo = request.getParameter("fechaPrestamo");
		String fechaDevolucion = request.getParameter("fechaDevolucion");
		int cantidad = Integer.parseInt(request.getParameter("cantidad"));
		String estado = request.getParameter("estado");
		String observacion = request.getParameter("observacion");

		// Crear el objeto PrestamoDevolucion
		PrestamoDevolucion prestamoDevolucion = new PrestamoDevolucion();
		prestamoDevolucion.setIdPrestamo(id);
		prestamoDevolucion.setLibro(Libro);
		prestamoDevolucion.setEstudiante(Estudiante);
		prestamoDevolucion.setFechaPrestamo(java.sql.Date.valueOf(fechaPrestamo));
		prestamoDevolucion.setFechaDevolucion(java.sql.Date.valueOf(fechaDevolucion));
		prestamoDevolucion.setCantidad(cantidad);
		prestamoDevolucion.setEstado(estado);
		prestamoDevolucion.setObservacion(observacion);

		// Llamar al modelo para actualizar el prestamoDevolucion
		PrestamoDevolucionModel model = new PrestamoDevolucionModel();
		model.updatePrestamo(prestamoDevolucion);

		// Redirigir al listado de prestamos
		// response.sendRedirect("PrestamoDevolucionServlet?type=list");
	}
}
