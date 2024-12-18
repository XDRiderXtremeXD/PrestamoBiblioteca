package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entidades.Estudiante;
import entidades.Libro;
import interfaces.EstudianteInterface;
import utils.MySqlConexion;

public class EstudianteModel implements EstudianteInterface {

	@Override
	public int createLibro(Estudiante estudiante) {
		// TODO Auto-generated method stub
		
		return 0;
	}

	@Override
	public int updateLibro(Estudiante estudiante) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteLibro(int id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Estudiante> listEstudiante() {
		// TODO Auto-generated method stub
		List<Estudiante> listEstudiante = new ArrayList<Estudiante>();
		
		Connection cn = null;
		PreparedStatement psm = null;
		ResultSet rs = null;

		try {
		    cn = MySqlConexion.getConexion();
		    // Modificar la consulta para incluir el nombre de la facultad
		    String sql = "SELECT e.IDEstudiante, e.DNI, e.Nombres, e.Apellidos, e.Direccion, " +
		                 "e.Telefono, e.CorreoElectronico, e.FechaNacimiento, e.Genero, " +
		                 "f.NombreFacultad AS Facultad, e.Estado " +
		                 "FROM Estudiante e " +
		                 "JOIN Facultad f ON e.IDFacultad = f.IDFacultad";
		    psm = cn.prepareStatement(sql);
		    rs = psm.executeQuery();

		    while (rs.next()) {
		        Estudiante estudiante = new Estudiante();
		        estudiante.setIdEstudiante(rs.getInt("IDEstudiante"));
		        estudiante.setDni(rs.getString("DNI"));
		        estudiante.setNombres(rs.getString("Nombres"));
		        estudiante.setApellidos(rs.getString("Apellidos"));
		        estudiante.setDireccion(rs.getString("Direccion"));
		        estudiante.setTelefono(rs.getString("Telefono"));
		        estudiante.setCorreoElectronico(rs.getString("CorreoElectronico"));
		        estudiante.setFechaNacimiento(rs.getDate("FechaNacimiento"));
		        estudiante.setGenero(rs.getString("Genero"));
		        // Establecer el nombre de la facultad en lugar del ID
		        estudiante.setFacultad(rs.getString("Facultad"));  
		        estudiante.setEstado(rs.getString("Estado"));
		        listEstudiante.add(estudiante);
		    }

		} catch (Exception e) {
		    // TODO: handle exception
		    e.printStackTrace();
		} finally {
		    try {
		        if (rs != null) rs.close();
		        if (psm != null) psm.close();
		        if (cn != null) cn.close();
		    } catch (Exception e2) {
		        // TODO: handle exception
		        e2.printStackTrace();
		    }
		}

		return listEstudiante;
	}

	@Override
	public Estudiante getLibro(int id) {
		// TODO Auto-generated method stub
		return null;
	}

}
