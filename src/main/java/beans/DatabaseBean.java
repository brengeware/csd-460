package beans;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseBean implements Serializable {
	
	private String database;
	private String username;
	private String password;
	private Connection connection;
	private Statement statement;
	
	// Default no-arg constructor
	public DatabaseBean() {
		this("csd460", "MoffatBayUser", "MoffatBayPassword");
	}
	
	// Constructor for all manual fields
	public DatabaseBean(String database, String username, String password) {
		this.database = database;
		this.username = username;
		this.password = password;
	}
	
	// Set methods
	public void setDatabase(String database) {
		this.database = database;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	// Get methods
	public String getDatabase() {
		return database;
	}
	
	public String getUsername() {
		return username;
	}
	
	public String getPassword() {
		return password;
	}
	
	// Connects to the database, creating a connection and a statement
	// returns true if connected and false otherwise
	public boolean connectToDatabase() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost", username, password);
			statement = connection.createStatement();
			statement.executeUpdate("USE " + database);
			return true;
		} catch(SQLException e) {
			return false;
		} catch(ClassNotFoundException e) {
			return false;
		}
	}
	
	// Checks whether an email address is in the database and returns the result as a boolean
	public boolean checkEmail(String email) throws SQLException {
		PreparedStatement preparedStatement = connection.prepareStatement("SELECT user_id FROM users WHERE email = ?");
		preparedStatement.setString(1, email);
		ResultSet results = preparedStatement.executeQuery();
		return results.next();
	}
}