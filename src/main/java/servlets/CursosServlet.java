package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import entidades.Curso;
import modelos.CursosModel;

@WebServlet("/CursosServlet")
public class CursosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String type = request.getParameter("type");
        System.out.println("Acción recibida: " + type);

        switch (type) {
            case "list":
                listCursos(request, response);
                break;
            case "view":
                getCurso(request, response);
                break;
            case "create":
                createCurso(request, response);
                break;
            case "update":
                updateCurso(request, response);
                break;
            default:
                request.setAttribute("mensaje", "Acción no válida");
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }

    private void listCursos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    	 String filtro = request.getParameter("filtro");
         filtro = (filtro == null) ? "" : filtro;
         System.out.println("Filtro curso: " + filtro);
    	
        CursosModel cursosModel = new CursosModel();
        List<Curso> data = cursosModel.listCurso(filtro);

        request.setAttribute("data", data);
        request.getRequestDispatcher("cursos.jsp").forward(request, response);
    }

    private void getCurso(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        CursosModel cursosModel = new CursosModel();
        Curso curso = cursosModel.getCurso(id);

        if (curso != null) {
            request.setAttribute("curso", curso);
            request.getRequestDispatcher("cursoDetalle.jsp").forward(request, response);
        } else {
            request.setAttribute("mensaje", "Curso no encontrado");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }

    private void createCurso(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String nombre = request.getParameter("addCursoNombre");
            String nivel = request.getParameter("addCursoNivel");
            String descripcion = request.getParameter("addCursoDescripcion");
            String estado = request.getParameter("addCursoEstado");

            Curso curso = new Curso();
            curso.setNombre(nombre);
            curso.setNivel(nivel);
            curso.setDescripcion(descripcion);
            curso.setEstado(estado);

            CursosModel model = new CursosModel();
            int result = model.createCurso(curso);

            request.setAttribute("mensaje", result != 0 
                ? "Curso creado exitosamente" 
                : "Error al crear el curso");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al procesar curso nuevo");
        }

        listCursos(request, response);
    }

    private void updateCurso(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
        	int id = Integer.parseInt(request.getParameter("editCursoId"));
        	String nombre = request.getParameter("editCursoNombre");
        	String nivel = request.getParameter("editCursoNivel");
        	String descripcion = request.getParameter("editCursoDescripcion");
        	String estado = request.getParameter("editCursoEstado");


            Curso curso = new Curso();
            curso.setIdCurso(id);
            curso.setNombre(nombre);
            curso.setNivel(nivel);
            curso.setDescripcion(descripcion);
            curso.setEstado(estado);
            
            System.out.println(estado);

            CursosModel model = new CursosModel();
            int result = model.updateCurso(curso);

            request.setAttribute("mensaje", result != 0 
                ? "Curso actualizado correctamente" 
                : "No se pudo actualizar el curso");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al actualizar el curso");
        }

        listCursos(request, response);
    }
}
