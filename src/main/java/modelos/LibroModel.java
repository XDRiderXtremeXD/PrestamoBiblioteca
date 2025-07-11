package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entidades.Libro;
import interfaces.LibroInterface;
import utils.MySqlConexion;

public class LibroModel implements LibroInterface {

	@Override
	public int createLibro(Libro subject) {
	    int result = 0;
	    Connection cn = null;
	    PreparedStatement psm = null;

	    try {
	        cn = MySqlConexion.getConexion();
	        String sql = """
	            INSERT INTO Libro (Titulo, Ejemplares_totales, Ejemplares_prestados, 
	                               IDAutor, IDEditorial, IDCurso, FechaLanzamiento, Genero, Estado)
	            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
	        """;
	        psm = cn.prepareStatement(sql);
	        psm.setString(1, subject.getTitulo());
	        psm.setInt(2, subject.getEjemplaresTotales());
	        psm.setInt(3, subject.getEjemplaresPrestados());
	        psm.setInt(4, Integer.parseInt(subject.getAutor()));
	        psm.setInt(5, Integer.parseInt(subject.getEditorial()));
	        psm.setInt(6, Integer.parseInt(subject.getCurso()));
	        psm.setDate(7, new java.sql.Date(subject.getFechaLanzamiento().getTime()));
	        psm.setString(8, subject.getGenero());
	        psm.setString(9, subject.getEstado());

	        result = psm.executeUpdate();
	    } catch (Exception e) {
	        System.out.println("Error al crear libro: " + e.getMessage());
	    } finally {
	        try { if (psm != null) psm.close(); if (cn != null) cn.close(); } catch (Exception e) {}
	    }

	    return result;
	}

	@Override
	public int updateLibro(Libro subject) {
	    int result = 0;
	    Connection cn = null;
	    PreparedStatement psm = null;

	    try {
	        cn = MySqlConexion.getConexion();
	        String sql = """
	            UPDATE Libro
	            SET Titulo = ?, Ejemplares_totales = ?, Ejemplares_prestados = ?,
	                IDAutor = ?, IDEditorial = ?, IDCurso = ?, FechaLanzamiento = ?,
	                Genero = ?, Estado = ?
	            WHERE IDLibro = ?
	        """;
	        
	        psm = cn.prepareStatement(sql);
	        psm.setString(1, subject.getTitulo());
	        psm.setInt(2, subject.getEjemplaresTotales());
	        psm.setInt(3, subject.getEjemplaresPrestados());
	        psm.setInt(4, Integer.parseInt(subject.getAutor()));
	        psm.setInt(5, Integer.parseInt(subject.getEditorial()));
	        psm.setInt(6, Integer.parseInt(subject.getCurso()));
	        psm.setDate(7, subject.getFechaLanzamiento());	        
	        psm.setString(8, subject.getGenero());
	        psm.setString(9, subject.getEstado());
	        psm.setInt(10, subject.getIdLibro());

	        result = psm.executeUpdate();
	    } catch (Exception e) {
	        System.out.println("Error al actualizar libro: " + e.getMessage());
	    } finally {
	        try { if (psm != null) psm.close(); if (cn != null) cn.close(); } catch (Exception e) {}
	    }

	    return result;
	}

	@Override
	public int deleteLibro(int id) {
	    int result = 0;
	    Connection cn = null;
	    PreparedStatement psm = null;

	    try {
	        cn = MySqlConexion.getConexion();
	        String sql = "UPDATE Libro SET Estado = 'inactivo' WHERE IDLibro = ?";
	        psm = cn.prepareStatement(sql);
	        psm.setInt(1, id);

	        result = psm.executeUpdate();
	    } catch (Exception e) {
	        System.out.println("Error al eliminar (inactivar) libro: " + e.getMessage());
	    } finally {
	        try { if (psm != null) psm.close(); if (cn != null) cn.close(); } catch (Exception e) {}
	    }

	    return result;
	}


	@Override
	public List<Libro> listLibro(String filtro) {
	    List<Libro> libros = new ArrayList<>();
	    Connection cn = null;
	    PreparedStatement psm = null;
	    ResultSet rs = null;

	    try {
	        cn = MySqlConexion.getConexion();

	        String sql = """
	            SELECT 
	                l.IDLibro,
	                l.Titulo,
	                l.Ejemplares_totales,
	                l.Ejemplares_prestados,
	                a.Nombre AS NombreAutor,
	                ed.Nombre AS NombreEditorial,
	                c.Nombre AS NombreCurso,
	                l.FechaLanzamiento,
	                l.Genero,
	                l.Estado
	            FROM Libro l
	            INNER JOIN Autor a ON l.IDAutor = a.IDAutor
	            INNER JOIN Editorial ed ON l.IDEditorial = ed.IDEditorial
	            INNER JOIN Curso c ON l.IDCurso = c.IDCurso
	            WHERE 
                    (l.Titulo LIKE ? OR
                    a.Nombre LIKE ? OR
                    ed.Nombre LIKE ? OR
                    c.Nombre LIKE ?)
                    AND l.Estado = 'activo'
	        """;

	        psm = cn.prepareStatement(sql);
	        String filtroLike = filtro + "%";
	        for (int i = 1; i <= 4; i++) {
	            psm.setString(i, filtroLike);
	        }

	        rs = psm.executeQuery();

	        while (rs.next()) {
	            Libro libro = new Libro();
	            libro.setIdLibro(rs.getInt("IDLibro"));
	            libro.setTitulo(rs.getString("Titulo"));
	            libro.setEjemplaresTotales(rs.getInt("Ejemplares_totales"));
	            libro.setEjemplaresPrestados(rs.getInt("Ejemplares_prestados"));
	            libro.setAutor(rs.getString("NombreAutor"));
	            libro.setEditorial(rs.getString("NombreEditorial"));
	            libro.setCurso(rs.getString("NombreCurso"));
	            libro.setFechaLanzamiento(rs.getDate("FechaLanzamiento"));
	            libro.setGenero(rs.getString("Genero"));
	            libro.setEstado(rs.getString("Estado"));

	            libros.add(libro);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (psm != null) psm.close();
	            if (cn != null) cn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    return libros;
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
