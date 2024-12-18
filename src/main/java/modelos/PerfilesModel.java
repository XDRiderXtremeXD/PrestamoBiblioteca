package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entidades.Perfil;
import interfaces.PerfilesInterface;
import utils.MySqlConexion;

public class PerfilesModel implements PerfilesInterface{

	@Override
	public int createPerfil(Perfil perfil) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updatePerfil(Perfil perfil) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deletePerfil(int id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Perfil> listPerfil() {
		// TODO Auto-generated method stub
		 List<Perfil> listPerfil = new ArrayList<Perfil>();

	        // Variables para la conexión y la consulta
	        Connection cn = null;
	        PreparedStatement psm = null;
	        ResultSet rs = null;

	        try {
	            // Establecer la conexión con la base de datos
	            cn = MySqlConexion.getConexion();

	            // SQL para obtener la información de los perfiles
	            String sql = "SELECT idPerfil, usuario, correoElectronico, nombres, apellidos, contrasena, rol, fotoPerfil, estado FROM Perfil";

	            // Preparar la sentencia SQL
	            psm = cn.prepareStatement(sql);

	            // Ejecutar la consulta
	            rs = psm.executeQuery();

	            // Recorrer los resultados de la consulta
	            while (rs.next()) {
	                Perfil perfil = new Perfil();
	                
	                // Asignar los resultados a los atributos del perfil
	                perfil.setIdPerfil(rs.getInt("idPerfil"));
	                perfil.setUsuario(rs.getString("usuario"));
	                perfil.setCorreoElectronico(rs.getString("correoElectronico"));
	                perfil.setNombres(rs.getString("nombres"));
	                perfil.setApellidos(rs.getString("apellidos"));
	                perfil.setContrasena(rs.getString("contrasena"));
	                perfil.setRol(rs.getString("rol"));
	                perfil.setFotoPerfil(rs.getString("fotoPerfil"));
	                perfil.setEstado(rs.getString("estado"));

	                // Agregar el perfil a la lista
	                listPerfil.add(perfil);
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

	        return listPerfil;  // Devolver la l
	}

	@Override
	public Perfil getPerfil(int id) {
		// TODO Auto-generated method stub
		return null;
	}

}
