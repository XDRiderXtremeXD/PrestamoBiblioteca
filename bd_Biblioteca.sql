CREATE DATABASE bookstudio_db;
USE bookstudio_db;

-- Crear la tabla Facultad
CREATE TABLE Facultad (
    IDFacultad INT AUTO_INCREMENT PRIMARY KEY,
    NombreFacultad VARCHAR(255) UNIQUE
);

-- Insertar datos en la tabla Facultad
INSERT INTO Facultad (NombreFacultad) VALUES ('Ingeniería'), ('Ciencias Sociales'), ('Medicina');

-- Crear la tabla GeneroLiterario
CREATE TABLE GeneroLiterario (
    IDGeneroLiterario INT AUTO_INCREMENT PRIMARY KEY,
    NombreGenero VARCHAR(255) UNIQUE
);

-- Insertar géneros literarios
INSERT INTO GeneroLiterario (NombreGenero)
VALUES ('Realismo mágico'),
       ('Fantasía'),
       ('Ficción');

-- Crear la tabla Autor
CREATE TABLE Autor (
    IDAutor INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255),
    Nacionalidad VARCHAR(100),
    IDGeneroLiterario INT,
    FechaNacimiento DATE,
    Foto LONGBLOB,
    Biografia TEXT,
    Estado ENUM('activo', 'inactivo') DEFAULT 'activo', -- Campo Estado
    FOREIGN KEY (IDGeneroLiterario) REFERENCES GeneroLiterario(IDGeneroLiterario)
);

-- Insertar datos en la tabla Autor
INSERT INTO Autor (Nombre, Nacionalidad, IDGeneroLiterario, FechaNacimiento, Estado)
VALUES ('Gabriel García Márquez', 'Colombiana', 1, '1927-03-06', 'activo'),
       ('J.K. Rowling', 'Británica', 2, '1965-07-31', 'activo');

-- Crear la tabla Editorial
CREATE TABLE Editorial (
    IDEditorial INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255),
    Nacionalidad VARCHAR(100),
    IDGeneroLiterario INT,
    Foto LONGBLOB,
    AñoFundacion INT,
    PaginaWeb VARCHAR(255),
    Direccion VARCHAR(255),
    Estado ENUM('activo', 'inactivo') DEFAULT 'activo', -- Campo Estado
    FOREIGN KEY (IDGeneroLiterario) REFERENCES GeneroLiterario(IDGeneroLiterario)
);

-- Insertar datos en la tabla Editorial
INSERT INTO Editorial (Nombre, Nacionalidad, IDGeneroLiterario, AñoFundacion, PaginaWeb, Direccion, Estado) 
VALUES ('Penguin Random House', 'Estados Unidos', 3, 1925, 'https://www.penguinrandomhouse.com', '555 Editorial St', 'activo'),
       ('HarperCollins', 'Estados Unidos', 3, 1817, 'https://www.harpercollins.com', '789 Harper Ave', 'activo');

-- Crear la tabla Curso
CREATE TABLE Curso (
    IDCurso INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255),
    Nivel VARCHAR(100),
    Descripcion TEXT,
    Estado ENUM('activo', 'inactivo') DEFAULT 'activo' -- Campo Estado
);

-- Insertar datos en la tabla Curso
INSERT INTO Curso (Nombre, Nivel, Descripcion, Estado) 
VALUES ('Matemáticas Avanzadas', 'Avanzado', 'Curso sobre álgebra, geometría y cálculo', 'activo'),
       ('Literatura Contemporánea', 'Intermedio', 'Estudio de la literatura moderna y sus géneros', 'activo');

-- Crear la tabla Estudiante
CREATE TABLE Estudiante (
    IDEstudiante INT AUTO_INCREMENT PRIMARY KEY,
    DNI VARCHAR(20) UNIQUE,
    Nombres VARCHAR(255),
    Apellidos VARCHAR(255),
    Direccion VARCHAR(255),
    Telefono VARCHAR(15),
    CorreoElectronico VARCHAR(100) UNIQUE,
    FechaNacimiento DATE,
    Genero VARCHAR(10),
    IDFacultad INT,
    Estado ENUM('activo', 'inactivo') DEFAULT 'activo', -- Campo Estado
    FOREIGN KEY (IDFacultad) REFERENCES Facultad(IDFacultad)
);

