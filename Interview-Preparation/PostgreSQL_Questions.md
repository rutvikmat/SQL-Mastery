# PostgreSQL Interview Questions & Answers

## SQL-Mastery-Portfolio

---

# Introduction

PostgreSQL is one of the most popular open-source relational database systems used by:

* Google
* Apple
* Instagram
* Reddit
* Spotify
* Netflix
* Uber

This guide contains PostgreSQL interview questions from:

* Beginner Level
* Intermediate Level
* Advanced Level
* DBA Level
* Backend Developer Interviews
* Data Engineer Interviews

---

# Table of Contents

1. PostgreSQL Fundamentals
2. Architecture Questions
3. SQL & PostgreSQL Features
4. Indexing Questions
5. Transactions & Concurrency
6. Performance Optimization
7. PostgreSQL Administration
8. Advanced PostgreSQL
9. Scenario-Based Questions
10. PostgreSQL Interview Checklist

---

# POSTGRESQL FUNDAMENTALS

---

## Q1. What is PostgreSQL?

### Answer

PostgreSQL is an open-source Object Relational Database Management System (ORDBMS).

Features:

* ACID compliant
* Open source
* Highly extensible
* Supports JSON
* Supports Window Functions
* Supports CTEs
* Enterprise-grade database

---

## Q2. Why PostgreSQL?

### Answer

Advantages:

* Free and open source
* Excellent performance
* Strong data integrity
* Advanced indexing
* JSON support
* Partitioning
* Extensions support

---

## Q3. Difference Between PostgreSQL and MySQL?

| Feature          | PostgreSQL | MySQL     |
| ---------------- | ---------- | --------- |
| Open Source      | Yes        | Yes       |
| ACID Compliance  | Strong     | Good      |
| JSON Support     | Advanced   | Basic     |
| Window Functions | Excellent  | Supported |
| Extensibility    | High       | Moderate  |
| Complex Queries  | Better     | Good      |

---

## Q4. What are PostgreSQL Data Types?

### Numeric

```sql id="e13pl1"
SMALLINT
INTEGER
BIGINT
DECIMAL
NUMERIC
REAL
DOUBLE PRECISION
```

### Character

```sql id="gxx1tr"
CHAR
VARCHAR
TEXT
```

### Date & Time

```sql id="m1skhf"
DATE
TIME
TIMESTAMP
TIMESTAMPTZ
```

### Boolean

```sql id="1zjlwm"
BOOLEAN
```

### JSON

```sql id="ifwk60"
JSON
JSONB
```

---

# POSTGRESQL ARCHITECTURE

---

## Q5. What is PostgreSQL Architecture?

### Components

```text id="1kwbwm"
Client
   |
PostgreSQL Server
   |
Database
   |
Schema
   |
Tables
```

---

## Q6. What is a Database Cluster?

### Answer

A collection of databases managed by a single PostgreSQL server instance.

---

## Q7. What is a Schema?

### Answer

A namespace used to organize database objects.

Example:

```sql id="20jnce"
CREATE SCHEMA hr;
```

---

## Q8. Difference Between Database and Schema?

| Database          | Schema                    |
| ----------------- | ------------------------- |
| Separate database | Namespace inside database |
| Independent       | Belongs to database       |
| Multiple schemas  | Single database           |

---

# POSTGRESQL FEATURES

---

## Q9. What is JSONB?

### Answer

Binary JSON storage.

Advantages:

* Faster searches
* Better indexing
* Less storage

Example:

```sql id="g5zbji"
CREATE TABLE users
(
id SERIAL PRIMARY KEY,
profile JSONB
);
```

---

## Q10. Difference Between JSON and JSONB?

| JSON          | JSONB             |
| ------------- | ----------------- |
| Text Storage  | Binary Storage    |
| Slower Search | Faster Search     |
| No Indexing   | Supports Indexing |

---

## Q11. What are Window Functions?

### Answer

Functions operating across rows without collapsing results.

Examples:

```sql id="p2k2ch"
ROW_NUMBER()
RANK()
LAG()
LEAD()
```

