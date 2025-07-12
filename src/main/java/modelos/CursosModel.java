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

public class CursosModel implements CursosInterface {

    @Override
    public int createCurso(Curso curso) {
        String sql = """
            INSERT INTO Curso (Nombre, Nivel, Descripcion, Estado)
            VALUES (?, ?, ?, ?)
        """;

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, curso.getNombre());
            ps.setString(2, curso.getNivel());
            ps.setString(3, curso.getDescripcion());
            ps.setString(4, curso.getEstado());

            return ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int updateCurso(Curso curso) {
        String sql = """
            UPDATE Curso 
            SET Nombre = ?, Nivel = ?, Descripcion = ?, Estado = ?
            WHERE IDCurso = ?
        """;
        
        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
         
            ps.setString(1, curso.getNombre());
            ps.setString(2, curso.getNivel());
            ps.setString(3, curso.getDescripcion());
            ps.setString(4, curso.getEstado());
            ps.setInt(5, curso.getIdCurso());

            return ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int deleteCurso(int id) {
        String sql = "DELETE FROM Curso WHERE IDCurso = ?";

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
	public List<Curso> listCurso(String filtro) {
        List<Curso> cursos = new ArrayList<>();

        String sql = """
            SELECT * FROM Curso
            WHERE 
                Nombre LIKE ?
                OR Nivel LIKE ?
                OR Descripcion LIKE ?
        """;

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            String filtroLike = filtro + "%";

            ps.setString(1, filtroLike);
            ps.setString(2, filtroLike);
            ps.setString(3, filtroLike);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Curso curso = new Curso();

                    curso.setIdCurso(rs.getInt("IDCurso"));
                    curso.setNombre(rs.getString("Nombre"));
                    curso.setNivel(rs.getString("Nivel"));
                    curso.setDescripcion(rs.getString("Descripcion"));
                    curso.setEstado(rs.getString("Estado"));

                    cursos.add(curso);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cursos;
    }

    @Override
    public Curso getCurso(int id) {
        String sql = "SELECT * FROM Curso WHERE IDCurso = ?";

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Curso curso = new Curso();

                    curso.setIdCurso(rs.getInt("IDCurso"));
                    curso.setNombre(rs.getString("Nombre"));
                    curso.setNivel(rs.getString("Nivel"));
                    curso.setDescripcion(rs.getString("Descripcion"));
                    curso.setEstado(rs.getString("Estado"));

                    return curso;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}
