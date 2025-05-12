
-- Sample Users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
('a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8', 'Alice', 'Johnson', 'alice@example.com', 'hash123', '+1234567890', 'host'),
('b2c3d4e5-f6g7-8901-h2i3-j4k5l6m7n8o9', 'Bob', 'Smith', 'bob@example.com', 'hash456', '+0987654321', 'guest'),
('c3d4e5f6-g7h8-9012-i3j4-k5l6m7n8o9p0', 'Charlie', 'Brown', 'charlie@example.com', 'hash789', NULL, 'guest'),
('d4e5f6g7-h8i9-0123-j4k5-l6m7n8o9p0q1', 'Diana', 'Prince', 'diana@example.com', 'hash101', '+1122334455', 'admin'),
('e5f6g7h8-i9j0-1234-k5l6-m7n8o9p0q1r2', 'Eve', 'Williams', 'eve@example.com', 'hash202', '+2233445566', 'host');

-- Sample Properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES
('p1q2r3s4-t5u6-v7w8-x9y0-z1a2b3c4d5e6', 'a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8', 'Cozy Cabin in the Woods', 'A peaceful cabin surrounded by nature.', 'Aspen, CO', 120.00),
('p2q3r4s5-t6u7-v8w9-x0y1-z2a3b4c5d6e7', 'e5f6g7h8-i9j0-1234-k5l6-m7n8o9p0q1r2', 'Modern Apartment Downtown', 'Great location near all amenities.', 'New York, NY', 200.00),
('p3q4r5s6-t7u8-v9w0-x1y2-z3a4b5c6d7e8', 'a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8', 'Beach House by the Sea', 'Wake up to ocean views every day.', 'Miami, FL', 300.00);

-- Sample Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
('b1c2d3e4-f5g6-7890-h1i2-j3k4l5m6n7o8', 'p1q2r3s4-t5u6-v7w8-x9y0-z1a2b3c4d5e6', 'b2c3d4e5-f6g7-8901-h2i3-j4k5l6m7n8o9', '2025-06-10', '2025-06-15', 600.00, 'confirmed'),
('b2c3d4e5-f6g7-8901-h2i3-j4k5l6m7n8p9', 'p2q3r4s5-t6u7-v8w9-x0y1-z2a3b4c5d6e7', 'c3d4e5f6-g7h8-9012-i3j4-k5l6m7n8o9p0', '2025-07-01', '2025-07-05', 800.00, 'pending'),
('b3d4e5f6-g7h8-9012-i3j4-k5l6m7n8o9p0', 'p3q4r5s6-t7u8-v9w0-x1y2-z3a4b5c6d7e8', 'b2c3d4e5-f6g7-8901-h2i3-j4k5l6m7n8o9', '2025-08-20', '2025-08-25', 1500.00, 'confirmed');

-- Sample Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
('pay1a2b3-c4d5-e6f7-g8h9-i0j1k2l3m4n5', 'b1c2d3e4-f5g6-7890-h1i2-j3k4l5m6n7o8', 600.00, '2025-06-05 14:30:00', 'credit_card'),
('pay2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'b2c3d4e5-f6g7-8901-h2i3-j4k5l6m7n8p9', 800.00, '2025-06-28 10:15:00', 'paypal'),
('pay3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'b3d4e5f6-g7h8-9012-i3j4-k5l6m7n8o9p0', 1500.00, '2025-08-15 16:45:00', 'stripe');

-- Sample Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
('rev1x2y3-z4a5-b6c7-d8e9-f0g1h2i3j4k5', 'p1q2r3s4-t5u6-v7w8-x9y0-z1a2b3c4d5e6', 'b2c3d4e5-f6g7-8901-h2i3-j4k5l6m7n8o9', 5, 'Amazing experience! The cabin was cozy and very clean.'),
('rev2y3z4-a5b6-c7d8-e9f0-g1h2i3j4k5l6', 'p2q3r4s5-t6u7-v8w9-x0y1-z2a3b4c5d6e7', 'c3d4e5f6-g7h8-9012-i3j4-k5l6m7n8o9p0', 4, 'Good apartment, but a bit noisy at night.'),
('rev3z4a5-b6c7-d8e9-f0g1-h2i3j4k5l6m7', 'p3q4r5s6-t7u8-v9w0-x1y2-z3a4b5c6d7e8', 'b2c3d4e5-f6g7-8901-h2i3-j4k5l6m7n8o9', 5, 'The beach house was perfect. Highly recommended!');

-- Sample Messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
('msg1a2b3-c4d5-e6f7-g8h9-i0j1k2l3m4n5', 'b2c3d4e5-f6g7-8901-h2i3-j4k5l6m7n8o9', 'a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8', 'Hi Alice, I have a question about the check-in time.'),
('msg2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8', 'b2c3d4e5-f6g7-8901-h2i3-j4k5l6m7n8o9', 'Hi Bob, check-in is after 3 PM. Let me know if you need help.'),
('msg3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'c3d4e5f6-g7h8-9012-i3j4-k5l6m7n8o9p0', 'e5f6g7h8-i9j0-1234-k5l6-m7n8o9p0q1r2', 'Hello Eve, I loved your apartment!');
