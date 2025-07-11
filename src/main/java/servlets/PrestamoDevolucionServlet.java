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

		System.out.println("aca");
		// Obtener los parámetros de la solicitud
		int idPrestamo = Integer.parseInt(request.getParameter("idPrestamo"));
		String nuevoEstado = request.getParameter("nuevoEstado");

		PrestamoDevolucionModel model = new PrestamoDevolucionModel();
		int resultado = model.changeState(idPrestamo, nuevoEstado); // Usamos updatePrestamo para actualizar el estado

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
		
		String filtro = request.getParameter("filtro");
		System.out.println(filtro);
		PrestamoDevolucionModel model = new PrestamoDevolucionModel();
		List<PrestamoDevolucion> data = model.listPrestamo(filtro==null?"":filtro);		

		LibroModel model2 = new LibroModel();
		List<Libro> libros = model2.listLibro(""); // Llamada al modelo para obtener la lista de prestamos/devoluciones

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
	    String idLibro = request.getParameter("addLoanBook");
	    String idEstudiante = request.getParameter("addLoanStudent");
	    String fechaPrestamo = request.getParameter("addLoanDate");
	    String fechaDevolucion = request.getParameter("addReturnDate");
	    int cantidad = Integer.parseInt(request.getParameter("addLoanQuantity"));
	    String estado = request.getParameter("state");
	    String observacion = request.getParameter("addLoanObservation");

	 // Depuración de los valores recuperados
	    System.out.println("idLibro: " + idLibro);
	    System.out.println("idEstudiante: " + idEstudiante);
	    System.out.println("fechaPrestamo: " + fechaPrestamo);
	    System.out.println("fechaDevolucion: " + fechaDevolucion);
	    System.out.println("cantidad: " + cantidad);
	    System.out.println("estado: " + estado);
	    System.out.println("observacion: " + observacion);
	    
	    // Crear el objeto PrestamoDevolucion
	    PrestamoDevolucion prestamoDevolucion = new PrestamoDevolucion();
	    prestamoDevolucion.setFechaPrestamo(java.sql.Date.valueOf(fechaPrestamo));
	    prestamoDevolucion.setFechaDevolucion(java.sql.Date.valueOf(fechaDevolucion));
	    prestamoDevolucion.setCantidad(cantidad);
	    prestamoDevolucion.setEstado(estado);
	    prestamoDevolucion.setObservacion(observacion);

	    // Llamar al modelo para crear el prestamoDevolucion
	    PrestamoDevolucionModel model = new PrestamoDevolucionModel();
	    model.createPrestamo(prestamoDevolucion,Integer.parseInt(idLibro),Integer.parseInt(idEstudiante));
		List<PrestamoDevolucion> data = model.listPrestamo(""); // Llamada al modelo para obtener la lista de
																// prestamos/devoluciones
		LibroModel model2 = new LibroModel();
		List<Libro> libros = model2.listLibro(""); // Llamada al modelo para obtener la lista de prestamos/devoluciones

		EstudianteModel model3 = new EstudianteModel();
		List<Estudiante> estudiantes = model3.listEstudiante(); // Llamada al modelo para obtener la lista de
																// prestamos/devoluciones
		
		// Redirigir al listado de prestamos o a donde se desee
		request.setAttribute("data", data);
		request.setAttribute("libros", libros);
		request.setAttribute("estudiantes", estudiantes);
		request.getRequestDispatcher("pyd.jsp").forward(request, response);
	    
	}

	// Método para actualizar un prestamoDevolucion existente
	private void updatePrestamoDevolucion(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Obtener los parámetros del formulario
		int id = Integer.parseInt(request.getParameter("idEstudiante"));
		String libroId = request.getParameter("selLibro"); // Se modificó a 'selLibro'
		String estudianteId = request.getParameter("selEstudiante"); // Se modificó a 'selEstudiante'
		String fechaPrestamo = request.getParameter("loanDate"); // Se modificó a 'loanDate'
		String fechaDevolucion = request.getParameter("returnDate"); // Se modificó a 'returnDate'
		int cantidad = Integer.parseInt(request.getParameter("loanQuantity")); // Se modificó a 'loanQuantity'
		String observacion = request.getParameter("loanObservation"); // Se modificó a 'loanObservation'

		// Crear el objeto PrestamoDevolucion
		PrestamoDevolucion prestamoDevolucion = new PrestamoDevolucion();
		prestamoDevolucion.setIdPrestamo(id);
		prestamoDevolucion.setFechaPrestamo(java.sql.Date.valueOf(fechaPrestamo));
		prestamoDevolucion.setFechaDevolucion(java.sql.Date.valueOf(fechaDevolucion));
		prestamoDevolucion.setCantidad(cantidad);
		prestamoDevolucion.setObservacion(observacion);

		 // Imprimir o procesar las variables según sea necesario
        System.out.println("ID Estudiante: " + id);
        System.out.println("ID Libro: " + libroId);
        System.out.println("ID Estudiante: " + estudianteId);
        System.out.println("Fecha de Préstamo: " + fechaPrestamo);
        System.out.println("Fecha de Devolución: " + fechaDevolucion);
        System.out.println("Cantidad: " + cantidad);
        System.out.println("Observación: " + observacion);
		    
		// Llamar al modelo para actualizar el prestamoDevolucion
		PrestamoDevolucionModel model = new PrestamoDevolucionModel();
		model.updatePrestamo(prestamoDevolucion,Integer.parseInt(libroId),Integer.parseInt(estudianteId));
		List<PrestamoDevolucion> data = model.listPrestamo(""); // Llamada al modelo para obtener la lista de
																// prestamos/devoluciones
		LibroModel model2 = new LibroModel();
		List<Libro> libros = model2.listLibro(""); // Llamada al modelo para obtener la lista de prestamos/devoluciones

		EstudianteModel model3 = new EstudianteModel();
		List<Estudiante> estudiantes = model3.listEstudiante(); // Llamada al modelo para obtener la lista de
																// prestamos/devoluciones
		
		// Redirigir al listado de prestamos o a donde se desee
		request.setAttribute("data", data);
		request.setAttribute("libros", libros);
		request.setAttribute("estudiantes", estudiantes);
		request.getRequestDispatcher("pyd.jsp").forward(request, response);
	}

}
