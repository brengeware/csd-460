<!-- Brennan Cheatwood, Anthony Nguyen, and Daniel Preller, 8 October 2026, Assignment 5
	JSP for verifying user login credentials -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="javax.crypto.spec.PBEKeySpec, javax.crypto.SecretKeyFactory, java.util.HexFormat, java.security.MessageDigest, java.security.NoSuchAlgorithmException,
    java.security.spec.InvalidKeySpecException, java.io.IOException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logging in</title>
</head>
<body>
	<jsp:useBean id = "database" class = "beans.DatabaseBean" />
	<%! // Hashes a password with the given salt. This must use the same settings as registration.jsp or the hashes will never match
		private byte[] hashPassword(String password, byte[] salt, int iterations, int key_size, String algorithm) throws NoSuchAlgorithmException, InvalidKeySpecException {
			PBEKeySpec keySpec = new PBEKeySpec(password.toCharArray(), salt, iterations, key_size);
			try {
				SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(algorithm);
				return keyFactory.generateSecret(keySpec).getEncoded();
			} finally {
				keySpec.clearPassword();
			}
		}
	%>
	<%!	// Returns to the login page with an error message
		// This does not stop execution on its own and must be accompanied with a return statement
		private void returnWithError(HttpSession session, HttpServletRequest request, HttpServletResponse response, String errorMessage) throws IOException {
			session.setAttribute("loginErrorMessage", errorMessage);
			session.setAttribute("loginEmail", request.getParameter("email")); // Keeps the email so the user only retypes the password
			response.sendRedirect("login.jsp");
		}
	%>
	<%
		// Hashing parameters (same as registration.jsp)
		final int ITERATIONS = 600_000;
		final int HASH_LENGTH = 256;
		final String ALGORITHM = "PBKDF2WithHmacSHA256";

		// One generic message for every failure so the page does not reveal which emails have accounts
		final String BAD_LOGIN = "Incorrect email or password";

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		// Verifies that both fields exist and are not blank
		if (email == null || email.isBlank() || password == null || password.isBlank()) {
			returnWithError(session, request, response, "Please fill all fields");
			return;
		}

		// Tries to connect to the database. Gives an error on failure
		if (!database.connectToDatabase()) {
			returnWithError(session, request, response, "Database connection failed");
			return;
		}

		// Looks up the stored value, which is saved as salt:hash in hexadecimal
		String storedPassword = database.getStoredPassword(email);
		if (storedPassword == null) {
			returnWithError(session, request, response, BAD_LOGIN);
			return;
		}

		String[] parts = storedPassword.split(":");
		if (parts.length != 2) {
			returnWithError(session, request, response, BAD_LOGIN);
			return;
		}

		// Hashes the entered password with the stored salt and compares it to the stored hash
		byte[] salt = HexFormat.of().parseHex(parts[0]);
		byte[] storedHash = HexFormat.of().parseHex(parts[1]);
		byte[] enteredHash = hashPassword(password, salt, ITERATIONS, HASH_LENGTH, ALGORITHM);

		// MessageDigest.isEqual compares in constant time, unlike equals()
		if (MessageDigest.isEqual(storedHash, enteredHash)) {
			request.changeSessionId(); // New session ID after login to prevent session fixation
			session.setAttribute("username", email); // Same attribute registration.jsp uses
			session.setAttribute("firstName", database.getFirstName(email)); // Not "firstName", since register.jsp uses and clears that one
			session.setAttribute("loggedIn", "True");
			session.removeAttribute("loginErrorMessage");
			session.removeAttribute("loginEmail");
			response.sendRedirect("index.jsp");
		} else {
			returnWithError(session, request, response, BAD_LOGIN);
			return;
		}
	%>
</body>
</html>
