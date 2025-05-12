## Airbnb Clone Database – 3NF Normalization Report

### Objective

Ensure the database schema is in Third Normal Form (3NF) by eliminating partial and transitive dependencies.

**1. First Normal Form (1NF)**

✅ All tables have atomic values (no repeating groups or arrays).

✅ Each field contains only one value per row (e.g., no multiple phone numbers).

**2. Second Normal Form (2NF)**

✅ All non-key attributes are fully functionally dependent on the whole primary key.

No composite primary keys used; every non-key attribute depends on a single-column PK.

✅ Booking, Review, Payment, etc., reference their parent entities via foreign keys — no partial dependencies.

**3. Third Normal Form (3NF)**

✅ No transitive dependencies (i.e., non-key attribute depending on another non-key attribute).

For example:

*User.email* is unique and not derived from another field.

*Property.host_id* depends only on property_id.

*Payment.payment_method* is a proper ENUM; no other attribute depends on it.

✅ Final Verdict:

 Airbnb clone schema is in 3NF. 
