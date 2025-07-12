<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es" data-bs-theme="auto">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookStudio</title>
    <link rel="icon" href="images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <div class="container-fluid g-0">
        <div class="row vh-100 g-0">
            <!-- Lado Izquierdo (Imagen de fondo) -->
            <section class="col-lg-6 d-none d-lg-block position-relative" aria-hidden="true">
                <div class="bg-holder" style="background-image: url('images/login.jpg');"></div>
            </section>

            <!-- Lado Derecho (Formulario de inicio de sesión) -->
            <main class="col-12 col-lg-6 d-flex justify-content-center align-items-center bg-body-tertiary">
                <div class="col-10 col-sm-8 col-md-6 col-lg-7 col-xl-6">
                    <!-- Logo -->
                    <header class="d-flex align-items-center mb-4 justify-content-center">
                        <img src="images/logo.png" alt="Logo de BookStudio" class="logo me-2">
                        <div class="d-flex flex-column align-items-start">
                            <h6 class="mb-0 text-body-emphasis text-logo">Biblioteca</h6>
                            <h6 class="mb-0 text-body-emphasis text-logo">BookStudio</h6>
                        </div>
                    </header>

                    <div class="text-center mb-4">
                        <h2 class="fw-bold text-body-emphasis">Iniciar Sesión</h2>
                        <p>Accede a tu cuenta</p>
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                    </div>

                    <!-- Formulario -->
                    <form action="LoginLEServlet" method="post" id="loginForm" aria-labelledby="loginTitle">
                        <!-- Campo Username -->
                        <div class="mb-4 position-relative">
                            <label for="username" class="form-label">Usuario</label>
                            <input type="text" id="username" name="usuario" class="form-control fs-6" placeholder="Ingrese su usuario" required>
                            <small class="text-danger"></small>
                        </div>

                        <!-- Campo Contraseña -->
                        <div class="mb-4 position-relative">
                            <label for="password" class="form-label">Contraseña</label>
                            <div class="input-group">
                                <input type="password" class="form-control password-field" id="password" name="contrasena" placeholder="Ingrese su contraseña" required>
                                <span class="input-group-text eye-icon" data-toggle-id="1">
                                    <i class="bi bi-eye-slash"></i>
                                </span>
                            </div>
                            <small class="text-danger"></small>
                        </div>

                        <!-- Opciones adicionales -->
                        <div class="mb-4 d-flex justify-content-between">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="remember-me">
                                <label for="remember-me" class="form-check-label text-secondary">
                                    <small>Recuérdame</small>
                                </label>
                            </div>
                            <a href="#" class="text-decoration-none"><small>¿Olvidaste tu contraseña?</small></a>
                        </div>

                        <!-- Botón de Iniciar Sesión -->
                        <div class="mb-3">
                            <button type="submit" class="btn btn-lg btn-primary w-100 fs-6">Iniciar Sesión</button>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </div>

    <!-- Botón de cambiar tema -->
    <div class="dropdown position-fixed bottom-0 end-0 mb-3 me-3">
        <jsp:include page="WEB-INF/includes/buttonTheme.jsp">
            <jsp:param name="menuType" value="2" />
        </jsp:include>
    </div>

    <!-- JavaScript -->
    <script src="js/color-modes.js"></script>
    <script src="js/password.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script>

    <script>
        $(document).ready(function () {
            $("#loginForm").validate({
                rules: {
                    usuario: {
                        required: true
                    },
                    contrasena: {
                        required: true,
                        minlength: 6
                    }
                },
                messages: {
                    usuario: {
                        required: "Por favor, ingresa tu usuario.",
                    },
                    contrasena: {
                        required: "Por favor, ingresa tu contraseña.",
                        minlength: "Tu contraseña debe tener al menos 6 caracteres."
                    }
                },
                errorElement: "small",
                errorClass: "text-danger",
                highlight: function (element) {
                    $(element).addClass("is-invalid");
                },
                unhighlight: function (element) {
                    $(element).removeClass("is-invalid");
                }
            });
        });
    </script>
</body>
</html>
