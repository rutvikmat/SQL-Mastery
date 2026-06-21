# 📚 SQL Cheat Sheet

## Overview

This cheat sheet contains the most commonly used SQL commands, functions, clauses, joins, window functions, and optimization techniques.

Use this document as a quick reference during:

* Learning SQL
* Interview Preparation
* Project Development
* Data Analysis
* PostgreSQL Development

---

# 🔹 Database Commands

## Create Database

```sql
CREATE DATABASE company_db;
```

## Connect Database (PostgreSQL)

```sql
\c company_db
```

## Show Databases

```sql
\l
```

## Delete Database

```sql
DROP DATABASE company_db;
```

---

# 🔹 Table Commands

## Create Table

```sql
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    salary DECIMAL(10,2)
);
```

## View Table Structure

```sql
\d employees
```

## Rename Table

```sql
ALTER TABLE employees
RENAME TO staff;
```

## Drop Table

```sql
DROP TABLE employees;
```

---

# 🔹 Data Types

## Numeric Types

```sql
INT
BIGINT
SMALLINT
DECIMAL(10,2)
NUMERIC
FLOAT
REAL
```

## Character Types

```sql
CHAR(10)
VARCHAR(100)
TEXT
```

## Date & Time

```sql
DATE
TIME
TIMESTAMP
INTERVAL
```

## Boolean

```sql
BOOLEAN
```

---

# 🔹 Constraints

## Primary Key

```sql
PRIMARY KEY
```

## Foreign Key

```sql
FOREIGN KEY
```

## Unique

```sql
UNIQUE
```

## Not Null

```sql
NOT NULL
```

## Check

```sql
CHECK (salary > 0)
```

## Default

```sql
DEFAULT CURRENT_DATE
```

---

# 🔹 SELECT Statements

## Select All

```sql
SELECT * FROM employees;
```

## Select Specific Columns

```sql
SELECT full_name, salary
FROM employees;
```

## Distinct Values

```sql
SELECT DISTINCT city
FROM employees;
```

## Alias

```sql
SELECT full_name AS employee_name
FROM employees;
```

---

# 🔹 WHERE Clause

## Equal

```sql
SELECT *
FROM employees
WHERE city = 'Bangalore';
```

## Not Equal

```sql
SELECT *
FROM employees
WHERE city <> 'Bangalore';
```

## Greater Than

```sql
WHERE salary > 50000;
```

## Less Than

```sql
WHERE salary < 50000;
```

## BETWEEN

```sql
WHERE salary BETWEEN 30000 AND 80000;
```

## IN

```sql
WHERE city IN ('Bangalore','Mysore');
```

## LIKE

```sql
WHERE full_name LIKE 'R%';
```

## NULL Check

```sql
WHERE phone IS NULL;
```

---

# 🔹 Sorting

## Ascending

```sql
ORDER BY salary ASC;
```

## Descending

```sql
ORDER BY salary DESC;
```

## Multiple Columns

```sql
ORDER BY department, salary DESC;
```

---

# 🔹 Limiting Records

## Top 5 Rows

```sql
SELECT *
FROM employees
LIMIT 5;
```

## Offset

```sql
SELECT *
FROM employees
LIMIT 10 OFFSET 20;
```

---

# 🔹 INSERT

## Single Row

```sql
INSERT INTO employees
(full_name,salary)
VALUES
('Rutvik',70000);
```

## Multiple Rows

```sql
INSERT INTO employees
(full_name,salary)
VALUES
('A',50000),
('B',60000),
('C',70000);
```

---

# 🔹 UPDATE

```sql
UPDATE employees
SET salary = 80000
WHERE employee_id = 1;
```

---

# 🔹 DELETE

```sql
DELETE FROM employees
WHERE employee_id = 1;
```

---

# 🔹 Aggregate Functions

## Count

```sql
SELECT COUNT(*)
FROM employees;
```

## Sum

```sql
SELECT SUM(salary)
FROM employees;
```

## Average

```sql
SELECT AVG(salary)
FROM employees;
```

## Maximum

```sql
SELECT MAX(salary)
FROM employees;
```

## Minimum

```sql
SELECT MIN(salary)
FROM employees;
```

---

# 🔹 GROUP BY

```sql
SELECT department,
COUNT(*)
FROM employees
GROUP BY department;
```

---

# 🔹 HAVING

```sql
SELECT department,
COUNT(*)
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;
```

---

# 🔹 JOINs

## INNER JOIN

```sql
SELECT *
FROM employees e
INNER JOIN departments d
ON e.department_id=d.department_id;
```

## LEFT JOIN

```sql
SELECT *
FROM employees e
LEFT JOIN departments d
ON e.department_id=d.department_id;
```

## RIGHT JOIN

```sql
SELECT *
FROM employees e
RIGHT JOIN departments d
ON e.department_id=d.department_id;
```

## FULL JOIN

```sql
SELECT *
FROM employees e
FULL JOIN departments d
ON e.department_id=d.department_id;
```

## SELF JOIN

```sql
SELECT e1.full_name,
e2.full_name
FROM employees e1
JOIN employees e2
ON e1.manager_id=e2.employee_id;
```

---

# 🔹 Subqueries

## Scalar Subquery

```sql
SELECT *
FROM employees
WHERE salary =
(
SELECT MAX(salary)
FROM employees
);
```

## IN Subquery

```sql
SELECT *
FROM employees
WHERE department_id IN
(
SELECT department_id
FROM departments
);
```

## EXISTS

