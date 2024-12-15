<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es" data-bs-theme="auto">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/sidebars.css">
    <title>BookStudio</title>
    <link rel="icon" href="images/favicon.ico" type="image/x-icon">
</head>
<body>
    <!-- Header -->
	<jsp:include page="WEB-INF/includes/header.jsp"></jsp:include>
	
	<!-- Sidebar -->
	<jsp:include page="WEB-INF/includes/sidebar.jsp">
   		<jsp:param name="currentPage" value="dashboard.jsp" />
	</jsp:include>

    <!-- Contenido Principal-->
	<main class="p-4 d-flex flex-column min-vh-100 bg-body-tertiary">
	    
	    <!-- Primera fila -->
	    <section class="row">
			
	        <!-- Total de Libros -->
	        <article class="col-md-4">
	            <div class="card text-white bg-primary mb-3">
	                <div class="card-body sombra">
	                    <h5 class="card-title d-flex align-items-center">
	                        <i class="bi pe-none me-2 bi-book"></i>
	                        Total de Libros
	                    </h5>
	                    <p class="card-text">1500 Libros</p>
	                </div>
	            </div>
	        </article>
	
	        <!-- Total de Autores -->
	        <article class="col-md-4">
	            <div class="card text-white bg-success mb-3">
	                <div class="card-body sombra">
	                    <h5 class="card-title d-flex align-items-center">
	                    	<i class="bi pe-none me-2 bi-person-vcard"></i>
	                     	Autores
	                 	</h5>
	                    <p class="card-text">250 Autores</p>
	                </div>
	            </div>
	        </article>
	
	        <!-- Total de Editoriales -->
	        <article class="col-md-4">
	            <div class="card text-white bg-warning mb-3">
	                <div class="card-body sombra">
	                    <h5 class="card-title d-flex align-items-center">
							<i class="bi pe-none me-2 bi-newspaper"></i>
	                    	Editoriales
	                    </h5>
	                    <p class="card-text">50 Editoriales</p>
	                </div>
	            </div>
	        </article>
		</section>

	    <!-- Segunda Fila -->
	    <section class="row">
	        <!-- Cursos -->
	        <article class="col-md-4">
	            <div class="card text-white bg-info mb-3">
	                <div class="card-body sombra">
	                    <h5 class="card-title d-flex align-items-center">
							<i class="bi pe-none me-2 bi-journal-bookmark"></i>
							Cursos
	                    </h5>
	                    <p class="card-text">10 Cursos</p>
	                </div>
	            </div>
	        </article>
	       
	        <!-- Estudiantes -->
	        <article class="col-md-4">
	            <div class="card text-white bg-secondary mb-3">
	                <div class="card-body sombra">
	                    <h5 class="card-title d-flex align-items-center">
	                   		<i class="bi pe-none me-2 bi-mortarboard"></i>
	                   		Estudiantes
	                    </h5>
	                    <p class="card-text">300 Estudiantes</p>
	                </div>
	            </div>
	        </article>
	
	        <!-- Préstamos Activos -->
	        <article class="col-md-4">
	            <div class="card text-white bg-danger mb-3">
	                <div class="card-body sombra">
	                    <h5 class="card-title d-flex align-items-center">
	                     	<i class="bi pe-none me-2 bi-file-earmark-bar-graph"></i>
	                     	Préstamos Activos
	                    </h5>
	                    <p class="card-text">120 Préstamos</p>
	                </div>
	            </div>
	        </article>
	    </section>
	    
	    <!-- Footer -->
	    <footer class="mb-4 py-3 mt-auto">
	        <div class="container text-center">
	            <p class="mb-0">© 2024 Biblioteca BookStudio. Casi todos los derechos reservados.</p>
	            <p>Desarrollado por <a href="#" class="text-decoration-none ">Estudiantes de Cibertec</a></p>
	        </div>
	    </footer>
	</main>

    <!-- JavaScript -->
    <script src="js/color-modes.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>