<%@page import="entidades.Editorial"%>
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
	List<Editorial> listEditorial= (List<Editorial>) request.getAttribute("data");
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
						<label for="customSearch" class="visually-hidden">Buscar
							editorial</label> <input type="text" id="customSearch"
							class="form-control me-2 w-100 w-md-auto" placeholder="Buscar..."
							style="max-width: 200px;">
						<button class="btn btn-primary" aria-label="Iniciar búsqueda">Buscar</button>
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
								<td><%=item.getGeneroLiterario()%></td>
								<td><%=item.getFoto()%></td>
								<td><%=item.getAnioFundacion()%></td>
								<td><%=item.getPaginaWeb()%></td>
								<td><%=item.getDireccion()%></td>
								<td><%=item.getEstado()%></td>
								<td class="align-middle text-center">
									<div class="d-inline-flex gap-2">
										<button
											class="btn btn-sm btn-outline-secondary view-editorial"
											data-id="<%=item.getIdEditorial()%>" data-bs-toggle="modal"
											data-bs-target="#viewEditorialModal" title="Ver más"
											aria-label="Ver detalles de la editorial">
											<i class="bi bi-eye"></i>
										</button>

										<button class="btn btn-sm btn-outline-primary edit-editorial"
											data-id="<%=item.getIdEditorial()%>" data-bs-toggle="modal"
											data-bs-target="#editEditorialModal" title="Editar"
											aria-label="Editar editorial">
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
	</main>

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
					<form action="" method="post" id="addEditorialForm">
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addEditorialName" class="form-label">Nombre</label>
								<input type="text" class="form-control" id="addEditorialName"
									name="addEditorialName"
									placeholder="Ingrese el nombre de la editorial" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addEditorialNationality" class="form-label">Nacionalidad</label>
								<input type="text" class="form-control"
									id="addEditorialNationality" name="addEditorialNationality"
									placeholder="Ingrese la nacionalidad de la editorial" required>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addLiteraryGenre" class="form-label">Género
									Literario</label> <select class="selectpicker form-control"
									id="addLiteraryGenre" data-live-search="true"
									title="Seleccione un género literario" required>
									<option value="Realismo mágico">Realismo mágico</option>
									<option value="Fantasía">Fantasía</option>
									<option value="Ficción">Ficción</option>
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
									id="addFoundationYear" name="addFoundationYear" min="0"
									max="2024" placeholder="Ingrese el año de fundación" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addEditorialWebsite" class="form-label">Página
									Web</label> <input type="url" class="form-control"
									id="addEditorialWebsite" name="addEditorialWebsite"
									placeholder="https://ejemplo.com">
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addEditorialAddress" class="form-label">Dirección</label>
								<textarea class="form-control" id="addEditorialAddress"
									name="addEditorialAddress" rows="3"
									placeholder="Ingrese la dirección de la editorial"></textarea>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addEditorialState" class="form-label">Estado</label>
								<select class="selectpicker form-control" id="addEditorialState"
									title="Seleccione un estado" required>
									<option value="Activo">Activo</option>
									<option value="No Activo">Inactivo</option>
								</select>
							</div>
						</div>
					</form>
				</div>
				<footer class="modal-footer">
					<button type="button"
						class="btn btn-outline-secondary static-style"
						data-bs-dismiss="modal">Cancelar</button>
					<button type="submit" class="btn btn-success showSweetAlert"
						data-bs-dismiss="modal"
						data-text="Editorial agregada correctamente." data-icon="success"
						form="addEditorialForm">Agregar</button>
				</footer>
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
					<form action="" method="post" id="editPublisherForm">
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
									Literario</label> <select class="selectpicker form-control"
									id="editLiteraryGenre" title="Seleccione un género literario"
									required>
									<option value="Realismo mágico" selected>Realismo
										mágico</option>
									<option value="Fantasía">Fantasía</option>
									<option value="Ficción">Ficción</option>
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
								<select class="selectpicker form-control"
									id="editPublisherState" name="Seleccione un estado" required>
									<option value="Activo" selected>Activo</option>
									<option value="No Activo">Inactivo</option>
								</select>
							</div>
						</div>
					</form>
				</div>
				<footer class="modal-footer">
					<button type="button"
						class="btn btn-outline-secondary static-style"
						data-bs-dismiss="modal">Cancelar</button>
					<button type="submit" class="btn btn-success showSweetAlert"
						data-bs-dismiss="modal"
						data-text="Editorial editada correctamente." data-icon="success"
						form="editPublisherForm">Guardar</button>
				</footer>
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

	<!-- Script para DataTable -->
	<script>
		setupDataTable('#tablaEditoriales');
	</script>
</body>
</html>