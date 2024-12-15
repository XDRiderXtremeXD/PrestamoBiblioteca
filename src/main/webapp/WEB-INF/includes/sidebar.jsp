	<%
	    String currentPage = (String) request.getParameter("currentPage");
	%>
	<!-- Sidebar visible en pantallas medianas y grandes -->
	<aside class="position-fixed d-none d-md-flex flex-column border-end bg-body">
    <!-- Navegación -->
	    <ul class="nav flex-column p-3 flex-grow-1">
	        <li class="mb-1">
	            <a href="dashboard.jsp" class="nav-link link-body-emphasis d-flex align-items-center" aria-current="page">
	                <i class="bi pe-none me-2 bi-speedometer2"></i>
	                Dashboard
	            </a>
	        </li>
	        <li class="mb-1">
	            <a href="pyd.jsp" class="nav-link link-body-emphasis d-flex align-items-center">
	                <i class="bi pe-none me-2 bi-file-earmark-bar-graph"></i>
	                Prestar / Devolver
	            </a>
	        </li>
	        <li class="mb-1">
	            <a href="libros.jsp" class="nav-link link-body-emphasis d-flex align-items-center">
	                <i class="bi pe-none me-2 bi-book"></i>
	                Libros
	            </a>
	        </li>
	        <li class="mb-1">
	            <a href="autores.jsp" class="nav-link link-body-emphasis d-flex align-items-center">
	                <i class="bi pe-none me-2 bi-person-vcard"></i>
	                Autores
	            </a>
	        </li>
	        <li class="mb-1">
	            <a href="editoriales.jsp" class="nav-link link-body-emphasis d-flex align-items-center">
	                <i class="bi pe-none me-2 bi-newspaper"></i>
	                Editoriales
	            </a>
	        </li>
	        <li class="mb-1">
	            <a href="cursos.jsp" class="nav-link link-body-emphasis d-flex align-items-center">
	                <i class="bi pe-none me-2 bi-journal-bookmark"></i>
	                Cursos
	            </a>
	        </li>
	        <li class="mb-1">
	            <a href="estudiantes.jsp" class="nav-link link-body-emphasis d-flex align-items-center">
	                <i class="bi pe-none me-2 bi-mortarboard"></i>
	                Estudiantes
	            </a>
	        </li>
	        <li class="mb-1">
	            <a href="perfiles.jsp" class="nav-link link-body-emphasis d-flex align-items-center">
	                <i class="bi pe-none me-2 bi-people"></i>
	                Perfiles
	            </a>
	        </li>
	    </ul>
	
	    <!-- Información Usuario -->
	    <footer class="p-4 mt-auto">
	        <p class="text-muted mb-0">Sesión iniciada como: <strong>Usuario</strong></p>
	    </footer>
	</aside>

	
	<!-- Sidebar (offcanvas) visible solo en pantallas pequeñas -->
	<aside class="offcanvas offcanvas-start border-end bg-body" id="offcanvasSidebar" aria-labelledby="offcanvasSidebarLabel">
		<header class="offcanvas-header">
		    <h5 id="offcanvasSidebarLabel">BookStudio</h5>
		    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Cerrar"></button>
		</header>
		<nav class="offcanvas-body d-flex flex-column p-0">
			<ul class="nav flex-column p-3 flex-grow-1">
		        <li class="nav-item">
		            <a href="dashboard.jsp" class="nav-link link-body-emphasis" aria-current="page">
		                <i class="bi pe-none me-2 bi-speedometer2"></i>
		                Dashboard
		            </a>
		        </li>
		        <li>
		            <a href="pyd.jsp" class="nav-link link-body-emphasis">
		                <i class="bi pe-none me-2 bi-file-earmark-bar-graph"></i>
		                Prestar / Devolver
		            </a>
		        </li>
		        <li>
		            <a href="libros.jsp" class="nav-link link-body-emphasis">
		                <i class="bi pe-none me-2 bi-book"></i>
		                Libros
		            </a>
		        </li>
		        <li>
		            <a href="autores.jsp" class="nav-link link-body-emphasis">
		                <i class="bi pe-none me-2 bi-person-vcard"></i>
		                Autores
		            </a>
		        </li>
		        <li>
		            <a href="editoriales.jsp" class="nav-link link-body-emphasis">
		                <i class="bi pe-none me-2 bi-newspaper"></i>
		                Editoriales
		            </a>
		        </li>
		        <li>
		            <a href="cursos.jsp" class="nav-link link-body-emphasis">
		                <i class="bi pe-none me-2 bi-journal-bookmark"></i>
		                Cursos
		            </a>
		        </li>
		        <li>
		            <a href="estudiantes.jsp" class="nav-link link-body-emphasis">
		                <i class="bi pe-none me-2 bi-mortarboard"></i>
		                Estudiantes
		            </a>
		        </li>
		        <li>
		            <a href="perfiles.jsp" class="nav-link link-body-emphasis">
		                <i class="bi pe-none me-2 bi-people"></i>
		                Perfiles
		            </a>
		        </li>
		    </ul>
	   	
			 <!-- Información Usuario -->
		    <footer class="p-4 mt-auto">
		        <p class="text-muted mb-0">Sesión iniciada como: <strong>Usuario</strong></p>
		    </footer>
		</nav>
	</aside>
	
	<script type="text/javascript">
	const navLinks = document.querySelectorAll('.nav-link');
	
	const currentPage = "<%= currentPage %>";
	
	navLinks.forEach(link => {
	  const linkHref = link.getAttribute('href');
	
	  if (linkHref === currentPage) {
	    link.classList.add('active');
	    link.classList.remove('link-body-emphasis');
	  } else {
	    link.classList.add('link-body-emphasis');
	    link.classList.remove('active');
	  }
	});
	</script>