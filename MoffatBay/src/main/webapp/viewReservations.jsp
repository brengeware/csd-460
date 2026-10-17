<!-- Brennan Cheatwood, Anthony Nguyen, and Daniel Preller, 17 October 2026, Assignment 5
JSP page that shows all of the logged in user's reservations -->
<%@ taglib prefix = "navbar" uri = "WEB-INF/tlds/NavigationBarTld.tld" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.math.BigDecimal, java.sql.ResultSet, java.sql.SQLException, java.time.LocalDate, java.time.temporal.ChronoUnit"%>
<jsp:useBean id = "database" class = "beans.DatabaseBean" />
<%!	// Escapes text so it cannot be read as HTML
	private String escape(String text) {
		return text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
	}
%>
<%
	// Only logged in users have reservations to view. Sends everyone else to log in first and brings them back afterward
	if (!"True".equals(session.getAttribute("loggedIn")) || session.getAttribute("username") == null) {
		session.setAttribute("loginRedirect", "viewReservations.jsp");
		session.setAttribute("loginErrorMessage", "Please log in to view your reservations");
		response.sendRedirect("login.jsp");
		return;
	}
	
	// Builds the table rows from the database
	StringBuilder rows = new StringBuilder();
	int count = 0;
	String errorMessage = null;
	
	if (database.connectToDatabase()) {
		try {
			int userID = database.getUserID((String) session.getAttribute("username"));
			ResultSet reservations = database.getReservationsByUser(userID);
			
			while (reservations.next()) {
				LocalDate checkIn = reservations.getObject("check_in_date", LocalDate.class);
				LocalDate checkOut = reservations.getObject("check_out_date", LocalDate.class);
				long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
				BigDecimal price = reservations.getBigDecimal("price");
				BigDecimal total = price.multiply(BigDecimal.valueOf(nights));
				count++;
				
				rows.append("<tr><td>" + reservations.getInt("reservation_id") + "</td>");
				rows.append("<td>" + escape(reservations.getString("name")) + "</td>");
				rows.append("<td>" + checkIn + "</td>");
				rows.append("<td>" + checkOut + "</td>");
				rows.append("<td>" + nights + "</td>");
				rows.append("<td>" + reservations.getInt("guest_count") + "</td>");
				rows.append("<td>" + String.format("$%,.2f", total) + "</td></tr>\n");
			}
		} catch (SQLException e) {
			errorMessage = "We could not load your reservations";
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
    <title>Your Reservations</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        .reservation-table {
            border-collapse: collapse;
            margin: 20px auto;
            background: #fff;
        }

        .reservation-table th, .reservation-table td {
            border: 1px solid #ccc;
            padding: 8px 14px;
            text-align: center;
        }

        .reservation-table th {
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
    <h1>Your Reservations</h1>
<% if (errorMessage != null) { %>
    <p style="color: red;"><%= errorMessage %></p>
<% } else if (count == 0) { %>
    <p>You do not have any reservations yet.</p>
<% } else { %>
    <table class="reservation-table">
        <thead>
            <tr>
                <th>Reservation #</th>
                <th>Room</th>
                <th>Check In</th>
                <th>Check Out</th>
                <th>Nights</th>
                <th>Guests</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
<%= rows %>
        </tbody>
    </table>
<% } %>
    <button onclick="window.location.href='reservation.jsp';">Book a Room</button>
    <button onclick="window.location.href='index.jsp';">Return Home</button>
</div>

</body>
</html>
