package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entidades.Autor;
import interfaces.AutoresInterface;
import utils.MySqlConexion;

public class AutorModel implements AutoresInterface {

    /**
     * Inserta un nuevo autor en la base de datos
     */
    @Override
    public int createAutor(Autor autor) {
        String sql = """
            INSERT INTO Autor 
            (Nombre, Nacionalidad, IDGeneroLiterario, FechaNacimiento, Foto, Biografia, Estado) 
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """;

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, autor.getNombre());
            ps.setString(2, autor.getNacionalidad());
            ps.setInt(3, autor.getIdGeneroLiterario());
            ps.setDate(4, autor.getFechaNacimiento());
            ps.setBytes(5, autor.getFoto());
            ps.setString(6, autor.getBiografia());
            ps.setString(7, autor.getEstado());

            return ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    /**
     * Actualiza los datos de un autor
     */
    @Override
    public int updateAutor(Autor autor) {
        String sql = """
            UPDATE Autor 
            SET Nombre = ?, Nacionalidad = ?, IDGeneroLiterario = ?, 
                FechaNacimiento = ?, Foto = ?, Biografia = ?, Estado = ?
            WHERE IDAutor = ?
        """;

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, autor.getNombre());
            ps.setString(2, autor.getNacionalidad());
            ps.setInt(3, autor.getIdGeneroLiterario());
            ps.setDate(4, autor.getFechaNacimiento());
            ps.setBytes(5, autor.getFoto());
            ps.setString(6, autor.getBiografia());
            ps.setString(7, autor.getEstado());
            ps.setInt(8, autor.getIdAutor());

            return ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    /**
     * Elimina un autor por su ID
     */
    @Override
    public int deleteAutor(int id) {
        String sql = "DELETE FROM Autor WHERE IDAutor = ?";

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    /**
     * Lista autores aplicando filtro por nombre, nacionalidad o género literario
     */
    @Override
    public List<Autor> listAutor(String filtro) {
        List<Autor> autores = new ArrayList<>();

        String sql = """
            SELECT a.*, g.NombreGenero 
            FROM Autor a
            JOIN GeneroLiterario g ON a.IDGeneroLiterario = g.IDGeneroLiterario
            WHERE 
                a.Nombre LIKE ? 
                OR a.Nacionalidad LIKE ? 
                OR g.NombreGenero LIKE ?
        """;

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            String filtroLike = filtro + "%";
            ps.setString(1, filtroLike);
            ps.setString(2, filtroLike);
            ps.setString(3, filtroLike);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Autor a = new Autor();
                    a.setIdAutor(rs.getInt("IDAutor"));
                    a.setNombre(rs.getString("Nombre"));
                    a.setNacionalidad(rs.getString("Nacionalidad"));
                    a.setIdGeneroLiterario(rs.getInt("IDGeneroLiterario"));
                    a.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                    a.setFoto(rs.getBytes("Foto"));
                    a.setBiografia(rs.getString("Biografia"));
                    a.setEstado(rs.getString("Estado"));
                    a.setNombreGenero(rs.getString("NombreGenero")); // De la tabla GeneroLiterario

                    autores.add(a);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return autores;
    }

    /**
     * Obtiene un autor por su ID
     */
    @Override
    public Autor getAutor(int id) {
        String sql = "SELECT * FROM Autor WHERE IDAutor = ?";

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Autor a = new Autor();
                    a.setIdAutor(rs.getInt("IDAutor"));
                    a.setNombre(rs.getString("Nombre"));
                    a.setNacionalidad(rs.getString("Nacionalidad"));
                    a.setIdGeneroLiterario(rs.getInt("IDGeneroLiterario"));
                    a.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                    a.setFoto(rs.getBytes("Foto"));
                    a.setBiografia(rs.getString("Biografia"));
                    a.setEstado(rs.getString("Estado"));

                    return a;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}
