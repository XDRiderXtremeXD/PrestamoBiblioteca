package interfaces;

import entidades.Perfil;

public interface AuthInterface {
	public Perfil verificarInicioSesion(String correo,String clave);
}
