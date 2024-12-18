package interfaces;

import java.util.List;

import entidades.Estudiante;

public interface EstudianteInterface {
		public int createLibro(Estudiante estudiante);
		public int updateLibro(Estudiante estudiante);
		public int deleteLibro(int id);
		public List<Estudiante> listEstudiante();
		public Estudiante getLibro(int id);

}