-- Insertar datos en la tabla Estudiante
INSERT INTO Estudiante (DNI, Nombres, Apellidos, Direccion, Telefono, CorreoElectronico, FechaNacimiento, Genero, IDFacultad, Estado) 
VALUES ('12345678A', 'Juan', 'Pérez', 'Calle Ficticia 123', '987654321', 'juan.perez@correo.com', '1995-05-20', 'Masculino', 1, 'activo'),
       ('87654321B', 'Ana', 'González', 'Calle Real 456', '123456789', 'ana.gonzalez@correo.com', '1998-11-11', 'Femenino', 2, 'activo');

-- Crear la tabla Libro
CREATE TABLE Libro (
    IDLibro INT AUTO_INCREMENT PRIMARY KEY,
    Titulo VARCHAR(255),
    Ejemplares_totales INT,
    Ejemplares_prestados INT,
    IDAutor INT,
    IDEditorial INT,
    IDCurso INT,
    FechaLanzamiento DATE,
    Genero VARCHAR(100),
    Estado ENUM('activo', 'inactivo') DEFAULT 'activo', -- Campo Estado
    FOREIGN KEY (IDAutor) REFERENCES Autor(IDAutor),
    FOREIGN KEY (IDEditorial) REFERENCES Editorial(IDEditorial),
    FOREIGN KEY (IDCurso) REFERENCES Curso(IDCurso)
);

-- Insertar datos en la tabla Libro
INSERT INTO Libro (Titulo, Ejemplares_totales, Ejemplares_prestados, IDAutor, IDEditorial, IDCurso, FechaLanzamiento, Genero, Estado) 
VALUES 
    ('Álgebra Superior', 10, 10, 1, 1, 1, '2020-01-15', 'Matemáticas', 'activo'),
    ('Harry Potter y la piedra filosofal', 15, 15, 2, 2, 2, '1997-06-26', 'Fantasía', 'activo');

-- Crear la tabla Prestamo_Devolucion
CREATE TABLE Prestamo_Devolucion (
    IDPrestamo INT AUTO_INCREMENT PRIMARY KEY,
    IDLibro INT,
    IDEstudiante INT,
    FechaPrestamo DATE,
    FechaDevolucion DATE,
    Cantidad INT,
    Estado VARCHAR(255),
    Observacion TEXT,
    FOREIGN KEY (IDLibro) REFERENCES Libro(IDLibro),
    FOREIGN KEY (IDEstudiante) REFERENCES Estudiante(IDEstudiante)
);

-- Insertar datos en la tabla Prestamo_Devolucion
INSERT INTO Prestamo_Devolucion (IDLibro, IDEstudiante, FechaPrestamo, FechaDevolucion, Cantidad, Estado, Observacion)
VALUES (1, 1, '2024-12-01', '2024-12-15', 1, 'Prestado', 'Ninguna observación'),
       (2, 2, '2024-12-02', '2024-12-16', 1, 'Devuelto', 'Libro en perfecto estado');

-- Crear la tabla Perfil
CREATE TABLE Perfil (
    IDPerfil INT AUTO_INCREMENT PRIMARY KEY,
    Usuario VARCHAR(50) UNIQUE,
    CorreoElectronico VARCHAR(100) UNIQUE,
    Nombres VARCHAR(255),
    Apellidos VARCHAR(255),
    Contrasena VARCHAR(255),
    Rol VARCHAR(50),
    FotoPerfil LONGBLOB,
    Estado ENUM('activo', 'inactivo') DEFAULT 'activo' -- Campo Estado
);

-- Insertar datos en la tabla Perfil
INSERT INTO Perfil (Usuario, CorreoElectronico, Nombres, Apellidos, Contrasena, Rol, Estado) 
VALUES ('juanperez', 'juan.perez@correo.com', 'Juan', 'Pérez', 'contraseña123', 'Estudiante', 'activo'),
       ('anagonzalez', 'ana.gonzalez@correo.com', 'Ana', 'González', 'contraseña456', 'Estudiante', 'activo');
       
       INSERT INTO Facultad (NombreFacultad) 
VALUES ('Derecho'), 
       ('Arquitectura'), 
       ('Economía'), 
       ('Psicología'), 
       ('Ciencias de la Computación'), 
       ('Biología'), 
       ('Filosofía'), 
       ('Educación');

INSERT INTO GeneroLiterario (NombreGenero) 
VALUES ('Poesía'), 
       ('Drama'), 
       ('Ensayo'), 
       ('Ciencia Ficción'), 
       ('Biografía'), 
       ('Misterio'), 
       ('Aventura'), 
       ('Crónica');
       
       INSERT INTO Autor (Nombre, Nacionalidad, IDGeneroLiterario, FechaNacimiento, Estado)
