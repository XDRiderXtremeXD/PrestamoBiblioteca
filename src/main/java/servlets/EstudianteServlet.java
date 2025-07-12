package servlets;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import entidades.Estudiante;
import entidades.Facultad;
import modelos.EstudianteModel;
import modelos.FacultadModel;

@WebServlet("/EstudianteServlet")
public class EstudianteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String type = request.getParameter("type");
        System.out.println("Acción recibida: " + type);

        switch (type) {
            case "list":
                listEstudiantes(request, response);
                break;
            case "view":
                getEstudiante(request, response);
                break;
            case "create":
                createEstudiante(request, response);
                break;
            case "update":
                updateEstudiante(request, response);
                break;
            default:
                request.setAttribute("mensaje", "Acción no válida");
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }

    /**
     * Lista todos los estudiantes con filtro opcional
     */
    private void listEstudiantes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String filtro = request.getParameter("filtro");
        filtro = (filtro == null) ? "" : filtro;
        System.out.println("Filtro estudiante: " + filtro);

        EstudianteModel estudianteModel = new EstudianteModel();
        FacultadModel facultadModel = new FacultadModel();

        List<Estudiante> data = estudianteModel.listEstudiante(filtro);
        List<Facultad> facultades = facultadModel.listFacultad();

        request.setAttribute("data", data);
        request.setAttribute("facultades", facultades);
        request.getRequestDispatcher("estudiantes.jsp").forward(request, response);
    }

    /**
     * Muestra los detalles de un estudiante por ID
     */
    private void getEstudiante(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            EstudianteModel model = new EstudianteModel();
            Estudiante estudiante = model.getEstudiante(id);

            if (estudiante != null) {
                request.setAttribute("estudiante", estudiante);
                request.getRequestDispatcher("estudianteDetalle.jsp").forward(request, response);
            } else {
                request.setAttribute("mensaje", "Estudiante no encontrado");
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al obtener estudiante");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }

    /**
     * Registra un nuevo estudiante
     */
    private void createEstudiante(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Usar los nombres correctos del formulario
            String dni = request.getParameter("addStudentDni");
            String nombres = request.getParameter("addStudentFirstName");
            String apellidos = request.getParameter("addStudentLastName");
            String direccion = request.getParameter("addStudentAddress");
            String telefono = request.getParameter("addStudentPhone");
            String correo = request.getParameter("addStudentEmail");
            String fecha = request.getParameter("addStudentBirthDate");
            String genero = request.getParameter("addStudentGender");
            String facultad = request.getParameter("addFaculty");
            String estado = request.getParameter("addStudentState");

            // Sysout de depuración
            System.out.println("=== DATOS DE REGISTRO ===");
            System.out.println("DNI: " + dni);
            System.out.println("Nombre: " + nombres + " " + apellidos);
            System.out.println("Correo: " + correo);
            System.out.println("Facultad: " + facultad);
            System.out.println("Fecha Nacimiento: " + fecha);

            // Crear objeto estudiante
            Estudiante e = new Estudiante();
            e.setDni(dni);
            e.setNombres(nombres);
            e.setApellidos(apellidos);
            e.setDireccion(direccion);
            e.setTelefono(telefono);
            e.setCorreoElectronico(correo);
            e.setGenero(genero);
            e.setFacultad(facultad);
            e.setEstado(estado);

            // Convertir fecha
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date fechaUtil = sdf.parse(fecha);
            e.setFechaNacimiento(new Date(fechaUtil.getTime()));

            // Guardar en BD
            EstudianteModel model = new EstudianteModel();
            int result = model.createEstudiante(e);

            request.setAttribute("mensaje", result > 0
                ? "Estudiante registrado correctamente"
                : "Error al registrar estudiante");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al procesar creación");
        }

        listEstudiantes(request, response);
    }

    /**
     * Actualiza un estudiante existente
     */
    private void updateEstudiante(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {    
        	System.out.println("editId: " + request.getParameter("editId"));
        	System.out.println("editStudentDNI: " + request.getParameter("editStudentDNI"));
        	System.out.println("editStudentFirstName: " + request.getParameter("editStudentFirstName"));
        	System.out.println("editStudentLastName: " + request.getParameter("editStudentLastName"));
        	System.out.println("editStudentAddress: " + request.getParameter("editStudentAddress"));
        	System.out.println("editStudentPhone: " + request.getParameter("editStudentPhone"));
        	System.out.println("editStudentEmail: " + request.getParameter("editStudentEmail"));
        	System.out.println("editStudentBirthDate: " + request.getParameter("editStudentBirthDate"));
        	System.out.println("editstudentGender: " + request.getParameter("editstudentGender")); // Ojo: revisa el nombre del parámetro, parece inconsistente
        	System.out.println("editFaculty: " + request.getParameter("editFaculty"));
        	System.out.println("editStudentState: " + request.getParameter("editStudentState"));

        	
        	int id = Integer.parseInt(request.getParameter("editId"));
        	String dni = request.getParameter("editStudentDNI");
        	String nombres = request.getParameter("editStudentFirstName");
        	String apellidos = request.getParameter("editStudentLastName");
        	String direccion = request.getParameter("editStudentAddress");
        	String telefono = request.getParameter("editStudentPhone");
        	String correo = request.getParameter("editStudentEmail");
        	String fecha = request.getParameter("editStudentBirthDate");
        	String genero = request.getParameter("editstudentGender"); // 
        	String facultad = request.getParameter("editFaculty");
        	String estado = request.getParameter("editStudentState");
        	
            Estudiante e = new Estudiante();
            e.setIdEstudiante(id);
            e.setDni(dni);
            e.setNombres(nombres);
            e.setApellidos(apellidos);
            e.setDireccion(direccion);
            e.setTelefono(telefono);
            e.setCorreoElectronico(correo);
            e.setGenero(genero);
            e.setFacultad(facultad);
            e.setEstado(estado);

            // Convertir fecha
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date fechaUtil = sdf.parse(fecha);
            e.setFechaNacimiento(new Date(fechaUtil.getTime()));

            EstudianteModel model = new EstudianteModel();
            int result = model.updateEstudiante(e);

            request.setAttribute("mensaje", result > 0 ? "Estudiante actualizado correctamente" : "Error al actualizar estudiante");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al procesar actualización");
        }

        listEstudiantes(request, response);
    }
}
