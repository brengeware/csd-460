<!-- Brennan Cheatwood, Anthony Nguyen, and Daniel Preller, 17 October 2026, Assignment 5
JSP page that shows the reservation confirmation -->
<%@ taglib prefix = "navbar" uri = "WEB-INF/tlds/NavigationBarTld.tld" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.math.BigDecimal, java.sql.ResultSet, java.sql.SQLException, java.time.LocalDate, java.time.temporal.ChronoUnit, java.util.List"%>
<jsp:useBean id = "database" class = "beans.DatabaseBean" />
<%!	// Escapes text so it cannot be read as HTML
	private String escape(String text) {
		return text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
	}
%>
<%
	// Only logged in users can see a confirmation
	if (!"True".equals(session.getAttribute("loggedIn")) || session.getAttribute("username") == null) {
		session.setAttribute("loginErrorMessage", "Please log in to view your reservation");
		response.sendRedirect("login.jsp");
		return;
	}

	// Without a recent booking there is nothing to show
	List<Integer> reservationIDs = (List<Integer>) session.getAttribute("reservationIDs");
	if (reservationIDs == null || reservationIDs.isEmpty()) {
		response.sendRedirect("reservation.jsp");
		return;
	}

	// Builds the table rows from the database, so the page shows what was actually saved
	StringBuilder rows = new StringBuilder();
	BigDecimal grandTotal = BigDecimal.ZERO;
	String errorMessage = null;

	if (database.connectToDatabase()) {
		try {
			int userID = database.getUserID((String) session.getAttribute("username"));

			for (int reservationID : reservationIDs) {
				ResultSet reservation = database.getReservationByID(reservationID, userID);
				LocalDate checkIn = reservation.getObject("check_in_date", LocalDate.class);
				LocalDate checkOut = reservation.getObject("check_out_date", LocalDate.class);
				long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
				BigDecimal price = reservation.getBigDecimal("price");
				BigDecimal subtotal = price.multiply(BigDecimal.valueOf(nights));
				grandTotal = grandTotal.add(subtotal);

				rows.append("<tr><td>" + reservation.getInt("reservation_id") + "</td>");
				rows.append("<td>" + escape(reservation.getString("name")) + "</td>");
				rows.append("<td>" + checkIn + "</td>");
				rows.append("<td>" + checkOut + "</td>");
				rows.append("<td>" + nights + "</td>");
				rows.append("<td>" + reservation.getInt("guest_count") + "</td>");
				rows.append("<td>" + String.format("$%,.2f", price) + "</td>");
				rows.append("<td>" + String.format("$%,.2f", subtotal) + "</td></tr>\n");
			}
		} catch (SQLException e) {
			errorMessage = "We could not load your reservation details";
		} finally {
			database.closeConnection();
		}
	} else {
		errorMessage = "Database connection failed";
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reservation Confirmed</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        .confirmation-table {
            border-collapse: collapse;
            margin: 20px auto;
            background: #fff;
        }

        .confirmation-table th, .confirmation-table td {
            border: 1px solid #ccc;
            padding: 8px 14px;
            text-align: center;
        }

        .confirmation-table th {
            background-color: #005f8a;
            color: white;
        }
    </style>
</head>
<body>
    <header>
        <navbar:NavigationBar />
    </header>

<div class="container">
<% if (errorMessage != null) { %>
    <h1>Something went wrong</h1>
    <p style="color: red;"><%= errorMessage %></p>
<% } else { %>
    <h1>Reservation Confirmed</h1>
    <p>Thank you for booking with Moffat Bay Resort. Your reservation details are below.</p>

    <table class="confirmation-table">
        <thead>
            <tr>
                <th>Reservation #</th>
                <th>Room</th>
                <th>Check In</th>
                <th>Check Out</th>
                <th>Nights</th>
                <th>Guests</th>
                <th>Price per Night</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
<%= rows %>
        </tbody>
    </table>

    <p><b>Total: <%= String.format("$%,.2f", grandTotal) %></b></p>
<% } %>
    <button onclick="window.location.href='reservation.jsp';">Book Another Room</button>
    <button onclick="window.location.href='cancelReservation.jsp'">Cancel Reservation</button>
    <button onclick="window.location.href='index.jsp';">Return Home</button>
</div>

</body>
</html>
