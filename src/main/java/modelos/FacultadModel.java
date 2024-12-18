package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entidades.Facultad;
import interfaces.FacultadInterface;
import utils.MySqlConexion;

public class FacultadModel implements FacultadInterface{

	@Override
	public List<Facultad> listFacultad() {
	    List<Facultad> listFacultad = new ArrayList<Facultad>();
	    
	    Connection cn = null;
	    PreparedStatement psm = null;
	    ResultSet rs = null;
	    
	    try {
	        cn = MySqlConexion.getConexion();
	        String sql = "SELECT IDFacultad, NombreFacultad FROM Facultad";
	        psm = cn.prepareStatement(sql);
	        rs = psm.executeQuery();
	        
	        while (rs.next()) {
	            Facultad facultad = new Facultad();
	            facultad.setIdFacultad(rs.getInt("IDFacultad"));
	            facultad.setNombreFacultad(rs.getString("NombreFacultad"));
	            listFacultad.add(facultad);
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
	    
	    return listFacultad;
	}
}
