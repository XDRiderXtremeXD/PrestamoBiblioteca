<%@page import="entidades.Curso"%>
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
	List<Curso> listCursos = (List<Curso>) request.getAttribute("data");
	%>
	<!-- Header -->
	<jsp:include page="WEB-INF/includes/header.jsp"></jsp:include>

	<!-- Sidebars -->
	<jsp:include page="WEB-INF/includes/sidebar.jsp">
		<jsp:param name="currentPage" value="cursos.jsp" />
	</jsp:include>

	<!-- Contenido Principal -->
	<main class="p-4 bg-body-tertiary">

		<!-- Tarjeta -->
		<section class="card border">

			<header class="card-header d-flex align-items-center">
				<h5 class="card-title text-center mb-0 text-body-emphasis">Tabla
					Cursos</h5>
			</header>

			<div class="card-body">

				<!-- Controles de Interacción -->
				<section class="row g-3 mb-2 align-items-center">

					<!-- Botón Agregar -->
					<div
						class="col-12 col-md-6 d-flex justify-content-center justify-content-md-start mb-3 mb-md-0">
						<button class="btn btn-success d-flex align-items-center"
							data-bs-toggle="modal" data-bs-target="#addCourseModal"
							aria-label="Agregar curso">
							<i class="bi bi-plus-circle me-2"></i> Agregar
						</button>
					</div>

					<!-- Barra de búsqueda -->
					<div
						class="col-12 col-md-6 d-flex justify-content-center justify-content-md-end align-items-center">
						<label for="customSearch" class="visually-hidden">Buscar
							curso</label> <input type="text" id="customSearch"
							class="form-control me-2 w-100 w-md-auto" placeholder="Buscar..."
							style="max-width: 200px;">
						<button class="btn btn-primary" aria-label="Iniciar búsqueda">Buscar</button>
					</div>
				</section>

				<!-- Tabla de Cursos -->
				<section class="table-responsive small">
					<table id="tablaCursos" class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col">Nombre</th>
								<th scope="col">Descripción</th>
								<th scope="col">Nivel</th>
								<th scope="col">Estado</th>
								<th scope="col" class="text-center">Acciones</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (listCursos != null) {
								for (Curso item : listCursos) {
							%>
							<tr>
								<td><%=item.getIdCurso()%></td>
								<td><%=item.getNombre()%></td>
								<td><%=item.getDescripcion()%></td>
								<td><%=item.getNivel()%></td>
								<td><%=item.getEstado()%></td>
								<td class="align-middle text-center">
									<div class="d-inline-flex gap-2">
										>
										<!-- Botón para ver detalles del curso -->
										<button class="btn btn-sm btn-outline-secondary"
											title="Ver más" data-bs-toggle="modal"
											data-bs-target="#viewCourseModal"
											aria-label="Ver detalles del curso"
											data-id="<%=item.getIdCurso()%>"
											data-nombre="<%=item.getNombre()%>"
											data-nivel="<%=item.getNivel()%>"
											data-descripcion="<%=item.getDescripcion()%>"
											data-estado="<%=item.getEstado()%>">
											<i class="bi bi-eye"></i>
										</button>
										<!-- Botón para editar el curso -->
										<button class="btn btn-sm btn-outline-primary" title="Editar"
											data-bs-toggle="modal" data-bs-target="#editCourseModal"
											aria-label="Editar curso" data-id="<%=item.getIdCurso()%>"
											data-nombre="<%=item.getNombre()%>"
											data-nivel="<%=item.getNivel()%>"
											data-descripcion="<%=item.getDescripcion()%>"
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
			</div>
		</section>
		</section>
	</main>

	<!-- Modal de Agregar -->
	<div class="modal fade" id="addCourseModal" tabindex="-1"
		aria-labelledby="addCourseModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis" id="addCourseModalLabel">Agregar
						Curso</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<form action="" method="post" id="addCourseForm">
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addCourseName" class="form-label">Nombre</label> <input
									type="text" class="form-control" id="addCourseName"
									name="addCourseName" placeholder="Ingrese el nombre del curso"
									required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addCourseLevel" class="form-label">Nivel</label> <select
									class=" form-control" id="addCourseLevel"
									title="Seleccione un nivel" required>
									<option value="Básico">Básico</option>
									<option value="Intermedio">Intermedio</option>
									<option value="Avanzado">Avanzado</option>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addCourseState" class="form-label">Estado</label> <select
									class=" form-control" id="addCourseState"
									title="Seleccione un estado" required>
									<option value="Activo">Activo</option>
									<option value="No Activo">Inactivo</option>
								</select>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editCourseDescription" class="form-label">Descripción</label>
								<textarea class="form-control" id="editCourseDescription"
									name="editCourseDescription" rows="4"
									placeholder="Ingrese una breve descripción" required></textarea>
							</div>
						</div>
					</form>
				</div>
				<footer class="modal-footer">
					<button type="button"
						class="btn btn-outline-secondary static-style"
						data-bs-dismiss="modal">Cancelar</button>
					<button type="submit" class="btn btn-success showSweetAlert"
						data-bs-dismiss="modal" data-text="Curso agregado correctamente."
						data-icon="success" form="addCourseForm">Agregar</button>
				</footer>
			</div>
		</div>
	</div>

	<!-- Modal de Ver Más -->
	<div class="modal fade" id="viewCourseModal" tabindex="-1"
		aria-labelledby="viewCourseModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis"
						id="viewCourseModalLabel">Detalles del Curso</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">ID</h6>
							<p id="viewCourseID">1</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Nombre</h6>
							<p id="viewCourseName">Matemáticas Básicas</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Nivel</h6>
							<p id="viewCourseLevel">Intermedio</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Estado</h6>
							<p id="viewCourseState" class="text-success">Activo</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 mb-3">
							<h6 class="fw-bold">Descripción</h6>
							<p id="viewCourseDescription">Este curso cubre los principios
								básicos de las matemáticas, ideal para estudiantes de secundaria
								o principios de universidad.</p>
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
	<div class="modal fade" id="editCourseModal" tabindex="-1"
		aria-labelledby="editCourseModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis"
						id="editCourseModalLabel">Editar Curso</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<form action="" method="post" id="editCourseForm">
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editCourseName" class="form-label">Nombre</label> <input
									type="text" class="form-control" id="editCourseName"
									name="editCourseName" value="Matemáticas Básicas" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editCourseLevel" class="form-label">Nivel</label> <select
									class=" form-control" id="editCourseLevel"
									name="editCourseLevel" required>
									<option value="Básico">Básico</option>
									<option value="Intermedio" selected>Intermedio</option>
									<option value="Avanzado">Avanzado</option>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editCourseState" class="form-label">Estado</label> <select
									class=" form-control" id="editCourseState"
									name="editCourseState" required>
									<option value="Activo" selected>Activo</option>
									<option value="No Activo">Inactivo</option>
								</select>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editCourseDescription" class="form-label">Descripción</label>
								<textarea class="form-control" id="editCourseDescription"
									name="editCourseDescription" rows="4" required>Este curso cubre los principios básicos de las matemáticas, ideal para estudiantes de secundaria o principios de universidad.</textarea>
							</div>
						</div>
					</form>
				</div>
				<footer class="modal-footer">
					<button type="button"
						class="btn btn-outline-secondary static-style"
						data-bs-dismiss="modal">Cancelar</button>
					<button type="submit" class="btn btn-success showSweetAlert"
						data-bs-dismiss="modal" data-text="Curso editado correctamente."
						data-icon="success" form="editCourseForm">Guardar</button>
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
	<script src="js/cursosModal.js"></script>
	<!-- Script para DataTable  -->
	<script>
		setupDataTable('#tablaCursos');
	</script>
</body>
</html>