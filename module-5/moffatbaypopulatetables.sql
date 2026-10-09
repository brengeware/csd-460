-- Brennan Cheatwood, Anthony Nguyen, and Daniel Preller, 10/07/26
-- GROUP A
-- CSD460 - Moffat Bay - Populate Tables
-- Updated to use hashed passwords that are based on the originals and to use digit-only phone numbers

USE CSD460;

-- USERS

INSERT INTO users (email, first_name, last_name, phone_number, password)
VALUES
('example@example.com', 'John', 'Goodman', '1234567890', 'DDDE7DFCE1BCE9A9E93A0DB4CC22232F:C063DE3A621AAAFA85718689A3CDA55DED2C818C2F2C88267A426424C0192576'), -- Password before hash: Password123
('anotherexample@example.com', 'Jane', 'Janeington', '9876543210', '5CBDC6C68EAC9867DE13FB81E3500277:AF3345FAE88B27834A87BAFAEF98F1474A1E017B1F6CB66C15B7CB6C45963C89'), -- Password before hash: Supersecurepassw0rd
('thirdexample@example.com', 'Bart', 'Johnsontonston', '5555555555', '7B0516E7C94B3480FF5A993DD400A316:23A152BDDE8027AB0FC3378F42159427F1920796ED898D238EE537511070F2AE'); -- Password before hash: ThisIsAWeakPa55word


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
