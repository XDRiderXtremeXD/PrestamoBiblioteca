<header
	class="header position-fixed d-flex align-items-center px-3 bg-body border-bottom">

	<!-- Botón Menu -->
	<button class="btn btn-link nav-link d-md-none" type="button"
		data-bs-toggle="offcanvas" data-bs-target="#offcanvasSidebar"
		aria-controls="offcanvasSidebar">
		<i class="bi bi-list hdr"></i>
	</button>

	<!-- Contenedor flexible -->
	<div
		class="d-flex flex-grow-1 justify-content-between align-items-center">

		<!-- Espacio vacío para mantener la alineación -->
		<div class="d-md-none me-5"></div>

		<!-- Logo -->
		<a href="/BookStudio/dashboard.jsp"
			class="text-center text-decoration-none text-body-emphasis ms-md-2 d-flex align-items-center">
			<img class="logo me-2" alt="Logo" src="images/logo.png"> <span
			class="fs-5 text-logo">BookStudio</span>
		</a>


		<!-- Contenedor para botones de tema y usuario -->
		<div class="d-flex align-items-center">

			<!-- Botón cambiar tema -->
			<div class="dropdown me-2">
				<jsp:include page="buttonTheme.jsp">
					<jsp:param name="menuType" value="1" />
				</jsp:include>
			</div>

			<!-- Separador -->
			<div class="d-flex align-items-center me-2">
				<div class="vr d-none d-lg-block mx-2 sprtor"></div>
				<!-- Ocultar en pantallas pequeñas y mostrar en pantallas grandes -->
			</div>


			<!-- Dropdown de usuario -->
			<div class="dropdown">
				<a href="#"
					class="d-flex align-items-center text-decoration-none link-body-emphasis"
					data-bs-toggle="dropdown" aria-expanded="false"> <i
					class="bi pe-none me-1 bi-person-circle hdr"></i>
				</a>
				<ul class="dropdown-menu dropdown-menu-end text-small shadow">
					<li><a class="dropdown-item" href="perfil.jsp">Perfil</a></li>
					<li><hr class="dropdown-divider"></li>
					<li><button class="dropdown-item logout-item"
							data-bs-toggle="modal" data-bs-target="#logoutModal">Cerrar
							Sesión</button></li>
				</ul>
			</div>
		</div>
	</div>
</header>

<!-- Modal de Confirmación -->
<div class="modal fade" id="logoutModal" tabindex="-1"
	aria-labelledby="logoutModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title text-body-emphasis" id="logoutModalLabel">Confirmar
					Cierre de Sesión</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<p>¿Estás seguro de que deseas cerrar tu sesión?</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-secondary static-style"
					data-bs-dismiss="modal">Cancelar</button>
				<button type="button" class="btn btn-danger"
					onclick="window.location.href='LogoutServlet'">Cerrar
					Sesión</button>
			</div>
		</div>
	</div>
</div>

<script>
	document.getElementById('confirmLogout').addEventListener('click',
			function() {
				window.location.href = '/BookStudio/login.jsp';
			});
</script>