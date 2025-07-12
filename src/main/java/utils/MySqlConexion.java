package utils;
import io.github.cdimascio.dotenv.Dotenv;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySqlConexion {
	public static Connection getConexion() {
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();

			// Si Railway define las variables, se usan directamente.
			String url = System.getenv("DB_URL");
			String user = System.getenv("DB_USER");
			String pass = System.getenv("DB_PASS");

			// Si no existen (en entorno local), intenta cargarlas desde .env
			if (url == null || user == null || pass == null) {
			    try {
			        Dotenv dotenv = Dotenv.load();
			        if (url == null) url = dotenv.get("DB_URL");
			        if (user == null) user = dotenv.get("DB_USER");
			        if (pass == null) pass = dotenv.get("DB_PASS");
			    } catch (Exception e) {
			        System.out.println("Error cargando .env: " + e.getMessage());
			    }
			}			
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
