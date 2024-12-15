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
	public int deleteLibro(String id) {
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
			String sql="SELECT * FROM Libro";
			psm = cn.prepareStatement(sql);
			rs=psm.executeQuery();
			
			while (rs.next()) {
				Libro libro = new Libro();
				libro.setIdLibro(rs.getInt("IDLibro"));
				libro.setTitulo(rs.getString("Titulo"));
				libro.setEjemplaresTotales(rs.getInt("Ejemplares_totales"));
				libro.setEjemplaresPrestados(rs.getInt("Ejemplares_prestados"));
				libro.setIdAutor(rs.getInt("IDAutor"));
				libro.setIdEditorial(rs.getInt("IDEditorial"));
				libro.setIdCurso(rs.getInt("IDCurso"));
				libro.setFechaLanzamiento(rs.getDate("FechaLanzamiento"));
				libro.setGenero(rs.getString("Genero"));
				libro.setEstado(rs.getString("Estado"));
				listLibro.add(libro);
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
		
		return listLibro;
	}

}
