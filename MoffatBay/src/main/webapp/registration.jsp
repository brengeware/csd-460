<!-- Brennan Cheatwood, Anthony Nguyen, and Daniel Preller, 7 October 2026, Assignment 5
	JSP for verifying user registration and registering users -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.security.SecureRandom, javax.crypto.spec.PBEKeySpec, javax.crypto.SecretKeyFactory, java.util.HexFormat, java.security.NoSuchAlgorithmException,
    java.security.spec.InvalidKeySpecException, java.io.IOException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id = "database" class = "beans.DatabaseBean" />
	<%! // Generates a salt of the specified byte length
		private byte[] generateSalt(int length) {
			byte[] salt = new byte[length];
			new SecureRandom().nextBytes(salt); // Sets each byte in the array to a random value
			return salt;
		}
	%>
	<%! // Hashes a password
		private String hashPassword(String password, byte[] salt, int iterations, int key_size, String algorithm) throws NoSuchAlgorithmException, InvalidKeySpecException {
			PBEKeySpec keySpec = new PBEKeySpec(password.toCharArray(), salt, iterations, key_size); // Creates a key specification detailing the password, salt, iterations, and key size
			try{
				SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(algorithm);// Creates a key factory using the specified algorithm
				byte[] passwordBytes = keyFactory.generateSecret(keySpec).getEncoded();// Hashes the password
				return HexFormat.of().withUpperCase().formatHex(passwordBytes);// Converts hash to hexadecimal for storage
			} finally {
				keySpec.clearPassword();// Clears the copy of the password if hashing fails
			}			
		}
	%>
	<%!	// Returns to the registration page with an error message
		// This does not stop execution on its own and must be accompanied with a return statement
		private void returnWithError(HttpSession session, HttpServletRequest request, HttpServletResponse response,String errorMessage, String URL) throws IOException {
			session.setAttribute("registrationErrorMessage", errorMessage);// Adds the error message as an attribute
			
			// Saves all input as attributes so the user does not have to re-enter everything
			String[] attributes = {"firstName", "lastName", "emailAddress", "phoneNumber", "password", "confirmPassword"};
			for (String attribute : attributes)	{
				session.setAttribute(attribute, request.getParameter(attribute));
			}
			
			response.sendRedirect(URL);
	}
	%>
	<%
		// URL for registration page
		final String URL = "register.jsp";
		
		// Hashing parameters
		final int ITERATIONS = 600_000; // OWASP recommended number of iterations
		final int SALT_LENGTH = 16; // Length in bytes; 128 bits
		final int HASH_LENGTH = 256; // Length in bits
		final String ALGORITHM = "PBKDF2WithHmacSHA256";
		
		// Sets all request parameters to variables for ease of use
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String emailAddress = request.getParameter("emailAddress");
		String phoneNumber = request.getParameter("phoneNumber");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		
		// Verifies that all fields exist and are not blank
		if (firstName == null || firstName.isBlank() || lastName == null || lastName.isBlank() || emailAddress == null || emailAddress.isBlank() || 
			phoneNumber == null || phoneNumber.isBlank() || password == null || password.isBlank() || confirmPassword == null || confirmPassword.isBlank()) {
			returnWithError(session, request, response, "Please fill all fields", URL);
			return; // Ends execution
		}
		
		// Ensures the email address is valid (non-whitespace, @ non-whitespace, ., non-whitespace)
		if (!emailAddress.matches("^(\\S+)@(\\S+)[.](\\S+)")) {
			returnWithError(session, request, response, "Please enter a valid email address", URL);
			return;
		}
		
		// Trims all non-numeric characters from the phone number, but still allows them to be entered
		String trimmedPhoneNumber = phoneNumber.replaceAll("\\D", "");
		
		// Ensures that password is at least 8 characters, has a number, has a lowercase letter, has an uppercase letter, and has no whitespace
		if (password.length() < 8 || !password.matches("\\S*\\d\\S*") || !password.matches("\\S*[a-z]\\S*") || !password.matches("\\S*[A-Z]\\S*") || password.matches(".*\\s.*")) {
			returnWithError(session, request, response, "Please enter a valid password", URL);
			return;
		}
		
		// Verifies that the password and password confirmation match
		if (!password.equals(confirmPassword)) {
			returnWithError(session, request, response, "Passwords do not match", URL);
			return;
		}
		
		// Hashes the password and combines the salt and hash, separated with a colon
		byte[] salt = generateSalt(SALT_LENGTH);
		String hashedPassword = hashPassword(password, salt, ITERATIONS, HASH_LENGTH, ALGORITHM);
		String storedPassword = String.join(":", HexFormat.of().withUpperCase().formatHex(salt), hashedPassword);
		
		// Tries to connect to the database. Gives an error on failure
		if (database.connectToDatabase()) {
		
			// Verifies that the email is unique
			if(database.checkEmail(emailAddress)) {
				returnWithError(session, request, response, "There is already an account with this email address", URL);
				return;
			}
			
			// Attempts to add the user to the database, and saves the result
			boolean success = database.createUser(emailAddress, firstName, lastName, trimmedPhoneNumber, storedPassword);

			if (success) {// If successfully registered, logs the user in and redirects to the home page
				session.setAttribute("username", emailAddress);// Uses the entered email as the username to avoid unnecessary database queries
				session.setAttribute("firstName", firstName);// Sets the first name
				session.setAttribute("loggedIn", "True");// Logs the user in
				response.sendRedirect("index.jsp");
			} else {
				returnWithError(session, request, response, "An unknown error occurred", URL);
				return;
			}
			
		} else {
			returnWithError(session, request, response, "Database connection failed", URL);
			return;
		}
	%>	
</body>
</html>