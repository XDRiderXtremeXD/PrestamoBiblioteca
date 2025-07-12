package servlets;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Autor;
import entidades.Curso;
import entidades.Editorial;
import entidades.GeneroLiterario;
import entidades.Libro;
import modelos.AutorModel;
import modelos.CursosModel;
import modelos.EditorialesModel;
import modelos.GeneroLiterarioModel;
import modelos.LibroModel;

/**
 * Servlet implementation class LibroServlet
 */
@WebServlet("/LibroServlet")
public class LibroServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Método principal que recibe todas las solicitudes y ejecuta la acción
	 * correspondiente
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String type = request.getParameter("type");

		switch (type) {
		case "list":
			listLibro(request, response);
			break;
		case "view":
			getLibro(request, response);
			break;
		case "update":
			updateLibro(request, response);
			break;
		case "create":
			createLibro(request, response);
			break;
		default:
			request.setAttribute("mensaje", "Ocurrió un problema");
			request.getRequestDispatcher("dashboard.jsp").forward(request, response);
		}
	}

	/**
	 * Obtiene un libro por su ID y lo guarda como atributo en la request
	 */
	private void getLibro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String id = request.getParameter("id");
		LibroModel libroModel = new LibroModel();
		Libro data = libroModel.getLibro(Integer.parseInt(id));
		request.setAttribute("libroID", data);
	}

	/**
	 * Lista todos los libros y también carga datos auxiliares como autores, cursos,
	 * etc.
	 */
	private void listLibro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String filtro = request.getParameter("filtro");
		filtro=filtro==null?"":filtro;
		System.out.println("filtro libro "+filtro);

		LibroModel libroModel = new LibroModel();
		List<Libro> data = libroModel.listLibro(filtro);

		AutorModel autorModel = new AutorModel();
		List<Autor> autores = autorModel.listAutor("");

		GeneroLiterarioModel generoLiterarioModel = new GeneroLiterarioModel();
		List<GeneroLiterario> generos = generoLiterarioModel.listGeneroLiterario();

		EditorialesModel editorialModel = new EditorialesModel();
		List<Editorial> editoriales = editorialModel.listEditorial("");

		CursosModel cursosModel = new CursosModel();
		List<Curso> cursos = cursosModel.listCurso("");

		request.setAttribute("data", data);
		request.setAttribute("autores", autores);
		request.setAttribute("generos", generos);
		request.setAttribute("editoriales", editoriales);
		request.setAttribute("cursos", cursos);
		request.setAttribute("filtro", filtro);

		request.getRequestDispatcher("libros.jsp").forward(request, response);
	}

	/**
	 * Actualiza la información de un libro existente
	 */
	private void updateLibro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Captura de parámetros del formulario
		String id = request.getParameter("editBookId");
		String titulo = request.getParameter("editBookTitle");
		int ejemplaresTotales = Integer.parseInt(request.getParameter("editBookCopyTotal"));
		int idAutor = Integer.parseInt(request.getParameter("selAutor"));
		int idEditorial = Integer.parseInt(request.getParameter("selEditorial"));
		String fechaLanzamiento = request.getParameter("editReleaseDate");
		int idGenero = Integer.parseInt(request.getParameter("selGenero"));
		int idCurso = Integer.parseInt(request.getParameter("selCurso"));
		String estado = request.getParameter("SelEstado");

		// Obtener nombre del género
		GeneroLiterarioModel generoLiterarioModel = new GeneroLiterarioModel();
		String nombreGenero = generoLiterarioModel.getNombreGenero(idGenero);

		// Crear y poblar el objeto libro
		Libro libro = new Libro();
		libro.setIdLibro(Integer.parseInt(id));
		libro.setTitulo(titulo);
		libro.setEjemplaresTotales(ejemplaresTotales);
		libro.setAutor(String.valueOf(idAutor));
		libro.setEditorial(String.valueOf(idEditorial));
		libro.setCurso(String.valueOf(idCurso));
		libro.setGenero(nombreGenero);
		libro.setEstado(estado);

		// Conversión de fecha
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date fechaUtil = sdf.parse(fechaLanzamiento);
			java.sql.Date fechaSql = new java.sql.Date(fechaUtil.getTime());
			libro.setFechaLanzamiento(fechaSql);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// Actualizar libro en la base de datos
		LibroModel libroModel = new LibroModel();
		int resultado = libroModel.updateLibro(libro);

		if (resultado != 0) {
			request.setAttribute("mensaje", "Libro actualizado exitosamente");
		} else {
			request.setAttribute("mensaje", "Error al actualizar el libro");
		}

		// Redirigir a la lista de libros
		listLibro(request, response);
	}

	/**
	 * Crea un nuevo libro en la base de datos
	 */
	private void createLibro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// Captura de parámetros del formulario
			String titulo = request.getParameter("addBookTitle");
			int ejemplaresTotales = Integer.parseInt(request.getParameter("addBookCopyTotal"));
			int idAutor = Integer.parseInt(request.getParameter("selAutor"));
			int idEditorial = Integer.parseInt(request.getParameter("selEditorial"));
			String fechaLanzamiento = request.getParameter("addBookReleaseDate");
			int idGenero = Integer.parseInt(request.getParameter("selGenero"));
			int idCurso = Integer.parseInt(request.getParameter("selCurso"));
			String estado = request.getParameter("SelEstado");

			// Obtener nombre del género
			GeneroLiterarioModel generoLiterarioModel = new GeneroLiterarioModel();
			String nombreGenero = generoLiterarioModel.getNombreGenero(idGenero);

			// Crear y poblar el objeto libro
			Libro libro = new Libro();
			libro.setTitulo(titulo);
			libro.setEjemplaresTotales(ejemplaresTotales);
			libro.setAutor(String.valueOf(idAutor));
			libro.setEditorial(String.valueOf(idEditorial));
			libro.setCurso(String.valueOf(idCurso));
			libro.setGenero(nombreGenero);
			libro.setEstado(estado);

			// Conversión de fecha
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				java.util.Date fechaUtil = sdf.parse(fechaLanzamiento);
				java.sql.Date fechaSql = new java.sql.Date(fechaUtil.getTime());
				libro.setFechaLanzamiento(fechaSql);
			} catch (Exception e) {
				e.printStackTrace();
			}

			// Guardar libro en la base de datos
			LibroModel libroModel = new LibroModel();
			int resultado = libroModel.createLibro(libro);

			if (resultado != 0) {
				request.setAttribute("mensaje", "Libro creado exitosamente");
			} else {
				request.setAttribute("mensaje", "Error al crear el libro");
			}

			// Redirigir a la lista
			listLibro(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al procesar los datos del libro.");
		}
	}
}
