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

    @Override
    public int createAutor(Autor autor) {
        int result = 0;
        // Variables para la conexión y la consulta
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            // Establecer la conexión con la base de datos
            cn = MySqlConexion.getConexion();

            // SQL para insertar un nuevo autor
            String sql = "INSERT INTO AUTOR (Nombre, Nacionalidad, IdGeneroLiterario, FechaNacimiento, Foto, Biografia, Estado) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?)";

            // Preparar la sentencia SQL
            psm = cn.prepareStatement(sql);
            psm.setString(1, autor.getNombre());
            psm.setString(2, autor.getNacionalidad());
            psm.setInt(3, autor.getIdGeneroLiterario());
            psm.setDate(4, autor.getFechaNacimiento());
            psm.setBytes(5, autor.getFoto());
            psm.setString(6, autor.getBiografia());
            psm.setString(7, autor.getEstado());

            // Ejecutar la inserción
            result = psm.executeUpdate();

        } catch (SQLException e) {
            // Manejo de excepciones
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            try {
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (SQLException e2) {
                e2.printStackTrace();
            }
        }

        return result;  // Retornar el número de registros afectados
    }

    @Override
    public int updateAutor(Autor autor) {
        int result = 0;
        // Variables para la conexión y la consulta
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            // Establecer la conexión con la base de datos
            cn = MySqlConexion.getConexion();

            // SQL para actualizar un autor existente
            String sql = "UPDATE AUTOR SET Nombre = ?, Nacionalidad = ?, IdGeneroLiterario = ?, FechaNacimiento = ?, Foto = ?, Biografia = ?, Estado = ? "
                       + "WHERE IdAutor = ?";

            // Preparar la sentencia SQL
            psm = cn.prepareStatement(sql);
            psm.setString(1, autor.getNombre());
            psm.setString(2, autor.getNacionalidad());
            psm.setInt(3, autor.getIdGeneroLiterario());
            psm.setDate(4, autor.getFechaNacimiento());
            psm.setBytes(5, autor.getFoto());
            psm.setString(6, autor.getBiografia());
            psm.setString(7, autor.getEstado());
            psm.setInt(8, autor.getIdAutor());

            // Ejecutar la actualización
            result = psm.executeUpdate();

        } catch (SQLException e) {
            // Manejo de excepciones
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            try {
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (SQLException e2) {
                e2.printStackTrace();
            }
        }

        return result;  // Retornar el número de registros afectados
    }

    @Override
    public int deleteAutor(int id) {
        int result = 0;
        // Variables para la conexión y la consulta
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            // Establecer la conexión con la base de datos
            cn = MySqlConexion.getConexion();

            // SQL para eliminar un autor
            String sql = "DELETE FROM AUTOR WHERE IdAutor = ?";

            // Preparar la sentencia SQL
            psm = cn.prepareStatement(sql);
            psm.setInt(1, id);

            // Ejecutar la eliminación
            result = psm.executeUpdate();

        } catch (SQLException e) {
            // Manejo de excepciones
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            try {
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (SQLException e2) {
                e2.printStackTrace();
            }
        }

        return result;  // Retornar el número de registros afectados
    }

    @Override
    public List<Autor> listAutor() {
        List<Autor> listAutores = new ArrayList<Autor>();

        // Variables para la conexión y la consulta
        Connection cn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;

        try {
            // Establecer la conexión con la base de datos
            cn = MySqlConexion.getConexion();

            // SQL para obtener los autores
            String sql = "SELECT * FROM AUTOR";

            // Preparar la sentencia SQL
            psm = cn.prepareStatement(sql);

            // Ejecutar la consulta
            rs = psm.executeQuery();

            // Recorrer los resultados de la consulta
            while (rs.next()) {
                Autor autor = new Autor();

                // Asignar los resultados a los atributos del autor
                autor.setIdAutor(rs.getInt("IdAutor"));
                autor.setNombre(rs.getString("Nombre"));
                autor.setNacionalidad(rs.getString("Nacionalidad"));
                autor.setIdGeneroLiterario(rs.getInt("IdGeneroLiterario"));
                autor.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                autor.setFoto(rs.getBytes("Foto"));
                autor.setBiografia(rs.getString("Biografia"));
                autor.setEstado(rs.getString("Estado"));

                // Agregar el autor a la lista
                listAutores.add(autor);
            }

        } catch (SQLException e) {
            // Manejo de excepciones
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            try {
                if (rs != null) rs.close();
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (SQLException e2) {
                e2.printStackTrace();
            }
        }

        return listAutores;  // Devolver la lista de autores
    }

    @Override
    public Autor getAutor(int id) {
        Autor autor = null;

        // Variables para la conexión y la consulta
        Connection cn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;

        try {
            // Establecer la conexión con la base de datos
            cn = MySqlConexion.getConexion();

            // SQL para obtener un autor por su ID
            String sql = "SELECT * FROM AUTOR WHERE IdAutor = ?";

            // Preparar la sentencia SQL
            psm = cn.prepareStatement(sql);
            psm.setInt(1, id);

            // Ejecutar la consulta
            rs = psm.executeQuery();

            // Si se encuentra el autor, asignarlo a la variable
            if (rs.next()) {
                autor = new Autor();

                autor.setIdAutor(rs.getInt("IdAutor"));
                autor.setNombre(rs.getString("Nombre"));
                autor.setNacionalidad(rs.getString("Nacionalidad"));
                autor.setIdGeneroLiterario(rs.getInt("IdGeneroLiterario"));
                autor.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                autor.setFoto(rs.getBytes("Foto"));
                autor.setBiografia(rs.getString("Biografia"));
                autor.setEstado(rs.getString("Estado"));
            }

        } catch (SQLException e) {
            // Manejo de excepciones
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            try {
                if (rs != null) rs.close();
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (SQLException e2) {
                e2.printStackTrace();
            }
        }

        return autor;  // Devolver el autor o null si no se encontró
    }
}
