package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import entidades.UsuarioLE;

/**
 * Servlet implementation class LoginLEServlet2
 */
@WebServlet("/LoginLEServlet2")
public class LoginLEServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	/*protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String correo=request.getParameter("txtCorreo");
		String clave=request.getParameter("txtPass");
		
		if(correo.equals("pwsamani@cibertec.edu.pe")&&clave.equals("123")) {
			UsuarioLE usuario=new UsuarioLE();
			usuario.setNombre("Williams");
			usuario.setApellido("Samaniego");
			usuario.setCodigo(100);
			usuario.setClave(clave);
			usuario.setCorreo(correo);
			usuario.setUser("Will");
			request.setAttribute("usuario", usuario);
			request.getRequestDispatcher("principalLE2.jsp")
			.forward(request, response);
		}else {
			request.setAttribute("mensaje", "Error en usuario y/o clave");
			request.getRequestDispatcher("loginLE2.jsp").forward(request, response);
		}
	}
**/
}
