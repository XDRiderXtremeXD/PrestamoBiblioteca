package interfaces;

import java.util.List;

import entidades.Libro;

public interface LibroInterface {
	public int createLibro(Libro subject);
	public int updateLibro(Libro subject);
	public int deleteLibro(int id);
	public List<Libro> listLibro();
	public Libro getLibro(int id);
}
