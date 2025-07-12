<%@page import="entidades.Estudiante"%>
<%@page import="entidades.Libro"%>
<%@page import="entidades.PrestamoDevolucion"%>
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
	List<PrestamoDevolucion> listPrestamosDevoluciones = (List<PrestamoDevolucion>) request.getAttribute("data");
	List<Libro> listLibro = (List<Libro>) request.getAttribute("libros");
	List<Estudiante> listEstudiantes = (List<Estudiante>) request.getAttribute("estudiantes");
	String filtroRecording = request.getParameter("filtro");
	%>
	<!-- Header -->
	<jsp:include page="WEB-INF/includes/header.jsp"></jsp:include>

	<!-- Sidebars -->
	<jsp:include page="WEB-INF/includes/sidebar.jsp">
		<jsp:param name="currentPage" value="pyd.jsp" />
	</jsp:include>

	<!-- Contenido Principal -->
	<main class="p-4 bg-body-tertiary">

		<!-- Tarjeta -->
		<section class="card border">

			<header class="card-header d-flex align-items-center">
				<h5 class="card-title text-center mb-0 text-body-emphasis">Tabla
					Préstamos</h5>
			</header>

			<div class="card-body">

				<!-- Controles de Interacción -->
				<section class="row g-3 mb-2 align-items-center">

					<!-- Botón Prestar -->
					<div
						class="col-12 col-md-6 d-flex justify-content-center justify-content-md-start mb-3 mb-md-0">
						<button class="btn btn-success d-flex align-items-center"
							data-bs-toggle="modal" data-bs-target="#addLoanModal"
							aria-label="Prestar libro">
							<i class="bi bi-plus-circle me-2"></i> Prestar
						</button>
					</div>

					<!-- Barra de búsqueda con formulario -->
					<div
						class="col-12 col-md-6 d-flex justify-content-center justify-content-md-end align-items-center">
						<form action="PrestamoDevolucionServlet" method="get"
							class="d-flex">
							<input type="hidden" name="type" value="list"> <label
								for="customSearch" class="visually-hidden">Buscar
								préstamo</label> <input type="text" id="customSearch" name="filtro"
								class="form-control me-2 w-100 w-md-auto"
								style="max-width: 200px;" placeholder="Buscar..."
								value="<%=filtroRecording == null ? "" : filtroRecording%>">
							<button type="submit" class="btn btn-primary">Buscar</button>
						</form>
					</div>
				</section>

				<!-- Tabla de Préstamos -->
				<section class="table-responsive small">
					<table id="tablaPyD" class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col">Libro</th>
								<th scope="col">Estudiante</th>
								<th scope="col">Fecha Préstamo</th>
								<th scope="col">Fecha Devolución</th>
								<th scope="col">Cantidad</th>
								<th scope="col">Estado</th>
								<th scope="col" class="text-center">Acciones</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (listPrestamosDevoluciones != null) {
								for (PrestamoDevolucion item : listPrestamosDevoluciones) {
							%>
							<tr>
								<td><%=item.getIdPrestamo()%></td>
								<td><%=item.getLibro()%></td>
								<!-- Aquí puedes mostrar el título del libro si tienes esa información -->
								<td><%=item.getEstudiante()%></td>
								<!-- Similar para el nombre del estudiante -->
								<td><%=item.getFechaPrestamo()%></td>
								<td><%=item.getFechaDevolucion()%></td>
								<td><%=item.getCantidad()%></td>
								<td>
									<%
									if (item.getEstado().equals("Prestado")) {
									%> <span class="text-danger"><b>Prestado</b></span> <%
 } else {
 %> <span class="text-success"><b>Devuelto</b></span> <%
 }
 %>
								</td>
								<td class="align-middle text-center">
									<div class="d-inline-flex gap-2">
										<!-- Botón para ver detalles del préstamo -->
										<button class="btn btn-sm btn-outline-secondary"
											title="Ver más" data-bs-toggle="modal"
											data-bs-target="#viewLoanModal"
											aria-label="Ver detalles del préstamo"
											data-id="<%=item.getIdPrestamo()%>"
											data-libro="<%=item.getLibro()%>"
											data-estudiante="<%=item.getEstudiante()%>"
											data-fecha-prestamo="<%=item.getFechaPrestamo()%>"
											data-fecha-devolucion="<%=item.getFechaDevolucion()%>"
											data-cantidad="<%=item.getCantidad()%>"
											data-estado="<%=item.getEstado()%>"
											data-observacion="<%=item.getObservacion() != null ? item.getObservacion() : ""%>">

											<i class="bi bi-eye"></i>
										</button>


										<!-- Botón para cambiar estado del préstamo -->
										<button class="btn btn-sm btn-outline-warning"
											title="Cambiar Estado" data-bs-toggle="modal"
											data-bs-target="#confirmStatusChangeModal"
											aria-label="Cambiar estado del préstamo"
											data-id="<%=item.getIdPrestamo()%>"
											data-estado="<%=item.getEstado()%>">
											<i class="bi bi-arrow-repeat"></i>
										</button>

										<!-- Botón para editar el préstamo -->
										<button class="btn btn-sm btn-outline-primary" title="Editar"
											data-bs-toggle="modal" data-bs-target="#editLoanModal"
											aria-label="Editar préstamo"
											data-id="<%=item.getIdPrestamo()%>"
											data-libro="<%=item.getLibro()%>"
											data-estudiante="<%=item.getEstudiante()%>"
											data-fecha-prestamo="<%=item.getFechaPrestamo()%>"
											data-fecha-devolucion="<%=item.getFechaDevolucion()%>"
											data-cantidad="<%=item.getCantidad()%>"
											data-estado="<%=item.getEstado()%>"
											data-observacion="<%=item.getObservacion() != null ? item.getObservacion() : ""%>">
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
	<div class="modal fade" id="addLoanModal" tabindex="-1"
		aria-labelledby="addLoanModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis" id="addLoanModalLabel">Agregar
						Préstamo</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<form action="PrestamoDevolucionServlet" method="post"
						id="addLoanForm">
						<input type="hidden" name="type" value="create">
						<!-- Fila para Libro y Estudiante -->
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addLoanBook" class="form-label">Libro</label> <select
									class="form-control" id="addLoanBook" name="addLoanBook"
									data-live-search="true" title="Seleccione un libro" required>
									<%
									if (listLibro != null) {
										for (Libro item : listLibro) {
									%>
									<option value="<%=item.getIdLibro()%>"><%=item.getTitulo()%></option>
									<%
									}
									}
									%>
								</select>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addLoanStudent" class="form-label">Estudiante</label>
								<select class="form-control" id="addLoanStudent"
									name="addLoanStudent" data-live-search="true"
									title="Seleccione un estudiante" required>
									<%
									if (listLibro != null) {
										for (Estudiante item : listEstudiantes) {
									%>
									<option value="<%=item.getIdEstudiante()%>"
										name="<%=item.getIdEstudiante()%>"><%=item.getNombres() + " " + item.getApellidos()%></option>
									<%
									}
									}
									%>
								</select>
							</div>
						</div>

						<!-- Fila para Fecha de Préstamo, Fecha de Devolución -->
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addLoanDate" class="form-label">Fecha
									Préstamo</label> <input type="date" class="form-control"
									id="addLoanDate" name="addLoanDate" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addReturnDate" class="form-label">Fecha
									Devolución</label> <input type="date" class="form-control"
									id="addReturnDate" name="addReturnDate" required>
							</div>
						</div>

						<!-- Fila para Cantidad, Estado y Observación -->
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addLoanQuantity" class="form-label">Cantidad</label>
								<input type="number" class="form-control" id="addLoanQuantity"
									name="addLoanQuantity" min="1"
									placeholder="Ingrese la cantidad" required>
							</div>
							<input type="hidden" name="state" value="Prestado">
							<div class="col-md-6 mb-3">
								<label for="addLoanObservation" class="form-label">Observación</label>
								<textarea class="form-control" id="addLoanObservation"
									name="addLoanObservation" rows="4"
									placeholder="Ingrese cualquier observación opcional"></textarea>
							</div>
						</div>

						<br>
						<div class="d-flex justify-content-center gap-3">
							<!-- Botón de cancelar -->
							<button type="button" class="btn btn-outline-secondary"
								data-bs-dismiss="modal">Cancelar</button>

							<!-- Botón de enviar -->
							<input type="submit" class="btn btn-primary" value="Enviar Datos">
						</div>

					</form>

				</div>
			</div>
		</div>
	</div>

	<!-- Modal de Ver Más -->
	<div class="modal fade" id="viewLoanModal" tabindex="-1"
		aria-labelledby="viewLoanModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis" id="viewLoanModalLabel">Detalles
						del Préstamo</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">ID</h6>
							<p id="loanId">1</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Libro</h6>
							<p id="loanBook">Matemáticas Básicas</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Estudiante</h6>
							<p id="loanStudent">Pedro Gómez</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Fecha de Préstamo</h6>
							<p id="loanDate">10-12-2024</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Fecha de Devolución</h6>
							<p id="returnDate">10-01-2025</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Cantidad</h6>
							<p id="loanQuantity">1</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Estado</h6>
							<p id="loanStatus">
								<b class="text-danger">Prestado</b>
							</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Observación</h6>
							<p id="loanObservation">Ninguna</p>
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


	<!-- Modal de Confirmación de Cambio de Estado -->
	<div class="modal fade" id="confirmStatusChangeModal" tabindex="-1"
		aria-labelledby="confirmStatusChangeModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title text-body-emphasis"
						id="confirmStatusChangeModalLabel">Confirmación</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>
						¿Estás seguro de cambiar el estado a <strong class="text-success"
							id="estadoPrestamo"> 'Devuelto' </strong> de este libro?
					</p>
					<p>
						<strong>Este cambio no se puede deshacer.</strong>
					</p>
				</div>
				<div class="modal-footer">
					<input type="hidden" id="idPrestamo" name="idPrestamo" value="0">
					<button type="button"
						class="btn btn-outline-secondary static-style"
						data-bs-dismiss="modal">Cancelar</button>
					<button onclick="cambiarEstado()" type="button"
						class="btn btn-success" id="confirmReturn">Confirmar</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal de Editar -->
	<div class="modal fade" id="editLoanModal" tabindex="-1"
		aria-labelledby="editLoanModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis" id="editLoanModalLabel">Editar
						Préstamo</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<form action="PrestamoDevolucionServlet" method="post"
						id="editLoanForm">
						<input type="hidden" name="type" value="update"> <input
							type="hidden" name="idEstudiante" value=1>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editLoanBook" class="form-label">Libro</label> <select
									class="form-control" id="editLoanBook" data-live-search="true"
									title="Seleccione un libro" name="selLibro" required>
									<%
									if (listLibro != null) {
										for (Libro item : listLibro) {
									%>
									<option value="<%=item.getIdLibro()%>"><%=item.getTitulo()%></option>
									<%
									}
									}
									%>
								</select>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editLoanStudent" class="form-label">Estudiante</label>
								<select class="form-control" id="editLoanStudent"
									data-live-search="true" title="Seleccione un estudiante"
									name="selEstudiante" required>
									<%
									if (listEstudiantes != null) {
										for (Estudiante item : listEstudiantes) {
									%>
									<option value="<%=item.getIdEstudiante()%>"><%=item.getNombres() + " " + item.getApellidos()%></option>
									<%
									}
									}
									%>
								</select>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editLoanDate" class="form-label">Fecha de
									Préstamo</label> <input type="date" class="form-control"
									id="editLoanDate" name="loanDate" value="2024-12-10" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editReturnDate" class="form-label">Fecha de
									Devolución</label> <input type="date" class="form-control"
									id="editReturnDate" name="returnDate" value="2025-01-10"
									required>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editLoanQuantity" class="form-label">Cantidad</label>
								<input type="number" class="form-control" id="editLoanQuantity"
									name="loanQuantity" value="1" min="1" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editloanObservation" class="form-label">Observación</label>
								<textarea class="form-control" id="editloanObservation"
									name="loanObservation" rows="3">Ninguna</textarea>
							</div>
						</div>
						<br>
						<div class="d-flex justify-content-center gap-3">
							<!-- Botón de cancelar -->
							<button type="button" class="btn btn-outline-secondary"
								data-bs-dismiss="modal">Cancelar</button>

							<!-- Botón de enviar -->
							<input type="submit" class="btn btn-primary" value="Enviar Datos">
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
	<script src="js/modals/prestamoDevolucionModals.js"></script>
	<script src="js/prestamoDevolucionBotonesAccion.js"></script>

	<!-- Script para DataTable -->
	<script>
		setupDataTable('#tablaPyD');
	</script>



</body>
</html>