---

## Q12. What is a CTE?

### Answer

Common Table Expression.

```sql id="0k0e74"
WITH employee_data AS
(
SELECT *
FROM employees
)

SELECT *
FROM employee_data;
```

---

## Q13. What is Recursive CTE?

### Answer

Used for hierarchical data.

```sql id="4w2f7y"
WITH RECURSIVE numbers AS
(
SELECT 1

UNION ALL

SELECT n+1
FROM numbers
WHERE n<10
)

SELECT *
FROM numbers;
```

---

# INDEXING QUESTIONS

---

## Q14. What types of indexes are available in PostgreSQL?

### B-Tree

Default index.

```sql id="y6f7qg"
CREATE INDEX idx_name
ON employees(full_name);
```

### Hash

```sql id="gsxyur"
CREATE INDEX idx_hash
ON employees USING HASH(email);
```

### GIN

For JSONB and arrays.

```sql id="7c7r9n"
CREATE INDEX idx_profile
ON users USING GIN(profile);
```

### GiST

For geometric and full-text search.

---

## Q15. What is a Partial Index?

### Answer

Indexes only specific rows.

```sql id="34znp8"
CREATE INDEX idx_active_users
ON users(email)
WHERE status='ACTIVE';
```

---

## Q16. What is a Composite Index?

### Answer

Multiple columns in one index.

```sql id="r9dnwm"
CREATE INDEX idx_dept_salary
ON employees
(
department_id,
salary
);
```

---

# TRANSACTIONS & CONCURRENCY

---

## Q17. What is ACID?

### Atomicity

All or nothing.

### Consistency

Data remains valid.

### Isolation

Transactions do not interfere.

### Durability

Committed data persists.

---

## Q18. What is MVCC?

### Multi-Version Concurrency Control

Allows:

* Concurrent reads
* Concurrent writes

Without locking readers.

One of PostgreSQL's strongest features.

---

## Q19. What is a Deadlock?

### Answer

Two transactions waiting for each other.

Example:

```text id="l4ce86"
Transaction A waits for B
Transaction B waits for A
```

---

## Q20. How does PostgreSQL handle Deadlocks?

### Answer

PostgreSQL automatically detects deadlocks and terminates one transaction.

---

## Q21. What are Isolation Levels?

### Read Uncommitted

(Not supported directly)

### Read Committed

Default.

### Repeatable Read

Consistent view.

### Serializable

Highest isolation.

---

# PERFORMANCE OPTIMIZATION

---

## Q22. What is EXPLAIN?

```sql id="40lm1z"
EXPLAIN

SELECT *
FROM employees;
```

Shows execution plan.

---

## Q23. What is EXPLAIN ANALYZE?

```sql id="elx6lq"
EXPLAIN ANALYZE

SELECT *
FROM employees;
```

Shows actual execution statistics.

---

## Q24. What is VACUUM?

### Answer

Reclaims dead tuples.

```sql id="llc0tp"
VACUUM employees;
```

---

## Q25. What is ANALYZE?

### Answer

Updates query planner statistics.

```sql id="3hjj7u"
ANALYZE employees;
```

---

## Q26. What is VACUUM ANALYZE?

```sql id="nvvlyc"
VACUUM ANALYZE employees;
```

Combines both operations.

---

## Q27. What is REINDEX?

```sql id="dx5vtx"
REINDEX TABLE employees;
```

Rebuilds indexes.

---

## Q28. What is Autovacuum?

### Answer

Automatic background process.

Responsibilities:

* VACUUM
* ANALYZE

Without manual intervention.

---

# POSTGRESQL ADMINISTRATION

---

## Q29. How do you create a user?

```sql id="o3n8bi"
CREATE USER admin
WITH PASSWORD 'password';
```

---

## Q30. Grant privileges?

```sql id="w2q3ec"
GRANT ALL PRIVILEGES
ON DATABASE companydb
TO admin;
```

---

## Q31. How do you create a database?

```sql id="pf4kbq"
CREATE DATABASE companydb;
```

---

## Q32. Backup a PostgreSQL Database?