```sql
SELECT *
FROM employees e
WHERE EXISTS
(
SELECT 1
FROM departments d
WHERE e.department_id=d.department_id
);
```

---

# 🔹 String Functions

## Uppercase

```sql
SELECT UPPER(full_name)
FROM employees;
```

## Lowercase

```sql
SELECT LOWER(full_name)
FROM employees;
```

## Length

```sql
SELECT LENGTH(full_name)
FROM employees;
```

## Concatenate

```sql
SELECT CONCAT(first_name,' ',last_name);
```

## Substring

```sql
SELECT SUBSTRING(full_name,1,5);
```

---

# 🔹 Date Functions

## Current Date

```sql
SELECT CURRENT_DATE;
```

## Current Timestamp

```sql
SELECT CURRENT_TIMESTAMP;
```

## Extract Year

```sql
SELECT EXTRACT(YEAR FROM CURRENT_DATE);
```

## Age

```sql
SELECT AGE(date_of_birth);
```

---

# 🔹 Numeric Functions

## Round

```sql
SELECT ROUND(123.456,2);
```

## Ceiling

```sql
SELECT CEIL(123.2);
```

## Floor

```sql
SELECT FLOOR(123.8);
```

## Absolute

```sql
SELECT ABS(-100);
```

---

# 🔹 CASE Statement

```sql
SELECT
full_name,

CASE
    WHEN salary > 100000 THEN 'High'
    WHEN salary > 50000 THEN 'Medium'
    ELSE 'Low'
END AS salary_category

FROM employees;
```

---

# 🔹 Views

## Create View

```sql
CREATE VIEW employee_view AS
SELECT *
FROM employees;
```

## Query View

```sql
SELECT *
FROM employee_view;
```

## Delete View

```sql
DROP VIEW employee_view;
```

---

# 🔹 Indexes

## Create Index

```sql
CREATE INDEX idx_employee_name
ON employees(full_name);
```

## Drop Index

```sql
DROP INDEX idx_employee_name;
```

---

# 🔹 Transactions

## Begin Transaction

```sql
BEGIN;
```

## Commit

```sql
COMMIT;
```

## Rollback

```sql
ROLLBACK;
```

Example:

```sql
BEGIN;

UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 1000
WHERE account_id = 2;

COMMIT;
```

---

# 🔹 Common Table Expressions (CTE)

```sql
WITH department_salary AS
(
SELECT
department_id,
AVG(salary) avg_salary
FROM employees
GROUP BY department_id
)

SELECT *
FROM department_salary;
```

---

# 🔹 Recursive CTE

```sql
WITH RECURSIVE numbers AS
(
SELECT 1

UNION ALL

SELECT n + 1
FROM numbers
WHERE n < 10
)

SELECT *
FROM numbers;
```

---

# 🔹 Window Functions

## ROW_NUMBER

```sql
SELECT
full_name,
salary,

ROW_NUMBER()
OVER(
ORDER BY salary DESC
)

FROM employees;
```

## RANK

```sql
SELECT
full_name,
salary,

RANK()
OVER(
ORDER BY salary DESC
)

FROM employees;
```

## DENSE_RANK

```sql
SELECT
full_name,
salary,

DENSE_RANK()
OVER(
ORDER BY salary DESC
)

FROM employees;
```

## LEAD

```sql
SELECT
salary,

LEAD(salary)
OVER(
ORDER BY salary
)

FROM employees;
```

## LAG

```sql
SELECT
salary,

LAG(salary)
OVER(
ORDER BY salary
)

FROM employees;
```

---

# 🔹 Performance Optimization

## Explain Query

```sql
EXPLAIN
SELECT *
FROM employees;
```

## Explain Analyze

```sql
EXPLAIN ANALYZE
SELECT *
FROM employees;
```

### Best Practices

✅ Use indexes on frequently searched columns

✅ Avoid SELECT *

✅ Filter data early

✅ Use JOINs efficiently

✅ Index foreign keys

✅ Avoid unnecessary subqueries

---

# 🔹 SQL Execution Order

```text
FROM
JOIN
WHERE
GROUP BY
HAVING
SELECT
DISTINCT
ORDER BY
LIMIT
```

---

# 🔹 Most Important Interview Questions

### Difference between WHERE and HAVING?

* WHERE filters rows before grouping.
* HAVING filters groups after aggregation.

### Difference between DELETE, TRUNCATE, and DROP?

DELETE

* Removes rows
* Can use WHERE

TRUNCATE

* Removes all rows
* Faster

DROP

* Removes entire table

### Difference between RANK and DENSE_RANK?

RANK:

```text
1
2
2
4
```

DENSE_RANK:

```text
1
2
2
3
```

---

# 🚀 Quick Revision Checklist

## Fundamentals

* [ ] SELECT
* [ ] WHERE
* [ ] ORDER BY
* [ ] LIMIT

## Intermediate

* [ ] INSERT
* [ ] UPDATE
* [ ] DELETE
* [ ] GROUP BY
* [ ] HAVING
* [ ] JOINs

## Advanced

* [ ] Subqueries
* [ ] Views
* [ ] Indexes
* [ ] Transactions
* [ ] CTEs
* [ ] Window Functions

---

# 🎯 SQL Mastery Formula

```text
SQL Fundamentals
        ↓
JOINs & Relationships
        ↓
Aggregations
        ↓
Subqueries
        ↓
Views & Indexes
        ↓
CTEs
        ↓
Window Functions
        ↓
Analytics
        ↓
Projects
        ↓
SQL Mastery
```
