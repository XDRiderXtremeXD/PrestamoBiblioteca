package servlets;

import java.io.IOException;
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
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		String type = request.getParameter("type");
		System.out.println("Esta es la acción enviada: " + type);

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
		default:
			request.setAttribute("mensaje", "Ocurrio un problema");
			request.getRequestDispatcher("dashboard.jsp").forward(request, response);
		}
	}

	private void getLibro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id = request.getParameter("id");
		LibroModel libroModel = new LibroModel();

		Libro data = libroModel.getLibro(Integer.parseInt(id));

		request.setAttribute("libroID", data);
		System.out.println(data.getTitulo());
	}

	private void listLibro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		LibroModel libroModel = new LibroModel();
		List<Libro> data = libroModel.listLibro();

		AutorModel autorModel = new AutorModel();
		List<Autor> autores = autorModel.listAutor();

		GeneroLiterarioModel generoLiterarioModel = new GeneroLiterarioModel();
		List<GeneroLiterario> generos = generoLiterarioModel.listGeneroLiterario();

		EditorialesModel editorialModel = new EditorialesModel();
		List<Editorial> editoriales = editorialModel.listEditorial();

		CursosModel cursosModel = new CursosModel();
		List<Curso> cursos = cursosModel.listCurso();
		request.setAttribute("cursos", cursos);

		request.setAttribute("autores", autores);
		request.setAttribute("generos", generos);
		request.setAttribute("editoriales", editoriales);
		request.setAttribute("data", data);
		request.getRequestDispatcher("libros.jsp").forward(request, response);
	}

	private void updateLibro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Extraer los parámetros del formulario
		String id = request.getParameter("editBookId"); // Asegúrate de incluir este campo hidden en tu formulario
		String titulo = request.getParameter("editBookTitle");
		int ejemplaresTotales = Integer.parseInt(request.getParameter("editBookCopyTotal"));
		int idAutor = Integer.parseInt(request.getParameter("selAutor"));
		int idEditorial = Integer.parseInt(request.getParameter("selEditorial"));
		String fechaLanzamiento = request.getParameter("editReleaseDate");
		int idGenero = Integer.parseInt(request.getParameter("selGenero"));
		int idCurso = Integer.parseInt(request.getParameter("selCurso"));
		String estado = request.getParameter("editBookState");

		// Crear el objeto libro con los datos actualizados
		Libro libro = new Libro();
		libro.setIdLibro(Integer.parseInt(id));
		libro.setTitulo(titulo);
		libro.setEjemplaresTotales(ejemplaresTotales);
		/*libro.setIdAutor(idAutor);
		libro.setIdEditorial(idEditorial);
		libro.setFechaLanzamiento(fechaLanzamiento);
		libro.setIdGeneroLiterario(idGenero);
		libro.setIdCurso(idCurso);
		libro.setEstado(estado);
*/
		// Llamar al modelo para actualizar el libro
		LibroModel libroModel = new LibroModel();
		//boolean resultado = libroModel.updateLibro(libro);

		// Redirigir o mostrar mensaje según el resultado
		/*
			if (resultado) {
			request.setAttribute("mensaje", "Libro actualizado exitosamente");
		} else {
			request.setAttribute("mensaje", "Error al actualizar el libro");
		}
*/
		// Redirigir a la lista de libros
		listLibro(request, response);
	}
	
	private void createLibro(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    // Extraer parámetros del formulario
	    String titulo = request.getParameter("addBookTitle");
	    int ejemplaresTotales = Integer.parseInt(request.getParameter("addBookCopyTotal"));
	    int idAutor = Integer.parseInt(request.getParameter("selAutor"));
	    int idEditorial = Integer.parseInt(request.getParameter("selEditorial"));
	    String fechaLanzamiento = request.getParameter("addReleaseDate");
	    int idGenero = Integer.parseInt(request.getParameter("selGenero"));
	    int idCurso = Integer.parseInt(request.getParameter("selCurso"));
	    String estado = request.getParameter("addBookState");

	    // Crear objeto libro con los datos recibidos
	    Libro libro = new Libro();
	    libro.setTitulo(titulo);
	    libro.setEjemplaresTotales(ejemplaresTotales);
	   /* libro.setIdAutor(idAutor);
	    libro.setIdEditorial(idEditorial);
	    libro.setFechaLanzamiento(fechaLanzamiento);
	    libro.setIdGeneroLiterario(idGenero);
	    libro.setIdCurso(idCurso);
	    */libro.setEstado(estado);

	    // Llamar al modelo para guardar el libro
	    LibroModel libroModel = new LibroModel();
	  //  boolean resultado = libroModel.createLibro(libro);

	    // Manejar resultado y redirigir
	    /*if (resultado) {
	        request.setAttribute("mensaje", "Libro creado exitosamente");
	    } else {
	        request.setAttribute("mensaje", "Error al crear el libro");
	    }*/

	    // Redirigir a la lista de libros
	    listLibro(request, response);
	}

}
