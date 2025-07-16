# 📚 BookStudio

**BookStudio** es una aplicación web desarrollada con **Java**, utilizando **JSP** y **Servlets**, diseñada para gestionar de forma eficiente el **préstamo y devolución de libros** en una **biblioteca universitaria**.

El sistema cuenta con una base de datos relacional en **MySQL**, y permite manejar entidades clave como:

- Libros 📖  
- Estudiantes 🎓  
- Autores ✍️  
- Editoriales 🏢  
- Cursos 📚  
- Facultades 🏫

---

## 🛠️ Tecnologías utilizadas

- Java 8+
- JSP (Java Server Pages)
- Servlets
- JDBC (Java Database Connectivity)
- MySQL
- Apache Tomcat
- [dotenv-java](https://github.com/cdimascio/dotenv-java) (manejo de variables de entorno)

---

## 📁 Estructura básica del proyecto

```
BookStudio/
├── src/
│   └── ... (código fuente Java)
├── WebContent/
│   ├── jsp/
│   └── ... (recursos web)
├── .env
├── README.md
└── ...
```

---

## 🔐 Configuración de variables de entorno

> **⚠️ Es obligatorio crear un archivo `.env` en la raíz del proyecto.**

Este archivo contiene las credenciales necesarias para conectarse a la base de datos.  
Ejemplo de contenido del archivo `.env`:

```env
DB_URL=jdbc:mysql://localhost:3306/bookstudio
DB_USER=tu_usuario
DB_PASS=tu_contraseña
```

En el código Java se utiliza la biblioteca `dotenv-java` para cargar estas variables:

```java
Dotenv dotenv = Dotenv.load();
if (url == null) url = dotenv.get("DB_URL");
if (user == null) user = dotenv.get("DB_USER");
if (pass == null) pass = dotenv.get("DB_PASS");
```

> ✅ El archivo `.env` está incluido en el `.gitignore`, por lo tanto **no será subido al repositorio**.

---

## 🚀 Cómo ejecutar el proyecto

1. Clona este repositorio:
   ```bash
   git clone https://github.com/tuusuario/BookStudio.git
   ```

2. Crea el archivo `.env` en la raíz del proyecto con tus variables de entorno.

3. Importa el proyecto a tu IDE favorito (Eclipse, IntelliJ, NetBeans).

4. Asegúrate de tener **MySQL** ejecutándose y una base de datos llamada `bookstudio` ya creada.

5. Configura el servidor **Apache Tomcat**.

6. Ejecuta el proyecto desde tu IDE o despliega en Tomcat manualmente.

7. Abre tu navegador y accede a:
   ```
   http://localhost:8080/BookStudio/
   ```

---

## 🧱 Estructura de la base de datos

### Entidades principales

- **Facultad**
- **Curso**
- **Estudiante**
- **Autor**
- **Editorial**
- **Libro**
- **Préstamo**

### Diagrama entidad-relación (ER)

```
[Libro] -----< [Prestamo] >----- [Estudiante]
   |                                |
   |                                |
[Autor]                        [Curso]
   |                                |
[Editorial]                    [Facultad]
```

---

## 👨‍💻 Autor

Desarrollado como proyecto académico de aprendizaje en **Cibertec** por:
