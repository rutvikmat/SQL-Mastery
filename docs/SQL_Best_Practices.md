# 🚀 SQL Best Practices

## Overview

This document contains industry-standard SQL best practices used by:

* Database Engineers
* Backend Developers
* Data Engineers
* Data Analysts
* PostgreSQL Developers
* Software Architects

The goal is to write SQL that is:

* Readable
* Maintainable
* Scalable
* Secure
* Performant

---

# 🎯 Core Principles

Every SQL query should follow these principles:

### Correctness

Return accurate results.

### Readability

Easy to understand and maintain.

### Performance

Execute efficiently.

### Scalability

Handle growing datasets.

### Security

Protect sensitive data.

---

# 📚 Database Design Best Practices

## 1. Use Meaningful Table Names

### ❌ Bad

```sql
emp
cust
prod
```

### ✅ Good

```sql
employees
customers
products
```

---

## 2. Use Consistent Naming Conventions

### Recommended

```sql
employee_id
department_id
created_at
updated_at
```

### Avoid

```sql
EmployeeID
DeptID
CreatedAt
```

---

## 3. Always Use Primary Keys

Every table should have a primary key.

```sql
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY
);
```

Benefits:

* Uniqueness
* Faster indexing
* Better relationships

---

## 4. Use Foreign Keys

Maintain referential integrity.

```sql
FOREIGN KEY (department_id)
REFERENCES departments(department_id)
```

Benefits:

* Prevent orphan records
* Ensure consistency

---

## 5. Normalize Data

Apply:

* 1NF
* 2NF
* 3NF

Benefits:

* Reduced redundancy
* Better maintenance
* Improved consistency

---

## 6. Avoid Over-Normalization

Too many joins can hurt performance.

Balance:

```text
Normalization
vs
Performance
```

---

# 📚 Table Design Best Practices

## 7. Choose Correct Data Types

### ❌ Bad

```sql
salary VARCHAR(50)
```

### ✅ Good

```sql
salary DECIMAL(10,2)
```

---

## 8. Use VARCHAR Instead of CHAR

### Prefer

```sql
VARCHAR(100)
```

### Avoid

```sql
CHAR(100)
```

Unless fixed-length data is required.

---

## 9. Use NOT NULL Where Appropriate

### Good

```sql
full_name VARCHAR(100) NOT NULL
```

Benefits:

* Better data quality
* Easier validation

---

## 10. Use CHECK Constraints

```sql
salary DECIMAL(10,2)
CHECK (salary > 0)
```

Benefits:

* Data validation at database level

---

# 📚 Query Writing Best Practices

## 11. Avoid SELECT *

### ❌ Bad

```sql
SELECT *
FROM employees;
```

### ✅ Good

```sql
SELECT
employee_id,
full_name,
salary
FROM employees;
```

Benefits:

* Better performance
* Reduced network traffic
* Easier maintenance

---

## 12. Use Aliases

### Good

```sql
SELECT
e.full_name,
d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;
```

Benefits:

* Cleaner queries
* Better readability

---

## 13. Format SQL Consistently

### Recommended

```sql
SELECT
    employee_id,
    full_name
FROM employees
WHERE salary > 50000
ORDER BY salary DESC;
```

---

## 14. Use Meaningful Aliases

### ❌ Bad

```sql
SELECT *
FROM employees a
JOIN departments b;
```

### ✅ Good

```sql
SELECT *
FROM employees emp
JOIN departments dept;
```

---

## 15. Filter Early

### Good

```sql
SELECT *
FROM employees
WHERE department_id = 1;
```

Reduces data processing.

---

# 📚 JOIN Best Practices

## 16. Join Only Required Tables

### Avoid

Unnecessary joins.

### Use

Only required relationships.

---

## 17. Always Specify JOIN Conditions

### ❌ Bad

```sql
SELECT *
FROM employees,
departments;
```

Produces Cartesian Product.

### ✅ Good

```sql
SELECT *
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;
```

---

## 18. Prefer Explicit JOIN Syntax

### Recommended

```sql
INNER JOIN
LEFT JOIN
RIGHT JOIN
```

Instead of implicit joins.

---

# 📚 Aggregate Query Best Practices

## 19. Use GROUP BY Carefully

Ensure every non-aggregated column appears in GROUP BY.

### Correct

```sql
SELECT
department_id,
COUNT(*)
FROM employees
GROUP BY department_id;
```

---

## 20. Use HAVING for Aggregate Filters

### Correct

```sql
SELECT department_id,
COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 10;
```

---

# 📚 Subquery Best Practices

## 21. Avoid Deeply Nested Queries

### ❌ Bad

Multiple nested levels.

### ✅ Better

Use CTEs.

```sql
WITH high_salary AS (
    SELECT *
    FROM employees
    WHERE salary > 100000
)
SELECT *
FROM high_salary;
```

---

## 22. Use EXISTS for Large Datasets

### Better

```sql
WHERE EXISTS (...)
```

Instead of:

```sql
WHERE IN (...)
```

for large datasets.

---

# 📚 CTE Best Practices

## 23. Use CTEs for Readability

### Example

