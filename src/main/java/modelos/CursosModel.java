package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entidades.Curso;
import interfaces.CursosInterface;
import utils.MySqlConexion;

public class CursosModel implements CursosInterface{

	@Override
	public int createCurso(Curso curso) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateCurso(Curso curso) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteCurso(int id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Curso> listCurso() {
		// TODO Auto-generated method stub
		  List<Curso> listCursos = new ArrayList<Curso>();

	        // Variables para la conexión y la consulta
	        Connection cn = null;
	        PreparedStatement psm = null;
	        ResultSet rs = null;

	        try {
	            // Establecer la conexión con la base de datos
	            cn = MySqlConexion.getConexion();

	            // SQL para obtener los cursos
	            String sql = "SELECT * FROM CURSO";

	            // Preparar la sentencia SQL
	            psm = cn.prepareStatement(sql);

	            // Ejecutar la consulta
	            rs = psm.executeQuery();

	            // Recorrer los resultados de la consulta
	            while (rs.next()) {
	                Curso curso = new Curso();

	                // Asignar los resultados a los atributos del curso
	                curso.setIdCurso(rs.getInt("IDCurso"));
	                curso.setNombre(rs.getString("Nombre"));
	                curso.setNivel(rs.getString("Nivel"));
	                curso.setDescripcion(rs.getString("Descripcion"));
	                curso.setEstado(rs.getString("Estado"));

	                // Agregar el curso a la lista
	                listCursos.add(curso);
	            }

	        } catch (Exception e) {
	            // Manejo de excepciones
	            e.printStackTrace();
	        } finally {
	            // Cerrar recursos para evitar fugas de memoria
	            try {
	                if (rs != null) rs.close();
	                if (psm != null) psm.close();
	                if (cn != null) cn.close();
	            } catch (SQLException e2) {
	                e2.printStackTrace();
	            }
	        }

	        return listCursos;  // Devolver la lista de cursos
	}

	@Override
	public Curso getCurso(int id) {
		// TODO Auto-generated method stub
		return null;
	}

}