### Command

```bash id="xgx9kn"
pg_dump companydb > backup.sql
```

---

## Q33. Restore Database?

```bash id="ax7mni"
psql companydb < backup.sql
```

---

# ADVANCED POSTGRESQL

---

## Q34. What is Partitioning?

### Answer

Splitting large tables into smaller parts.

### Range Partitioning

```sql id="edhmuh"
CREATE TABLE sales
(
sale_date DATE
)
PARTITION BY RANGE(sale_date);
```

---

## Q35. What is Table Inheritance?

### Answer

Child tables inherit columns from parent tables.

```sql id="lc0do7"
CREATE TABLE employees
(
id INT,
name TEXT
);

CREATE TABLE managers()
INHERITS (employees);
```

---

## Q36. What are Materialized Views?

### Answer

Stores query results physically.

```sql id="vhcy08"
CREATE MATERIALIZED VIEW revenue_summary
AS
SELECT
SUM(revenue)
FROM sales;
```

Refresh:

```sql id="hy7n85"
REFRESH MATERIALIZED VIEW revenue_summary;
```

---

## Q37. What are Extensions?

### Answer

Additional PostgreSQL functionality.

Example:

```sql id="es3gvp"
CREATE EXTENSION pg_stat_statements;
```

Popular Extensions:

* pg_stat_statements
* PostGIS
* pgcrypto
* uuid-ossp

---

# SCENARIO-BASED QUESTIONS

---

## Q38. A query suddenly becomes slow. What would you do?

### Answer

1. Check EXPLAIN ANALYZE
2. Verify indexes
3. Run ANALYZE
4. Check table growth
5. Check locks
6. Review execution plan

---

## Q39. A table has 500 million rows. How do you optimize it?

### Answer

* Partitioning
* Indexing
* Materialized Views
* Query Optimization
* Archiving old data

---

## Q40. JSONB search is slow. How do you fix it?

### Answer

Create GIN index.

```sql id="1wv6ic"
CREATE INDEX idx_jsonb
ON users
USING GIN(profile);
```

---

## Q41. Database size is growing rapidly. What would you check?

### Answer

* Unused indexes
* Dead tuples
* Table bloat
* Logs
* Archive data

---

## Q42. High CPU usage on PostgreSQL server. How do you investigate?

### Answer

* Active queries
* Slow queries
* Missing indexes
* Query plans
* Connection count

---

# FREQUENTLY ASKED POSTGRESQL INTERVIEW QUESTIONS

---

## Beginner

* What is PostgreSQL?
* What is JSONB?
* What is VACUUM?
* What is MVCC?

---

## Intermediate

* Index Types
* CTEs
* Window Functions
* Transactions

---

## Advanced

* Partitioning
* Materialized Views
* Query Optimization
* Deadlocks

---

## DBA Level

* Replication
* Backup & Recovery
* Autovacuum
* Performance Tuning

---

# PostgreSQL Interview Checklist

## Fundamentals

* [ ] Data Types
* [ ] Constraints
* [ ] Joins
* [ ] Views

---

## Intermediate

* [ ] JSONB
* [ ] CTEs
* [ ] Window Functions
* [ ] Indexing

---

## Advanced

* [ ] MVCC
* [ ] VACUUM
* [ ] Partitioning
* [ ] Materialized Views

---

## DBA

* [ ] Backup
* [ ] Recovery
* [ ] Replication
* [ ] Monitoring

---

# PostgreSQL Success Formula

```text id="5x6jht"
SQL Fundamentals
        +
PostgreSQL Internals
        +
Indexing
        +
Optimization
        +
Administration
        =
PostgreSQL Expert
```

---

# Summary

## Topics Covered

* PostgreSQL Fundamentals
* JSONB
* MVCC
* Indexes
* Transactions
* Optimization
* Administration
* Advanced Features

## Questions Covered

42+ PostgreSQL Interview Questions

## Difficulty Levels

* Beginner
* Intermediate
* Advanced
* DBA

---

**Portfolio Status:** PostgreSQL Interview Ready 🚀
