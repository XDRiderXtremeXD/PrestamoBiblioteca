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

public class PerfilesModel implements PerfilesInterface {

    @Override
    public int createPerfil(Perfil perfil) {
        String sql = """
            INSERT INTO Perfil 
            (Usuario, CorreoElectronico, Nombres, Apellidos, Contrasena, Rol, FotoPerfil, Estado) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """;

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, perfil.getUsuario());
            ps.setString(2, perfil.getCorreoElectronico());
            ps.setString(3, perfil.getNombres());
            ps.setString(4, perfil.getApellidos());
            ps.setString(5, perfil.getContrasena());
            ps.setString(6, perfil.getRol());
            ps.setString(7, perfil.getFotoPerfil()); // Si fuera byte[] sería setBytes()
            ps.setString(8, perfil.getEstado());

            return ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int updatePerfil(Perfil perfil) {
        String sql = """
            UPDATE Perfil 
            SET Usuario = ?, CorreoElectronico = ?, Nombres = ?, Apellidos = ?, 
                Contrasena = ?, Rol = ?, FotoPerfil = ?, Estado = ?
            WHERE IDPerfil = ?
        """;

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, perfil.getUsuario());
            ps.setString(2, perfil.getCorreoElectronico());
            ps.setString(3, perfil.getNombres());
            ps.setString(4, perfil.getApellidos());
            ps.setString(5, perfil.getContrasena());
            ps.setString(6, perfil.getRol());
            ps.setString(7, perfil.getFotoPerfil()); // Si es LONGBLOB y byte[], usa setBytes()
            ps.setString(8, perfil.getEstado());
            ps.setInt(9, perfil.getIdPerfil());

            return ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int deletePerfil(int id) {
        String sql = "DELETE FROM Perfil WHERE IDPerfil = ?";

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
    public List<Perfil> listPerfil(String filtro) {
        List<Perfil> perfiles = new ArrayList<>();

        String sql = """
            SELECT * FROM Perfil
            WHERE usuario LIKE ? 
               OR correoElectronico LIKE ?
               OR nombres LIKE ?
               OR apellidos LIKE ?
               OR rol LIKE ?
        """;

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            String filtroLike = filtro + "%";
            for (int i = 1; i <= 5; i++) {
                ps.setString(i, filtroLike);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Perfil perfil = new Perfil();
                    perfil.setIdPerfil(rs.getInt("IDPerfil"));
                    perfil.setUsuario(rs.getString("Usuario"));
                    perfil.setCorreoElectronico(rs.getString("CorreoElectronico"));
                    perfil.setNombres(rs.getString("Nombres"));
                    perfil.setApellidos(rs.getString("Apellidos"));
                    perfil.setContrasena(rs.getString("Contrasena"));
                    perfil.setRol(rs.getString("Rol"));
                    perfil.setFotoPerfil(rs.getString("FotoPerfil")); // usa rs.getBytes si es byte[]
                    perfil.setEstado(rs.getString("Estado"));
                    perfiles.add(perfil);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return perfiles;
    }

    @Override
    public Perfil getPerfil(int id) {
        String sql = "SELECT * FROM Perfil WHERE IDPerfil = ?";

        try (Connection cn = MySqlConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Perfil perfil = new Perfil();
                    perfil.setIdPerfil(rs.getInt("IDPerfil"));
                    perfil.setUsuario(rs.getString("Usuario"));
                    perfil.setCorreoElectronico(rs.getString("CorreoElectronico"));
                    perfil.setNombres(rs.getString("Nombres"));
                    perfil.setApellidos(rs.getString("Apellidos"));
                    perfil.setContrasena(rs.getString("Contrasena"));
                    perfil.setRol(rs.getString("Rol"));
                    perfil.setFotoPerfil(rs.getString("FotoPerfil"));
                    perfil.setEstado(rs.getString("Estado"));
                    return perfil;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}

