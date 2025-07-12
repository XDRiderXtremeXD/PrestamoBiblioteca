package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entidades.Editorial;
import interfaces.EditorialesInterface;
import utils.MySqlConexion;

public class EditorialesModel implements EditorialesInterface {

    @Override
    public int createEditorial(Editorial editorial) {
        String sql = """
            INSERT INTO Editorial 
            (Nombre, Nacionalidad, IDGeneroLiterario, Foto, AñoFundacion, PaginaWeb, Direccion, Estado) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """;

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, editorial.getNombre());
            ps.setString(2, editorial.getNacionalidad());
            ps.setInt(3, editorial.getIdGeneroLiterario());
            ps.setString(4, editorial.getFoto());
            ps.setInt(5, editorial.getAnioFundacion());
            ps.setString(6, editorial.getPaginaWeb());
            ps.setString(7, editorial.getDireccion());
            ps.setString(8, editorial.getEstado());

            return ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int updateEditorial(Editorial editorial) {
    	
        String sql = """
            UPDATE Editorial 
            SET Nombre = ?, Nacionalidad = ?, IDGeneroLiterario = ?, 
                Foto = ?, AñoFundacion = ?, PaginaWeb = ?, Direccion = ?, Estado = ?
            WHERE IDEditorial = ?
        """;

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, editorial.getNombre());
            ps.setString(2, editorial.getNacionalidad());
            ps.setInt(3, editorial.getIdGeneroLiterario());
            ps.setString(4, editorial.getFoto());
            ps.setInt(5, editorial.getAnioFundacion());
            ps.setString(6, editorial.getPaginaWeb());
            ps.setString(7, editorial.getDireccion());
            ps.setString(8, editorial.getEstado());
            ps.setInt(9, editorial.getIdEditorial());

            return ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int deleteEditorial(int id) {
        String sql = "DELETE FROM Editorial WHERE IDEditorial = ?";

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public List<Editorial> listEditorial(String filtro) {
        List<Editorial> editoriales = new ArrayList<>();

        String sql = """
            SELECT e.*, g.NombreGenero 
            FROM Editorial e
            JOIN GeneroLiterario g ON e.IDGeneroLiterario = g.IDGeneroLiterario
            WHERE 
                e.Nombre LIKE ? OR 
                e.Nacionalidad LIKE ? OR 
                g.NombreGenero LIKE ?
        """;

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            String filtroLike = "%" + filtro + "%";
            ps.setString(1, filtroLike);
            ps.setString(2, filtroLike);
            ps.setString(3, filtroLike);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Editorial e = new Editorial();
                    e.setIdEditorial(rs.getInt("IDEditorial"));
                    e.setNombre(rs.getString("Nombre"));
                    e.setNacionalidad(rs.getString("Nacionalidad"));
                    e.setIdGeneroLiterario(rs.getInt("IDGeneroLiterario"));
                    e.setFoto(rs.getString("Foto"));
                    e.setAnioFundacion(rs.getInt("AñoFundacion"));
                    e.setPaginaWeb(rs.getString("PaginaWeb"));
                    e.setDireccion(rs.getString("Direccion"));
                    e.setEstado(rs.getString("Estado"));
                    e.setNombreGeneroLiterario(rs.getString("NombreGenero"));
                    editoriales.add(e);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return editoriales;
    }


    @Override
    public Editorial getEditorial(int id) {
        String sql = "SELECT * FROM Editorial WHERE IDEditorial = ?";

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Editorial e = new Editorial();
                    e.setIdEditorial(rs.getInt("IDEditorial"));
                    e.setNombre(rs.getString("Nombre"));
                    e.setNacionalidad(rs.getString("Nacionalidad"));
                    e.setIdGeneroLiterario(rs.getInt("IDGeneroLiterario"));
                    e.setFoto(rs.getString("Foto"));
                    e.setAnioFundacion(rs.getInt("AñoFundacion"));
                    e.setPaginaWeb(rs.getString("PaginaWeb"));
                    e.setDireccion(rs.getString("Direccion"));
                    e.setEstado(rs.getString("Estado"));

                    return e;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}
