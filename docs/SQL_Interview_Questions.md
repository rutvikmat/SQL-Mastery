# 🎯 SQL Interview Questions & Answers

## Overview

This document contains the most frequently asked SQL interview questions collected from:

* Product Companies
* Startups
* Service-Based Companies
* FAANG-Level Interviews
* Data Engineering Interviews
* Backend Development Interviews

Difficulty Levels:

* Beginner
* Intermediate
* Advanced
* PostgreSQL
* Scenario-Based
* Query Optimization

---

# 📚 Beginner SQL Questions

## 1. What is SQL?

SQL (Structured Query Language) is a language used to interact with relational databases.

It is used for:

* Creating Databases
* Managing Tables
* Inserting Data
* Updating Data
* Querying Data

---

## 2. What is a Database?

A database is an organized collection of data that can be stored, managed, and retrieved efficiently.

Example:

```text
Students
Employees
Products
Orders
```

---

## 3. What is DBMS?

Database Management System.

Examples:

* MySQL
* PostgreSQL
* Oracle
* SQL Server

---

## 4. What is RDBMS?

Relational Database Management System.

Stores data in tables with relationships.

Examples:

* PostgreSQL
* MySQL
* Oracle

---

## 5. What is a Table?

A table stores data in rows and columns.

Example:

```text
Employees
-----------------------
ID | Name | Salary
```

---

## 6. What is a Row?

A row represents a single record.

Example:

```text
1 | Rutvik | 75000
```

---

## 7. What is a Column?

A column represents an attribute.

Example:

```text
Name
Salary
Department
```

---

## 8. What is a Primary Key?

A column that uniquely identifies each row.

Properties:

* Unique
* Not Null

Example:

```sql
employee_id
```

---

## 9. What is a Foreign Key?

A column used to establish relationships between tables.

Example:

```sql
department_id
```

---

## 10. Difference Between Primary Key and Foreign Key?

| Primary Key       | Foreign Key          |
| ----------------- | -------------------- |
| Unique            | Can Repeat           |
| Identifies Record | Creates Relationship |
| Not Null          | Can be Null          |

---

# 📚 Intermediate SQL Questions

## 11. What is the Difference Between DELETE, TRUNCATE, and DROP?

### DELETE

Removes selected rows.

```sql
DELETE FROM employees
WHERE employee_id = 1;
```

### TRUNCATE

Removes all rows.

```sql
TRUNCATE TABLE employees;
```

### DROP

Deletes entire table.

```sql
DROP TABLE employees;
```

---

## 12. Difference Between WHERE and HAVING?

### WHERE

Filters rows before grouping.

### HAVING

Filters grouped data.

Example:

```sql
SELECT department,
COUNT(*)
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;
```

---

## 13. What is GROUP BY?

Used to group rows with the same values.

```sql
SELECT department,
COUNT(*)
FROM employees
GROUP BY department;
```

---

## 14. What is ORDER BY?

Used for sorting.

```sql
SELECT *
FROM employees
ORDER BY salary DESC;
```

---

## 15. What is DISTINCT?

Removes duplicate values.

```sql
SELECT DISTINCT city
FROM employees;
```

---

## 16. What is LIMIT?

Restricts result count.

```sql
SELECT *
FROM employees
LIMIT 10;
```

---

## 17. What are Aggregate Functions?

Functions that operate on multiple rows.

Examples:

```sql
COUNT()
SUM()
AVG()
MAX()
MIN()
```

---

## 18. What is Normalization?

Process of reducing redundancy.

Benefits:

* Better Storage
* Data Integrity
* Easier Maintenance

---

## 19. Explain 1NF, 2NF, 3NF

### 1NF

No repeating groups.

### 2NF

Remove partial dependency.

### 3NF

Remove transitive dependency.

---

## 20. What is Denormalization?

Combining tables to improve performance.

---

# 📚 JOIN Interview Questions

## 21. What is INNER JOIN?

Returns matching records.

```sql
SELECT *
FROM employees e
INNER JOIN departments d
ON e.department_id=d.department_id;
```

---

## 22. What is LEFT JOIN?

Returns all rows from left table.

---

## 23. What is RIGHT JOIN?

Returns all rows from right table.

---

## 24. What is FULL JOIN?

Returns all records from both tables.

---

## 25. What is SELF JOIN?

A table joined with itself.

Example:

Manager ↔ Employee hierarchy.

---

## 26. Difference Between INNER JOIN and LEFT JOIN?

INNER JOIN

Returns matching rows only.

LEFT JOIN

Returns all rows from left table.

---

## 27. Can We Join More Than Two Tables?

Yes.

```sql
table1
JOIN table2
JOIN table3
```

---

# 📚 Subquery Questions

## 28. What is a Subquery?

A query inside another query.

Example:

```sql
SELECT *
FROM employees
WHERE salary >
(
SELECT AVG(salary)
FROM employees
);
```

---

## 29. Types of Subqueries

* Scalar
* Correlated
* Nested

---

## 30. What is a Correlated Subquery?

Executed once for each row.

---

# 📚 Advanced SQL Questions

## 31. What is a View?

Virtual table based on query results.

```sql
CREATE VIEW employee_view AS
SELECT * FROM employees;
```

---

## 32. Advantages of Views

* Security
* Simplicity
* Reusability

---

## 33. What is an Index?

Improves search performance.

```sql
CREATE INDEX idx_name
ON employees(full_name);
```

---

## 34. Disadvantages of Indexes

* Extra Storage
* Slower Inserts/Updates

