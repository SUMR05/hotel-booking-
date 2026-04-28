drop database hotel_db;
CREATE DATABASE hotel_db;
USE hotel_db;
CREATE TABLE Hotels (
hotel_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100),
location VARCHAR(100)
);
CREATE TABLE Rooms (
room_id INT PRIMARY KEY AUTO_INCREMENT,
hotel_id INT,
room_type VARCHAR(50),
price_per_night DECIMAL(10,2),
FOREIGN KEY (hotel_id) REFERENCES Hotels(hotel_id)
);
CREATE TABLE Customers (
customer_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100),
phone VARCHAR(15)
);
CREATE TABLE Bookings (
booking_id INT PRIMARY KEY AUTO_INCREMENT,
room_id INT,
customer_id INT,
check_in DATE,
check_out DATE,
total_amount DECIMAL(10,2),
FOREIGN KEY (room_id) REFERENCES Rooms(room_id),
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
INSERT INTO Hotels (name, location) VALUES
('Taj Hotel','Hyderabad'),
('ITC Hotel','Chennai');
INSERT INTO Rooms (hotel_id, room_type, price_per_night) VALUES
(1,'Single',2000),
(1,'Double',3500),
(2,'Deluxe',5000);
INSERT INTO Customers (name, phone) VALUES
('Ravi','9999999999'),
('Anjali','8888888888');
INSERT INTO Bookings (room_id, customer_id, check_in, check_out, total_amount) VALUES
(1,1,'2026-04-10','2026-04-12',4000),
(2,2,'2026-04-11','2026-04-13',7000);
-- check room availability
SELECT r.room_id, h.name AS hotel, r.room_type
FROM Rooms r
JOIN Hotels h ON r.hotel_id = h.hotel_id
WHERE r.room_id NOT IN (
SELECT room_id FROM Bookings
WHERE '2026-04-11' BETWEEN check_in AND check_out
);
-- booking history
SELECT c.name, h.name AS hotel, r.room_type, b.check_in, b.check_out
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Rooms r ON b.room_id = r.room_id
JOIN Hotels h ON r.hotel_id = h.hotel_id;
-- revenue per hostel
SELECT h.name, SUM(b.total_amount) AS revenue
FROM Hotels h
JOIN Rooms r ON h.hotel_id = r.hotel_id
JOIN Bookings b ON r.room_id = b.room_id
GROUP BY h.hotel_id;
-- peak season anlysis
SELECT MONTH(check_in) AS month, COUNT(*) AS total_bookings
FROM Bookings
GROUP BY MONTH(check_in)
ORDER BY total_bookings DESC;
-- constraints 
ALTER TABLE Bookings
ADD CONSTRAINT chk_dates CHECK (check_out > check_in);
-- booking process
START TRANSACTION;
INSERT INTO Bookings (room_id, customer_id, check_in, check_out, total_amount)
VALUES (1,2,'2026-04-15','2026-04-17',4000);
COMMIT;
-- indexing
CREATE INDEX idx_room ON Bookings(room_id);
CREATE INDEX idx_dates ON Bookings(check_in, check_out);