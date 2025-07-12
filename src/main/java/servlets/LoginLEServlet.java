package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidades.Perfil;
import modelos.PerfilesModel;

/**
 * Servlet implementation class LoginLEServlet
 */
@WebServlet("/LoginLEServlet")
public class LoginLEServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String usuario = request.getParameter("usuario");
		String contrasena = request.getParameter("contrasena");

		System.out.println(usuario);
		
		PerfilesModel model = new PerfilesModel();
		Perfil perfil = model.validarLogin(usuario, contrasena);

		if (perfil != null) {
			HttpSession session = request.getSession();
			session.setAttribute("perfilLogueado", perfil);
			response.sendRedirect("dashboard.jsp");
		} else {
			request.setAttribute("error", "Usuario o contraseña incorrectos.");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}

}
