package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import entidades.Perfil;
import modelos.PerfilesModel;

@WebServlet("/PerfilServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5) // 5MB máx
public class PerfilServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String type = request.getParameter("type");
        System.out.println("Acción recibida: " + type);

        switch (type) {
            case "list":
                listPerfiles(request, response);
                break;
            case "view":
                getPerfil(request, response);
                break;
            case "create":
                createPerfil(request, response);
                break;
            case "update":
                updatePerfil(request, response);
                break;
            case "delete":
                deletePerfil(request, response);
                break;
            default:
                request.setAttribute("mensaje", "Acción no válida");
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }

    private void listPerfiles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    	 String filtro = request.getParameter("filtro");
         filtro = (filtro == null) ? "" : filtro;
         System.out.println("Filtro perfil: " + filtro);
    	
    	PerfilesModel perfilModel = new PerfilesModel();
        List<Perfil> data = perfilModel.listPerfil(filtro);

        request.setAttribute("data", data);
        request.getRequestDispatcher("perfiles.jsp").forward(request, response);
    }

    private void getPerfil(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Perfil perfil = new PerfilesModel().getPerfil(id);

        if (perfil != null) {
            request.setAttribute("perfil", perfil);
            request.getRequestDispatcher("perfilDetalle.jsp").forward(request, response);
        } else {
            request.setAttribute("mensaje", "Perfil no encontrado");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }

    private void createPerfil(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String usuario = request.getParameter("addProfileUsername");
            String correo = request.getParameter("addProfileEmail");
            String nombres = request.getParameter("addProfileFirstName");
            String apellidos = request.getParameter("addProfileLastName");
            String contrasena = request.getParameter("addProfilePassword");
            String rol = request.getParameter("addProfileType");
            Part fotoPart = request.getPart("addProfilePhoto");
            String nombreFoto = obtenerNombreArchivo(fotoPart);

            Perfil perfil = new Perfil();
            perfil.setUsuario(usuario);
            perfil.setCorreoElectronico(correo);
            perfil.setNombres(nombres);
            perfil.setApellidos(apellidos);
            perfil.setContrasena(contrasena);
            perfil.setRol(rol);
            perfil.setEstado("activo"); // por defecto
            perfil.setFotoPerfil(nombreFoto);

            int result = new PerfilesModel().createPerfil(perfil);

            request.setAttribute("mensaje", result != 0
                    ? "Perfil creado exitosamente"
                    : "Error al crear el perfil");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al procesar el perfil");
        }

        listPerfiles(request, response);
    }

    private void updatePerfil(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
        	
            int id = Integer.parseInt(request.getParameter("editProfileId"));
            String nombres = request.getParameter("editProfileFirstName");
            String apellidos = request.getParameter("editProfileLastName");
            String contrasena = request.getParameter("editProfilePassword");
            String rol = request.getParameter("editProfileRole");
            String estado = request.getParameter("editProfileState");
            String email = request.getParameter("editProfileEmail");
            String username = request.getParameter("editProfileUsername");

            Part fotoPart = request.getPart("editProfilePhoto");
            String nombreFoto = obtenerNombreArchivo(fotoPart);

            Perfil perfil = new Perfil();
            perfil.setIdPerfil(id);
            perfil.setNombres(nombres);
            perfil.setApellidos(apellidos);
            perfil.setContrasena(contrasena);
            perfil.setRol(rol);
            perfil.setEstado(estado);
            perfil.setCorreoElectronico(email);
            perfil.setUsuario(username);

            // Solo se guarda si hay nueva foto
            if (nombreFoto != null && !nombreFoto.isEmpty()) {
                perfil.setFotoPerfil(nombreFoto);
            }

            int result = new PerfilesModel().updatePerfil(perfil);

            request.setAttribute("mensaje", result != 0
                    ? "Perfil actualizado exitosamente"
                    : "Error al actualizar el perfil");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al actualizar el perfil");
        }

        listPerfiles(request, response);
    }

    // Extrae el nombre del archivo (si se desea almacenar en disco también se puede agregar)
    private String obtenerNombreArchivo(Part part) {
        if (part == null) return null;
        String contentDisp = part.getHeader("content-disposition");
        for (String cd : contentDisp.split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
    
    private void deletePerfil(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("deleteProfileId")); // debe coincidir con el `name` del input
            PerfilesModel model = new PerfilesModel();
            int result = model.deletePerfil(id);

            request.setAttribute("mensaje", result != 0
                    ? "Perfil eliminado exitosamente"
                    : "No se pudo eliminar el perfil");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al eliminar el perfil");
        }

        listPerfiles(request, response);
    }
}
