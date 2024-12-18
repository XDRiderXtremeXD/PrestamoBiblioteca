package interfaces;

import java.util.List;

import entidades.PrestamoDevolucion;

public interface PrestamoInterface {
    public int createPrestamo(PrestamoDevolucion prestamo);
    public int updatePrestamo(PrestamoDevolucion prestamo);
    public List<PrestamoDevolucion> listPrestamo();
    public PrestamoDevolucion getPrestamo(int id);
    public void changeState(int idPrestamo, String nuevoEstado);
}