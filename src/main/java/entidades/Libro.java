package entidades;

import java.sql.Date;

public class Libro {
    private int idLibro;
    private String titulo;
    private int ejemplaresTotales;
    private int ejemplaresPrestados;
    private int ejemplaresDisponibles;
    private String autor;
    private String editorial;
    private String curso;
    private Date fechaLanzamiento;
    private String genero;
    private String estado;
    
	public int getEjemplaresDisponibles() {
		return ejemplaresDisponibles;
	}
	public void setEjemplaresDisponibles(int ejemplaresDisponibles) {
		this.ejemplaresDisponibles = ejemplaresDisponibles;
	}
	public int getIdLibro() {
		return idLibro;
	}
	public void setIdLibro(int idLibro) {
		this.idLibro = idLibro;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public int getEjemplaresTotales() {
		return ejemplaresTotales;
	}
	public void setEjemplaresTotales(int ejemplaresTotales) {
		this.ejemplaresTotales = ejemplaresTotales;
	}
	public int getEjemplaresPrestados() {
		return ejemplaresPrestados;
	}
	public void setEjemplaresPrestados(int ejemplaresPrestados) {
		this.ejemplaresPrestados = ejemplaresPrestados;
		setEjemplaresDisponibles(ejemplaresTotales-ejemplaresPrestados);
	}
	public Date getFechaLanzamiento() {
		return fechaLanzamiento;
	}
	public void setFechaLanzamiento(Date fechaLanzamiento) {
		this.fechaLanzamiento = fechaLanzamiento;
	}
	public String getGenero() {
		return genero;
	}
	public void setGenero(String genero) {
		this.genero = genero;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getAutor() {
		return autor;
	}
	public void setAutor(String autor) {
		this.autor = autor;
	}
	public String getEditorial() {
		return editorial;
	}
	public void setEditorial(String editorial) {
		this.editorial = editorial;
	}
	public String getCurso() {
		return curso;
	}
	public void setCurso(String curso) {
		this.curso = curso;
	}
    
    
}
