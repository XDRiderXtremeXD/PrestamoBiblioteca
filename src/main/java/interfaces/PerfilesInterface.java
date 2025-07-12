package interfaces;

import java.util.List;

import entidades.Perfil;

public interface PerfilesInterface {
    public int createPerfil(Perfil perfil);
    public int updatePerfil(Perfil perfil);
    public int deletePerfil(int id);
    public List<Perfil>  listPerfil(String filtro);
    public Perfil getPerfil(int id);
}