VALUES ('Mario Vargas Llosa', 'Peruana', 1, '1936-03-28', 'activo'),
       ('Isabel Allende', 'Chilena', 2, '1942-08-02', 'activo'),
       ('Gabriel García Márquez', 'Colombiana', 3, '1927-03-06', 'activo'),
       ('Juan Rulfo', 'Mexicana', 4, '1917-05-16', 'activo'),
       ('Jorge Luis Borges', 'Argentina', 5, '1899-08-24', 'activo'),
       ('Pablo Neruda', 'Chilena', 6, '1904-07-12', 'activo'),
       ('José Saramago', 'Portugués', 7, '1922-11-16', 'activo'),
       ('Octavio Paz', 'Mexicana', 8, '1914-03-31', 'activo');


INSERT INTO Editorial (Nombre, Nacionalidad, IDGeneroLiterario, AñoFundacion, PaginaWeb, Direccion, Estado) 
VALUES ('Planeta', 'España', 3, 1949, 'https://www.planetadelibros.com', 'Calle Editorial 123', 'activo'),
       ('Random House Mondadori', 'Estados Unidos', 2, 1998, 'https://www.randomhousemondadori.com', 'Calle Mondadori 456', 'activo'),
       ('Alfaguara', 'España', 1, 1960, 'https://www.alfaguara.com', 'Calle Alfaguara 789', 'activo'),
       ('Tusquets Editores', 'España', 5, 1960, 'https://www.tusquetseditores.com', 'Calle Tusquets 101', 'activo'),
       ('Ediciones SM', 'España', 7, 1939, 'https://www.ediciones-sm.com', 'Calle SM 202', 'activo'),
       ('Ediciones Cátedra', 'España', 8, 1967, 'https://www.catedra.com', 'Calle Cátedra 303', 'activo'),
       ('RBA Libros', 'España', 6, 1959, 'https://www.rbalibros.com', 'Calle RBA 404', 'activo'),
       ('Seix Barral', 'España', 4, 1911, 'https://www.seixbarral.com', 'Calle Barral 505', 'activo');


INSERT INTO Curso (Nombre, Nivel, Descripcion, Estado) 
VALUES ('Introducción a la Física', 'Básico', 'Curso para aprender los fundamentos de la física', 'activo'),
       ('Filosofía Contemporánea', 'Avanzado', 'Análisis de los principales filósofos del siglo XX', 'activo'),
       ('Historia del Arte', 'Intermedio', 'Estudio de las principales corrientes artísticas', 'activo'),
       ('Programación Web', 'Intermedio', 'Curso sobre tecnologías web modernas', 'activo'),
       ('Ética Profesional', 'Básico', 'Reflexión sobre los principios éticos en el ámbito laboral', 'activo'),
       ('Psicología Cognitiva', 'Avanzado', 'Exploración de los procesos mentales y su influencia en el comportamiento', 'activo'),
       ('Teoría del Derecho', 'Intermedio', 'Estudio de las bases jurídicas y los sistemas legales', 'activo'),
       ('Diseño Gráfico', 'Básico', 'Curso de introducción al diseño gráfico digital', 'activo');

INSERT INTO Estudiante (DNI, Nombres, Apellidos, Direccion, Telefono, CorreoElectronico, FechaNacimiento, Genero, IDFacultad, Estado) 
VALUES ('11223344C', 'Carlos', 'Martínez', 'Avenida Libertador 789', '987654322', 'carlos.martinez@correo.com', '1992-10-15', 'Masculino', 1, 'activo'),
       ('22334455D', 'Lucía', 'Fernández', 'Calle Mayor 456', '876543211', 'lucia.fernandez@correo.com', '1997-07-25', 'Femenino', 2, 'activo'),
       ('33445566E', 'Carlos', 'Pérez', 'Calle de la Paz 102', '765432109', 'carlos.perez@correo.com', '1996-12-20', 'Masculino', 3, 'activo'),
       ('44556677F', 'María', 'López', 'Calle del Sol 212', '654321098', 'maria.lopez@correo.com', '1994-05-13', 'Femenino', 4, 'activo'),
       ('55667788G', 'Pedro', 'González', 'Calle Mistral 67', '543210987', 'pedro.gonzalez@correo.com', '1993-02-18', 'Masculino', 5, 'activo'),
       ('66778899H', 'Elena', 'Sánchez', 'Avenida del Norte 808', '432109876', 'elena.sanchez@correo.com', '1991-09-22', 'Femenino', 6, 'activo'),
       ('77889900I', 'Sofía', 'Ramírez', 'Calle Primavera 333', '321098765', 'sofia.ramirez@correo.com', '1998-03-04', 'Femenino', 7, 'activo'),
       ('88990011J', 'Juan', 'Hernández', 'Calle Nueva 456', '210987654', 'juan.hernandez@correo.com', '1999-06-17', 'Masculino', 8, 'activo');

