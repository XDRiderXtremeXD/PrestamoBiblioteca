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
   		<jsp:param name="currentPage" value="" />
	</jsp:include>
            
    <!-- Contenido Principal-->
	<main class="d-flex flex-column overflow-auto bg-body-tertiary">
	    <section class="container mt-4">
	        <h2 class="text-center">Configuración de Perfil</h2>
	
	        <div class="d-flex justify-content-center">
	            <figure class="position-relative">
	                <i class="bi bi-person-circle" style="font-size: 150px;"></i>
	                <form action="" method="post" enctype="multipart/form-data">
	                    <label for="foto" class="position-absolute rounded-circle d-flex align-items-center justify-content-center usuario-img bg-body">
	                        <i class="bi bi-pencil-fill text-primary"></i>
	                    </label>
	                    <input type="file" id="foto" name="foto" style="display: none;">
	                </form>
	            </figure>
	        </div>
	
	        <!-- Formulario de actualización de perfil -->
	        <article class="d-flex justify-content-center">
	            <div class="col-12 col-md-10 col-lg-8">
	                <form action="actualizarPerfil" method="post">
	                    <fieldset class="row">
	                        <!-- Campo para Usuario -->
	                        <div class="col-12 col-md-6 mb-3">
	                            <label for="usuario" class="form-label">Usuario</label>
	                            <input type="text" class="form-control w-100" id="usuario" name="usuario" value="Usuario" disabled>
	                        </div>
	
	                        <!-- Campo para Correo Electrónico -->
	                        <div class="col-12 col-md-6 mb-3">
	                            <label for="correo" class="form-label">Correo Electrónico</label>
	                            <input type="email" class="form-control w-100" id="correo" name="correo" value="usuario@correo.com" disabled>
	                        </div>
	
	                        <!-- Campo para Nombres -->
	                        <div class="col-12 col-md-6 mb-3">
	                            <label for="nombres" class="form-label">Nombres</label>
	                            <input type="text" class="form-control w-100" id="nombres" name="nombres" value="Nombres" placeholder="Actualizar nombres">
	                        </div>
	
	                        <!-- Campo para Apellidos -->
	                        <div class="col-12 col-md-6 mb-3">
	                            <label for="apellidos" class="form-label">Apellidos</label>
	                            <input type="text" class="form-control w-100" id="apellidos" name="apellidos" value="Apellidos" placeholder="Actualizar apellidos">
	                        </div>
	
	                        <!-- Campo para Contraseña -->
	                        <div class="col-12 col-md-6 mb-3 position-relative">
	                            <label for="contraseña" class="form-label">Contraseña</label>
	                            <div class="input-group">
	                                <input type="password" class="form-control password-field" data-toggle-id="1" name="contraseña" placeholder="Contraseña actual">
	                                <span class="input-group-text" data-toggle-id="1" style="cursor: pointer;">
	                                    <i class="bi bi-eye-slash"></i>
	                                </span>
	                            </div>
	                        </div>
	
	                        <!-- Campo para Nueva Contraseña -->
	                        <div class="col-12 col-md-6 mb-3 position-relative">
	                            <label for="confirmarContraseña" class="form-label">Contraseña Nueva</label>
	                            <div class="input-group">
	                                <input type="password" class="form-control password-field" data-toggle-id="2" name="confirmarContraseña" placeholder="Actualizar contraseña">
	                                <span class="input-group-text" data-toggle-id="2" style="cursor: pointer;">
	                                    <i class="bi bi-eye-slash"></i>
	                                </span>
	                            </div>
	                        </div>
	                    </fieldset>
	
	                    <!-- Botón de actualización -->
	                    <div class="row justify-content-center mb-4">
	                        <div class="col-12 col-md-4">
	                            <button type="submit" class="btn btn-primary w-100 fs-6 showSweetAlert" data-text="Su perfil se ha editado correctamente." data-icon="success">Actualizar Perfil</button>
	                        </div>
	                    </div>
	                </form>
	            </div>
	        </article>
	    </section>
	</main>

    <!-- JavaScript -->
    <script src="js/color-modes.js"></script>
    <script src="js/alert.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/password.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>    
</body>
</html>