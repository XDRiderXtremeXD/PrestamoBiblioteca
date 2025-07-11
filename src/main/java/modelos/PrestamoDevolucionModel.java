package modelos;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entidades.PrestamoDevolucion;
import interfaces.PrestamoInterface;
import utils.MySqlConexion;

public class PrestamoDevolucionModel implements PrestamoInterface {

    @Override
    public int createPrestamo(PrestamoDevolucion prestamoDevolucion,int idLibro,int idEstudiante) {
        int resultado = 0;
        Connection cn = null;
        PreparedStatement psm = null;
      
     
        try {
            cn = MySqlConexion.getConexion();
            String sql = "INSERT INTO Prestamo_Devolucion (IDLibro, IDEstudiante, FechaPrestamo, FechaDevolucion, Cantidad, Estado, Observacion) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";

            psm = cn.prepareStatement(sql);
            psm.setInt(1, idLibro);
            psm.setInt(2, idEstudiante);
            psm.setDate(3, prestamoDevolucion.getFechaPrestamo());
            psm.setDate(4, prestamoDevolucion.getFechaDevolucion());
            psm.setInt(5, prestamoDevolucion.getCantidad());
            psm.setString(6, prestamoDevolucion.getEstado());
            psm.setString(7, prestamoDevolucion.getObservacion());
            System.out.println("Entra");
            resultado = psm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return resultado; // Devuelve el número de filas afectadas
    }

    @Override
    public int updatePrestamo(PrestamoDevolucion prestamoDevolucion, int idLibro, int idEstudiante) {
        int resultado = 0;
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            // Actualizamos la consulta SQL para incluir idLibro y idEstudiante
            String sql = "UPDATE Prestamo_Devolucion SET FechaPrestamo = ?, FechaDevolucion = ?, Cantidad = ?, Observacion = ?, IDLibro = ?, IDEstudiante = ? "
                         + "WHERE IDPrestamo = ?";

            psm = cn.prepareStatement(sql);
            psm.setDate(1, prestamoDevolucion.getFechaPrestamo());
            psm.setDate(2, prestamoDevolucion.getFechaDevolucion());
            psm.setInt(3, prestamoDevolucion.getCantidad());
            psm.setString(4, prestamoDevolucion.getObservacion());
            psm.setInt(5, idLibro); // Nuevo parámetro para IDLibro
            psm.setInt(6, idEstudiante); // Nuevo parámetro para IDEstudiante
            psm.setInt(7, prestamoDevolucion.getIdPrestamo()); // IDPrestamo para la condición WHERE

            resultado = psm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return resultado; // Devuelve el número de filas afectadas
    }


    @Override
    public List<PrestamoDevolucion> listPrestamo(String filtro) {

        List<PrestamoDevolucion> listPrestamos = new ArrayList<>();
        Connection cn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;

        try {
            cn = MySqlConexion.getConexion();
            
            // Consulta SQL con filtro para nombres de libro y estudiante que empiezan con el valor de 'filtro'
            String sql = """
                SELECT 
                    pd.IDPrestamo, 
                    pd.FechaPrestamo, 
                    pd.FechaDevolucion, 
                    pd.Cantidad, 
                    pd.Estado, 
                    pd.Observacion,
                    l.Titulo AS NombreLibro,
                    e.Nombres AS NombreEstudiante,
                    e.Apellidos AS ApellidoEstudiante
                FROM 
                    Prestamo_Devolucion pd
                INNER JOIN 
                    Libro l ON pd.IDLibro = l.IDLibro
                INNER JOIN 
                    Estudiante e ON pd.IDEstudiante = e.IDEstudiante
                WHERE 
                    l.Titulo LIKE ? OR 
                    (e.Nombres LIKE ? OR e.Apellidos LIKE ?)
            """;

            // Prepara la consulta y establece los parámetros
            psm = cn.prepareStatement(sql);
            
            // Parámetros de filtro para que los nombres empiecen con el valor dado
            String filtroLike = filtro + "%"; // Se agrega '%' al final para hacer el filtro 'starts with'
            
            psm.setString(1, filtroLike); // Filtra por Titulo del libro
            psm.setString(2, filtroLike); // Filtra por Nombres del estudiante
            psm.setString(3, filtroLike); // Filtra por Apellidos del estudiante

            // Ejecuta la consulta
            rs = psm.executeQuery();

            // Procesa los resultados
            while (rs.next()) {
                PrestamoDevolucion prestamoDevolucion = new PrestamoDevolucion();
                prestamoDevolucion.setIdPrestamo(rs.getInt("IDPrestamo"));
                prestamoDevolucion.setFechaPrestamo(rs.getDate("FechaPrestamo"));
                prestamoDevolucion.setFechaDevolucion(rs.getDate("FechaDevolucion"));
                prestamoDevolucion.setCantidad(rs.getInt("Cantidad"));
                prestamoDevolucion.setEstado(rs.getString("Estado"));
                prestamoDevolucion.setObservacion(rs.getString("Observacion"));
                prestamoDevolucion.setLibro(rs.getString("NombreLibro"));
                prestamoDevolucion.setEstudiante(rs.getString("NombreEstudiante") + " " + rs.getString("ApellidoEstudiante"));

                listPrestamos.add(prestamoDevolucion);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return listPrestamos; // Devuelve la lista de préstamos
    }

    @Override
    public PrestamoDevolucion getPrestamo(int idPrestamo) {
        PrestamoDevolucion prestamoDevolucion = null;
        Connection cn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "SELECT * FROM Prestamo_Devolucion WHERE IDPrestamo = ?";

            psm = cn.prepareStatement(sql);
            psm.setInt(1, idPrestamo);
            rs = psm.executeQuery();

            if (rs.next()) {
                prestamoDevolucion = new PrestamoDevolucion();
                prestamoDevolucion.setIdPrestamo(rs.getInt("IDPrestamo"));
                prestamoDevolucion.setLibro(rs.getString("NombreLibro"));
                prestamoDevolucion.setEstudiante(rs.getString("NombreEstudiante") + " " + rs.getString("ApellidoEstudiante"));
                prestamoDevolucion.setFechaPrestamo(rs.getDate("FechaPrestamo"));
                prestamoDevolucion.setFechaDevolucion(rs.getDate("FechaDevolucion"));
                prestamoDevolucion.setCantidad(rs.getInt("Cantidad"));
                prestamoDevolucion.setEstado(rs.getString("Estado"));
                prestamoDevolucion.setObservacion(rs.getString("Observacion"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return prestamoDevolucion; // Devuelve el préstamo específico o null si no se encuentra
    }

    @Override
    public int changeState(int idPrestamo, String nuevoEstado) {
        Connection cn = null;
        PreparedStatement psm = null;
        System.out.println("aca2");
        System.out.println(idPrestamo);
        System.out.println(nuevoEstado);
        
        try {
            // Conexión a la base de datos
            cn = MySqlConexion.getConexion();
            // SQL para actualizar el estado del préstamo
            String sql = "UPDATE Prestamo_Devolucion SET Estado = ? WHERE IDPrestamo = ?";
            
            psm = cn.prepareStatement(sql);
            psm.setString(1, nuevoEstado); // Establecer el nuevo estado
            psm.setInt(2, idPrestamo);     // Establecer el ID del préstamo

            // Ejecutar la consulta de actualización
            int filasAfectadas = psm.executeUpdate();

            if (filasAfectadas > 0) {
                System.out.println("El estado del préstamo con ID " + idPrestamo + " ha sido actualizado a: " + nuevoEstado);
                return 1;
            } else {
                System.out.println("No se encontró un préstamo con el ID especificado: " + idPrestamo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            try {
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return 0;
    }

}
