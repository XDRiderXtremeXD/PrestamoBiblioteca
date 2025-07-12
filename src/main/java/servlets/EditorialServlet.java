package servlets;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import entidades.Editorial;
import entidades.GeneroLiterario;
import modelos.EditorialesModel;
import modelos.GeneroLiterarioModel;

@WebServlet("/EditorialServlet")
public class EditorialServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Asegurar correcta codificación para tildes
		request.setCharacterEncoding("UTF-8");

		String type = request.getParameter("type");

		switch (type) {
		case "list":
			listEditorial(request, response);
			break;
		case "view":
			getEditorial(request, response);
			break;
		case "create":
			insertEditorial(request, response);
			break;
		case "update":
			updateEditorial(request, response);
			break;
		case "delete":
			deleteEditorial(request, response);
			break;
		default:
			request.setAttribute("mensaje", "Acción no reconocida");
			request.getRequestDispatcher("dashboard.jsp").forward(request, response);
		}
	}

	private void listEditorial(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String filtro = request.getParameter("filtro");
		filtro = (filtro == null) ? "" : filtro;
		System.out.println("Filtro Editorial: " + filtro);

		EditorialesModel editorialModel = new EditorialesModel();
		GeneroLiterarioModel generoModel = new GeneroLiterarioModel();

		List<Editorial> data = editorialModel.listEditorial(filtro);
		List<GeneroLiterario> generos = generoModel.listGeneroLiterario();

		request.setAttribute("data", data);
		request.setAttribute("generos", generos);
		request.getRequestDispatcher("editoriales.jsp").forward(request, response);
	}

	private void getEditorial(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		EditorialesModel editorialModel = new EditorialesModel();
		Editorial editorial = editorialModel.getEditorial(id);
		request.setAttribute("editorial", editorial);
		request.getRequestDispatcher("editorialDetalle.jsp").forward(request, response);
	}

	private void insertEditorial(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			Editorial editorial = buildEditorialFromRequest(request);
			EditorialesModel model = new EditorialesModel();
			int result = model.createEditorial(editorial);

			if (result > 0) {
				request.setAttribute("mensaje", "Editorial registrada correctamente.");
			} else {
				request.setAttribute("mensaje", "Error al registrar editorial.");
			}
		} catch (Exception e) {
			request.setAttribute("mensaje", "Error: " + e.getMessage());
			e.printStackTrace();
		}
		listEditorial(request, response);
	}

	private void updateEditorial(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			Editorial editorial = buildEditorialFromRequest(request);

			EditorialesModel model = new EditorialesModel();

			int result = model.updateEditorial(editorial);

			if (result > 0) {
				request.setAttribute("mensaje", "Editorial actualizada correctamente.");
			} else {
				request.setAttribute("mensaje", "Error al actualizar editorial.");
			}
		} catch (Exception e) {
			request.setAttribute("mensaje", "Error: " + e.getMessage());
			e.printStackTrace();
		}
		listEditorial(request, response);
	}

	private void deleteEditorial(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int id = Integer.parseInt(request.getParameter("editEditorialId"));
			EditorialesModel model = new EditorialesModel();
			int result = model.deleteEditorial(id);

			if (result > 0) {
				request.setAttribute("mensaje", "Editorial eliminada correctamente.");
			} else {
				request.setAttribute("mensaje", "No se pudo eliminar la editorial.");
			}
		} catch (Exception e) {
			request.setAttribute("mensaje", "Error al eliminar: " + e.getMessage());
			e.printStackTrace();
		}
		listEditorial(request, response);
	}

	private Editorial buildEditorialFromRequest(HttpServletRequest request) throws Exception {
		Editorial editorial = new Editorial();

		String idStr = request.getParameter("editEditorialId"); // Este input hidden aún no existe en tu formulario
		System.out.println("editEditorialId: " + idStr);
		if (idStr != null && !idStr.isEmpty()) {
			editorial.setIdEditorial(Integer.parseInt(idStr));
		}

		String nombre = request.getParameter("editPublisherName");
		System.out.println("editPublisherName: " + nombre);
		editorial.setNombre(nombre);

		String nacionalidad = request.getParameter("editPublisherNationality");
		System.out.println("editPublisherNationality: " + nacionalidad);
		editorial.setNacionalidad(nacionalidad);

		String generoStr = request.getParameter("editLiteraryGenre");
		System.out.println("editLiteraryGenre: " + generoStr);
		editorial.setIdGeneroLiterario(Integer.parseInt(generoStr));

		String anioStr = request.getParameter("editPublisherYear");
		System.out.println("editPublisherYear: " + anioStr);
		editorial.setAnioFundacion(Integer.parseInt(anioStr));

		String paginaWeb = request.getParameter("editPublisherWebsite");
		System.out.println("editPublisherWebsite: " + paginaWeb);
		editorial.setPaginaWeb(paginaWeb);

		String direccion = request.getParameter("editPublisherAddress");
		System.out.println("editPublisherAddress: " + direccion);
		editorial.setDireccion(direccion);

		String estado = request.getParameter("editPublisherState");
		System.out.println("editPublisherState: " + estado);
		editorial.setEstado(estado);

		return editorial;
	}

}
