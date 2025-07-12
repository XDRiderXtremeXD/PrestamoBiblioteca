<%@page import="entidades.Perfil"%>
<%@page import="entidades.GeneroLiterario"%>
<%@page import="entidades.Editorial"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Perfil perfil = (Perfil) session.getAttribute("perfilLogueado");
	if (perfil == null) {
		response.sendRedirect("login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html lang="es" data-bs-theme="auto">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/css/bootstrap-select.min.css">
<link rel="stylesheet" href="css/sidebars.css">
<title>BookStudio</title>
<link rel="icon" href="images/favicon.ico" type="image/x-icon">
</head>
<body>
	<%
	List<Editorial> listEditorial = (List<Editorial>) request.getAttribute("data");
	List<GeneroLiterario> listGeneroLiterario = (List<GeneroLiterario>) request.getAttribute("generos");
	String filtroRecording = request.getParameter("filtro");
	%>
	<!-- Header -->
	<jsp:include page="WEB-INF/includes/header.jsp"></jsp:include>

	<!-- Sidebars -->
	<jsp:include page="WEB-INF/includes/sidebar.jsp">
		<jsp:param name="currentPage" value="editoriales.jsp" />
	</jsp:include>

	<!-- Contenido Principal -->
	<main class="p-4 bg-body-tertiary">

		<!-- Tarjeta -->
		<section class="card border">

			<header class="card-header d-flex align-items-center">
				<h5 class="card-title text-center mb-0 text-body-emphasis">Tabla
					Editoriales</h5>
			</header>

			<div class="card-body">

				<!-- Controles de Interacción -->
				<section class="row g-3 mb-2 align-items-center">

					<!-- Botón Agregar -->
					<div
						class="col-12 col-md-6 d-flex justify-content-center justify-content-md-start mb-3 mb-md-0">
						<button class="btn btn-success d-flex align-items-center"
							data-bs-toggle="modal" data-bs-target="#addEditorialModal"
							aria-label="Agregar editorial">
							<i class="bi bi-plus-circle me-2"></i> Agregar
						</button>
					</div>

					<!-- Barra de búsqueda -->
					<div
						class="col-12 col-md-6 d-flex justify-content-center justify-content-md-end align-items-center">
						<form action="EditorialServlet" method="get" class="d-flex">
							<input type="hidden" name="type" value="list"> <label
								for="customSearch" class="visually-hidden">Buscar Autor</label>

							<input type="text" id="customSearch" name="filtro"
								class="form-control me-2 w-100 w-md-auto"
								style="max-width: 200px;" placeholder="Buscar..."
								value="<%=filtroRecording == null ? "" : filtroRecording%>">

							<button type="submit" class="btn btn-primary"
								aria-label="Iniciar búsqueda">Buscar</button>
						</form>
					</div>
				</section>

				<!-- Tabla de Editoriales -->
				<section class="table-responsive small">
					<table id="tablaEditoriales" class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col">Nombre</th>
								<th scope="col">Nacionalidad</th>
								<th scope="col">Género Literario</th>
								<th scope="col">Foto</th>
								<th scope="col">Año Fundación</th>
								<th scope="col">Página Web</th>
								<th scope="col">Dirección</th>
								<th scope="col">Estado</th>
								<th scope="col" class="text-center">Acciones</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (listEditorial != null) {
								for (Editorial item : listEditorial) {
							%>
							<tr>
								<td><%=item.getIdEditorial()%></td>
								<td><%=item.getNombre()%></td>
								<td><%=item.getNacionalidad()%></td>
								<td><%=item.getNombreGeneroLiterario()%></td>
								<td><%=item.getFoto()%></td>
								<td><%=item.getAnioFundacion()%></td>
								<td><%=item.getPaginaWeb()%></td>
								<td><%=item.getDireccion()%></td>
								<td><%=item.getEstado()%></td>
								<td class="align-middle text-center">
									<div class="d-inline-flex gap-2">
										<!-- Botón para ver detalles de la editorial -->
										<button class="btn btn-sm btn-outline-secondary"
											title="Ver más" data-bs-toggle="modal"
											data-bs-target="#viewPublisherModal"
											aria-label="Ver detalles de la editorial"
											data-id="<%=item.getIdEditorial()%>"
											data-nombre="<%=item.getNombre()%>"
											data-nacionalidad="<%=item.getNacionalidad()%>"
											data-genero-literario="<%=item.getNombreGeneroLiterario()%>"
											data-anio-fundacion="<%=item.getAnioFundacion()%>"
											data-pagina-web="<%=item.getPaginaWeb()%>"
											data-direccion="<%=item.getDireccion()%>"
											data-estado="<%=item.getEstado()%>"
											data-foto="<%=item.getFoto()%>">
											<i class="bi bi-eye"></i>
										</button>
										<!-- Botón para editar la editorial -->
										<button class="btn btn-sm btn-outline-primary" title="Editar"
											data-bs-toggle="modal" data-bs-target="#editPublisherModal"
											aria-label="Editar editorial"
											data-id="<%=item.getIdEditorial()%>"
											data-nombre="<%=item.getNombre()%>"
											data-nacionalidad="<%=item.getNacionalidad()%>"
											data-genero-literario="<%=item.getNombreGeneroLiterario()%>"
											data-anio-fundacion="<%=item.getAnioFundacion()%>"
											data-pagina-web="<%=item.getPaginaWeb()%>"
											data-direccion="<%=item.getDireccion()%>"
											data-estado="<%=item.getEstado()%>"
											data-foto="<%=item.getFoto()%>">
											<i class="bi bi-pencil"></i>
										</button>
										<!-- Botón para eliminar la editorial -->
										<button class="btn btn-sm btn-outline-danger" title="Eliminar"
											data-bs-toggle="modal" data-bs-target="#deletePublisherModal"
											aria-label="Eliminar editorial"
											data-id="<%=item.getIdEditorial()%>">
											<i class="bi bi-trash"></i>
										</button>
									</div>
								</td>
							</tr>
							<%
							}
							}
							%>
						</tbody>
					</table>
				</section>
	</main>
	
	<!-- Modal de Confirmación para Eliminar -->
<div class="modal fade" id="deletePublisherModal" tabindex="-1" aria-labelledby="deletePublisherModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<header class="modal-header">
				<h5 class="modal-title" id="deletePublisherModalLabel">¿Eliminar Editorial?</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
			</header>
			<div class="modal-body">
				<p>¿Estás seguro que deseas eliminar esta editorial?</p>
			</div>
			<footer class="modal-footer">
				<form action="EditorialServlet" method="post">
					<input type="hidden" name="type" value="delete">
					<input type="hidden" id="deleteEditorialId" name="editEditorialId" value="0">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
					<button type="submit" class="btn btn-danger">Eliminar</button>
				</form>
			</footer>
		</div>
	</div>
</div>
	

	<!-- Modal de Agregar -->
	<div class="modal fade" id="addEditorialModal" tabindex="-1"
		aria-labelledby="addEditorialModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis"
						id="addEditorialModalLabel">Agregar Editorial</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<form action="EditorialServlet" method="post" id="addEditorialForm">
						<input type="hidden" name="type" value="create">

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addEditorialName" class="form-label">Nombre</label>
								<input type="text" class="form-control" id="addEditorialName"
									name="editPublisherName"
									placeholder="Ingrese el nombre de la editorial" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addEditorialNationality" class="form-label">Nacionalidad</label>
								<input type="text" class="form-control"
									id="addEditorialNationality" name="editPublisherNationality"
									placeholder="Ingrese la nacionalidad de la editorial" required>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addLiteraryGenre" class="form-label">Género
									Literario</label> <select class="form-control" id="addLiteraryGenre"
									name="editLiteraryGenre" data-live-search="true"
									title="Seleccione un género literario" required>
									<%
									if (listGeneroLiterario != null) {
										for (GeneroLiterario item : listGeneroLiterario) {
									%>
									<option value="<%=item.getIdGeneroLiterario()%>"><%=item.getNombreGenero()%></option>
									<%
									}
									}
									%>
								</select>
							</div>

							<div class="col-md-6 mb-3">
								<label for="addEditorialPhoto" class="form-label">Foto</label> <input
									type="file" class="form-control" id="addEditorialPhoto"
									name="addEditorialPhoto" accept="image/*">
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addFoundationYear" class="form-label">Año de
									Fundación</label> <input type="number" class="form-control"
									id="addFoundationYear" name="editPublisherYear" min="0"
									max="2024" placeholder="Ingrese el año de fundación" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addEditorialWebsite" class="form-label">Página
									Web</label> <input type="url" class="form-control"
									id="addEditorialWebsite" name="editPublisherWebsite"
									placeholder="https://ejemplo.com">
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addEditorialAddress" class="form-label">Dirección</label>
								<textarea class="form-control" id="addEditorialAddress"
									name="editPublisherAddress" rows="3"
									placeholder="Ingrese la dirección de la editorial"></textarea>
							</div>
							
							<input type="hidden" name="editPublisherState" value="activo">
							
						</div>

						<br>
						<div class="d-flex justify-content-center gap-3">
							<button type="button" class="btn btn-outline-secondary"
								data-bs-dismiss="modal">Cancelar</button>
							<input type="submit" class="btn btn-primary"
								value="Crear Editorial">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<!-- Modal de Ver Más -->
	<div class="modal fade" id="viewPublisherModal" tabindex="-1"
		aria-labelledby="viewPublisherModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis"
						id="viewPublisherModalLabel">Detalles de la Editorial</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">ID</h6>
							<p id="viewPublisherID">1</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Nombre</h6>
							<p id="viewPublisherName">HarperCollins</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Nacionalidad</h6>
							<p id="viewPublisherNationality">Estadounidense</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Género Literario</h6>
							<p id="viewPublisherGenre">Ficción, No Ficción</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Foto</h6>
							<img id="viewPublisherPhoto" src="publisher-photo.jpg"
								alt="Foto de la Editorial" class="img-fluid" width="100">
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Año de Fundación</h6>
							<p id="viewPublisherYear">1989</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Página Web</h6>
							<p id="viewPublisherWebsite">
								<a href="https://www.harpercollins.com" target="_blank">www.harpercollins.com</a>
							</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Dirección</h6>
							<p id="viewPublisherAddress">195 Broadway, New York, NY
								10007, USA</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Estado</h6>
							<p id="viewPublisherState" class="text-success">Activo</p>
						</div>
					</div>
				</div>
				<footer class="modal-footer">
					<button type="button"
						class="btn btn-outline-secondary static-style"
						data-bs-dismiss="modal">Cerrar</button>
				</footer>
			</div>
		</div>
	</div>

	<!-- Modal de Editar -->
	<div class="modal fade" id="editPublisherModal" tabindex="-1"
		aria-labelledby="editPublisherModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis"
						id="editPublisherModalLabel">Editar Editorial</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<form action="EditorialServlet" method="post"
						id="editPublisherForm">
						<input type="hidden" name="type" value="update"> <input
							type="hidden" name="editEditorialId" id="editEditorialId"
							value="0">
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editPublisherName" class="form-label">Nombre</label>
								<input type="text" class="form-control" id="editPublisherName"
									name="editPublisherName" value="HarperCollins" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editPublisherNationality" class="form-label">Nacionalidad</label>
								<input type="text" class="form-control"
									id="editPublisherNationality" name="editPublisherNationality"
									value="Estadounidense" required>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editLiteraryGenre" class="form-label">Género
									Literario</label> <select class="form-control" id="editLiteraryGenre"
									data-live-search="true" title="Seleccione un género literario"
									name="editLiteraryGenre" required>
									<%
									if (listGeneroLiterario != null) {
										for (GeneroLiterario item : listGeneroLiterario) {
									%>
									<option value="<%=item.getIdGeneroLiterario()%>"><%=item.getNombreGenero()%></option>
									<%
									}
									}
									%>
								</select>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editPublisherPhoto" class="form-label">Foto</label>
								<input type="file" class="form-control" id="editPublisherPhoto"
									name="editPublisherPhoto">
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editPublisherYear" class="form-label">Año de
									Fundación</label> <input type="number" class="form-control"
									id="editPublisherYear" name="editPublisherYear" value="1989"
									required>
							</div>

							<div class="col-md-6 mb-3">
								<label for="editPublisherWebsite" class="form-label">Página
									Web</label> <input type="url" class="form-control"
									id="editPublisherWebsite" name="editPublisherWebsite"
									value="https://www.harpercollins.com" required>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editPublisherAddress" class="form-label">Dirección</label>
								<textarea class="form-control" id="editPublisherAddress"
									name="editPublisherAddress" rows="3"
									placeholder="Ingrese la dirección de la editorial" required>195 Broadway, New York, NY 10007, USA</textarea>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editPublisherState" class="form-label">Estado</label>
								<select class=" form-control" id="editPublisherState"
									name="editPublisherState" required>
									<option value="activo" selected>Activo</option>
									<option value="inactivo">Inactivo</option>
								</select>
							</div>
						</div>
						<br>
						<div class="d-flex justify-content-center gap-3">
							<button type="button" class="btn btn-outline-secondary"
								data-bs-dismiss="modal">Cancelar</button>
							<input type="submit" class="btn btn-primary"
								value="Editar Editorial">
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- Scripts de bibliotecas externas -->
		<script src="js/color-modes.js"></script>
		<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
		<script
			src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/js/bootstrap-select.min.js"></script>
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/i18n/defaults-es_ES.min.js"></script>
		<script
			src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

		<!-- Scripts personalizados (que se cargan después de las bibliotecas) -->
		<script src="js/alert.js"></script>
		<script src="js/datatables-setup.js"></script>
		<script src="js/modals/editorialesModal.js"></script>
		<!-- Script para DataTable -->
		<script>
			setupDataTable('#tablaEditoriales');
		</script>
</body>
</html>