# ALX Airbnb Database - Advanced SQL Techniques

This directory contains advanced SQL scripts and performance optimization techniques for the ALX Airbnb Database project. These scripts demonstrate best practices for handling large datasets and complex queries in a relational database system.

## Table of Contents

1. [Database Schema Overview](#database-schema-overview)
2. [Advanced SQL Scripts](#advanced-sql-scripts)
   - [Joins and Relationships](#joins-and-relationships)
   - [Subqueries](#subqueries)
   - [Aggregations and Window Functions](#aggregations-and-window-functions)
   - [Performance Optimization](#performance-optimization)
   - [Database Indexing](#database-indexing)
   - [Table Partitioning](#table-partitioning)
3. [Performance Reports](#performance-reports)
4. [How to Use](#how-to-use)

## Database Schema Overview

The ALX Airbnb Database implements a relational model with the following core tables:

- **User**: Stores user information (guests, hosts, admins)
- **Property**: Contains property listings with details
- **Booking**: Records reservation information
- **Payment**: Tracks payment transactions
- **Review**: Stores property reviews and ratings
- **Message**: Manages communication between users

The database follows 3NF (Third Normal Form) with proper primary/foreign key relationships, appropriate data types (UUID for IDs), and validation constraints.

## Advanced SQL Scripts

### Joins and Relationships

File: [joins_queries.sql](joins_queries.sql)

Demonstrates various JOIN operations:
- INNER JOIN to connect related tables
- LEFT/RIGHT JOIN for optional relationships
- Multiple table joins for complex data retrieval

### Subqueries

File: [subqueries.sql](subqueries.sql)

Implements advanced subquery techniques:
- Correlated subqueries
- Subqueries in SELECT, FROM, and WHERE clauses
- Filtering with subquery results

Example subquery finding properties with high ratings:
```sql
SELECT 
    p.property_id,
    p.name,
    p.location
FROM 
    Property p
WHERE 
    p.property_id IN (
        SELECT 
            r.property_id
        FROM 
            Review r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    );
```

### Aggregations and Window Functions

File: [aggregations_and_window_functions.sql](aggregations_and_window_functions.sql)

Implements SQL aggregation and window functions:
- COUNT with GROUP BY to analyze booking counts
- ROW_NUMBER() to rank properties by bookings
- RANK() for handling ties in the ranking

Example query counting bookings per user:
```sql
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
```

### Performance Optimization

File: [perfomance.sql](perfomance.sql)

Demonstrates query optimization techniques:
- Reducing column selection
- Eliminating unnecessary joins
- Using subqueries for specific needs
- Implementing pagination

Performance comparison shows significant improvements:
- Column Selection: ~15-20% reduction in execution time
- Join Elimination: ~30-40% reduction in execution time
- Pagination: >50% reduction in initial response time

### Database Indexing

File: [database_index.sql](database_index.sql)

Implements strategic indexing to improve query performance:
- Foreign key indexes for JOIN operations
- Single-column indexes for filtering operations
- Composite indexes for multi-column conditions
- Text search indexes for exact matches

Index examples:
```sql
-- Foreign key indexing
CREATE INDEX idx_property_host_id ON Property(host_id);

-- Filtering index
CREATE INDEX idx_booking_status ON Booking(status);

-- Composite index
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
```

### Table Partitioning

File: [partitioning.sql](partitioning.sql)

Implements table partitioning for the Booking table:
- Range partitioning by year of booking date
- Partition pruning for date-range queries
- Local indexes per partition

Partitioning strategy:
```sql
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p_2023 VALUES LESS THAN (2024),
    PARTITION p_2024 VALUES LESS THAN (2025),
    PARTITION p_2025 VALUES LESS THAN (2026),
    PARTITION p_2026 VALUES LESS THAN (2027),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);
```

## Performance Reports

Detailed performance analysis is available in:
- [optimization_report.md](optimization_report.md): General query optimization techniques
- [index_performance.md](index_performance.md): Database indexing implementation
- [partition_performance.md](partition_performance.md): Table partitioning benefits

Key performance improvements:
- Single-year queries: 75% faster with partitioning
- Filtered queries: 30-40% faster with proper indexing
- Complex joins: 30-40% reduction in execution time
- Large result sets: >50% faster with pagination

## How to Use

1. Execute the schema and seed scripts first:
   ```
   mysql -u username -p database_name < ../database-script-0x01/schema.sql
   mysql -u username -p database_name < ../database-script-0x02/seed.sql
   ```

2. Run any of the advanced SQL scripts:
   ```
   mysql -u username -p database_name < database_index.sql
   mysql -u username -p database_name < partitioning.sql
   ```

3. Test performance with EXPLAIN ANALYZE:
   ```sql
   EXPLAIN ANALYZE SELECT ... FROM ... WHERE ...;
   ```

4. Compare performance before and after optimizations using timing results.

---

This project demonstrates the implementation of advanced SQL techniques to optimize database performance for an Airbnb-like application. The optimizations are particularly valuable as data volume grows, ensuring the application remains responsive and efficient.
