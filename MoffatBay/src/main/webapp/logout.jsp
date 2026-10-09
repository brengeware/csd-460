<!-- Brennan Cheatwood, Anthony Nguyen, and Daniel Preller, 8 October 2026, Assignment 5
JSP for logging out. Ends the session and returns to the home page -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
	session.invalidate(); // Removes the username and everything else stored in the session
	response.sendRedirect("index.jsp");
%>
