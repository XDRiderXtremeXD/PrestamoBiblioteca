<%@page import="entidades.Curso"%>
<%@page import="entidades.Editorial"%>
<%@page import="entidades.GeneroLiterario"%>
<%@page import="entidades.Autor"%>
<%@page import="java.util.List"%>
<%@page import="entidades.Libro"%>
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
	List<Libro> listLibro = (List<Libro>) request.getAttribute("data");
	List<Autor> listAutor = (List<Autor>) request.getAttribute("autores");
	List<GeneroLiterario> listGeneroLiterario = (List<GeneroLiterario>) request.getAttribute("generos");
	List<Editorial> listEditorial = (List<Editorial>) request.getAttribute("editoriales");
	List<Curso> listCursos = (List<Curso>) request.getAttribute("cursos");
	String filtroRecording = request.getParameter("filtro");
	%>
	<!-- Header -->
	<jsp:include page="WEB-INF/includes/header.jsp"></jsp:include>

	<!-- Sidebars -->
	<jsp:include page="WEB-INF/includes/sidebar.jsp">
		<jsp:param name="currentPage" value="libros.jsp" />
	</jsp:include>

	<!-- Contenido Principal -->
	<main class="p-4 bg-body-tertiary">

		<!-- Tarjeta -->
		<section class="card border">

			<header class="card-header d-flex align-items-center">
				<h5 class="card-title text-center mb-0 text-body-emphasis">Tabla
					Libros</h5>
			</header>

			<div class="card-body">

				<!-- Controles de Interacción -->
				<section class="row g-3 mb-2 align-items-center">

					<!-- Botón Agregar -->
					<div
						class="col-12 col-md-6 d-flex justify-content-center justify-content-md-start mb-3 mb-md-0">
						<button class="btn btn-success d-flex align-items-center"
							data-bs-toggle="modal" data-bs-target="#addBookModal"
							aria-label="Agregar libro">
							<i class="bi bi-plus-circle me-2"></i> Agregar
						</button>
					</div>

					<!-- Barra de búsqueda -->
					<div
						class="col-12 col-md-6 d-flex justify-content-center justify-content-md-end align-items-center">
						<form action="LibroServlet" method="get"
							class="d-flex">
							<input type="hidden" name="type" value="list"> <label
								for="customSearch" class="visually-hidden">Buscar libro</label>

							<input type="text" id="customSearch" name="filtro"
								class="form-control me-2 w-100 w-md-auto"
								style="max-width: 200px;" placeholder="Buscar..."
								value="<%=filtroRecording == null ? "" : filtroRecording%>">

							<button type="submit" class="btn btn-primary"
								aria-label="Iniciar búsqueda">Buscar</button>
						</form>
					</div>

				</section>

				<!-- Tabla de Libros -->
				<section class="table-responsive small">
					<table id="tablaLibros" class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col">Título</th>
								<th scope="col">Ejemplares Disponibles</th>
								<th scope="col">Ejemplares Prestados</th>
								<th scope="col">Autor</th>
								<th scope="col">Editorial</th>
								<th scope="col">Curso</th>
								<th scope="col">Estado</th>
								<th scope="col" class="text-center">Acciones</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (listLibro != null) {
								for (Libro item : listLibro) {
							%>
							<tr>
								<td><%=item.getIdLibro()%></td>
								<td><%=item.getTitulo()%></td>
								<td><%=item.getEjemplaresDisponibles()%></td>
								<td><%=item.getEjemplaresPrestados()%></td>
								<td><%=item.getAutor()%></td>
								<td><%=item.getEditorial()%></td>
								<td><%=item.getCurso()%></td>
								<td><%=item.getEstado()%></td>
								<td class="align-middle text-center">
									<div class="d-inline-flex gap-2">
										<!-- Botón para ver detalles del libro -->
										<button class="btn btn-sm btn-outline-secondary view-book"
											title="Ver más" data-bs-toggle="modal"
											data-bs-target="#viewBookModal"
											aria-label="Ver detalles del libro"
											data-id="<%=item.getIdLibro()%>"
											data-titulo="<%=item.getTitulo()%>"
											data-autor="<%=item.getAutor()%>"
											data-editorial="<%=item.getEditorial()%>"
											data-curso="<%=item.getCurso()%>"
											data-fecha-lanzamiento="<%=item.getFechaLanzamiento()%>"
											data-genero="<%=item.getGenero()%>"
											data-estado="<%=item.getEstado()%>"
											data-ejemplares-totales="<%=item.getEjemplaresTotales()%>"
											data-ejemplares-prestados="<%=item.getEjemplaresPrestados()%>"
											data-ejemplares-disponibles="<%=item.getEjemplaresDisponibles()%>">
											<i class="bi bi-eye"></i>
										</button>
										<!-- Botón para editar el libro -->
										<button class="btn btn-sm btn-outline-primary edit-book"
											title="Editar" data-bs-toggle="modal"
											data-bs-target="#editBookModal" aria-label="Editar libro"
											data-id="<%=item.getIdLibro()%>"
											data-titulo="<%=item.getTitulo()%>"
											data-autor="<%=item.getAutor()%>"
											data-editorial="<%=item.getEditorial()%>"
											data-curso="<%=item.getCurso()%>"
											data-fecha-lanzamiento="<%=item.getFechaLanzamiento()%>"
											data-genero="<%=item.getGenero()%>"
											data-estado="<%=item.getEstado()%>"
											data-ejemplares-totales="<%=item.getEjemplaresTotales()%>"
											data-ejemplares-prestados="<%=item.getEjemplaresPrestados()%>"
											data-ejemplares-disponibles="<%=item.getEjemplaresDisponibles()%>">
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
	<div class="modal fade" id="addBookModal" tabindex="-1"
		aria-labelledby="addBookModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis" id="addBookModalLabel">Agregar
						Libro</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<form action="LibroServlet" method="post" id="addBookForm">
						<input type="hidden" name="type" value="create">

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addBookTitle" class="form-label">Título</label> <input
									type="text" class="form-control" id="addBookTitle"
									name="addBookTitle" placeholder="Ingrese el título del libro"
									required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="addBookCopyTotal" class="form-label">Ejemplares
									Totales</label> <input type="number" class="form-control"
									id="addBookCopyTotal" name="addBookCopyTotal" min="1"
									placeholder="Ingrese la cantidad de ejemplares" required>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addAuthor" class="form-label">Autor</label> <select
									class="form-control" id="addAuthor" name="selAutor"
									data-live-search="true" required>
									<%
									if (listAutor != null) {
										for (Autor item : listAutor) {
									%>
									<option value="<%=item.getIdAutor()%>"><%=item.getNombre()%></option>
									<%
									}
									}
									%>
								</select>
							</div>

							<div class="col-md-6 mb-3">
								<label for="addBookEditorial" class="form-label">Editorial</label>
								<select class="form-control" id="addBookEditorial"
									name="selEditorial" data-live-search="true" required>
									<%
									if (listEditorial != null) {
										for (Editorial item : listEditorial) {
									%>
									<option value="<%=item.getIdEditorial()%>"><%=item.getNombre()%></option>
									<%
									}
									}
									%>
								</select>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addReleaseDate" class="form-label">Fecha de
									lanzamiento</label> <input type="date" class="form-control"
									id="addReleaseDate" name="addBookReleaseDate" required>
							</div>

							<div class="col-md-6 mb-3">
								<label for="addLiteraryGenre" class="form-label">Género
									Literario</label> <select class="form-control" id="addLiteraryGenre"
									name="selGenero" data-live-search="true" required>
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
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="addCurso" class="form-label">Curso</label> <select
									class="form-control" id="addCurso" name="selCurso"
									data-live-search="true" required>
									<%
									if (listCursos != null) {
										for (Curso item : listCursos) {
									%>
									<option value="<%=item.getIdCurso()%>"><%=item.getNombre()%></option>
									<%
									}
									}
									%>
								</select>
							</div>

							<input type="hidden" name="SelEstado" value="Activo">

						</div>

						<br>
						<div class="d-flex justify-content-center gap-3">
							<button type="button" class="btn btn-outline-secondary"
								data-bs-dismiss="modal">Cancelar</button>
							<input type="submit" class="btn btn-primary" value="Enviar Datos">
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>

	<!-- Modal de Ver Más -->
	<div class="modal fade" id="viewBookModal" tabindex="-1"
		aria-labelledby="viewBookModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis" id="viewBookModalLabel">Detalles
						del Libro</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">ID</h6>
							<p id="viewBookID">1</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Título</h6>
							<p id="viewBookTitle">Matemáticas Básicas</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Ejemplares Disponibles</h6>
							<p id="viewBookAvailableCopies">50</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Ejemplares Prestados</h6>
							<p id="viewBookBorrowedCopies">40</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Autor</h6>
							<p id="viewBookAuthor">Juan López</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Editorial</h6>
							<p id="viewBookPublisher">HarperCollins</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Fecha de lanzamiento</h6>
							<p id="viewReleaseDate">01-03-2010</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Género</h6>
							<p id="viewBookGenre">Ficción</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Curso</h6>
							<p id="viewBookCourse">Matemáticas</p>
						</div>
						<div class="col-md-6 mb-3">
							<h6 class="fw-bold">Estado</h6>
							<p id="viewBookState" class="text-success">Activo</p>
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
	<div class="modal fade" id="editBookModal" tabindex="-1"
		aria-labelledby="editBookModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<header class="modal-header">
					<h5 class="modal-title text-body-emphasis" id="editBookModalLabel">Editar
						Libro</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</header>
				<div class="modal-body">
					<form action="LibroServlet" method="post" id="edirBookForm">
						<input type="hidden" name="type" value="update"> <input
							type="hidden" name="editBookId" id="editBookId" value="">

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editBookTitle" class="form-label">Título</label> <input
									type="text" class="form-control" value="Matemáticas Básicas"
									id="editBookTitle" name="editBookTitle"
									placeholder="Ingrese el título del libro" required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editBookCopyTotal" class="form-label">Ejemplares
									Totales</label> <input type="number" class="form-control" value="90"
									id="editBookCopyTotal" name="editBookCopyTotal" min="1"
									placeholder="Ingrese la cantidad de ejemplares" required>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editAuthor" class="form-label">Autor</label> <select
									class="form-control" id="editAuthor" data-live-search="true"
									name="selAutor" title="Seleccione un autor" required>
									<%
									if (listAutor != null) {
										for (Autor item : listAutor) {
									%>
									<option value="<%=item.getIdAutor()%>"><%=item.getNombre()%></option>
									<%
									}
									}
									%>
								</select>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editBookEditorial" class="form-label">Editorial</label>
								<select class="form-control" id="editBookEditorial"
									name="selEditorial" data-live-search="true"
									title="Seleccione una editorial" required>
									<%
									if (listEditorial != null) {
										for (Editorial item : listEditorial) {
									%>
									<option value="<%=item.getIdEditorial()%>"><%=item.getNombre()%></option>
									<%
									}
									}
									%>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editReleaseDate" class="form-label">Fecha de
									lanzamiento</label> <input type="date" class="form-control"
									value="2010-03-01" id="editReleaseDate" name="editReleaseDate"
									required>
							</div>
							<div class="col-md-6 mb-3">
								<label for="editLiteraryGenre" class="form-label">Género
									Literario</label> <select class="form-control" id="editLiteraryGenre"
									data-live-search="true" title="Seleccione un género literario"
									name="selGenero" required>
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
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editCurso" class="form-label">Curso</label> <select
									class="form-control" id="editBookCourse"
									data-live-search="true" title="Seleccione Curso"
									name="selCurso" required>
									<%
									if (listCursos != null) {
										for (Curso item : listCursos) {
									%>
									<option value="<%=item.getIdCurso()%>"><%=item.getNombre()%></option>
									<%
									}
									}
									%>
								</select>
							</div>

							<div class="col-md-6 mb-3">
								<label for="editBookState" class="form-label">Estado</label> <select
									class=" form-control" id="editBookState" name="SelEstado"
									required>
									<option value="activo" selected>Activo</option>
									<option value="inactivo">Inactivo</option>
								</select>
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
	<script src="js/color-modes.js"></script>
	<script src="js/alert.js"></script>
	<script src="js/datatables-setup.js"></script>
	<script src="js/librosModal.js"></script>
	<!-- Script para DataTable -->
	<script>
		setupDataTable('#tablaLibros');
	</script>
</body>
</html>