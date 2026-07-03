# Hotel Booking System

A MySQL database project for managing hotels, rooms, customers, and bookings — with queries for availability checks, booking history, revenue, and seasonal demand.

## Schema

| Table | Description |
|---|---|
| `Hotels` | Hotel ID, name, location |
| `Rooms` | Room ID, type, price per night, linked to a hotel |
| `Customers` | Customer ID, name, phone |
| `Bookings` | Room + customer, check-in/check-out dates, total amount |

Includes a `CHECK` constraint ensuring `check_out` is always after `check_in`, plus indexes on `Bookings(room_id)` and `Bookings(check_in, check_out)` for faster availability lookups.

## Sample Queries Included

- **Room availability** — rooms not booked for a given date
- **Booking history** — full customer/hotel/room/date breakdown
- **Revenue per hotel**
- **Peak season analysis** — bookings grouped by month
- **Transactional booking insert** wrapped in `START TRANSACTION` / `COMMIT`

## Tech Stack

- MySQL

## How to Run

1. Open a MySQL client (MySQL Workbench, phpMyAdmin, or the CLI).
2. Run the script:
   ```sql
   SOURCE hotel_booking_system.sql;
   ```
   This creates the `hotel_db` database, builds the tables, seeds sample data, and runs the included reporting queries.

## Future Improvements

- Add a frontend/API layer for browsing rooms and making bookings
- Add payment tracking and cancellation handling
