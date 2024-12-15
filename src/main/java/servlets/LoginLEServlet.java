package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginLEServlet
 */
@WebServlet("/LoginLEServlet")
public class LoginLEServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	/*protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String correo=request.getParameter("txtCorreo");
		String clave=request.getParameter("txtPass");
		
		if(correo.equals("pwsamani@cibertec.edu.pe")&&clave.equals("123")) {
			request.setAttribute("mensaje", "Williams Samaniego");
			request.getRequestDispatcher("principalLE.jsp").forward(request, response);
		}else {
			request.setAttribute("mensaje", "Error en usuario y/o clave");
			request.getRequestDispatcher("loginLE.jsp").forward(request, response);
		}
	}*/

}
