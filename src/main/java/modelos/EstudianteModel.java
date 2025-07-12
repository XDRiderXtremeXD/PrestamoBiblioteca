package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entidades.Estudiante;
import interfaces.EstudianteInterface;
import utils.MySqlConexion;

public class EstudianteModel implements EstudianteInterface {

    /**
     * Lista todos los estudiantes con su facultad
     */
    @Override
    public List<Estudiante> listEstudiante(String filtro) {
        List<Estudiante> estudiantes = new ArrayList<>();

        String sql = """
            SELECT e.IDEstudiante, e.DNI, e.Nombres, e.Apellidos, e.Direccion, 
                   e.Telefono, e.CorreoElectronico, e.FechaNacimiento, e.Genero, 
                   f.NombreFacultad AS Facultad, e.Estado
            FROM Estudiante e
            JOIN Facultad f ON e.IDFacultad = f.IDFacultad
            WHERE 
                e.Nombres LIKE ? OR 
                e.Apellidos LIKE ? OR 
                e.DNI LIKE ? OR 
                f.NombreFacultad LIKE ?
        """;

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            String filtroLike = "%" + filtro + "%";
            ps.setString(1, filtroLike);
            ps.setString(2, filtroLike);
            ps.setString(3, filtroLike);
            ps.setString(4, filtroLike);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Estudiante est = new Estudiante();
                    est.setIdEstudiante(rs.getInt("IDEstudiante"));
                    est.setDni(rs.getString("DNI"));
                    est.setNombres(rs.getString("Nombres"));
                    est.setApellidos(rs.getString("Apellidos"));
                    est.setDireccion(rs.getString("Direccion"));
                    est.setTelefono(rs.getString("Telefono"));
                    est.setCorreoElectronico(rs.getString("CorreoElectronico"));
                    est.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                    est.setGenero(rs.getString("Genero"));
                    est.setFacultad(rs.getString("Facultad"));
                    est.setEstado(rs.getString("Estado"));
                    estudiantes.add(est);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return estudiantes;
    }


    /**
     * Obtiene un estudiante por su ID
     */
    @Override
    public Estudiante getEstudiante(int id) {
        String sql = """
            SELECT e.*, f.NombreFacultad AS Facultad
            FROM Estudiante e
            JOIN Facultad f ON e.IDFacultad = f.IDFacultad
            WHERE e.IDEstudiante = ?
        """;

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Estudiante est = new Estudiante();
                    est.setIdEstudiante(rs.getInt("IDEstudiante"));
                    est.setDni(rs.getString("DNI"));
                    est.setNombres(rs.getString("Nombres"));
                    est.setApellidos(rs.getString("Apellidos"));
                    est.setDireccion(rs.getString("Direccion"));
                    est.setTelefono(rs.getString("Telefono"));
                    est.setCorreoElectronico(rs.getString("CorreoElectronico"));
                    est.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                    est.setGenero(rs.getString("Genero"));
                    est.setFacultad(rs.getString("Facultad"));
                    est.setEstado(rs.getString("Estado"));
                    return est;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Crea un nuevo estudiante
     */
    @Override
    public int createEstudiante(Estudiante est) {
        String sql = """
            INSERT INTO Estudiante 
            (DNI, Nombres, Apellidos, Direccion, Telefono, CorreoElectronico, 
             FechaNacimiento, Genero, IDFacultad, Estado)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, est.getDni());
            ps.setString(2, est.getNombres());
            ps.setString(3, est.getApellidos());
            ps.setString(4, est.getDireccion());
            ps.setString(5, est.getTelefono());
            ps.setString(6, est.getCorreoElectronico());
            ps.setDate(7, est.getFechaNacimiento());
            ps.setString(8, est.getGenero());
            ps.setInt(9, Integer.parseInt(est.getFacultad())); // Convertir nombre → ID
            ps.setString(10, est.getEstado());

            return ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    /**
     * Actualiza los datos de un estudiante
     */
    @Override
    public int updateEstudiante(Estudiante est) {
        String sql = """
            UPDATE Estudiante 
            SET DNI = ?, Nombres = ?, Apellidos = ?, Direccion = ?, Telefono = ?, 
                CorreoElectronico = ?, FechaNacimiento = ?, Genero = ?, 
                IDFacultad = ?, Estado = ?
            WHERE IDEstudiante = ?
        """;

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, est.getDni());
            ps.setString(2, est.getNombres());
            ps.setString(3, est.getApellidos());
            ps.setString(4, est.getDireccion());
            ps.setString(5, est.getTelefono());
            ps.setString(6, est.getCorreoElectronico());
            ps.setDate(7, est.getFechaNacimiento());
            ps.setString(8, est.getGenero());
            ps.setInt(9, Integer.parseInt(est.getFacultad()));
            ps.setString(10, est.getEstado());
            ps.setInt(11, est.getIdEstudiante());

            return ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    /**
     * Elimina un estudiante por su ID
     */
    @Override
    public int deleteEstudiante(int id) {
        String sql = "DELETE FROM Estudiante WHERE IDEstudiante = ?";

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
     * Obtiene el ID de una facultad por su nombre
     */
    private int getIdFacultadByName(String nombreFacultad) {
        String sql = "SELECT IDFacultad FROM Facultad WHERE NombreFacultad = ?";

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, nombreFacultad);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("IDFacultad");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
}
