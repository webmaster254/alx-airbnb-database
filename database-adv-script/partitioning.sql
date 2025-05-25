-- Table Partitioning Implementation for Booking Table
-- This script implements partitioning on the Booking table based on start_date
-- to improve query performance on large datasets

-- Step 1: Create a new partitioned table with the same structure as the original Booking table
CREATE TABLE Booking_Partitioned (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p_2023 VALUES LESS THAN (2024),
    PARTITION p_2024 VALUES LESS THAN (2025),
    PARTITION p_2025 VALUES LESS THAN (2026),
    PARTITION p_2026 VALUES LESS THAN (2027),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Step 2: Create indexes on the partitioned table
-- These indexes will be local to each partition, improving performance
CREATE INDEX idx_booking_part_property_id ON Booking_Partitioned(property_id);
CREATE INDEX idx_booking_part_user_id ON Booking_Partitioned(user_id);
CREATE INDEX idx_booking_part_dates ON Booking_Partitioned(start_date, end_date);
CREATE INDEX idx_booking_part_status ON Booking_Partitioned(status);

-- Step 3: Migrate data from the original table to the partitioned table
-- This would be executed after creating the partitioned table
INSERT INTO Booking_Partitioned
SELECT * FROM Booking;

-- Step 4: Rename tables to replace the original with the partitioned version
-- In a production environment, this would be done during a maintenance window
-- RENAME TABLE Booking TO Booking_Old, Booking_Partitioned TO Booking;

-- Example query to test partition pruning
-- This query will only scan the 2023 partition instead of the entire table
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name AS guest_first_name,
    u.last_name AS guest_last_name,
    p.name AS property_name,
    p.location AS property_location
FROM 
    Booking_Partitioned b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
WHERE 
    b.start_date BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY 
    b.start_date;

-- Example query for another partition
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name AS guest_first_name,
    u.last_name AS guest_last_name,
    p.name AS property_name,
    p.location AS property_location
FROM 
    Booking_Partitioned b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
WHERE 
    b.start_date BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY 
    b.start_date;

-- Example query for a date range spanning multiple partitions
EXPLAIN ANALYZE
SELECT 
    COUNT(*) AS total_bookings,
    YEAR(start_date) AS booking_year,
    MONTH(start_date) AS booking_month
FROM 
    Booking_Partitioned
WHERE 
    start_date BETWEEN '2023-06-01' AND '2025-06-30'
GROUP BY 
    YEAR(start_date), MONTH(start_date)
ORDER BY 
    booking_year, booking_month;
