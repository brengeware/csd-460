-- Brennan Cheatwood 9/28/26
-- GROUP A
-- CSD460 - Moffat Bay - Create Tables
-- Creates the tables for the Moffat Bay database

CREATE DATABASE IF NOT EXISTS CSD460;
USE CSD460;

-- USERS TABLE

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- ROOM SIZES TABLE

CREATE TABLE room_sizes (
	size_id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	price DECIMAL(5, 2) NOT NULL
);

-- RESERVATIONS TABLE

CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    size_id INT NOT NULL,
    guest_count INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (size_id) REFERENCES room_sizes(size_id)
);