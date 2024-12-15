package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import entidades.Perfil;
import interfaces.AuthInterface;
import utils.MySqlConexion;

public class AuthModel implements AuthInterface {

	@Override
	public Perfil verificarInicioSesion(String correo, String clave) {
		// TODO Auto-generated method stub
		Perfil usuario=null;
		/*Usuario usuario=null;
		PreparedStatement psmt=null;
		Connection cn =null;
		ResultSet rs = null;
		
		try {
			cn=MySqlConexion.getConexion();
			String mysql="SELECT usr.iduser,usr.email,pe.name,pe.lastname,ro.rolName "
					+ "from user as usr "
					+ "inner join people as pe "
					+ "on usr.people_idpeople = pe.idpeople "
					+ "inner join rol as ro "
					+ "on usr.rol_idrol=ro.idrol "
					+ "where email = ? and password = ?";
			psmt=cn.prepareStatement(mysql);
			psmt.setString(1, correo);
			psmt.setString(2, clave);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				usuario = new Usuario();
				
				usuario.setNombre(rs.getString("name"));
				usuario.setApellidos(rs.getString("lastname"));
				usuario.setId(rs.getString("iduser"));
				usuario.setEmail(rs.getString("email"));
				usuario.setRol(rs.getString("rolName"));
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (psmt != null) psmt.close();
				if (cn != null) cn.close();
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}*/
		return usuario;
	}

}
