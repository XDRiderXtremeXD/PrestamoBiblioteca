package interfaces;

import java.util.List;

import entidades.Editorial;

public interface EditorialesInterface {
    public int createEditorial(Editorial editorial);
    public int updateEditorial(Editorial editorial);
    public int deleteEditorial(int id);
    public List<Editorial> listEditorial(String filtro);
    public Editorial getEditorial(int id);
}