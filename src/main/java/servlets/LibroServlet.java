package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Autor;
import entidades.Editorial;
import entidades.GeneroLiterario;
import entidades.Libro;
import modelos.AutorModel;
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
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String type=request.getParameter("type");
		System.out.println("Esta es la acción enviada: "+type);
		
		switch(type) {
			case "list": listLibro(request,response);break;
			case "view": getLibro(request,response);break;
			default:
				request.setAttribute("mensaje", "Ocurrio un problema");
				request.getRequestDispatcher("dashboard.jsp").forward(request, response);
		}
	}

	private void getLibro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
				String id=request.getParameter("id");
				LibroModel libroModel=new LibroModel();
				
				Libro data=libroModel.getLibro(Integer.parseInt(id));
				
				request.setAttribute("libroID", data);
				System.out.println(data.getTitulo());
	}
	
	private void listLibro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		LibroModel libroModel = new LibroModel();
		List<Libro> data=libroModel.listLibro();
		
		AutorModel autorModel = new AutorModel();
		List<Autor> autores=autorModel.listAutor();
		
		GeneroLiterarioModel generoLiterarioModel = new GeneroLiterarioModel();
		List<GeneroLiterario> generos=generoLiterarioModel.listGeneroLiterario();
		
		EditorialesModel editorialModel = new EditorialesModel();
		List<Editorial> editoriales=editorialModel.listEditorial();
		
		request.setAttribute("autores", autores);
		request.setAttribute("generos", generos);
		request.setAttribute("editoriales",editoriales);
		request.setAttribute("data", data);
		request.getRequestDispatcher("libros.jsp").forward(request, response);
	}

}
