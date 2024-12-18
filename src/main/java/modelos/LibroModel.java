package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entidades.Libro;
import interfaces.LibroInterface;
import utils.MySqlConexion;

public class LibroModel implements LibroInterface {

	@Override
	public int createLibro(Libro subject) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateLibro(Libro subject) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteLibro(int id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Libro> listLibro() {
		// TODO Auto-generated method stub
		List<Libro> listLibro = new ArrayList<Libro>();
		
		Connection cn=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		
		try {
		    cn = MySqlConexion.getConexion();
		    String sql = """
		        SELECT l.IDLibro, l.Titulo, l.Ejemplares_totales, l.Ejemplares_prestados, 
		               a.Nombre AS Autor, e.Nombre AS Editorial, c.Nombre AS Curso, 
		               l.FechaLanzamiento, l.Genero, l.Estado
		        FROM Libro l
		        JOIN Autor a ON l.IDAutor = a.IDAutor
		        JOIN Editorial e ON l.IDEditorial = e.IDEditorial
		        JOIN Curso c ON l.IDCurso = c.IDCurso
		    """;
		    psm = cn.prepareStatement(sql);
		    rs = psm.executeQuery();
		    
		    while (rs.next()) {
		        Libro libro = new Libro();
		        libro.setIdLibro(rs.getInt("IDLibro"));
		        libro.setTitulo(rs.getString("Titulo"));
		        libro.setEjemplaresTotales(rs.getInt("Ejemplares_totales"));
		        libro.setEjemplaresPrestados(rs.getInt("Ejemplares_prestados"));
		        libro.setAutor(rs.getString("Autor")); // Setea el nombre del Autor
		        libro.setEditorial(rs.getString("Editorial")); // Setea el nombre de la Editorial
		        libro.setCurso(rs.getString("Curso")); // Setea el nombre del Curso
		        libro.setFechaLanzamiento(rs.getDate("FechaLanzamiento"));
		        libro.setGenero(rs.getString("Genero"));
		        libro.setEstado(rs.getString("Estado"));
		        listLibro.add(libro);
		    }
		} 
 catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
				if(rs !=null) rs.close();
				if(psm !=null) psm.close();
				if(cn !=null) cn.close();
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		
		return listLibro;
	}

	@Override
	public Libro getLibro(int id) {
		// TODO Auto-generated method stub
		
		// TODO Auto-generated method stub
		Libro libro=null;
		
		Connection cn=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		
		try {
			cn=MySqlConexion.getConexion();
			
			 String sql = """
				        SELECT l.IDLibro, l.Titulo, l.Ejemplares_totales, l.Ejemplares_prestados, 
				               a.Nombre AS Autor, e.Nombre AS Editorial, c.Nombre AS Curso, 
				               l.FechaLanzamiento, l.Genero, l.Estado
				        FROM Libro l
				        JOIN Autor a ON l.IDAutor = a.IDAutor
				        JOIN Editorial e ON l.IDEditorial = e.IDEditorial
				        JOIN Curso c ON l.IDCurso = c.IDCurso where l.IDLibro=?
				    """;
			 
			psm=cn.prepareStatement(sql);
			psm.setInt(1, id);
			
			rs=psm.executeQuery();
			
			if (rs.next()) {
				libro = new Libro();
				libro.setIdLibro(rs.getInt("IDLibro"));
				libro.setTitulo(rs.getString("Titulo"));
				libro.setEjemplaresTotales(rs.getInt("Ejemplares_totales"));
				libro.setEjemplaresPrestados(rs.getInt("Ejemplares_prestados"));
				 libro.setAutor(rs.getString("Autor")); // Setea el nombre del Autor
			        libro.setEditorial(rs.getString("Editorial")); // Setea el nombre de la Editorial
			        libro.setCurso(rs.getString("Curso")); // Setea el nombre del Curso
				libro.setFechaLanzamiento(rs.getDate("FechaLanzamiento"));
				libro.setGenero(rs.getString("Genero"));
				libro.setEstado(rs.getString("Estado"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
				if(rs !=null) rs.close();
				if(psm !=null) psm.close();
				if(cn !=null) cn.close();
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		
		return libro;
	}

}
