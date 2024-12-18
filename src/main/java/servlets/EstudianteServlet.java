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
import modelos.EstudianteModel;
import modelos.LibroModel;

/**
 * Servlet implementation class EstudianteServlet
 */
@WebServlet("/EstudianteServlet")
public class EstudianteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String type=request.getParameter("type");
		System.out.println("Esta es la acción enviada: "+type);
		
		switch(type) {
			case "list": listEstudiante(request,response);break;
			case "view": getEstudiante(request,response);break;
			default:
				request.setAttribute("mensaje", "Ocurrio un problema");
				request.getRequestDispatcher("dashboard.jsp").forward(request, response);
		}
	}

	private void getEstudiante(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}

	private void listEstudiante(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		EstudianteModel estudianteModel = new EstudianteModel();
		List<Estudiante> data=estudianteModel.listEstudiante();
		
		request.setAttribute("data", data);
		request.getRequestDispatcher("estudiantes.jsp").forward(request, response);
	}

}
