<%@page import="entidades.GeneroLiterario"%>
<%@page import="entidades.Autor"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	List<Autor> listAutores = (List<Autor>) request.getAttribute("data");
	List<GeneroLiterario> listGeneroLiterario = (List<GeneroLiterario>) request.getAttribute("generos");
	String filtroRecording = request.getParameter("filtro");
	%>
	<!-- Header -->
	<jsp:include page="WEB-INF/includes/header.jsp"></jsp:include>

	<!-- Sidebars -->
	<jsp:include page="WEB-INF/includes/sidebar.jsp">
		<jsp:param name="currentPage" value="autores.jsp" />
	</jsp:include>

	<!-- Contenido Principal -->
	<main class="p-4 bg-body-tertiary">

		<!-- Tarjeta -->
		<section class="card border">

			<header class="card-header d-flex align-items-center">
				<h5 class="card-title text-center mb-0 text-body-emphasis">Tabla
					Autores</h5>
			</header>

			<div class="card-body">

				<!-- Controles de Interacción -->
				<section class="row g-3 mb-2 align-items-center">

					<!-- Botón Agregar -->
					<div
						class="col-12 col-md-6 d-flex justify-content-center justify-content-md-start mb-3 mb-md-0">
						<button class="btn btn-success d-flex align-items-center"
							data-bs-toggle="modal" data-bs-target="#addAuthorModal"
							aria-label="Agregar autor">
							<i class="bi bi-plus-circle me-2"></i> Agregar
						</button>
					</div>

					<!-- Barra de búsqueda -->
					<div
						class="col-12 col-md-6 d-flex justify-content-center justify-content-md-end align-items-center">
						<form action="AutorServlet" method="get"
							class="d-flex">
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

				<!-- Tabla de Autores -->
				<section class="table-responsive small">
					<table id="tablaAutores" class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col">Nombre</th>
								<th scope="col">Nacionalidad</th>
								<th scope="col">Fecha de Nacimiento</th>
								<th scope="col">Estado</th>
								<th scope="col" class="text-center">Acciones</th>
							</tr>
						</thead>
						<tbody>
							<%
							// Asegurarse de que la lista de autores no esté vacía
							if (listAutores != null) {
								for (Autor item : listAutores) {
							%>
							<tr>
								<td><%=item.getIdAutor()%></td>
								<td><%=item.getNombre()%></td>
								<td><%=item.getNacionalidad()%></td>
								<td><%=item.getFechaNacimiento()%></td>
								<td><%=item.getEstado()%></td>
								<td class="align-middle text-center">
									<div class="d-inline-flex gap-2">
										<!-- Botón para ver detalles del autor -->
										<button class="btn btn-sm btn-outline-secondary"
											title="Ver más" data-bs-toggle="modal"
											data-bs-target="#viewAuthorModal"
											aria-label="Ver detalles del autor"
											data-id="<%=item.getIdAutor()%>"
											data-nombre="<%=item.getNombre()%>"
											data-nacionalidad="<%=item.getNacionalidad()%>"
											data-genero-literario="<%=item.getNombreGenero()%>"
											data-fecha-nacimiento="<%=item.getFechaNacimiento()%>"
											data-biografia="<%=item.getBiografia()%>"
											data-estado="<%=item.getEstado()%>">
											<i class="bi bi-eye"></i>
										</button>
										<!-- Botón para editar el autor -->
										<button class="btn btn-sm btn-outline-primary" title="Editar"
											data-bs-toggle="modal" data-bs-target="#editAuthorModal"
											aria-label="Editar autor" data-id="<%=item.getIdAutor()%>"
											data-nombre="<%=item.getNombre()%>"
											data-nacionalidad="<%=item.getNacionalidad()%>"
											data-id-genero-literario="<%=item.getIdGeneroLiterario()%>"
											data-fecha-nacimiento="<%=item.getFechaNacimiento()%>"
											data-biografia="<%=item.getBiografia()%>"
											data-estado="<%=item.getEstado()%>">
											<i class="bi bi-pencil"></i>
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

			</div>
		</section>
	</main>


	<!-- Modal de Agregar -->
	<div class="modal fade" id="addAuthorModal" tabindex="-1"
		aria-labelledby="addAuthorModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis" id="addAuthorModalLabel">Agregar
						Autor</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<form action="AutorServlet" method="post" id="addAuthorForm">
						<input type="hidden" name="type" value="create">
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addAuthorName" class="form-label">Nombre</label> <input
									type="text" class="form-control" id="addAuthorName"
									name="addAuthorName" placeholder="Ingrese el nombre del autor"
									required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addAuthorNationality" class="form-label">Nacionalidad</label>
								<input type="text" class="form-control"
									id="addAuthorNationality" name="addAuthorNationality"
									placeholder="Ingrese la nacionalidad del autor" required>
							</div>
						</div>
						<div class="row">

							<div class="col-md-6 mb-3">
								<label for="addLiteraryGenre" class="form-label">Género
									Literario</label> <select class="form-control" id="addLiteraryGenre"
									name="addLiteraryGenre" data-live-search="true"
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
								<label for="addAuthorBirthDate" class="form-label">Fecha
									de Nacimiento</label> <input type="date" class="form-control"
									id="addAuthorBirthDate" name="addAuthorBirthDate" required>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addAuthorPhoto" class="form-label">Foto</label> <input
									type="file" class="form-control" id="addAuthorPhoto"
									name="addAuthorPhoto" accept="image/*">
							</div>
							<input type="hidden" name="addAuthorState" value="activo">
						</div>
						<div class="row">
							<div class="col-md-12 mb-3">
								<label for="addAuthorBiography" class="form-label">Biografía</label>
								<textarea class="form-control" id="addAuthorBiography"
									name="addAuthorBiography" rows="3"
									placeholder="Escribe una breve biografía"></textarea>
							</div>
						</div>
						<br>
						<div class="d-flex justify-content-center gap-3">
							<button type="button" class="btn btn-outline-secondary"
								data-bs-dismiss="modal">Cancelar</button>
							<input type="submit" class="btn btn-primary" value="Crear Autor">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal de Ver Más -->
	<div class="modal fade" id="viewAuthorModal" tabindex="-1"
		aria-labelledby="viewAuthorModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis"
						id="viewAuthorModalLabel">Detalles del Autor</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">ID</h6>
							<p id="viewAuthorID">1</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Nombre</h6>
							<p id="viewAuthorName">Juan López</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Nacionalidad</h6>
							<p id="viewAuthorNationality">Mexicano</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Género Literario</h6>
							<p id="viewAuthorGenre">Ficción</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Fecha de Nacimiento</h6>
							<p id="viewAuthorBirthDate">15-08-1980</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Foto</h6>
							<img id="viewAuthorPhoto" src="author-photo.jpg"
								alt="Foto del Autor" class="img-fluid" width="100">
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 mb-3">
							<h6 class="fw-bold">Biografía</h6>
							<p id="viewAuthorBio">Juan López es un escritor mexicano
								reconocido por sus novelas de ficción histórica. Su obra ha sido
								traducida a varios idiomas y ha recibido varios premios
								literarios.</p>
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
	<div class="modal fade" id="editAuthorModal" tabindex="-1"
		aria-labelledby="editAuthorModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis"
						id="editAuthorModalLabel">Editar Autor</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<form action="AutorServlet" method="post" id="editAuthorForm">
						<input type="hidden" name="type" value="update"> <input
							type="hidden" name="editAuthorId" id="editAuthorId">

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editAuthorName" class="form-label">Nombre</label> <input
									type="text" class="form-control" id="editAuthorName"
									name="editAuthorName" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editAuthorNationality" class="form-label">Nacionalidad</label>
								<input type="text" class="form-control"
									id="edirAuthorNationality" name="edirAuthorNationality"
									required>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editLiteraryGenre" class="form-label">Género
									Literario</label> <select class="form-control" id="editLiteraryGenre"
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
								<label for="editAuthorBirthDate" class="form-label">Fecha
									de Nacimiento</label> <input type="date" class="form-control"
									id="editAuthorBirthDate" name="editAuthorBirthDate" required>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editAuthorPhoto" class="form-label">Foto</label> <input
									type="file" class="form-control" id="editAuthorPhoto"
									name="editAuthorPhoto">
							</div>
							<div class="col-md-6 mb-3">
								<label for="editAuthorState" class="form-label">Estado</label> <select
									class="form-control" id="editAuthorState"
									name="editAuthorState" required>
									<option value="activo">Activo</option>
									<option value="inactivo">Inactivo</option>
								</select>
							</div>
						</div>

						<div class="row">
							<div class="col-md-12 mb-3">
								<label for="editAuthorBio" class="form-label">Biografía</label>
								<textarea class="form-control" id="editAuthorBio"
									name="editAuthorBio" rows="3" required></textarea>
							</div>
						</div>

						<br>
						<div class="d-flex justify-content-center gap-3">
							<button type="button" class="btn btn-outline-secondary"
								data-bs-dismiss="modal">Cancelar</button>
							<input type="submit" class="btn btn-primary" value="Editar Autor">
						</div>
					</form>

				</div>
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
	<script src="js/modals/autorModal.js"></script>
	<!-- Script para DataTable -->
	<script>
		setupDataTable('#tablaAutores');
	</script>
</body>
</html>