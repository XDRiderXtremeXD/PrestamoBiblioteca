package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Libro;
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
			default:
				request.setAttribute("mensaje", "Ocurrio un problema");
				request.getRequestDispatcher("dashboard.jsp").forward(request, response);
		}
	}

	private void listLibro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		LibroModel libroModel = new LibroModel();
		List<Libro> data=libroModel.listLibro();
		
		request.setAttribute("data", data);
		System.out.println("entra");
		request.getRequestDispatcher("dashboard.jsp").forward(request, response);
	}

}
