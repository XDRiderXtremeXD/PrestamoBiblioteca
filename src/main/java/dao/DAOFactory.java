package dao;

import interfaces.AuthInterface;
import interfaces.SessionInterface;

public abstract class DAOFactory {
	public static final int MYSQL = 1;
	public static final int SQLSERVER=2;
	public static final int ORACLE=3;
	
	public abstract AuthInterface getAuth();
	public abstract SessionInterface getSession();
	
	public static DAOFactory getDaoFactory(int tipo) {
		switch (tipo) {
		case MYSQL:
			return new MySqlDAOFactory();
		case ORACLE:
			return null;
		default:
			return null;
		}
	}
}
