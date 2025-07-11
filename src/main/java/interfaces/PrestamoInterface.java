package interfaces;

import java.util.List;

import entidades.PrestamoDevolucion;

public interface PrestamoInterface {
    public List<PrestamoDevolucion> listPrestamo(String filtro);
    public PrestamoDevolucion getPrestamo(int id);
    public int changeState(int idPrestamo, String nuevoEstado);
    public int updatePrestamo(PrestamoDevolucion prestamoDevolucion,int idLibro,int idEstudiante) ;
	int createPrestamo(PrestamoDevolucion prestamoDevolucion, int idLibro, int idEstudiante);
}