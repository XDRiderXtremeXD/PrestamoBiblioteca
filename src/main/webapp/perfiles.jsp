<%@page import="entidades.Perfil"%>
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
	List<Perfil> listPerfil = (List<Perfil>) request.getAttribute("data");
	String filtroRecording = request.getParameter("filtro");
	%>
	<!-- Header -->
	<jsp:include page="WEB-INF/includes/header.jsp"></jsp:include>

	<!-- Sidebars -->
	<jsp:include page="WEB-INF/includes/sidebar.jsp">
		<jsp:param name="currentPage" value="perfiles.jsp" />
	</jsp:include>

	<!-- Contenido Principal -->
	<main class="p-4 bg-body-tertiary">

		<!-- Tarjeta -->
		<section class="card border">

			<header class="card-header d-flex align-items-center">
				<h5 class="card-title text-center mb-0 text-body-emphasis">Perfiles</h5>
			</header>

			<div class="card-body">

				<!-- Controles de Interacción -->
				<section class="row g-3 mb-2 align-items-center">

					<!-- Botón Agregar -->
					<div
						class="col-12 col-md-6 d-flex justify-content-center justify-content-md-start mb-3 mb-md-0">
						<button class="btn btn-success d-flex align-items-center"
							data-bs-toggle="modal" data-bs-target="#addProfileModal"
							aria-label="Agregar Perfil">
							<i class="bi bi-plus-circle me-2"></i> Agregar
						</button>
					</div>

					<!-- Barra de búsqueda -->
					<div
						class="col-12 col-md-6 d-flex justify-content-center justify-content-md-end align-items-center">
						<form action="PerfilServlet" method="get"
							class="d-flex">
							<input type="hidden" name="type" value="list"> <label
								for="customSearch" class="visually-hidden">Buscar Perfil</label>

							<input type="text" id="customSearch" name="filtro"
								class="form-control me-2 w-100 w-md-auto"
								style="max-width: 200px;" placeholder="Buscar..."
								value="<%=filtroRecording == null ? "" : filtroRecording%>">

							<button type="submit" class="btn btn-primary"
								aria-label="Iniciar búsqueda">Buscar</button>
						</form>
					</div>
				</section>

				<!-- Tabla de Perfiles -->
				<section class="table-responsive small">
					<table id="tablaPerfiles" class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col">Usuario</th>
								<th scope="col">Correo</th>
								<th scope="col">Nombre</th>
								<th scope="col">Estado</th>
								<th scope="col">Rol</th>
								<th scope="col">Foto de Perfil</th>
								<th scope="col" class="text-center">Acciones</th>
							</tr>
						</thead>
						<tbody>
							<%
							// Verifica si la lista de perfiles no es nula
							if (listPerfil != null) {
								for (Perfil item : listPerfil) {
							%>
							<tr>
								<td><%=item.getIdPerfil()%></td>
								<td><%=item.getUsuario()%></td>
								<td><%=item.getCorreoElectronico()%></td>
								<td><%=item.getNombres() + " " + item.getApellidos()%></td>
								<td><%=item.getEstado()%></td>
								<td><%=item.getRol()%></td>
								<td><img src="<%=item.getFotoPerfil()%>"
									alt="Foto de Perfil" class="img-thumbnail" width="50"
									height="50"></td>
								<td class="align-middle text-center">
									<div class="d-inline-flex gap-2">
										<!-- Ver perfil (abre un modal con más detalles) -->
										<button class="btn btn-sm btn-outline-secondary"
											title="Ver más" data-bs-toggle="modal"
											data-bs-target="#viewProfileModal"
											aria-label="Ver detalles del perfil"
											data-id="<%=item.getIdPerfil()%>"
											data-usuario="<%=item.getUsuario()%>"
											data-correo-electronico="<%=item.getCorreoElectronico()%>"
											data-nombres="<%=item.getNombres()%>"
											data-apellidos="<%=item.getApellidos()%>"
											data-rol="<%=item.getRol()%>"
											data-foto-perfil="<%=item.getFotoPerfil()%>"
											data-estado="<%=item.getEstado()%>">
											<i class="bi bi-eye"></i>
										</button>
										<!-- Editar perfil (abre un modal para editar) -->
										<button class="btn btn-sm btn-outline-primary" title="Editar"
											data-bs-toggle="modal" data-bs-target="#editProfileModal"
											aria-label="Editar perfil" data-id="<%=item.getIdPerfil()%>"
											data-usuario="<%=item.getUsuario()%>"
											data-correo-electronico="<%=item.getCorreoElectronico()%>"
											data-nombres="<%=item.getNombres()%>"
											data-apellidos="<%=item.getApellidos()%>"
											data-rol="<%=item.getRol()%>"
											data-foto-perfil="<%=item.getFotoPerfil()%>"
											data-estado="<%=item.getEstado()%>">
											<i class="bi bi-pencil"></i>
										</button>
										<!-- Eliminar perfil (abre un modal para confirmar eliminación) -->
										<button class="btn btn-sm btn-outline-danger" title="Eliminar"
											data-bs-toggle="modal" data-bs-target="#deleteProfileModal"
											aria-label="Eliminar perfil"
											data-id="<%=item.getIdPerfil()%>">
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

			</div>
		</section>
	</main>

	<!-- Modal de Agregar Perfil -->
	<div class="modal fade" id="addProfileModal" tabindex="-1"
		aria-labelledby="addProfileModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis"
						id="addProfileModalLabel">Agregar Perfil</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<form action="PerfilServlet" method="post" id="registerProfileForm"
						enctype="multipart/form-data">
						<input type="hidden" name="type" value="create">

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addProfileUsername" class="form-label">Usuario</label>
								<input type="text" class="form-control" id="addProfileUsername"
									name="addProfileUsername"
									placeholder="Ingrese su nombre de usuario" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addProfileEmail" class="form-label">Correo
									Electrónico</label> <input type="email" class="form-control"
									id="addProfileEmail" name="addProfileEmail"
									placeholder="ejemplo@correo.com" required>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addProfileFirstName" class="form-label">Nombres</label>
								<input type="text" class="form-control" id="addProfileFirstName"
									name="addProfileFirstName" placeholder="Ingrese sus nombres"
									required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addProfileLastName" class="form-label">Apellidos</label>
								<input type="text" class="form-control" id="addProfileLastName"
									name="addProfileLastName" placeholder="Ingrese sus apellidos"
									required>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addProfilePassword" class="form-label">Contraseña</label>
								<input type="password" class="form-control"
									id="addProfilePassword" name="addProfilePassword"
									placeholder="Ingrese su contraseña" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addProfileConfirmPassword" class="form-label">Confirmar
									Contraseña</label> <input type="password" class="form-control"
									id="addProfileConfirmPassword" name="addProfileConfirmPassword"
									placeholder="Confirme su contraseña" required>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addProfileType" class="form-label">Rol de
									Perfil</label> <select class="form-control" id="addProfileType"
									name="addProfileType" required>
									<option value="" disabled selected>Seleccione un rol</option>
									<option value="Usuario">Usuario</option>
									<option value="Admin">Administrador</option>
								</select>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addProfilePhoto" class="form-label">Foto</label> <input
									type="file" class="form-control" id="addProfilePhoto"
									name="addProfilePhoto" accept="image/*">
							</div>
						</div>

						<br>
						<div class="d-flex justify-content-center gap-3">
							<button type="button" class="btn btn-outline-secondary"
								data-bs-dismiss="modal">Cancelar</button>
							<input type="submit" class="btn btn-success" value="Crear Perfil">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<!-- Modal de Ver Más -->
	<div class="modal fade" id="viewProfileModal" tabindex="-1"
		aria-labelledby="viewProfileModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis"
						id="viewProfileModalLabel">Detalles del Perfil</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">ID</h6>
							<p id="viewProfileID">1</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Usuario</h6>
							<p id="viewProfileUsername">juanperez</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Correo Electrónico</h6>
							<p id="viewProfileEmail">juan.perez@mail.com</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Nombres</h6>
							<p id="viewProfileFirstName">Juan</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Apellidos</h6>
							<p id="viewProfileLastName">Pérez Gómez</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Contraseña</h6>
							<p id="viewProfilePassword">********</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Rol de Perfil</h6>
							<p id="viewProfileRole">Administrador</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Foto</h6>
							<img src="profile-photo.jpg" id="viewProfilePhoto"
								alt="Foto de Perfil" class="img-fluid rounded-circle"
								width="100">
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

	<!-- Modal de Editar Perfil -->
	<div class="modal fade" id="editProfileModal" tabindex="-1"
		aria-labelledby="editProfileModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis"
						id="editProfileModalLabel">Editar Perfil</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<form action="PerfilServlet" method="post" id="editProfileForm"
						enctype="multipart/form-data">
						<input type="hidden" name="type" value="update"> <input
							type="hidden" name="editProfileId" id="editProfileId" value="0" >

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editProfileUsername" class="form-label">Usuario</label>
								<input type="text" class="form-control" id="editProfileUsername"
									name="editProfileUsername" readonly>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editProfileEmail" class="form-label">Correo
									Electrónico</label> <input type="email" class="form-control"
									id="editProfileEmail" name="editProfileEmail" readonly>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editProfileFirstName" class="form-label">Nombres</label>
								<input type="text" class="form-control"
									id="editProfileFirstName" name="editProfileFirstName" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editProfileLastName" class="form-label">Apellidos</label>
								<input type="text" class="form-control" id="editProfileLastName"
									name="editProfileLastName" required>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editProfilePassword" class="form-label">Contraseña</label>
								<input type="password" class="form-control"
									id="editProfilePassword" name="editProfilePassword">
							</div>
							<div class="col-md-6 mb-3">
								<label for="editProfileRole" class="form-label">Rol de
									Perfil</label> <select class="form-control" id="editProfileRole"
									name="editProfileRole" required>
									<option value="Administrador">Administrador</option>
									<option value="Usuario">Usuario</option>
								</select>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editProfilePhoto" class="form-label">Foto de
									Perfil</label> <input type="file" class="form-control"
									id="editProfilePhoto" name="editProfilePhoto" accept="image/*">
							</div>
							<div class="col-md-6 mb-3">
								<label for="editProfileState" class="form-label">Estado</label>
								<select class="form-control" id="editProfileState"
									name="editProfileState" required>
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
<div class="modal fade" id="deleteProfileModal" tabindex="-1"
	aria-labelledby="deleteProfileModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title text-body-emphasis"
					id="deleteProfileModalLabel">Confirmar Eliminación de Perfil</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<p>¿Estás seguro de que deseas eliminar este perfil?</p>
			</div>
			<footer class="modal-footer">
				<form action="PerfilServlet" method="post">
					<input type="hidden" name="type" value="delete">
					<input type="hidden" id="deleteProfileId" name="deleteProfileId" value="0">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
					<button type="submit" class="btn btn-danger">Eliminar</button>
				</form>
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
	<script src="js/modals/perfilesModal.js"></script>

	<!-- Script para DataTable  -->
	<script>
		setupDataTable('#tablaPerfiles');
	</script>
</body>
</html>