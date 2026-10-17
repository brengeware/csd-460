<!-- Brennan Cheatwood, Anthony Nguyen, and Daniel Preller, 7 October 2026, Assignment 5
JSP page for user registration form -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix = "navbar" uri = "WEB-INF/tlds/NavigationBarTld.tld" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Create Your Account</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
	<header>
		<navbar:NavigationBar />
	</header>
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

<h1 style="text-align: center;">Create your account</h1>
<p style="text-align: center;">All fields are required.</p>
  <!-- All fields are populated with their attributes if they exist (from returning with incorrect form) -->

<form action = "registration.jsp" method = POST class = "form-container">

  <div class = "form-column">

    <div class = "form-group">
    <label for = firstName>First Name</label>
    <input type = text id = firstName name = firstName value = <%= session.getAttribute("firstName") %>>
    </div>

    <div class = "form-group">
    <label for = emailAddress>Email Address</label>
    <input type = email id = emailAddress name = emailAddress value = <%= session.getAttribute("emailAddress") %>>
    </div>

    <div class = "form-group">
      <label for = password)>Password (Minimum 8 characters, at least 1 uppercase letter, 1 lowercase letter, and 1 number)</label>
      <input type = password id = password name = password value = <%= session.getAttribute("password") %>>
    </div>

    <div class = "form-group">
      <input type = button onclick = "location.href='login.jsp'" value = "Login with an existing account">
    </div>

  </div>

  <div class = "form-column">

    <div class = "form-group">
      <label for = lastName>Last Name</label>
      <input type = text id = lastName name = lastName value = <%= session.getAttribute("lastName") %>>
    </div>

    <div class = "form-group">
    <label for = phoneNumber>Phone Number</label>
    <input type = tel id = phoneNumber name = phoneNumber value = <%= session.getAttribute("phoneNumber") %>>
    </div>

    <div class = "form-group">
    <label for = confirmPassword>Confirm Password<br>(Must match Password)<br>   </label>
    <input type = password id = confirmPassword name = confirmPassword value = <%= session.getAttribute("confirmPassword") %>>
    </div>

    <div class = "form-group">
    <input type = submit value = "Register">
   </div>
  </div>
  <div style="flex-basis: 100%; height = 0; text-align: center;"><!-- Used to hold the error message -->
  <%
    // Prints the error message if it exists
    if (session.getAttribute("registrationErrorMessage") != null) {
      out.print(session.getAttribute("registrationErrorMessage"));
      session.removeAttribute("registrationErrorMessage");
      // Removes all remaining attributes
      for (String attribute : attributes)	{
        session.removeAttribute(attribute);
    	}
    }
  %>
  </div>
</form>

<div style="text-align: center;">
  <button onclick="window.location.href='index.jsp';">
    Return
  </button>
</div>

</body>
</html>