INSERT INTO Libro (Titulo, Ejemplares_totales, Ejemplares_prestados, IDAutor, IDEditorial, IDCurso, FechaLanzamiento, Genero, Estado) 
VALUES 
    ('El Amor en los Tiempos del Cólera', 20, 5, 1, 1, 2, '1985-05-04', 'Ficción', 'activo'),
    ('La Sombra del Viento', 30, 10, 2, 2, 4, '2001-01-01', 'Misterio', 'activo'),
    ('Fahrenheit 451', 25, 3, 3, 3, 5, '1953-10-19', 'Ciencia Ficción', 'activo'),
    ('Cien Años de Soledad', 50, 15, 4, 1, 2, '1967-06-05', 'Realismo mágico', 'activo'),
    ('La Casa de los Espíritus', 15, 7, 5, 4, 6, '1982-11-25', 'Realismo mágico', 'activo'),
    ('El Quijote', 40, 12, 6, 5, 7, '1605-01-16', 'Aventura', 'activo'),
    ('Matar a un Ruiseñor', 35, 10, 7, 6, 8, '1960-07-11', 'Drama', 'activo'),
    ('1984', 30, 5, 8, 2, 3, '1949-06-08', 'Distopía', 'activo');

INSERT INTO Prestamo_Devolucion (IDLibro, IDEstudiante, FechaPrestamo, FechaDevolucion, Cantidad, Estado, Observacion)
VALUES (1, 1, '2024-12-01', '2024-12-15', 1, 'Prestado', 'Ninguna observación'),
       (2, 2, '2024-12-02', '2024-12-16', 1, 'Devuelto', 'Libro en perfecto estado'),
       (3, 3, '2024-12-03', '2024-12-17', 1, 'Prestado', 'Buen estado'),
       (4, 4, '2024-12-04', '2024-12-18', 1, 'Devuelto', 'Libro con algunos daños'),
       (5, 5, '2024-12-05', '2024-12-19', 1, 'Prestado', 'Ninguna observación'),
       (6, 6, '2024-12-06', '2024-12-20', 1, 'Devuelto', 'Libro sin daños'),
       (7, 7, '2024-12-07', '2024-12-21', 1, 'Prestado', 'Nada que reportar'),
       (8, 8, '2024-12-08', '2024-12-22', 1, 'Devuelto', 'Libro en buen estado');

INSERT INTO Perfil (Usuario, CorreoElectronico, Nombres, Apellidos, Contrasena, Rol, FotoPerfil, Estado) 
VALUES 
    ('carlosrodriguez', 'carlos.rodriguez@correo.com', 'Carlos', 'Rodríguez', 'contraseña789', 'Profesor', NULL, 'activo'),
    ('mariagarcia', 'maria.garcia@correo.com', 'María', 'García', 'contraseña101', 'Profesor', NULL, 'activo'),
    ('admin1', 'admin1@correo.com', 'Administrador', 'Sistema', 'adminpass123', 'Administrador', NULL, 'activo'),
    ('luisvargas', 'luis.vargas@correo.com', 'Luis', 'Vargas', 'luispass2024', 'Bibliotecario', NULL, 'activo'),
    ('patriciamartinez', 'patricia.martinez@correo.com', 'Patricia', 'Martínez', 'patricia123', 'Investigador', NULL, 'activo'),
    ('ricardoperez', 'ricardo.perez@correo.com', 'Ricardo', 'Pérez', 'ricardo456', 'Graduado', NULL, 'activo');

-- Insertar más datos en la tabla Prestamo_Devolucion
INSERT INTO Prestamo_Devolucion (IDLibro, IDEstudiante, FechaPrestamo, FechaDevolucion, Cantidad, Estado, Observacion)
VALUES (1, 2, '2024-12-05', '2024-12-19', 1, 'Prestado', 'Sin observaciones'),
       (2, 1, '2024-12-06', '2024-12-20', 1, 'Prestado', 'Libro en buen estado'),
       (1, 1, '2024-12-07', '2024-12-21', 1, 'Prestado', 'Sin observaciones');

Select * from pedido