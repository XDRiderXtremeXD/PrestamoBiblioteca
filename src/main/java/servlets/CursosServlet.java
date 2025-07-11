package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Curso;
import modelos.CursosModel;

/**
 * Servlet implementation class CursoServlet
 */
@WebServlet("/CursosServlet")
public class CursosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
     */
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el tipo de acción a realizar
        String type = request.getParameter("type");
        System.out.println("Esta es la acción enviada: " + type);
        System.out.println("aca curso");
        // Ejecutar la acción según el parámetro "type"
        switch (type) {
            case "list":
                listCursos(request, response);  // Listar cursos
                break;
            case "view":
                getCurso(request, response);  // Ver detalles de un curso
                break;
            default:
                request.setAttribute("mensaje", "Ocurrió un problema");
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }

    // Método para ver los detalles de un curso
    private void getCurso(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implementar la lógica para obtener un curso específico
    }

    // Método para listar todos los cursos
    private void listCursos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Crear una instancia del modelo de Cursos
        CursosModel cursosModel = new CursosModel();
        
        // Obtener la lista de cursos
        List<Curso> data = cursosModel.listCurso();

        // Establecer la lista de cursos como atributo para la vista JSP
        request.setAttribute("data", data);
        
        // Redirigir a la página de listado de cursos
        request.getRequestDispatcher("cursos.jsp").forward(request, response);
    }
}
