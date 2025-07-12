package interfaces;

import java.util.List;

import entidades.Curso;

public interface CursosInterface {
    public int createCurso(Curso curso);
    public int updateCurso(Curso curso);
    public int deleteCurso(int id);
    public List<Curso> listCurso(String filtro) ;
    public Curso getCurso(int id);
}
