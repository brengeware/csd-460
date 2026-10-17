-- moffatBayRoomSizes.sql
-- CSD460 - Moffat Bay Lodge Database
-- Makes the room_sizes table match the four rooms on the reservation page.
-- The size_id numbers must stay 1 to 4: the Select buttons on reservation.jsp send these numbers.
-- Safe to run on an empty table or on one that already has sample rows.

USE CSD460;

INSERT INTO room_sizes (size_id, name, price)
VALUES
(1, '2 Double Beds', 120.00),
(2, '1 Queen Bed', 135.00),
(3, '2 Queen Beds', 150.00),
(4, '1 King Bed', 160.00)
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price);
