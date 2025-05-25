-- Aggregations and Window Functions for Airbnb Database Analysis

-- Query 1: Total number of bookings made by each user
-- Uses COUNT function and GROUP BY clause
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

-- Query 2: Ranking properties based on total bookings using ROW_NUMBER()
-- This assigns a unique rank to each property (no ties)
SELECT 
    p.property_id,
    p.name AS property_name,
    CONCAT(h.first_name, ' ', h.last_name) AS host_name,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS property_rank
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
LEFT JOIN 
    User h ON p.host_id = h.user_id
GROUP BY 
    p.property_id, p.name, h.first_name, h.last_name
ORDER BY 
    property_rank;

-- Query 3: Ranking properties based on total bookings using RANK()
-- This assigns the same rank to properties with equal booking counts
SELECT 
    p.property_id,
    p.name AS property_name,
    CONCAT(h.first_name, ' ', h.last_name) AS host_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS property_rank
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
LEFT JOIN 
    User h ON p.host_id = h.user_id
GROUP BY 
    p.property_id, p.name, h.first_name, h.last_name
ORDER BY 
    property_rank;
