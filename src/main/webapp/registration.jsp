<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.security.SecureRandom, javax.crypto.spec.PBEKeySpec, javax.crypto.SecretKeyFactory, java.util.HexFormat, java.security.NoSuchAlgorithmException,
    java.security.spec.InvalidKeySpecException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id = "database" class = "beans.DatabaseBean" />
	<%!
		private byte[] generateSalt(int length) {
			byte[] salt = new byte[length];
			new SecureRandom().nextBytes(salt);
			return salt;
		}
	%>
	<%!
		private String hashPassword(String password, byte[] salt, int iterations, int key_size, String algorithm) throws NoSuchAlgorithmException, InvalidKeySpecException {
			PBEKeySpec keySpec = new PBEKeySpec(password.toCharArray(), salt, iterations, key_size);
			try{
				SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(algorithm);
				byte[] passwordBytes = keyFactory.generateSecret(keySpec).getEncoded();
				return HexFormat.of().withUpperCase().formatHex(passwordBytes);
			} finally {
				keySpec.clearPassword();
			}			
		}
	%>
	<%
		// Hashing parameters
		final int ITERATIONS = 600_000;
		final int SALT_LENGTH = 16; // Length in bytes; 128 bits
		final int HASH_LENGTH = 256; // Length in bits
		final String ALGORITHM = "PBKDF2WithHmacSHA256";
		
		// Sets all parameters to variables for ease of use
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String emailAddress = request.getParameter("emailAddress");
		String phoneNumber = request.getParameter("phoneNumber");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		
		// Verifies that all fields exist and are not blank
		if (firstName == null || firstName.isBlank() || lastName == null || lastName.isBlank() || emailAddress == null || emailAddress.isBlank() || 
			phoneNumber == null || phoneNumber.isBlank() || password == null || password.isBlank() || confirmPassword == null || confirmPassword.isBlank()) {
			out.print("Blanks or nulls<br>");
		}
		
		// Ensures the email address is valid (non-whitespace, @ non-whitespace, ., non-whitespace)
		if (!emailAddress.matches("^(\\S+)@(\\S+)[.](\\S+)")) {
			out.print("invalid email<br>");
		}
		
		// Trims all non-numeric characters from the phone number, but still allows them to be entered
		phoneNumber = phoneNumber.replaceAll("\\D", "");
		
		// Ensures that password is at least 8 characters, has a number, has a lowercase letter, has an uppercase letter, and has no whitespace
		if (password.length() < 8 || !password.matches("\\S*\\d\\S*") || !password.matches("\\S*[a-z]\\S*") || !password.matches("\\S*[A-Z]\\S*") || password.matches(".*\\s.*")) {
			out.print("invalid password<br>");
		}
		
		// Verifies that the password and password confirmation match
		if (!password.equals(confirmPassword)) {
			out.print("Password mismatch<br>");
		}
		
		byte[] salt = generateSalt(SALT_LENGTH);
		
		out.print("Salt: " + HexFormat.of().withUpperCase().formatHex(salt) + "<br>");
		out.print("Hash: " + hashPassword(password, salt, ITERATIONS, HASH_LENGTH, ALGORITHM) + "<br>");
		
		
		// Tries to connect to the database. Prints an error on failure
		if (database.connectToDatabase()) {
		
			// Verifies that the email is unique
			if(database.checkEmail(emailAddress)) {
				out.print("Duplicate email<br>");
			}
			
		} else {
			out.print("Connection failed<br>");
		}
		
	%>

	
	First Name: <%= firstName %><br>
	Last Name <%= lastName %><br>
	Email Address <%= emailAddress %><br>
	Phone <%= phoneNumber %><br>
	Password <%= password %><br>
	Confirm <%= confirmPassword %><br>

	
	
</body>
</html>