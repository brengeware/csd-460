/* Brennan Cheatwood, Anthony Nguyen, and Daniel Preller, 14 October 2026, Assignment 5
 * Bean for managing connection to the Moffat Bay Lodge database
 */
package beans;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;

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
	
	// Gets the stored password (salt:hash) for an email address
	// Returns null if there is no account with that email
	public String getStoredPassword(String email) throws SQLException {
		PreparedStatement preparedStatement = connection.prepareStatement("SELECT password FROM users WHERE email = ?");
		preparedStatement.setString(1, email);
		ResultSet results = preparedStatement.executeQuery();
		if (results.next()) {
			return results.getString("password");
		}
		return null;
	}

	// Gets the first name for an email address, used for the welcome message
	// Returns null if there is no account with that email
	public String getFirstName(String email) throws SQLException {
		PreparedStatement preparedStatement = connection.prepareStatement("SELECT first_name FROM users WHERE email = ?");
		preparedStatement.setString(1, email);
		ResultSet results = preparedStatement.executeQuery();
		if (results.next()) {
			return results.getString("first_name");
		}
		return null;
	}
	
	// Gets the user id for the associated email address
	// Email address is unique, so there will only be one id per email
	// Throws an exception if the email is not found
	public int getUserID (String email) throws SQLException {
		PreparedStatement preparedStatement = connection.prepareStatement("SELECT user_id FROM users WHERE email = ?");
		preparedStatement.setString(1, email);
		ResultSet results = preparedStatement.executeQuery();
		
		// Returns the user id, or throws an error if none is found
		if (results.next()) {
			return results.getInt("user_id");
		} else throw new SQLException("Email address not found");
	}
	
	// Returns a ResultSet containing all of the room IDs, intended for iteratively giving room information (i.e., dropdowns)
	public ResultSet getRoomIDs() throws SQLException {
		return statement.executeQuery("SELECT size_id FROM room_sizes");
	}
	
	// Gets all room information for the associated room ID
	// Throws an exception if the ID is not found
	// Returns the results as a result set that starts on the first result (instead of the default 0th result)
	public ResultSet getRoomByID(int roomID) throws SQLException {
		PreparedStatement preparedStatement = connection.prepareStatement("SELECT name, price FROM room_sizes WHERE size_id = ?");
		preparedStatement.setInt(1, roomID);
		ResultSet results = preparedStatement.executeQuery();
		
		// Returns the room information in a results set on the first (and only) result, or throws an error if none is found
		if (results.next()) {
			return results;
		} else {
			throw new SQLException("Room ID not found");
		}
	}

	// Inserts a user into the users table, returning true for a successful query and false otherwise
	public boolean createUser(String emailAddress, String firstName, String lastName, String phoneNumber, String password) {
		PreparedStatement preparedStatement;
		try {// Executes the insert query with a prepared statement
			preparedStatement = connection.prepareStatement("INSERT INTO users (email, first_name, last_name, phone_number, password) VALUES (?, ?, ?, ?, ?);");
			preparedStatement.setString(1, emailAddress);
			preparedStatement.setString(2, firstName);
			preparedStatement.setString(3, lastName);
			preparedStatement.setString(4, phoneNumber);
			preparedStatement.setString(5, password);
			int affectedRows = preparedStatement.executeUpdate();
			
			// Returns true if 1 row was affected (successful insert) or false otherwise
			if (affectedRows == 1) {
				return true;
			} else {
				return false;
			}
		} catch (SQLException e) {
			return false;
		}
	}
	
	// Inserts a reservation in the table, returning true for a successful query and false otherwise
	public boolean createReservation(int userID, int sizeID, int guests, LocalDate checkinDate, LocalDate checkoutDate) {
		PreparedStatement preparedStatement;
		try {// Executes the insert query with a prepared statement
			preparedStatement = connection.prepareStatement("INSERT INTO reservations (user_id, size_id, guest_count, check_in_date, check_out_date) VALUES (?, ?, ?, ?, ?)");
			preparedStatement.setInt(1, userID);
			preparedStatement.setInt(2, guests);
			preparedStatement.setInt(3, guests);
			preparedStatement.setObject(4, checkinDate);
			preparedStatement.setObject(5, checkoutDate);
			int affectedRows = preparedStatement.executeUpdate();
			
			// Returns true if exactly 1 row was affected (a successful insert) or false otherwise
			if (affectedRows == 1) {
				return true;
			} else {
				return false;
			}
		} catch (SQLException e) {
			return false;
		}
	}
}