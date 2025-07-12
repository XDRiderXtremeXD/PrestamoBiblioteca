package servlets;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Autor;
import entidades.GeneroLiterario;
import modelos.AutorModel;
import modelos.GeneroLiterarioModel;

@WebServlet("/AutorServlet")
@MultipartConfig // Por si se desea manejar archivos como fotos en el futuro
public class AutorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String type = request.getParameter("type");
        System.out.println("Acción recibida: " + type);

        switch (type) {
            case "list":
                listAutores(request, response);
                break;
            case "view":
                getAutor(request, response);
                break;
            case "create":
                createAutor(request, response);
                break;
            case "update":
                updateAutor(request, response);
                break;
            default:
                request.setAttribute("mensaje", "Acción no válida");
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }

    /**
     * Lista autores con filtro (si existe) y géneros literarios
     */
    private void listAutores(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String filtro = request.getParameter("filtro");
        filtro = (filtro == null) ? "" : filtro;
        System.out.println("Filtro autor: " + filtro);

        AutorModel autorModel = new AutorModel();
        GeneroLiterarioModel generoModel = new GeneroLiterarioModel();

        List<Autor> data = autorModel.listAutor(filtro);
        List<GeneroLiterario> generos = generoModel.listGeneroLiterario();

        request.setAttribute("data", data);
        request.setAttribute("generos", generos);
        request.getRequestDispatcher("autores.jsp").forward(request, response);
    }

    /**
     * Muestra un autor por ID
     */
    private void getAutor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        AutorModel autorModel = new AutorModel();
        Autor autor = autorModel.getAutor(id);

        if (autor != null) {
            request.setAttribute("autor", autor);
            request.getRequestDispatcher("autorDetalle.jsp").forward(request, response);
        } else {
            request.setAttribute("mensaje", "Autor no encontrado");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }

    /**
     * Crea un nuevo autor desde el formulario
     */
    private void createAutor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Obtener parámetros del formulario
            String nombre = request.getParameter("addAuthorName");
            String nacionalidad = request.getParameter("addAuthorNationality");
            int idGenero = Integer.parseInt(request.getParameter("addLiteraryGenre"));
            String fechaNacimiento = request.getParameter("addAuthorBirthDate");
            String biografia = request.getParameter("addAuthorBiography");
            String estado = request.getParameter("addAuthorState");

            // Crear objeto Autor
            Autor autor = new Autor();
            autor.setNombre(nombre);
            autor.setNacionalidad(nacionalidad);
            autor.setIdGeneroLiterario(idGenero);
            autor.setBiografia(biografia);
            autor.setEstado(estado);

            // Convertir fecha
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date fechaUtil = sdf.parse(fechaNacimiento);
            autor.setFechaNacimiento(new Date(fechaUtil.getTime()));

            // Guardar en BD
            AutorModel autorModel = new AutorModel();
            int result = autorModel.createAutor(autor);

            request.setAttribute("mensaje", result != 0 
                ? "Autor creado exitosamente" 
                : "Error al crear el autor");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al procesar el autor");
        }

        listAutores(request, response);
    }

    /**
     * Actualiza un autor existente
     */
    private void updateAutor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Obtener parámetros del formulario
            int id = Integer.parseInt(request.getParameter("editAuthorId"));
            String nombre = request.getParameter("editAuthorName");
            String nacionalidad = request.getParameter("editAuthorNationality"); // CORREGIDO
            int idGenero = Integer.parseInt(request.getParameter("editLiteraryGenre"));
            String fechaNacimiento = request.getParameter("editAuthorBirthDate");
            String biografia = request.getParameter("editAuthorBio");
            String estado = request.getParameter("editAuthorState");

            // Crear objeto Autor
            Autor autor = new Autor();
            autor.setIdAutor(id);
            autor.setNombre(nombre);
            autor.setNacionalidad(nacionalidad);
            autor.setIdGeneroLiterario(idGenero);
            autor.setBiografia(biografia);
            autor.setEstado(estado);

            // Convertir fecha
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date fechaUtil = sdf.parse(fechaNacimiento);
            autor.setFechaNacimiento(new Date(fechaUtil.getTime()));

            // Actualizar en BD
            AutorModel autorModel = new AutorModel();
            int result = autorModel.updateAutor(autor);

            request.setAttribute("mensaje", result != 0 
                ? "Autor actualizado exitosamente" 
                : "Error al actualizar el autor");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al procesar actualización");
        }

        listAutores(request, response);
    }
}
