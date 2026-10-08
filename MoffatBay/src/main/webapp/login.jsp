<!-- Brennan Cheatwood, Anthony Nguyen, and Daniel Preller, 8 October 2026, Assignment 5
JSP page for user login form -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix = "navbar" uri = "WEB-INF/tlds/NavigationBarTld.tld" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Moffat Bay Login</title>
		<link rel="stylesheet" href="styles.css">
	</head>
	<body>
	<header>
		<navbar:NavigationBar />
	</header>
<%
	// Gets the email from a failed attempt (if any) so it can be put back in the field
	// Uses HTML escaping so a quote in the email cannot break out of the value attribute
	String loginEmail = (String) session.getAttribute("loginEmail");
	if (loginEmail == null) {
		loginEmail = "";
	}
	String safeEmail = loginEmail.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;");
	session.removeAttribute("loginEmail");
%>
		<h1 style="text-align: center;">Login</h1>

		<p style="text-align: center;">All fields are required.</p>
		<form action="loginCheck.jsp" method="POST" class="form-container">
			<div class="form-column">
				<div class="form-group">
					<label for="email">Email</label>
					<input type="email" id="email" name="email" value="<%= safeEmail %>" required>
				</div>
				<div class="form-group">
					<label for="password">Password</label>
					<input type="password" id="password" name="password" required>
				</div>
				<div class="form-group submit-group">
					<input type="submit" value="Login">
				</div>
			</div>
		</form>

<%
	// Prints the error message if it exists, then clears it so it only shows once
	if (session.getAttribute("loginErrorMessage") != null) {
%>
		<p style="text-align: center; color: red;"><%= session.getAttribute("loginErrorMessage") %></p>
<%
		session.removeAttribute("loginErrorMessage");
	}
%>

		<p style="text-align: center;">Don't have an account? <a href="register.jsp">Register here</a></p>

		<div style="text-align: center;">
			<button onclick="window.location.href='index.jsp';">
				Return
			</button>
		</div>

	</body>
</html>
