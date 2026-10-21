<!-- Brennan Cheatwood, anthony Nguyen, and Daniel Preller, 21 October 2026, Assignment 7
	JSP for canceling the user's last reservation -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Canceling your reservation</title>
</head>
<body>
	<jsp:useBean id = "database" class = "beans.DatabaseBean" />
	<%
		// Redirects the user to the login page if not signed in
		if (!session.getAttribute("loggedIn").equals("True") || session.getAttribute("username") == null) {
			session.setAttribute("loginErrorMessage", "Please login before canceling a reservation");
			response.sendRedirect("login.jsp");
			return;
		}
		
		// Gets the reservation IDs from the session
		List<Integer> reservationIDs = (List<Integer>) session.getAttribute("reservationIDs");
		if (reservationIDs == null || reservationIDs.isEmpty()) {
			response.sendRedirect("reservationConfirmation.jsp");
			return;
		}
		
		// Removes the reservations and redirects to the reservation page
		if (database.connectToDatabase()) {
			for (int id: reservationIDs) {
				database.deleteReservationByID(id);
			}
			session.removeAttribute("reservationIDs");
			response.sendRedirect("reservation.jsp");
		} else {// Returns to the confirmation page if something fails
			response.sendRedirect("reservationConfirmation.jsp");
			return;
		}
		
	%>
</body>
</html>