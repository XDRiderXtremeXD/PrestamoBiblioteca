package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Autor;
import modelos.AutorModel;

/**
 * Servlet implementation class AutorServlet
 */
@WebServlet("/AutorServlet")
public class AutorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
     */
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el tipo de acción a realizar
        String type = request.getParameter("type");
        System.out.println("Esta es la acción enviada: " + type);
        System.out.println("Acción de Autor");
        
        // Ejecutar la acción según el parámetro "type"
        switch (type) {
            case "list":
                listAutores(request, response);  // Listar autores
                break;
            case "view":
                getAutor(request, response);  // Ver detalles de un autor
                break;
            default:
                request.setAttribute("mensaje", "Ocurrió un problema");
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }

    // Método para ver los detalles de un autor
    private void getAutor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el id del autor desde el request
        int id = Integer.parseInt(request.getParameter("id"));

        // Crear una instancia del modelo de autores
        AutorModel autoresModel = new AutorModel();

        // Obtener el autor específico
        Autor autor = autoresModel.getAutor(id);

        // Verificar si se ha encontrado el autor
        if (autor != null) {
            request.setAttribute("autor", autor);
            // Redirigir a la página de detalle de autor
            request.getRequestDispatcher("autorDetalle.jsp").forward(request, response);
        } else {
            // En caso de no encontrar el autor
            request.setAttribute("mensaje", "El autor no fue encontrado");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }

    // Método para listar todos los autores
    private void listAutores(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Crear una instancia del modelo de autores
        AutorModel autoresModel = new AutorModel();

        // Obtener la lista de autores
        List<Autor> data = autoresModel.listAutor();

        // Establecer la lista de autores como atributo para la vista JSP
        request.setAttribute("data", data);
        
        System.out.println(data);

        // Redirigir a la página de listado de autores
        request.getRequestDispatcher("autores.jsp").forward(request, response);
    }
}
