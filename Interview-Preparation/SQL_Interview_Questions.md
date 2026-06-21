# SQL Interview Questions & Answers

## SQL-Mastery-Portfolio

---

# Introduction

This guide contains the most frequently asked SQL interview questions for:

* Software Engineer
* Backend Developer
* Data Analyst
* Data Engineer
* Database Administrator
* Business Intelligence Developer

Questions are categorized from Beginner to Advanced level.

---

# Table of Contents

1. SQL Fundamentals
2. Database Design
3. Joins
4. Aggregate Functions
5. Subqueries
6. CTEs
7. Window Functions
8. Indexes
9. Transactions
10. Query Optimization
11. Advanced SQL
12. Scenario-Based Questions
13. FAANG SQL Questions

---

# SQL FUNDAMENTALS

## Q1. What is SQL?

SQL (Structured Query Language) is a language used to communicate with relational databases.

It is used for:

* Creating databases
* Retrieving data
* Updating data
* Deleting data
* Managing permissions

---

## Q2. What are the types of SQL commands?

### DDL

Data Definition Language

```sql
CREATE
ALTER
DROP
TRUNCATE
```

### DML

Data Manipulation Language

```sql
INSERT
UPDATE
DELETE
```

### DQL

Data Query Language

```sql
SELECT
```

### DCL

Data Control Language

```sql
GRANT
REVOKE
```

### TCL

Transaction Control Language

```sql
COMMIT
ROLLBACK
SAVEPOINT
```

---

## Q3. Difference between DELETE, TRUNCATE and DROP?

| Feature            | DELETE | TRUNCATE   | DROP    |
| ------------------ | ------ | ---------- | ------- |
| Removes Rows       | Yes    | Yes        | Yes     |
| WHERE Allowed      | Yes    | No         | No      |
| Rollback           | Yes    | Usually No | No      |
| Structure Retained | Yes    | Yes        | No      |
| Faster             | No     | Yes        | Fastest |

---

## Q4. What is a Primary Key?

A Primary Key uniquely identifies each row in a table.

Properties:

* Unique
* Not NULL
* One per table

Example:

```sql
employee_id INT PRIMARY KEY
```

---

## Q5. What is a Foreign Key?

A Foreign Key establishes a relationship between two tables.

Example:

```sql
department_id INT,
FOREIGN KEY (department_id)
REFERENCES departments(department_id)
```

---

# DATABASE DESIGN

## Q6. What is Normalization?

Normalization is the process of organizing data to reduce redundancy.

Goals:

* Reduce duplication
* Improve integrity
* Improve maintainability

---

## Q7. What are Normal Forms?

### 1NF

* Atomic values
* No repeating groups

### 2NF

* 1NF +
* No partial dependency

### 3NF

* 2NF +
* No transitive dependency

### BCNF

* Stronger version of 3NF

---

## Q8. What is Denormalization?

Denormalization combines tables to improve read performance.

Advantages:

* Faster queries

Disadvantages:

* Data redundancy

---

# JOINS

## Q9. What is INNER JOIN?

Returns matching rows from both tables.

```sql
SELECT *
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;
```

---

## Q10. What is LEFT JOIN?

Returns all rows from left table.

```sql
SELECT *
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;
```

---

## Q11. What is RIGHT JOIN?

Returns all rows from right table.

```sql
SELECT *
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id;
```

---

## Q12. What is FULL OUTER JOIN?

Returns all matching and non-matching rows.

```sql
SELECT *
FROM employees e
FULL OUTER JOIN departments d
ON e.department_id = d.department_id;
```

---

## Q13. What is SELF JOIN?

A table joined with itself.

Used for:

* Employee-manager relationships
* Hierarchies

```sql
SELECT
e.name,
m.name
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id;
```

---

# AGGREGATE FUNCTIONS

## Q14. What is COUNT()?

Returns number of rows.

```sql
SELECT COUNT(*)
FROM employees;
```

---

## Q15. Difference between COUNT(*) and COUNT(column)?

```sql
COUNT(*)        -> counts all rows
COUNT(column)   -> ignores NULL values
```

---

## Q16. What is AVG()?

Returns average value.

```sql
SELECT AVG(salary)
FROM employees;
```

---

## Q17. What is GROUP BY?

Groups rows for aggregation.

```sql
SELECT department_id,
COUNT(*)
FROM employees
GROUP BY department_id;
```

---

## Q18. What is HAVING?

Filters grouped data.

```sql
SELECT department_id,
COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5;
```

---

# SUBQUERIES

## Q19. What is a Subquery?

A query inside another query.

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

## Q20. What is a Correlated Subquery?

Depends on outer query.

```sql
SELECT *
FROM employees e1
WHERE salary >
(
SELECT AVG(salary)
FROM employees e2
WHERE e1.department_id=e2.department_id
);
```

---

## Q21. Find Second Highest Salary

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

## Q22. Find Third Highest Salary

```sql
SELECT MAX(salary)
FROM employees
WHERE salary <
(
SELECT MAX(salary)
FROM employees
WHERE salary <
(
SELECT MAX(salary)
FROM employees
)
);
```

---

# CTEs

## Q23. What is a CTE?

Common Table Expression.

Improves readability.

```sql
WITH dept_salary AS
(
SELECT department_id,
AVG(salary) avg_sal
FROM employees
GROUP BY department_id
)

SELECT *
FROM dept_salary;
```

---

## Q24. What is Recursive CTE?

Used for hierarchical data.

```sql
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

# WINDOW FUNCTIONS

## Q25. What is ROW_NUMBER()?

Assigns unique sequence.

```sql
SELECT
ROW_NUMBER()
OVER(ORDER BY salary DESC)
FROM employees;
```

---

## Q26. Difference between ROW_NUMBER(), RANK(), DENSE_RANK()?

### ROW_NUMBER

```text
1 2 3 4
```

### RANK

```text
1 2 2 4
```

### DENSE_RANK

```text
1 2 2 3
```

---

## Q27. What is LAG()?

Access previous row.

```sql
SELECT
salary,
LAG(salary)
OVER(ORDER BY employee_id)
FROM employees;
```

---

## Q28. What is LEAD()?

Access next row.

```sql
SELECT
salary,
LEAD(salary)
OVER(ORDER BY employee_id)
FROM employees;
```

---

## Q29. What is NTILE()?

Creates buckets.

```sql
SELECT
NTILE(4)
OVER(ORDER BY salary)
FROM employees;
```

---

# INDEXES

## Q30. What is an Index?

Improves query performance.

Like a book index.

---

## Q31. Advantages of Indexes?

* Faster search
* Faster joins
* Faster sorting

---

## Q32. Disadvantages of Indexes?

* More storage
* Slower inserts
* Slower updates

---

## Q33. Clustered vs Non-Clustered Index

| Feature       | Clustered | Non-Clustered |
| ------------- | --------- | ------------- |
| Data Sorted   | Yes       | No            |
| One Per Table | Yes       | Multiple      |
| Faster Reads  | Yes       | Moderate      |

---

# TRANSACTIONS

## Q34. What is a Transaction?

A sequence of operations treated as one unit.

---

## Q35. What is ACID?

### Atomicity

All or nothing.

### Consistency

Data remains valid.

### Isolation

Transactions don't interfere.

### Durability

Committed changes persist.

---

## Q36. Difference between COMMIT and ROLLBACK?

### COMMIT

Save changes.

### ROLLBACK

Undo changes.

---

# QUERY OPTIMIZATION

## Q37. What is EXPLAIN?

Displays execution plan.

```sql
EXPLAIN
SELECT *
FROM employees;
```

---

## Q38. What is EXPLAIN ANALYZE?

Shows actual execution statistics.

```sql
EXPLAIN ANALYZE
SELECT *
FROM employees;
```

---

## Q39. How to optimize SQL queries?

* Use indexes
* Avoid SELECT *
* Filter early
* Use EXISTS
* Analyze execution plans

---

## Q40. Why avoid SELECT *?

Problems:

* More I/O
* More memory
* Poor performance

---

# ADVANCED SQL

## Q41. Difference between EXISTS and IN?

### EXISTS

Stops at first match.

### IN

Checks entire set.

For large datasets:

```sql
EXISTS
```

is usually preferred.

---

## Q42. What is a Materialized View?

Stores query results physically.

Faster reads.

Requires refresh.

---

## Q43. What is Partitioning?

Splitting large tables into smaller pieces.

Examples:

* Range
* List
* Hash

---

## Q44. What is Sharding?

Horizontal database scaling.

Data split across servers.

---

## Q45. What are Window Functions?

Functions operating across rows without collapsing results.

Examples:

```sql
ROW_NUMBER()
RANK()
LAG()
LEAD()
```

---

# SCENARIO-BASED QUESTIONS

## Q46. Find Top 3 Employees Per Department

```sql
WITH ranked AS
(
SELECT *,
ROW_NUMBER()
OVER(
PARTITION BY department_id
ORDER BY salary DESC
) rn
FROM employees
)

SELECT *
FROM ranked
WHERE rn<=3;
```

---

## Q47. Find Duplicate Records

```sql
SELECT email,
COUNT(*)
FROM employees
GROUP BY email
HAVING COUNT(*) > 1;
```

---

## Q48. Find Employees Without Projects

```sql
SELECT *
FROM employees e
WHERE NOT EXISTS
(
SELECT 1
FROM employee_projects ep
WHERE ep.employee_id=e.employee_id
);
```

---

## Q49. Find Departments Without Employees

```sql
SELECT *
FROM departments d
WHERE NOT EXISTS
(
SELECT 1
FROM employees e
WHERE e.department_id=d.department_id
);
```

---

## Q50. Build Executive Dashboard Query

KPIs:

* Total Employees
* Total Revenue
* Average Salary
* Active Projects

Use:

```sql
COUNT()
SUM()
AVG()
GROUP BY
WINDOW FUNCTIONS
CTEs
```

---

# FAANG SQL QUESTIONS

## Frequently Asked

### Amazon

* Second Highest Salary
* Top N Per Group
* Running Totals
* Window Functions

### Google

* Recursive Queries
* CTEs
* Query Optimization

### Microsoft

* Joins
* Indexing
* Transactions

### Meta

* Analytics Queries
* Ranking Problems

### Netflix

* Time-Series Analytics
* Retention Analysis

---

# Final Interview Checklist

## Fundamentals

* [ ] SELECT
* [ ] WHERE
* [ ] ORDER BY
* [ ] GROUP BY
* [ ] HAVING

## Intermediate

* [ ] JOINs
* [ ] Subqueries
* [ ] CTEs
* [ ] Views

## Advanced

* [ ] Window Functions
* [ ] Transactions
* [ ] Indexes
* [ ] Query Optimization

## Expert

* [ ] Recursive CTEs
* [ ] Analytics Dashboards
* [ ] Execution Plans
* [ ] Performance Tuning

---

# SQL Interview Success Formula

```text
SQL Fundamentals
        +
JOINs
        +
Subqueries
        +
CTEs
        +
Window Functions
        +
Optimization
        +
Projects
        =
SQL Interview Success
```

---

**Total Questions Covered:** 50+

**Difficulty Levels:**

* Beginner
* Intermediate
* Advanced
* FAANG-Level

**Portfolio Status:** Interview Ready 🚀
