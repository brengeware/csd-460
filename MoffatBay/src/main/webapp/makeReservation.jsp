<!-- Brennan Cheatwood, Anthony Nguyen, and Daniel Preller, 17 October 2026, Assignment 5
	JSP for verifying reservation requests and saving reservations -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.time.LocalDate, java.time.format.DateTimeParseException, java.util.List, java.sql.SQLException, java.io.IOException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booking your reservation</title>
</head>
<body>
	<jsp:useBean id = "database" class = "beans.DatabaseBean" />
	<%!	// Returns to the reservation page with an error message
		// This does not stop execution on its own and must be accompanied with a return statement
		private void returnWithError(HttpSession session, HttpServletRequest request, HttpServletResponse response, String errorMessage) throws IOException {
			session.setAttribute("reservationErrorMessage", errorMessage);

			// Saves the input so the user does not have to re-enter everything
			session.setAttribute("resStartDate", request.getParameter("start_date"));
			session.setAttribute("resEndDate", request.getParameter("end_date"));
			session.setAttribute("resRooms", request.getParameter("num1"));
			session.setAttribute("resGuests", request.getParameter("num2"));

			response.sendRedirect("reservation.jsp");
		}
	%>
	<%
		// Only logged in users can book. Sends everyone else to log in first and brings them back afterward
		if (!"True".equals(session.getAttribute("loggedIn")) || session.getAttribute("username") == null) {
			session.setAttribute("loginRedirect", "reservation.jsp");
			session.setAttribute("loginErrorMessage", "Please log in to book a reservation");
			response.sendRedirect("login.jsp");
			return;
		}

		// This page only handles the submitted form
		if (!"POST".equals(request.getMethod())) {
			response.sendRedirect("reservation.jsp");
			return;
		}

		// Sets all request parameters to variables for ease of use
		String startDate = request.getParameter("start_date");
		String endDate = request.getParameter("end_date");
		String roomsText = request.getParameter("num1");
		String guestsText = request.getParameter("num2");
		String sizeText = request.getParameter("sizeId"); // Comes from the Select button that was clicked

		// Verifies that all fields exist and are not blank
		if (startDate == null || startDate.isBlank() || endDate == null || endDate.isBlank() || roomsText == null || roomsText.isBlank() ||
			guestsText == null || guestsText.isBlank()) {
			returnWithError(session, request, response, "Please fill in the dates, the number of rooms, and the number of guests");
			return;
		}
		if (sizeText == null || sizeText.isBlank()) {
			returnWithError(session, request, response, "Please click Select on the room you want to book");
			return;
		}

		// Converts the numbers. The form only allows numbers, but anyone can send a request without the form
		int rooms, guests, sizeID;
		try {
			rooms = Integer.parseInt(roomsText.trim());
			guests = Integer.parseInt(guestsText.trim());
			sizeID = Integer.parseInt(sizeText.trim());
		} catch (NumberFormatException e) {
			returnWithError(session, request, response, "Please enter whole numbers for rooms and guests");
			return;
		}

		if (rooms < 1 || rooms > 99) {
			returnWithError(session, request, response, "Please book between 1 and 99 rooms");
			return;
		}
		if (guests < 1 || guests > 99) {
			returnWithError(session, request, response, "Please enter between 1 and 99 guests");
			return;
		}
		if (guests < rooms) {
			returnWithError(session, request, response, "There must be at least one guest for each room");
			return;
		}

		// Converts the dates (the date input sends them as yyyy-mm-dd)
		LocalDate checkIn, checkOut;
		try {
			checkIn = LocalDate.parse(startDate);
			checkOut = LocalDate.parse(endDate);
		} catch (DateTimeParseException e) {
			returnWithError(session, request, response, "Please enter valid dates");
			return;
		}

		if (checkIn.isBefore(LocalDate.now())) {
			returnWithError(session, request, response, "The check in date cannot be in the past");
			return;
		}
		if (!checkOut.isAfter(checkIn)) {
			returnWithError(session, request, response, "The check out date must be after the check in date");
			return;
		}

		// Tries to connect to the database. Gives an error on failure
		if (!database.connectToDatabase()) {
			returnWithError(session, request, response, "Database connection failed");
			return;
		}

		try {
			int userID = database.getUserID((String) session.getAttribute("username"));
			database.getRoomByID(sizeID); // Throws an exception if the room does not exist

			// Saves the reservation and gets back the new reservation IDs
			List<Integer> reservationIDs = database.createReservations(userID, sizeID, guests, rooms, checkIn, checkOut);

			if (reservationIDs.isEmpty()) {
				returnWithError(session, request, response, "An unknown error occurred");
				return;
			}

			// Booked. Clears the saved form input and shows the confirmation page
			session.removeAttribute("resStartDate");
			session.removeAttribute("resEndDate");
			session.removeAttribute("resRooms");
			session.removeAttribute("resGuests");
			session.setAttribute("reservationIDs", reservationIDs);
			response.sendRedirect("reservationConfirmation.jsp");
		} catch (SQLException e) {
			returnWithError(session, request, response, "That room or account could not be found");
			return;
		} finally {
			database.closeConnection();
		}
	%>
</body>
</html>
