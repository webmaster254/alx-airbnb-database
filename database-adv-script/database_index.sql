-- Database Indexing for Performance Optimization
-- This script creates indexes on high-usage columns in the Airbnb database

-- Indexes for User Table
-- Index on user_id (though it's already a primary key and indexed)
-- ANALYZE User;

-- Index on email for login queries
CREATE INDEX idx_user_email ON User(email);

-- Index on role for filtering users by role
CREATE INDEX idx_user_role ON User(role);

-- Composite index on name fields for user search functionality
CREATE INDEX idx_user_names ON User(first_name, last_name);

-- Indexes for Property Table
-- Index on host_id for joining with User table
CREATE INDEX idx_property_host_id ON Property(host_id);

-- Index on location for location-based searches
CREATE INDEX idx_property_location ON Property(location);

-- Index on price for price-based filtering
CREATE INDEX idx_property_price ON Property(pricepernight);

-- Composite index for price and location queries
CREATE INDEX idx_property_price_location ON Property(pricepernight, location);

-- Indexes for Booking Table
-- Index on property_id for joining with Property table
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Index on user_id for joining with User table
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index on booking dates for date range queries
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);

-- Index on booking status for filtering
CREATE INDEX idx_booking_status ON Booking(status);

-- Analyze tables to update query planner statistics
ANALYZE User;
ANALYZE Property;
ANALYZE Booking;

-- Example performance test queries
-- Uncomment to run
/*
-- Test query performance before adding indexes
EXPLAIN ANALYZE 
SELECT 
    u.user_id, 
    CONCAT(u.first_name, ' ', u.last_name) AS user_name, 
    COUNT(b.booking_id) AS total_bookings
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name
ORDER BY 
    total_bookings DESC;

-- Test query performance after adding indexes
EXPLAIN ANALYZE 
SELECT 
    p.property_id,
    p.name AS property_name,
    CONCAT(h.first_name, ' ', h.last_name) AS host_name,
    COUNT(b.booking_id) AS total_bookings
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
LEFT JOIN 
    User h ON p.host_id = h.user_id
GROUP BY 
    p.property_id, p.name, h.first_name, h.last_name
ORDER BY 
    total_bookings DESC;
*/
