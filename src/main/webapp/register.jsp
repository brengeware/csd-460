<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Your Account</title>
</head>
<body>
	<div>
		Create your account
		<form action = "registration.jsp" method = POST>
			<label for = firstName>First Name</label>
			<input type = text id = firstName name = firstName>
			<label for = lastName>Last Name</label>
			<input type = text id = lastName name = lastName>
			<label for = emailAddress>Email Address</label>
			<input type = email id = emailAddress name = emailAddress>
			<label for = phoneNumber>Phone Number</label>
			<input type = tel id = phoneNumber name = phoneNumber>
			<label for = password>Password</label>
			<input type = password id = password name = password>
			<label for = confirmPassword>Confirm Password</label>
			<input type = password id = confirmPassword name = confirmPassword>
			<input type = button onclick = "location.href='index.jsp'" value = "Login with an existing account">
			<input type = submit value = "Register">
		</form>
	</div>
</body>
</html>