package entidades;

import java.sql.Date;

public class Autor {
    private int idAutor;
    private String nombre;
    private String nacionalidad;
    private int idGeneroLiterario;
    private Date fechaNacimiento;
    private byte[] foto;
    private String biografia;
    private String estado;
    
	public int getIdAutor() {
		return idAutor;
	}
	public void setIdAutor(int idAutor) {
		this.idAutor = idAutor;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getNacionalidad() {
		return nacionalidad;
	}
	public void setNacionalidad(String nacionalidad) {
		this.nacionalidad = nacionalidad;
	}
	public int getIdGeneroLiterario() {
		return idGeneroLiterario;
	}
	public void setIdGeneroLiterario(int idGeneroLiterario) {
		this.idGeneroLiterario = idGeneroLiterario;
	}
	public Date getFechaNacimiento() {
		return fechaNacimiento;
	}
	public void setFechaNacimiento(Date fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}
	public byte[] getFoto() {
		return foto;
	}
	public void setFoto(byte[] foto) {
		this.foto = foto;
	}
	public String getBiografia() {
		return biografia;
	}
	public void setBiografia(String biografia) {
		this.biografia = biografia;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	private String nombreGenero;

	public String getNombreGenero() {
	    return nombreGenero;
	}
	public void setNombreGenero(String nombreGenero) {
	    this.nombreGenero = nombreGenero;
	}
}
