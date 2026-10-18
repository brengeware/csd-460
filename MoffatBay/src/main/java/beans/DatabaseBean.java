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
import java.util.ArrayList;
import java.util.List;

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
			e.printStackTrace();
			return false;
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
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
			preparedStatement.setInt(2, sizeID);
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
	
	// Inserts one reservation for each room booked, splitting the guests between the rooms
	// (the reservations table has no room count column, so each room gets its own row)
	// Guests are split as evenly as possible; any extra guests go to the first rooms, so the total never changes
	// All rows are saved together or not at all
	// Returns the new reservation IDs, or an empty list if anything went wrong
	public List<Integer> createReservations(int userID, int sizeID, int guests, int rooms, LocalDate checkinDate, LocalDate checkoutDate) {
		List<Integer> reservationIDs = new ArrayList<Integer>();
		
		// Needs at least one room, and at least one guest in each room
		if (rooms < 1 || guests < rooms) {
			return reservationIDs;
		}
		
		try {
			connection.setAutoCommit(false); // Starts a transaction
			PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO reservations (user_id, size_id, guest_count, check_in_date, check_out_date) VALUES (?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
			int guestsPerRoom = guests / rooms;
			int extraGuests = guests % rooms;
			
			for (int room = 0; room < rooms; room++) {
				preparedStatement.setInt(1, userID);
				preparedStatement.setInt(2, sizeID);
				preparedStatement.setInt(3, guestsPerRoom + (room < extraGuests ? 1 : 0));
				preparedStatement.setObject(4, checkinDate);
				preparedStatement.setObject(5, checkoutDate);
				preparedStatement.executeUpdate();
				
				// Saves the auto-generated reservation ID
				ResultSet keys = preparedStatement.getGeneratedKeys();
				if (keys.next()) {
					reservationIDs.add(keys.getInt(1));
				}
			}
			
			connection.commit();
			connection.setAutoCommit(true);
			return reservationIDs;
		} catch (SQLException e) {
			try {// Undoes any rows already inserted
				connection.rollback();
				connection.setAutoCommit(true);
			} catch (SQLException rollbackError) {
				// Nothing else can be done if the rollback fails
			}
			return new ArrayList<Integer>();
		}
	}
	
	// Gets one reservation, with its room name and price, for the confirmation page
	// The user ID is checked too, so a user can only see their own reservations
	// Throws an exception if there is no matching reservation
	// Returns the results as a result set that starts on the first result, like getRoomByID
	public ResultSet getReservationByID(int reservationID, int userID) throws SQLException {
		PreparedStatement preparedStatement = connection.prepareStatement("SELECT r.reservation_id, r.guest_count, r.check_in_date, r.check_out_date, s.name, s.price FROM reservations r JOIN room_sizes s ON r.size_id = s.size_id WHERE r.reservation_id = ? AND r.user_id = ?");
		preparedStatement.setInt(1, reservationID);
		preparedStatement.setInt(2, userID);
		ResultSet results = preparedStatement.executeQuery();
		
		if (results.next()) {
			return results;
		} else {
			throw new SQLException("Reservation not found");
		}
	}
	
	// Gets every reservation for a user, with room names and prices, for the "view your reservations" page
	// Returns the results as a result set that has not been started yet, so loop through it with next()
	// If the user has no reservations, the result set is just empty
	public ResultSet getReservationsByUser(int userID) throws SQLException {
		PreparedStatement preparedStatement = connection.prepareStatement("SELECT r.reservation_id, r.guest_count, r.check_in_date, r.check_out_date, s.name, s.price FROM reservations r JOIN room_sizes s ON r.size_id = s.size_id WHERE r.user_id = ? ORDER BY r.check_in_date, r.reservation_id");
		preparedStatement.setInt(1, userID);
		return preparedStatement.executeQuery();
	}
	
	// Closes the database connection. Pages should call this when they are done with the bean
	public void closeConnection() {
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
			// Nothing else can be done if closing fails
		}
	}
}