---

## 35. What are Transactions?

A sequence of SQL operations executed as a unit.

---

## 36. What are ACID Properties?

### Atomicity

All or Nothing.

### Consistency

Valid State.

### Isolation

Independent Transactions.

### Durability

Permanent Storage.

---

## 37. What is COMMIT?

Saves changes permanently.

```sql
COMMIT;
```

---

## 38. What is ROLLBACK?

Undo changes.

```sql
ROLLBACK;
```

---

## 39. What is SAVEPOINT?

Partial rollback point.

```sql
SAVEPOINT sp1;
```

---

## 40. What is Locking?

Prevents data conflicts.

---

# 📚 CTE Questions

## 41. What is a CTE?

Common Table Expression.

```sql
WITH dept_salary AS
(
SELECT department_id,
AVG(salary)
FROM employees
GROUP BY department_id
)
SELECT *
FROM dept_salary;
```

---

## 42. Advantages of CTE

* Readability
* Reusability
* Recursive Queries

---

## 43. What is Recursive CTE?

CTE that references itself.

---

# 📚 Window Function Questions

## 44. What is ROW_NUMBER()?

Assigns unique sequence.

```sql
ROW_NUMBER()
OVER(ORDER BY salary DESC)
```

---

## 45. What is RANK()?

Ranking with gaps.

Example:

```text
1
2
2
4
```

---

## 46. What is DENSE_RANK()?

Ranking without gaps.

Example:

```text
1
2
2
3
```

---

## 47. What is LEAD()?

Access next row.

---

## 48. What is LAG()?

Access previous row.

---

## 49. Difference Between RANK and DENSE_RANK?

| RANK | DENSE_RANK |
| ---- | ---------- |
| Gaps | No Gaps    |

---

# 📚 PostgreSQL Interview Questions

## 50. Why PostgreSQL?

Features:

* Open Source
* ACID Compliant
* JSON Support
* Performance

---

## 51. What is SERIAL?

Auto Increment column.

```sql
id SERIAL PRIMARY KEY
```

---

## 52. What is JSONB?

Binary JSON storage.

Benefits:

* Faster Queries
* Index Support

---

## 53. What is Materialized View?

Stores query results physically.

---

## 54. Difference Between View and Materialized View?

View:

Virtual

Materialized View:

Physical Storage

---

## 55. What is EXPLAIN?

Shows query execution plan.

```sql
EXPLAIN
SELECT *
FROM employees;
```

---

## 56. What is EXPLAIN ANALYZE?

Shows actual execution statistics.

---

# 📚 Query Optimization Questions

## 57. How to Improve Query Performance?

* Use Indexes
* Avoid SELECT *
* Optimize JOINs
* Filter Early

---

## 58. Why Avoid SELECT *?

Retrieves unnecessary columns.

---

## 59. Which Columns Should Be Indexed?

* Frequently searched columns
* Foreign keys
* JOIN columns

---

## 60. What Causes Slow Queries?

* Missing Indexes
* Large Table Scans
* Complex Subqueries

---

# 📚 Scenario-Based Questions

## 61. Find Second Highest Salary

```sql
SELECT MAX(salary)
FROM employees
WHERE salary <
(
SELECT MAX(salary)
FROM employees
);
```

---

## 62. Find Duplicate Records

```sql
SELECT email,
COUNT(*)
FROM employees
GROUP BY email
HAVING COUNT(*) > 1;
```

---

## 63. Find Employees Without Department

```sql
SELECT *
FROM employees
WHERE department_id IS NULL;
```

---

## 64. Top 3 Highest Paid Employees

```sql
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 3;
```

---

## 65. Department With Highest Salary Expense

```sql
SELECT department_id,
SUM(salary)
FROM employees
GROUP BY department_id
ORDER BY SUM(salary) DESC
LIMIT 1;
```

---

# 🎯 FAANG-Level SQL Questions

## 66. Difference Between EXISTS and IN?

### EXISTS

Stops after first match.

### IN

Checks all values.

---

## 67. Difference Between UNION and UNION ALL?

UNION

Removes duplicates.

UNION ALL

Keeps duplicates.

---

## 68. Difference Between CTE and Subquery?

CTE:

Reusable.

Subquery:

Temporary.

---

## 69. How Does SQL Execute a Query?

Execution Order:

```text
FROM
JOIN
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
LIMIT
```

---

## 70. Explain Database Index Internals

Most databases use:

* B-Tree Indexes
* Hash Indexes

to speed up lookups.

---

# 🏆 Final Interview Checklist

## Fundamentals

* [ ] SELECT
* [ ] WHERE
* [ ] ORDER BY
* [ ] GROUP BY

## Intermediate

* [ ] JOINs
* [ ] Subqueries
* [ ] Functions

## Advanced

* [ ] Views
* [ ] Indexes
* [ ] Transactions
* [ ] CTEs
* [ ] Window Functions

## PostgreSQL

* [ ] SERIAL
* [ ] JSONB
* [ ] EXPLAIN ANALYZE
* [ ] Materialized Views

## Problem Solving

* [ ] Second Highest Salary
* [ ] Duplicate Records
* [ ] Top-N Queries
* [ ] Ranking Problems

---

# 🚀 Interview Success Formula

```text
SQL Fundamentals
       ↓
JOIN Mastery
       ↓
Subqueries
       ↓
Views & Indexes
       ↓
CTEs
       ↓
Window Functions
       ↓
Optimization
       ↓
System Design
       ↓
Interview Ready
```
