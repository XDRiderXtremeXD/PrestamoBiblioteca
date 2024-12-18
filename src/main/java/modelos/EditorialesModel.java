package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entidades.Editorial;
import interfaces.EditorialesInterface;
import utils.MySqlConexion;

public class EditorialesModel implements EditorialesInterface {

	@Override
	public int createEditorial(Editorial editorial) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateEditorial(Editorial editorial) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteEditorial(int id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Editorial> listEditorial() {
		// TODO Auto-generated method stub
		List<Editorial> listEditorial = new ArrayList<Editorial>();

		Connection cn = null;
		PreparedStatement psm = null;
		ResultSet rs = null;

		try {
		    cn = MySqlConexion.getConexion();
		    String sql = "SELECT e.IDEditorial, e.Nombre, e.Nacionalidad, e.AñoFundacion, e.PaginaWeb, e.Direccion, e.Estado, g.NombreGenero AS GeneroLiterario " +
		                 "FROM Editorial e " +
		                 "JOIN GeneroLiterario g ON e.IDGeneroLiterario = g.IDGeneroLiterario";  // SQL con JOIN
		    psm = cn.prepareStatement(sql);
		    rs = psm.executeQuery();

		    while (rs.next()) {
		        Editorial editorial = new Editorial();
		        editorial.setIdEditorial(rs.getInt("IDEditorial"));
		        editorial.setNombre(rs.getString("Nombre"));
		        editorial.setNacionalidad(rs.getString("Nacionalidad"));
		        editorial.setAnioFundacion(rs.getInt("AñoFundacion"));
		        editorial.setPaginaWeb(rs.getString("PaginaWeb"));
		        editorial.setDireccion(rs.getString("Direccion"));
		        editorial.setEstado(rs.getString("Estado"));
		        editorial.setGeneroLiterario(rs.getString("GeneroLiterario"));  // Setea el nombre del género literario

		        listEditorial.add(editorial);
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

		return listEditorial;

	}

	@Override
	public Editorial getEditorial(int id) {
		// TODO Auto-generated method stub
		return null;
	}

}
