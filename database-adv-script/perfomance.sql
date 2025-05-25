-- Performance Analysis and Optimization for Complex Queries
-- This file demonstrates performance optimization techniques for complex queries

-- Initial Complex Query
-- Retrieves all bookings with user, property, and payment details
-- This query potentially has performance issues due to multiple joins

-- Analyze the initial query performance
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id AS guest_id,
    u.first_name AS guest_first_name,
    u.last_name AS guest_last_name,
    u.email AS guest_email,
    p.property_id,
    p.name AS property_name,
    p.location AS property_location,
    p.pricepernight,
    host.user_id AS host_id,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    host.email AS host_email,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
JOIN 
    User host ON p.host_id = host.user_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.status = 'confirmed'
    AND b.start_date >= '2023-01-01'
ORDER BY 
    b.start_date DESC;

-- Optimization Approach 1: Limit the output columns to only what's needed
-- Reducing the number of columns can improve network transfer time and reduce memory usage

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
    p.location AS property_location,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    pay.amount AS payment_amount,
    pay.payment_method
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
JOIN 
    User host ON p.host_id = host.user_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.status = 'confirmed'
    AND b.start_date >= '2023-01-01'
ORDER BY 
    b.start_date DESC;

-- Optimization Approach 2: Avoid joining unnecessary tables
-- If we only need specific information, we can avoid some joins

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
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
WHERE 
    b.status = 'confirmed'
    AND b.start_date >= '2023-01-01'
ORDER BY 
    b.start_date DESC;

-- Optimization Approach 3: Use subqueries for specific needs
-- When we need data from multiple tables but not in a single row

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    (SELECT CONCAT(first_name, ' ', last_name) FROM User WHERE user_id = b.user_id) AS guest_name,
    (SELECT name FROM Property WHERE property_id = b.property_id) AS property_name,
    (SELECT location FROM Property WHERE property_id = b.property_id) AS property_location,
    (SELECT amount FROM Payment WHERE booking_id = b.booking_id LIMIT 1) AS payment_amount
FROM 
    Booking b
WHERE 
    b.status = 'confirmed'
    AND b.start_date >= '2023-01-01'
ORDER BY 
    b.start_date DESC;

-- Optimization Approach 4: Pagination for large result sets
-- When dealing with large data, limiting results can significantly improve performance

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
    p.location AS property_location,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    pay.amount AS payment_amount,
    pay.payment_method
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
JOIN 
    User host ON p.host_id = host.user_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.status = 'confirmed'
    AND b.start_date >= '2023-01-01'
ORDER BY 
    b.start_date DESC
LIMIT 100 OFFSET 0;  -- Adjust OFFSET for pagination
