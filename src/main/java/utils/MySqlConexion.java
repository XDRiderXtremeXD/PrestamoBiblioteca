package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySqlConexion {
	public static Connection getConexion() {
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();

			// Variables de entorno (Railway o .env)
			String url = System.getenv("DB_URL");
			String user = System.getenv("DB_USER");
			String pass = System.getenv("DB_PASS");

			// Si no está en entorno (ej. local), usar valores por defecto
			if (url == null)   url   = "jdbc:mysql://localhost:3308/bookstudio_db?useSSL=false&useUnicode=true&characterEncoding=UTF-8&useTimezone=true&serverTimezone=UTC";
			if (user == null)  user = "root";
			if (pass == null)  pass = "1234";
			
			con = DriverManager.getConnection(url, user, pass);

		} catch (ClassNotFoundException e) {
			System.out.println("Error >> Driver no instalado: " + e.getMessage());
		} catch (SQLException e) {
			System.out.println("Error >> Conexión fallida: " + e.getMessage());
		} catch (Exception e) {
			System.out.println("Error >> General: " + e.getMessage());
		}
		return con;
	}
}
