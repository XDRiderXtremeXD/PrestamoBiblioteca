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
    public int createPrestamo(PrestamoDevolucion prestamoDevolucion) {
        int resultado = 0;
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "INSERT INTO Prestamo_Devolucion (IDLibro, IDEstudiante, FechaPrestamo, FechaDevolucion, Cantidad, Estado, Observacion) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";

            psm = cn.prepareStatement(sql);
            psm.setString(1, prestamoDevolucion.getLibro());
            psm.setString(2, prestamoDevolucion.getEstudiante());
            psm.setDate(3, prestamoDevolucion.getFechaPrestamo());
            psm.setDate(4, prestamoDevolucion.getFechaDevolucion());
            psm.setInt(5, prestamoDevolucion.getCantidad());
            psm.setString(6, prestamoDevolucion.getEstado());
            psm.setString(7, prestamoDevolucion.getObservacion());

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
    public int updatePrestamo(PrestamoDevolucion prestamoDevolucion) {
        int resultado = 0;
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "UPDATE Prestamo_Devolucion SET FechaPrestamo = ?, FechaDevolucion = ?, Cantidad = ?, Estado = ?, Observacion = ? "
                    + "WHERE IDPrestamo = ?";

            psm = cn.prepareStatement(sql);
            psm.setDate(1, prestamoDevolucion.getFechaPrestamo());
            psm.setDate(2, prestamoDevolucion.getFechaDevolucion());
            psm.setInt(3, prestamoDevolucion.getCantidad());
            psm.setString(4, prestamoDevolucion.getEstado());
            psm.setString(5, prestamoDevolucion.getObservacion());
            psm.setInt(6, prestamoDevolucion.getIdPrestamo());

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
    public List<PrestamoDevolucion> listPrestamo() {
        List<PrestamoDevolucion> listPrestamos = new ArrayList<>();
        Connection cn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;

        try {
            cn = MySqlConexion.getConexion();
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
            """;

            psm = cn.prepareStatement(sql);
            rs = psm.executeQuery();

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
        }catch (SQLException e) {
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
	public void changeState(int idPrestamo, String nuevoEstado) {
	    Connection cn = null;
	    PreparedStatement psm = null;

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
		
	}
}
