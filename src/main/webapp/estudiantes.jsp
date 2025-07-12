<%@page import="entidades.Facultad"%>
<%@page import="java.util.List"%>
<%@page import="entidades.Estudiante"%>
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
	List<Estudiante> listEstudiante = (List<Estudiante>) request.getAttribute("data");
	List<Facultad> listFacultad = (List<Facultad>) request.getAttribute("facultades");
	String filtroRecording = request.getParameter("filtro");
	%>
	<!-- Header -->
	<jsp:include page="WEB-INF/includes/header.jsp"></jsp:include>

	<!-- Sidebars -->
	<jsp:include page="WEB-INF/includes/sidebar.jsp">
		<jsp:param name="currentPage" value="estudiantes.jsp" />
	</jsp:include>

	<!-- Contenido Principal -->
	<main class="p-4 bg-body-tertiary">

		<!-- Tarjeta -->
		<section class="card border">

			<header class="card-header d-flex align-items-center">
				<h5 class="card-title text-center mb-0 text-body-emphasis">Tabla
					Estudiantes</h5>
			</header>

			<div class="card-body">

				<!-- Controles de Interacción -->
				<section class="row g-3 mb-2 align-items-center">

					<!-- Botón Agregar -->
					<div
						class="col-12 col-md-6 d-flex justify-content-center justify-content-md-start mb-3 mb-md-0">
						<button class="btn btn-success d-flex align-items-center"
							data-bs-toggle="modal" data-bs-target="#addStudentModal"
							aria-label="Agregar Estudiante">
							<i class="bi bi-plus-circle me-2"></i> Agregar
						</button>
					</div>

					<!-- Barra de búsqueda -->
					<div
						class="col-12 col-md-6 d-flex justify-content-center justify-content-md-end align-items-center">
						<form action="EstudianteServlet" method="get"
							class="d-flex">
							<input type="hidden" name="type" value="list"> <label
								for="customSearch" class="visually-hidden">Buscar Estudiante</label>

							<input type="text" id="customSearch" name="filtro"
								class="form-control me-2 w-100 w-md-auto"
								style="max-width: 200px;" placeholder="Buscar..."
								value="<%=filtroRecording == null ? "" : filtroRecording%>">

							<button type="submit" class="btn btn-primary"
								aria-label="Iniciar búsqueda">Buscar</button>
						</form>
					</div>
				</section>

				<!-- Tabla de Estudiantes -->
				<section class="table-responsive small">
					<table id="tablaEstudiantes" class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col">DNI</th>
								<th scope="col">Nombres</th>
								<th scope="col">Apellidos</th>
								<th scope="col">Dirección</th>
								<th scope="col">Teléfono</th>
								<th scope="col">Correo Electrónico</th>
								<th scope="col">Género</th>
								<th scope="col">Facultad</th>
								<th scope="col">Estado</th>
								<th scope="col" class="text-center">Acciones</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (listEstudiante != null) {
								for (Estudiante item : listEstudiante) {
							%>
							<tr>
								<td><%=item.getIdEstudiante()%></td>
								<td><%=item.getDni()%></td>
								<td><%=item.getNombres()%></td>
								<td><%=item.getApellidos()%></td>
								<td><%=item.getDireccion()%></td>
								<td><%=item.getTelefono()%></td>
								<td><%=item.getCorreoElectronico()%></td>
								<td><%=item.getGenero()%></td>
								<td><%=item.getFacultad()%></td>
								<td><%=item.getEstado()%></td>
								<td class="align-middle text-center">
									<div class="d-inline-flex gap-2">
										<!-- Botón para ver detalles del estudiante -->
										<button class="btn btn-sm btn-outline-secondary view-student"
											title="Ver más" data-bs-toggle="modal"
											data-bs-target="#viewStudentModal"
											aria-label="Ver detalles del estudiante"
											data-id="<%=item.getIdEstudiante()%>"
											data-dni="<%=item.getDni()%>"
											data-nombres="<%=item.getNombres()%>"
											data-apellidos="<%=item.getApellidos()%>"
											data-direccion="<%=item.getDireccion()%>"
											data-telefono="<%=item.getTelefono()%>"
											data-correo-electronico="<%=item.getCorreoElectronico()%>"
											data-fecha-nacimiento="<%=item.getFechaNacimiento()%>"
											data-genero="<%=item.getGenero()%>"
											data-facultad="<%=item.getFacultad()%>"
											data-estado="<%=item.getEstado()%>">
											<i class="bi bi-eye"></i>
										</button>
										<!-- Botón para editar el estudiante -->
										<button class="btn btn-sm btn-outline-primary edit-student"
											title="Editar" data-bs-toggle="modal"
											data-bs-target="#editStudentModal"
											aria-label="Editar estudiante"
											data-id="<%=item.getIdEstudiante()%>"
											data-dni="<%=item.getDni()%>"
											data-nombres="<%=item.getNombres()%>"
											data-apellidos="<%=item.getApellidos()%>"
											data-direccion="<%=item.getDireccion()%>"
											data-telefono="<%=item.getTelefono()%>"
											data-correo-electronico="<%=item.getCorreoElectronico()%>"
											data-fecha-nacimiento="<%=item.getFechaNacimiento()%>"
											data-genero="<%=item.getGenero()%>"
											data-facultad="<%=item.getFacultad()%>"
											data-estado="<%=item.getEstado()%>">
											<i class="bi bi-pencil""></i>
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
	<div class="modal fade" id="addStudentModal" tabindex="-1"
		aria-labelledby="addStudentModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis"
						id="addStudentModalLabel">Agregar Estudiante</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>

				<div class="modal-body">
					<form action="EstudianteServlet" method="post" id="addStudentForm">
						<input type="hidden" name="type" value="create">

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addStudentDni" class="form-label">DNI</label> <input
									type="text" class="form-control" id="addStudentDni"
									name="addStudentDni"
									placeholder="Ingrese el DNI del estudiante" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addStudentFirstName" class="form-label">Nombres</label>
								<input type="text" class="form-control" id="addStudentFirstName"
									name="addStudentFirstName"
									placeholder="Ingrese los nombres del estudiante" required>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addStudentLastName" class="form-label">Apellidos</label>
								<input type="text" class="form-control" id="addStudentLastName"
									name="addStudentLastName"
									placeholder="Ingrese los apellidos del estudiante" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addStudentAddress" class="form-label">Dirección</label>
								<input type="text" class="form-control" id="addStudentAddress"
									name="addStudentAddress"
									placeholder="Ingrese la dirección del estudiante" required>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addStudentPhone" class="form-label">Teléfono</label>
								<input type="text" class="form-control" id="addStudentPhone"
									name="addStudentPhone"
									placeholder="Ingrese el teléfono del estudiante" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addStudentEmail" class="form-label">Correo
									Electrónico</label> <input type="email" class="form-control"
									id="addStudentEmail" name="addStudentEmail"
									placeholder="ejemplo@correo.com" required>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addStudentBirthDate" class="form-label">Fecha
									de Nacimiento</label> <input type="date" class="form-control"
									id="addStudentBirthDate" name="addStudentBirthDate" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addStudentGender" class="form-label">Género</label>
								<select class="form-control" id="addStudentGender"
									name="addStudentGender" required>
									<option value="">Seleccione un género</option>
									<option value="Masculino">Masculino</option>
									<option value="Femenino">Femenino</option>
								</select>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addFaculty" class="form-label">Facultad</label> <select
									class="form-control" id="addFaculty" name="addFaculty" required>
									<option value="">Seleccione una facultad</option>
									<%
									if (listFacultad != null) {
										for (Facultad item : listFacultad) {
									%>
									<option value="<%=item.getIdFacultad()%>"><%=item.getNombreFacultad()%></option>
									<%
									}
									}
									%>
								</select>
							</div>
							
							<input type="hidden" name="addStudentState" value="activo">
						</div>

						<br>
						<div class="d-flex justify-content-center gap-3">
							<button type="button" class="btn btn-outline-secondary"
								data-bs-dismiss="modal">Cancelar</button>
							<input type="submit" class="btn btn-primary"
								value="Agregar Estudiante">
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>


	<!-- Modal de Ver Más -->
	<div class="modal fade" id="viewStudentModal" tabindex="-1"
		aria-labelledby="viewStudentModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis"
						id="viewStudentModalLabel">Detalles del Estudiante</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">ID</h6>
							<p id="viewStudentID">1</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">DNI</h6>
							<p id="viewStudentDNI">12345678</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Nombres</h6>
							<p id="viewStudentFirstName">Juan</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Apellidos</h6>
							<p id="viewStudentLastName">Pérez Gómez</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Dirección</h6>
							<p id="viewStudentAddress">Calle Falsa 123, Ciudad</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Teléfono</h6>
							<p id="viewStudentPhone">987654321</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Correo Electrónico</h6>
							<p id="viewStudentEmail">juan.perez@mail.com</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Fecha de Nacimiento</h6>
							<p id="viewStudentBirthDate">15-04-1998</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Género</h6>
							<p id="viewStudentGender">Masculino</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Facultad</h6>
							<p id="viewStudentFaculty">Ingeniería</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Estado</h6>
							<p id="viewStudentState" class="text-success">Activo</p>
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
	<div class="modal fade" id="editStudentModal" tabindex="-1"
		aria-labelledby="editStudentModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis"
						id="editStudentModalLabel">Editar Estudiante</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>

				<div class="modal-body">
					<form action="EstudianteServlet" method="post" id="editStudentForm">
						<input type="hidden" name="type" value="update"> <input
							type="hidden" name="editId" id="editStudentId" value="0">

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editStudentDNI" class="form-label">DNI</label> <input
									type="text" class="form-control" id="editStudentDNI"
									name="editStudentDNI" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editStudentFirstName" class="form-label">Nombres</label>
								<input type="text" class="form-control"
									id="editStudentFirstName" name="editStudentFirstName" required>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editStudentLastName" class="form-label">Apellidos</label>
								<input type="text" class="form-control" id="editStudentLastName"
									name="editStudentLastName" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editStudentAddress" class="form-label">Dirección</label>
								<input type="text" class="form-control" id="editStudentAddress"
									name="editStudentAddress" required>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editStudentPhone" class="form-label">Teléfono</label>
								<input type="text" class="form-control" id="editStudentPhone"
									name="editStudentPhone" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editStudentEmail" class="form-label">Correo
									Electrónico</label> <input type="email" class="form-control"
									id="editStudentEmail" name="editStudentEmail" required>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editStudentBirthDate" class="form-label">Fecha
									de Nacimiento</label> <input type="date" class="form-control"
									id="editStudentBirthDate" name="editStudentBirthDate" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editstudentGender" class="form-label">Género</label>
								<select class="form-control" id="editstudentGender"
									name="editstudentGender" required>
									<option value="Masculino">Masculino</option>
									<option value="Femenino">Femenino</option>
								</select>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editFaculty" class="form-label">Facultad</label> <select
									class="form-control" id="editFaculty" name="editFaculty"
									required>
									<%
									if (listFacultad != null) {
										for (Facultad item : listFacultad) {
									%>
									<option value="<%=item.getIdFacultad()%>"><%=item.getNombreFacultad()%></option>
									<%
									}
									}
									%>
								</select>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editStudentState" class="form-label">Estado</label>
								<select class="form-control" id="editStudentState"
									name="editStudentState" required>
									<option value="activo">Activo</option>
									<option value="inactivo">Inactivo</option>
								</select>
							</div>
						</div>

						<br>
						<div class="d-flex justify-content-center gap-3">
							<button type="button" class="btn btn-outline-secondary"
								data-bs-dismiss="modal">Cancelar</button>
							<input type="submit" class="btn btn-primary"
								value="Guardar Cambios">
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>


	<!-- Modal de Eliminar -->
	<div class="modal fade" id="deleteStudentModal" tabindex="-1"
		aria-labelledby="deleteStudentModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title text-body-emphasis"
						id="deleteStudentModalLabel">Confirmar Eliminación de
						Estudiante</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>¿Estás seguro de que deseas eliminar este estudiante?</p>
				</div>
				<div class="modal-footer">
					<button type="button"
						class="btn btn-outline-secondary static-style"
						data-bs-dismiss="modal">Cancelar</button>
					<button type="button" class="btn btn-danger"
						id="confirmDeleteStudent">Eliminar</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Scripts de bibliotecas externas   -->
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
	<script src="js/estudianteModal.js"></script>
	<!-- Script para DataTable -->
	<script>
		setupDataTable('#tablaEstudiantes');
	</script>
</body>
</html>