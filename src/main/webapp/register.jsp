<!-- Brennan Cheatwood, Anthony Nguyen, and Daniel Preller, 7 October 2026, Assignment 5
	JSP page for user registration form -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Your Account</title>
</head>
<body>
	<%
		// Creates an array of attributes for all fields
		String[] attributes = {"firstName", "lastName", "emailAddress", "phoneNumber", "password", "confirmPassword"};
		
		// Sets nonexistent attributes to empty strings to avoid populating with nulls
		for (String attribute : attributes) {
			if (session.getAttribute(attribute) == null) {
				session.setAttribute(attribute, "");
			}
		}
	%>
	<div>
		Create your account
		<!-- All fields are populated with their attributes if they exist (from returning with incorrect form) -->
		<form action = "registration.jsp" method = POST>
			<label for = firstName>First Name</label>
			<input type = text id = firstName name = firstName value = <%= session.getAttribute("firstName") %>>
			<label for = lastName>Last Name</label>
			<input type = text id = lastName name = lastName value = <%= session.getAttribute("lastName") %>>
			<label for = emailAddress>Email Address</label>
			<input type = email id = emailAddress name = emailAddress value = <%= session.getAttribute("emailAddress") %>>
			<label for = phoneNumber>Phone Number</label>
			<input type = tel id = phoneNumber name = phoneNumber value = <%= session.getAttribute("phoneNumber") %>>
			<label for = password)>Password  (Must be at least 8 characters long and contain at least 1 uppercase letter, 1 lowercase letter, and 1 number)</label>
			<input type = password id = password name = password value = <%= session.getAttribute("password") %>>
			<label for = confirmPassword>Confirm Password</label>
			<input type = password id = confirmPassword name = confirmPassword value = <%= session.getAttribute("confirmPassword") %>>
			<input type = button onclick = "location.href='index.jsp'" value = "Login with an existing account">
			<input type = submit value = "Register">
		</form>
		<%
			// Prints the error message if it exists
			if (session.getAttribute("registrationErrorMessage") != null) {
				out.print(session.getAttribute("registrationErrorMessage"));
				session.removeAttribute("registrationErrorMessage");
			}
		%>
		<%
			// Removes all attributes
			for (String attribute : attributes)	{
				session.removeAttribute(attribute);
			}
		%>
	</div>
</body>
</html>