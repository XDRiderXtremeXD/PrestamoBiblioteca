package interfaces;

import java.util.List;

import entidades.Estudiante;

public interface EstudianteInterface {
		public int createEstudiante(Estudiante estudiante);
		public int updateEstudiante(Estudiante estudiante);
		public int deleteEstudiante(int id);
		public List<Estudiante> listEstudiante(String filtro);
		public Estudiante getEstudiante(int id);

}
