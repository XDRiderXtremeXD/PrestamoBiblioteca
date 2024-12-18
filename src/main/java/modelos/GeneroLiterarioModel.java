package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entidades.GeneroLiterario;
import interfaces.GeneroLiterarioInterface;
import utils.MySqlConexion;

public class GeneroLiterarioModel implements GeneroLiterarioInterface {

	@Override
	public List<GeneroLiterario> listGeneroLiterario() {
	    List<GeneroLiterario> listGeneroLiterario = new ArrayList<GeneroLiterario>();
	    
	    Connection cn = null;
	    PreparedStatement psm = null;
	    ResultSet rs = null;
	    
	    try {
	        cn = MySqlConexion.getConexion();
	        String sql = "SELECT IDGeneroLiterario, NombreGenero FROM GeneroLiterario";
	        psm = cn.prepareStatement(sql);
	        rs = psm.executeQuery();
	        
	        while (rs.next()) {
	            GeneroLiterario generoLiterario = new GeneroLiterario();
	            generoLiterario.setIdGeneroLiterario(rs.getInt("IDGeneroLiterario"));
	            generoLiterario.setNombreGenero(rs.getString("NombreGenero"));
	            listGeneroLiterario.add(generoLiterario);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (psm != null) psm.close();
	            if (cn != null) cn.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    
	    return listGeneroLiterario;
	}
}
