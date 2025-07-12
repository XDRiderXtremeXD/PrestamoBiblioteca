package interfaces;

import java.util.List;

import entidades.Autor;

public interface AutoresInterface {
    public int createAutor(Autor autor);
    public int updateAutor(Autor autor);
    public int deleteAutor(int id);
    public List<Autor> listAutor(String filtro);
    public Autor getAutor(int id);
}