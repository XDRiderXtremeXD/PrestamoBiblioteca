package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Perfil; // Cambiado para referirse a Perfil
import modelos.PerfilesModel; // Cambiado para el modelo de Perfiles

/**
 * Servlet implementation class PerfilServlet
 */
@WebServlet("/PerfilServlet")
public class PerfilServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
     */
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        System.out.println("Acción recibida: " + type);

        // Selección de la acción basada en el parámetro 'type'
        switch (type) {
            case "list":
                listPerfiles(request, response);
                break;
            case "view":
                getPerfil(request, response);
                break;
        }
    }

    private void getPerfil(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}

	// Método para listar todos los perfiles
    private void listPerfiles(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PerfilesModel perfilModel = new PerfilesModel();
        List<Perfil> data = perfilModel.listPerfil(); // Llamada al modelo para obtener la lista de todos los perfiles
        
        // Establecer la lista de perfiles como atributo de la solicitud
        request.setAttribute("data", data);
        request.getRequestDispatcher("perfiles.jsp").forward(request, response);
    }
}
