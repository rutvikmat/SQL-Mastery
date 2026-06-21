# Day 09 Quick Revision Notes

## Views

Virtual tables.

```sql
CREATE VIEW view_name AS
SELECT ...
```

---

## Materialized Views

Stores data physically.

```sql
CREATE MATERIALIZED VIEW ...
```

Refresh:

```sql
REFRESH MATERIALIZED VIEW ...
```

---

## Indexes

Improve performance.

```sql
CREATE INDEX idx_name
ON table_name(column_name);
```

---

## Transactions

```sql
BEGIN
COMMIT
ROLLBACK
SAVEPOINT
```

---

## ACID

Atomicity

Consistency

Isolation

Durability

---

## Important Interview Point

Indexes improve read speed but can slightly slow inserts and updates because the index must also be maintained.
