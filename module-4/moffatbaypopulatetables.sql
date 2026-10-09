-- Brennan Cheatwood 9/28/26
-- GROUP A
-- CSD460 - Moffat Bay - Populate Tables

USE CSD460;

-- USERS

INSERT INTO users (email, first_name, last_name, phone_number, password)
VALUES
('example@example.com', 'John', 'Goodman', '123-456-7890', 'password123'),
('anotherexample@example.com', 'Jane', 'Janeington', '987-654-3210', 'supersecurepassword'),
('thirdexample@example.com', 'Bart', 'Johnsontonston', '555-555-5555', 'thisisaweakpassword');


-- ROOM SIZES

INSERT INTO room_sizes (name, price)
VALUES
('Double full beds', 120.00),
('Queen', 135.00),
('Double queen beds', 150.00),
('King', 160.00);


-- RESERVATIONS
INSERT INTO reservations (user_id, size_id, guest_count, check_in_date, check_out_date)
VALUES
(1, 1, 2, '2026-10-01', '2026-10-05'),
(2, 2, 4, '2026-10-10', '2026-10-15'),
(3, 3, 6, '2026-10-20', '2026-10-25');
