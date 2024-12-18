package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Editorial;
import modelos.EditorialesModel;

/**
 * Servlet implementation class EditorialServlet
 */
@WebServlet("/EditorialServlet")
public class EditorialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
     */
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        System.out.println("Esta es la acción enviada: " + type);

        switch (type) {
            case "list":
                listEditorial(request, response);
                break;
            case "view":
                getEditorial(request, response);
                break;
            default:
                request.setAttribute("mensaje", "Ocurrió un problema");
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }

    private void getEditorial(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID de la editorial de los parámetros de la solicitud
    }

    private void listEditorial(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Crear una instancia del modelo de Editorial
    	EditorialesModel editorialModel = new EditorialesModel();
        
        // Obtener la lista de todas las editoriales
        List<Editorial> data = editorialModel.listEditorial();

        // Establecer los datos como atributo de la solicitud y redirigir a la vista
        request.setAttribute("data", data);
        request.getRequestDispatcher("editoriales.jsp").forward(request, response);
    }
}