```sql
WITH department_salary AS (
    SELECT
        department_id,
        AVG(salary) avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM department_salary;
```

Benefits:

* Cleaner queries
* Easier debugging

---

# 📚 Window Function Best Practices

## 24. Use Window Functions for Ranking

### Example

```sql
SELECT
employee_name,
salary,

RANK()
OVER(
ORDER BY salary DESC
)

FROM employees;
```

Better than complex subqueries.

---

## 25. Learn These Functions Thoroughly

```sql
ROW_NUMBER()
RANK()
DENSE_RANK()
LEAD()
LAG()
```

Frequently asked in interviews.

---

# 📚 Indexing Best Practices

## 26. Index Frequently Queried Columns

Examples:

```sql
email
department_id
customer_id
order_date
```

---

## 27. Index Foreign Keys

### Recommended

```sql
CREATE INDEX idx_department
ON employees(department_id);
```

---

## 28. Do Not Over-Index

Too many indexes:

* Increase storage
* Slow INSERT
* Slow UPDATE

---

## 29. Index Columns Used In

* WHERE
* JOIN
* ORDER BY
* GROUP BY

---

# 📚 Performance Optimization

## 30. Use EXPLAIN

```sql
EXPLAIN
SELECT *
FROM employees;
```

Understand query execution.

---

## 31. Use EXPLAIN ANALYZE

```sql
EXPLAIN ANALYZE
SELECT *
FROM employees;
```

Shows actual execution statistics.

---

## 32. Avoid Full Table Scans

Use indexes when appropriate.

---

## 33. Retrieve Only Needed Data

### Bad

```sql
SELECT *
```

### Better

```sql
SELECT id,name
```

---

## 34. Limit Result Sets

```sql
SELECT *
FROM employees
LIMIT 100;
```

---

# 📚 Transaction Best Practices

## 35. Always Use Transactions for Critical Operations

### Example

```sql
BEGIN;

UPDATE accounts
SET balance = balance - 500;

UPDATE accounts
SET balance = balance + 500;

COMMIT;
```

---

## 36. Rollback on Failure

```sql
ROLLBACK;
```

Prevents data corruption.

---

## 37. Keep Transactions Short

Long transactions:

* Lock resources
* Reduce concurrency

---

# 📚 Security Best Practices

## 38. Use Parameterized Queries

### ❌ Unsafe

```sql
SELECT *
FROM users
WHERE username = 'user_input';
```

### ✅ Safe

```sql
SELECT *
FROM users
WHERE username = ?;
```

Prevents SQL Injection.

---

## 39. Principle of Least Privilege

Grant only required permissions.

Example:

```sql
READ ONLY
READ + WRITE
ADMIN
```

---

## 40. Encrypt Sensitive Data

Examples:

* Passwords
* Financial Data
* Personal Information

---

# 📚 PostgreSQL Best Practices

## 41. Prefer SERIAL or IDENTITY

```sql
id SERIAL PRIMARY KEY
```

or

```sql
id BIGINT GENERATED ALWAYS AS IDENTITY
```

---

## 42. Use JSONB Carefully

Good for:

* Semi-structured data

Not ideal for:

* Highly relational data

---

## 43. Use Materialized Views for Heavy Reports

Benefits:

* Faster reporting
* Reduced computation

---

## 44. Regularly VACUUM Tables

```sql
VACUUM ANALYZE;
```

Improves performance.

---

# 📚 Documentation Best Practices

## 45. Document Every Schema

Include:

* Purpose
* Relationships
* Business Rules

---

## 46. Document Complex Queries

Use comments.

```sql
-- Calculate department revenue
SELECT ...
```

---

## 47. Maintain ER Diagrams

Keep database architecture documented.

---

# 📚 Production Database Checklist

## Design

* [ ] Primary Keys
* [ ] Foreign Keys
* [ ] Constraints
* [ ] Normalization

## Querying

* [ ] No unnecessary SELECT *
* [ ] Proper JOIN conditions
* [ ] Aliases used

## Performance

* [ ] Indexes added
* [ ] Queries analyzed
* [ ] Slow queries optimized

## Security

* [ ] Parameterized queries
* [ ] Least privilege access
* [ ] Sensitive data protected

## Documentation

* [ ] ER Diagram
* [ ] Schema Documentation
* [ ] Query Documentation

---

# 🏆 Golden Rules of SQL

### Rule #1

Always write readable SQL.

---

### Rule #2

Optimize only after measuring.

---

### Rule #3

Use indexes wisely.

---

### Rule #4

Never trust user input.

---

### Rule #5

Always design for future growth.

---

### Rule #6

Document everything.

---

### Rule #7

Learn execution plans.

---

### Rule #8

Master JOINs, CTEs, and Window Functions.

---

### Rule #9

Understand business requirements before writing queries.

---

### Rule #10

Think like a Database Engineer, not just a Query Writer.

---

# 🚀 SQL Engineering Mindset

```text
Correctness
      ↓
Readability
      ↓
Maintainability
      ↓
Performance
      ↓
Scalability
      ↓
Security
      ↓
Production Ready
```

Following these practices will help you write professional-grade SQL suitable for enterprise applications, analytics systems, backend services, and data engineering workflows.
